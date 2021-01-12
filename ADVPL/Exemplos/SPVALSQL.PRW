#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"



/*/{Protheus.doc} SPVALSQL
Função SPVALSQL
@param Não recebe parametros
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Mar|2020
/*/
User Function SPVALSQL()          
Local cSql as Character
Local lErro as Logical
Local nQueryRet as Numeric

cSql := ""
lErro := .F.
nQueryRet := 0

dbselectarea("SA1")
cSql :=�"SELECT * FROM "+RetSQLName('SB1')

nQueryRet := TCSQLEXEC(cSql)

if nQueryRet < 0
    msgstop("ERRO NA QUERY: "�+ chr(10) + TCSQLError())
    lErro := .T.
Endif

