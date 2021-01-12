----
-- Script that reorganizes or rebuilds all indexes having an average fragmentation 
-- percentage above a given threshold. It also works in the case
-- where Availability Groups are enabled as it determines if the
-- relevant databases are the primary replicas.
--
-- This script supports only SQL Server 2005 or later.
-- Also, if you execute this script in a SQL Server 2005 instance 
-- or later, any databases with compatibility level 2000 (80) or earlier
-- will be automatically excluded from the index reorganization/rebuild process.
----

--Initial check - You must be SysAdmin
DECLARE @isSysAdmin INT
SET @isSysAdmin=(SELECT IS_SRVROLEMEMBER ('sysadmin'));

--Initial check - You must be using SQL Server 2005 or later
DECLARE @SQLServerVersion INT
SET @SQLServerVersion=(SELECT CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(50)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(50)))-1) AS INT));


IF @isSysAdmin=1 AND @SQLServerVersion >= 9
BEGIN 

--
-- Variable/parameters Declaration
--
DECLARE @dbname NVARCHAR(128);
DECLARE @ReorganizeOrRebuildCommand NVARCHAR(MAX);
DECLARE @dbid INT;
DECLARE @indexFillFactor VARCHAR(5); 
DECLARE @fragmentationThreshold VARCHAR(10);
DECLARE @indexStatisticsScanningMode VARCHAR(20);
DECLARE @verboseMode BIT;
DECLARE @reportOnly BIT;
DECLARE @sortInTempdb VARCHAR(3);
DECLARE @isHadrEnabled BIT;
DECLARE @databaseToCheck VARCHAR(250)
DECLARE @dynamic_command NVARCHAR(1024);
DECLARE @dynamic_command_get_tables NVARCHAR(MAX);

--Initializations - Do not change
SET @databaseToCheck=NULL;
SET @dynamic_command = NULL;
SET @dynamic_command_get_tables = NULL;
SET @isHadrEnabled=0;

SET NOCOUNT ON;

---------------------------------------------------------
--Set Parameter Values: You can change these (optional) -
--Note: The script has default parameters set   -
---------------------------------------------------------
--if set to 1: it will just generate a report with the index reorganization/rebuild statements
--if set to 0: it will reorganize or rebuild the fragmented indexes
SET @reportOnly = 0;

--optional: if not set (NULL), it will scann all databases
--If name is set (i.e. 'testDB') it will just scan the given database
SET @databaseToCheck = NULL;

--maintains only the indexes that have average fragmentation percentage equal or higher from the given value
SET @fragmentationThreshold = 15; 

--fill factor - the percentage of the data page to be filled up with index data
SET @indexFillFactor = 90; 

--sets the scanning mode for index statistics 
--available values: 'DEFAULT', NULL, 'LIMITED', 'SAMPLED', or 'DETAILED'
SET @indexStatisticsScanningMode='SAMPLED';

--if set to ON: sorts intermediate index results in TempDB 
--if set to OFF: sorts intermediate index results in user database's log file
SET @sortInTempdb='ON'; 

--if set to 0: Does not output additional information about the index reorganization/rebuild process
--if set to 0: Outputs additional information about the index reorganization/rebuild process
SET @verboseMode = 0; 
------------------------------
--End Parameter Values Setup -
------------------------------

-- check if given database exists and if compatibility level >= SQL 2005 (90)
IF @verboseMode=1
 PRINT 'Checking if database '+@databaseToCheck+' exists and if compatibility level equals or greater 2005 (90)';

 -- if given database does not exist, raise error with severity 20
 -- in order to terminate script's execution
IF @databaseToCheck IS NOT NULL
BEGIN
 DECLARE @checkResult INT
 SET @checkResult=(SELECT COUNT(*) FROM master.sys.databases WHERE [name]=RTRIM(@databaseToCheck));
 IF @checkResult<1
  RAISERROR('Error executing index reorganization/rebuild script: Database does not exist' , 20, 1) WITH LOG;

 DECLARE @checkResult2 INT
 SET @checkResult=(SELECT [compatibility_level] FROM master.sys.databases WHERE [name]=RTRIM(@databaseToCheck));
 IF @checkResult<90
  RAISERROR('Error executing index reorganization/rebuild script: Only databases with SQL Server 2005 or later compatibility level are supported' , 20, 1) WITH LOG;  
END

IF @verboseMode=1
 PRINT 'Initial checks completed with no errors.';

-- Temporary table for storing index fragmentation details
IF OBJECT_ID('tempdb..#tmpFragmentedIndexes') IS NULL
BEGIN
CREATE TABLE #tmpFragmentedIndexes
    (
      [dbName] sysname,
      [tableName] sysname,
   [schemaName] sysname,
      [indexName] sysname,
      [databaseID] SMALLINT ,
      [objectID] INT ,
      [indexID] INT ,
      [AvgFragmentationPercentage] FLOAT,
   [reorganizationOrRebuildCommand] NVARCHAR(MAX)
    );
END 

-- Initialize temporary table
DELETE FROM #tmpFragmentedIndexes;

-- Validate parameters/set defaults
IF @sortInTempdb NOT IN ('ON','OFF')
SET @sortInTempdb='ON';

-- Check if instance has AlwaysOn AGs enabled
SET @isHadrEnabled=CAST((SELECT ISNULL(SERVERPROPERTY('IsHadrEnabled'),0)) AS BIT);

-- if database not specified scan all databases
IF @databaseToCheck IS NULL
BEGIN
DECLARE dbNames_cursor CURSOR
FOR
    SELECT  s.[name] AS dbName ,
            s.database_id
    FROM    master.sys.databases s            
    WHERE   s.state_desc = 'ONLINE'
            AND s.is_read_only != 1            
            AND s.[name] NOT IN ( 'master', 'model', 'tempdb' )
   AND s.[compatibility_level]>=90
    ORDER BY s.database_id;    
END 
ELSE
-- if database specified, scan only that database
BEGIN
DECLARE dbNames_cursor CURSOR 
FOR
    SELECT  s.[name] AS dbName ,
            s.database_id
    FROM    master.sys.databases s            
    WHERE   s.state_desc = 'ONLINE'
            AND s.is_read_only != 1                        
   AND s.[name]=RTRIM(@databaseToCheck)    
END 

-- if Always On Availability Groups are enabled, check for primary databases
-- (thus exclude secondary databases)
IF @isHadrEnabled=1
BEGIN

DEALLOCATE dbNames_cursor;

-- if database not specified scan all databases
IF @databaseToCheck IS NULL
BEGIN
 DECLARE dbNames_cursor CURSOR
 FOR
  SELECT  s.[name] AS dbName ,
    s.database_id
  FROM    master.sys.databases s
    LEFT JOIN master.sys.dm_hadr_availability_replica_states r ON s.replica_id = r.replica_id
  WHERE   s.state_desc = 'ONLINE'
    AND s.is_read_only != 1
    AND UPPER(ISNULL(r.role_desc, 'NonHadrEnabled')) NOT LIKE 'SECONDARY'
    AND s.[name] NOT IN ( 'master', 'model', 'tempdb' )
    AND s.[compatibility_level]>=90 
  ORDER BY s.database_id;    
END
ELSE
-- if database specified, scan only that database
BEGIN
 DECLARE dbNames_cursor CURSOR
 FOR
  SELECT  s.[name] AS dbName ,
    s.database_id
  FROM    master.sys.databases s
    LEFT JOIN master.sys.dm_hadr_availability_replica_states r ON s.replica_id = r.replica_id
  WHERE   s.state_desc = 'ONLINE'
    AND s.is_read_only != 1
    AND UPPER(ISNULL(r.role_desc, 'NonHadrEnabled')) NOT LIKE 'SECONDARY'    
    AND s.[name]=RTRIM(@databaseToCheck);  
END 
END 


--
-- For each database included in the cursor, 
-- gather all tables that have indexes with 
-- average fragmentation percentage equal or above @fragmentationThreshold
--
OPEN dbNames_cursor;
FETCH NEXT FROM dbNames_cursor INTO @dbname, @dbid;
WHILE @@fetch_status = 0
    BEGIN   
 
 --If verbose mode is enabled, print logs
        IF @verboseMode = 1
            BEGIN
    PRINT ''
                PRINT 'Gathering index fragmentation statistics for database: ['+ @dbname + '] with id: ' + CAST(@dbid AS VARCHAR(10));    
            END;
                   
        SET @dynamic_command_get_tables = N'
 USE [' + @dbname+ N'];
 INSERT INTO #tmpFragmentedIndexes (
  [dbName],
  [tableName],
  [schemaName],
  [indexName],
  [databaseID],
  [objectID],
  [indexID],
  [AvgFragmentationPercentage],
  [reorganizationOrRebuildCommand]  
  )
  SELECT
     DB_NAME() as [dbName], 
     tbl.name as [tableName],
     SCHEMA_NAME (tbl.schema_id) as schemaName, 
     idx.Name as [indexName], 
     pst.database_id as [databaseID], 
     pst.object_id as [objectID], 
     pst.index_id as [indexID], 
     pst.avg_fragmentation_in_percent as [AvgFragmentationPercentage],
     CASE WHEN pst.avg_fragmentation_in_percent > 30 THEN 
     ''ALTER INDEX [''+idx.Name+''] ON [''+DB_NAME()+''].[''+SCHEMA_NAME (tbl.schema_id)+''].[''+tbl.name+''] REBUILD WITH (FILLFACTOR = '+@indexFillFactor+', SORT_IN_TEMPDB = '+@sortInTempdb+', STATISTICS_NORECOMPUTE = OFF);''
     WHEN pst.avg_fragmentation_in_percent > 5 AND pst.avg_fragmentation_in_percent <= 30 THEN 
     ''ALTER INDEX [''+idx.Name+''] ON [''+DB_NAME()+''].[''+SCHEMA_NAME (tbl.schema_id)+''].[''+tbl.name+''] REORGANIZE;''     
     ELSE
     NULL
     END
  FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL , '''+@indexStatisticsScanningMode+''') as pst
   INNER JOIN sys.tables as tbl ON pst.object_id = tbl.object_id
   INNER JOIN sys.indexes idx ON pst.object_id = idx.object_id AND pst.index_id = idx.index_id
  WHERE pst.index_id != 0  
   AND pst.alloc_unit_type_desc IN ( N''IN_ROW_DATA'', N''ROW_OVERFLOW_DATA'')
   AND pst.avg_fragmentation_in_percent >= '+ @fragmentationThreshold + '';
        
  -- if verbose  mode is enabled, print logs    
  IF @verboseMode=1
   BEGIN
    PRINT 'Index fragmentation statistics script: ';    
    PRINT @dynamic_command_get_tables;
  END

  -- gather index fragmentation statistics
        EXEC (@dynamic_command_get_tables);
       
     -- bring next record from the cursor
        FETCH NEXT FROM dbNames_cursor INTO @dbname, @dbid;
    END;

CLOSE dbNames_cursor;
DEALLOCATE dbNames_cursor;

------------------------------------------------------------

-- if 'report only' mode is enabled
IF @reportOnly=1
BEGIN 
 SELECT  dbName ,
            tableName ,
            schemaName ,
            indexName ,            
            AvgFragmentationPercentage ,
            reorganizationOrRebuildCommand
 FROM    #tmpFragmentedIndexes
 ORDER BY AvgFragmentationPercentage DESC;
END
ELSE 
-- if 'report only' mode is disabled, then execute 
-- index reorganize/rebuild statements
BEGIN 
 DECLARE reorganizeOrRebuildCommands_cursor CURSOR
 FOR
    SELECT  reorganizationOrRebuildCommand
  FROM #tmpFragmentedIndexes
  WHERE reorganizationOrRebuildCommand IS NOT NULL
  ORDER BY AvgFragmentationPercentage DESC;

 OPEN reorganizeOrRebuildCommands_cursor;
 FETCH NEXT FROM reorganizeOrRebuildCommands_cursor INTO @ReorganizeOrRebuildCommand;
 WHILE @@fetch_status = 0
  BEGIN   
         
   IF @verboseMode = 1
   BEGIN
     PRINT ''
     PRINT 'Executing script:'     
     PRINT @ReorganizeOrRebuildCommand
   END
          
   EXEC (@ReorganizeOrRebuildCommand);          
   FETCH NEXT FROM reorganizeOrRebuildCommands_cursor INTO @ReorganizeOrRebuildCommand;
  END;

 CLOSE reorganizeOrRebuildCommands_cursor;
 DEALLOCATE reorganizeOrRebuildCommands_cursor;

 PRINT ''
 PRINT 'All fragmented indexes have been reorganized/rebuilt.'
 PRINT ''
END
END 
ELSE
BEGIN
 PRINT '';
 PRINT 'Error: You need to be SysAdmin and use SQL Server 2005 or later in order to use this script.';
 PRINT '';
END
--End of Script
