#INCLUDE "PROTHEUS.CH"    
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "TOPCONN.CH"
#include "TOTVS.CH"
#Include "RWMAKE.CH"

//define os campos que serão exportados
#DEFINE CSX2FIELD "X2_CHAVE|X2_NOMEENG     |X2_NOME         |X2_MODO|X2_MODOUN  |X2_MODOEMP|X2_UNICO |      |"
#DEFINE CSX2Label "Key     |Name in English|Nome em Portuges|Mode   |Unit. Mode |Corp. Mode|Uniqe Key|Action|"

#DEFINE CSIXFIELD "INDICE|ORDEM|CHAVE|DESCENG      |DESCRICAO          |      |"
#DEFINE CSIXLabel "Table |Order|Key  |Title English|Titulo em Portugues|Action|"

#DEFINE CSX1FIELD "X1_GRUPO|X1_ORDEM|X1_PERENG    |X1_PERGUNT         |X1_TIPO|X1_TAMANHO|X1_DECIMAL|X1_GSC      |X1_F3         |X1_GRPSXG    |X1_VALID  |X1_VAR01|X1_PRESEL|X1_DEFENG1      |X1_DEF01           |X1_DEFENG2      |X1_DEF02           |X1_DEFENG3      |X1_DEF03           |X1_DEFENG4      |X1_DEF04           |X1_DEFENG5      |X1_DEF05           |X1_PICTURE|      |"
#DEFINE CSX1Label "Group   |Order   |Title English|Titulo em Portugues|Type   |Size      |Decimal   |Group fields|Standard Query|Group Fields |Validation|Variable|Selected |Option 1 English|Option 1 Portugues |Option 2 English|Option 2 Portugues |Option 3 English|Option 3 Portugues |Option 4 English|Option 4 Portugues |Option 5 English|Option 5 Portugues |Picture   |Action|"

#DEFINE CSX6FIELD "X6_VAR  |X6_TIPO|X6_DSCENG          |X6_DESCRIC            |X6_DSCENG1           |X6_DESC1                |X6_DSCENG2           |X6_DESC2                |X6_CONTENG|X6_VALID  |      |"
#DEFINE CSX6Label "Variable|Type   |Description English|Descricao em Portugues|Description English 1|Descricao em Portugues 1|Description English 2|Descricao em Portugues 2|Value     |Validation|Action|"

#DEFINE CSX7FIELD "X7_CAMPO|X7_SEQUENC|X7_REGRA|X7_CDOMIN|X7_TIPO|X7_SEEK|X7_ALIAS|X7_ORDEM|X7_CHAVE|X7_CONDIC|      |"
#DEFINE CSX7Label "Field   |Sequence  |Rule    |C. Domain|Type   |Seek   | Alias  |Order   |key     |Condition|Action|"

#DEFINE CSXAFIELD "XA_ALIAS|XA_TIPO|XA_ORDEM|XA_AGRUP|XA_DESCENG         |XA_DESCRIC            |      |"
#DEFINE CSXALabel "Alias   |Type   |Order   |Group   |Description English|Descricao em Portugues|Action|"

#DEFINE CSXBFIELD "XB_ALIAS|XB_TIPO|XB_SEQ  |XB_COLUNA|XB_DESCENG         |XB_DESCRI             |XB_CONTEM|      |"
#DEFINE CSXBLabel "Alias   |Type   |Sequence|Column   |Description English|Descricao em Portugues|Conteud  |Action|"

#DEFINE CSX3FIELD "SX3->X3_ARQUIVO  |SX3->X3_CAMPO   |cTypefield(SX3->X3_TIPO)  |SX3->X3_TAMANHO    |SX3->X3_DECIMAL    |SX3->X3_ORDEM  |SX3->X3_PICTURE    |SX3->X3_TITENG     |SX3->X3_DESCENG        |Ap5GetHelp(SX3->X3_CAMPO)   |SX3->X3_TITULO       |SX3->X3_DESCRIC         |Ap5GetHelp(SX3->X3_CAMPO)  |X3Uso()    |X3Obrigat(SX3->X3_CAMPO)   |IIF(SX3->X3_BROWSE=='S','Yes',IIF(SX3->X3_BROWSE=='N','No',''))    |SX3->X3_CBOXENG         |SX3->X3_CBOX         |IIF(SX3->X3_CONTEXT=='R','Real',IIF(SX3->X3_CONTEXT=='V','Virtual',''))   |SX3->X3_F3              |SX3->X3_RELACAO     |Iif(empty(SX3->X3_VALID),SX3->X3_VLDUSER,SX3->X3_VALID)          |SX3->X3_WHEN  |SX3->X3_GRPSXG            |SX3->X3_TRIGGER    |SX3->X3_INIBRW |SX3->X3_FOLDER |SX3->X3_AGRUP  |IIf(SX3->X3_PROPRI == 'U','Creation','Update')     |"
#DEFINE CSX3Label "File	            |Field	         |Type	                    |Size               |Decimal            |Order		    |Picture    		|Title English		|Description English    |Help English                |Titulo em Portugues  |Descricao em Portugues	|Help Portugues		        |Used		|Mandatory		            |Browse		                                                        |Combox(English)         |Combox(Portugues)    |Context		                                                              |Standard Search         |Standard Init       |Validation                                                       |When		     |Group of Fields		    |Trigger		    |Init Browse    |Folder 		|Grouping		|Action		                                        |"


#Define ENTER	Chr(13)+Chr(10)

/*/{Protheus.doc} SPDOCAUT
Rotina responsavel por documentar dicionario de dados

@type function
@author Rafael Goncalves
@since Set|2020
/*/
User Function SPDOCAUT(cTGet1,cTGet2,cTGet3,cTGet4,cTGet5,cTGet6,cTGet7,cTGet8)

Default cTGet1 := space(250)
Default cTGet2 := space(250)
Default cTGet3 := space(250)
Default cTGet4 := space(250)
Default cTGet5 := space(250)
Default cTGet6 := space(250)
Default cTGet7 := space(250)
Default cTGet8 := space(250)

// Habilita interface com data mostrada com 4 digitos no ano
// e Habilita data em formato britânico ( Dia/Mes/Ano )
SET CENTURY ON
SET DATE BRITISH

cRmtBuild := GetBuild(.T.)
cRmtIp := GetclientIP()
cUsrName := LogUserName()
dRmtDate := GetRmtDate()
cRmtTime := GetRmtTime()
aRmtInfo := GetRmtInfo()
cRmtTmp := GetTempPath(.T.)
lActivex := IsPlugin()
lSSLConn := IsSecure()
cInfo := ''
cInfo += 'SmartClient Build ....... ' + cRmtBuild + ENTER
cInfo += 'SmartClient Activex ..... ' + IIF(lActivex,"SIM","NAO") + ENTER
cInfo += 'SmartClient Connection .. ' + IIF(lSSLConn ,"SSL","TCP") + ENTER
cInfo += 'SmartClient is 64 bits .. ' + IIF(IsRmt64() ,"SIM","NAO") + ENTER
cInfo += 'Remote IP ............... ' + cRmtIp + ENTER
cInfo += 'Remote User Name ........ ' + cUsrName + ENTER
cInfo += 'Remote DateTime ......... ' + dtoc(dRmtDate)+' '+cRmtTime + ENTER
cInfo += 'Remote Temp Path ........ ' + cRmtTmp + ENTER
cInfo += 'Remote Computer Name .... ' + aRmtInfo[1] + ENTER
cInfo += 'Remote O.S. ............. ' + aRmtInfo[2] + ENTER
cInfo += 'Remote O.S. Detais ...... ' + aRmtInfo[3] + ENTER
cInfo += 'Remote Memory (MB) ...... ' + aRmtInfo[4] + ENTER
cInfo += 'Remote CPU Count ........ ' + aRmtInfo[5] + ENTER
cInfo += 'Remote CPU MHZ .......... ' + aRmtInfo[6] + ENTER
cInfo += 'Remote CPU String ....... ' + aRmtInfo[7] + ENTER
cInfo += 'Remote O.S. Language .... ' + aRmtInfo[8] + ENTER
cInfo += 'Remote Web Browser ...... ' + aRmtInfo[9] + ENTER
cInfo += 'Remote Version .......... ' + RemoteXVersion()+ ENTER
cInfo += 'Remote Ini Patch ........ ' + GetRemoteIniName()+ ENTER
conout(cInfo)

//TODO remover
cTGet1 := "SA1|SA2" + space(250)
cTGet2 := "A1_COD|A1_LOJA"
cTGet3 := "SA1|SA2_1" + space(250)
cTGet4 := "ACA890|ACA980" + space(250)
cTGet5 := "MV_330ATCM|MV_LOTE" + space(250)
cTGet6 := "A00_NIVAGR|A1_CGC_002" + space(250)
cTGet7 := "AA1|ABS|AD1_1" + space(250)
cTGet8 := "SA1|SA2|SA4" + space(250)

/*If GetRemoteType() == 1  //nao for executado do menu
    RpcSetType(3)
    RpcSetEnv('00','102030')
    FSGERFILES(,,cTGet1, cTGet2, cTGet3, cTGet4, cTGet5, cTGet6, cTGet7, cTGet8)
else
*/

    DEFINE MSDIALOG oDlg FROM 0,0 TO 700,500 TITLE "Fast Dictionary Production (F.D.P.) - V 1.0.0" OF oMainWnd PIXEL

        nLin := 40
        //SX2
        oTGet1 := TGet():New( nLin+10,01, bSetGet( cTGet1 ),oDlg, 250,009,"",/* [ bValid ]*/,/**nClrFore */,/**nClrBack */,/**oFont */,/**uParam12 */,/**uParam13 */, .t.,/**uParam15 */,/**uParam16 */, {|| .T.},/*uParam18*/ ,/**uParam19 */, /*bChange*/, /* lReadOnly */, /* lPassword */, /* uParam23 */, /* cReadVar */, /* uParam25 */, /* uParam26 */, /* uParam27 */, /* lHasButton */, /* lNoButton */, /* uParam30 */, "Information for SX2 - Table Key(X2_CHAVE) Ex. SA1|SA2|SF1|"/* cLabelText */, 1/* nLabelPos */, /* oLabelFont */, /* nLabelColor */, /* cPlaceHold */, /* lPicturePriority */, /* lFocSel */ )
        nLin += 30
        //SX3
        //oTGet2 := TGet():New( nLin+10,01, bSetGet( cTGet2 ),oDlg, 250,009,"",/* [ bValid ]*/,/**nClrFore */,/**nClrBack */,/**oFont */,/**uParam12 */,/**uParam13 */, .t.,/**uParam15 */,/**uParam16 */, {|| .T.},/*uParam18*/ ,/**uParam19 */, /*bChange*/, /* lReadOnly */, /* lPassword */, /* uParam23 */, /* cReadVar */, /* uParam25 */, /* uParam26 */, /* uParam27 */, /* lHasButton */, /* lNoButton */, /* uParam30 */, "Information for SX3 - Table File or specific field Ex. SA1|A1_COD"/* cLabelText */, 1/* nLabelPos */, /* oLabelFont */, /* nLabelColor */, /* cPlaceHold */, /* lPicturePriority */, /* lFocSel */ )
        @ nLin+10,01 SAY oSay PROMPT 'Information for SX3 - Table File or specific field Ex. SA1|A1_COD' SIZE 250,09 OF oDlg PIXEL
        @ nLin+20,01 GET oGet VAR cTGet2 SIZE 248,60 MULTILINE OF oDlg PIXEL
               
        nLin += 80
        //SIX
        oTGet3 := TGet():New( nLin+10,01, bSetGet( cTGet3 ),oDlg, 250,009,"",/* [ bValid ]*/,/**nClrFore */,/**nClrBack */,/**oFont */,/**uParam12 */,/**uParam13 */, .t.,/**uParam15 */,/**uParam16 */, {|| .T.},/*uParam18*/ ,/**uParam19 */, /*bChange*/, /* lReadOnly */, /* lPassword */, /* uParam23 */, /* cReadVar */, /* uParam25 */, /* uParam26 */, /* uParam27 */, /* lHasButton */, /* lNoButton */, /* uParam30 */, "Information for SIX - Index in total or Index+Order order Ex. SA1|SA1_1|SA1_5|"/* cLabelText */, 1/* nLabelPos */, /* oLabelFont */, /* nLabelColor */, /* cPlaceHold */, /* lPicturePriority */, /* lFocSel */ )
        nLin += 30
        //SX1
        oTGet4 := TGet():New( nLin+10,01, bSetGet( cTGet4 ),oDlg, 250,009,"",/* [ bValid ]*/,/**nClrFore */,/**nClrBack */,/**oFont */,/**uParam12 */,/**uParam13 */, .t.,/**uParam15 */,/**uParam16 */, {|| .T.},/*uParam18*/ ,/**uParam19 */, /*bChange*/, /* lReadOnly */, /* lPassword */, /* uParam23 */, /* cReadVar */, /* uParam25 */, /* uParam26 */, /* uParam27 */, /* lHasButton */, /* lNoButton */, /* uParam30 */, "Information for SX1 - Pergunte Group Ex. ACA180|ACA190|"/* cLabelText */, 1/* nLabelPos */, /* oLabelFont */, /* nLabelColor */, /* cPlaceHold */, /* lPicturePriority */, /* lFocSel */ )
        nLin += 30
        //SX6
        oTGet5 := TGet():New( nLin+10,01, bSetGet( cTGet5 ),oDlg, 250,009,"",/* [ bValid ]*/,/**nClrFore */,/**nClrBack */,/**oFont */,/**uParam12 */,/**uParam13 */, .t.,/**uParam15 */,/**uParam16 */, {|| .T.},/*uParam18*/ ,/**uParam19 */, /*bChange*/, /* lReadOnly */, /* lPassword */, /* uParam23 */, /* cReadVar */, /* uParam25 */, /* uParam26 */, /* uParam27 */, /* lHasButton */, /* lNoButton */, /* uParam30 */, "Information for SX6 - Parameter Code Ex. MV_330ATCM|MV_LOTE"/* cLabelText */, 1/* nLabelPos */, /* oLabelFont */, /* nLabelColor */, /* cPlaceHold */, /* lPicturePriority */, /* lFocSel */ )
        nLin += 30
        //SX7
        oTGet6 := TGet():New( nLin+10,01, bSetGet( cTGet6 ),oDlg, 250,009,"",/* [ bValid ]*/,/**nClrFore */,/**nClrBack */,/**oFont */,/**uParam12 */,/**uParam13 */, .t.,/**uParam15 */,/**uParam16 */, {|| .T.},/*uParam18*/ ,/**uParam19 */, /*bChange*/, /* lReadOnly */, /* lPassword */, /* uParam23 */, /* cReadVar */, /* uParam25 */, /* uParam26 */, /* uParam27 */, /* lHasButton */, /* lNoButton */, /* uParam30 */, "Information for SX7 - Trigger Field or Field+Sequenc Ex. A00_NIVAGR|A1_CGC_002"/* cLabelText */, 1/* nLabelPos */, /* oLabelFont */, /* nLabelColor */, /* cPlaceHold */, /* lPicturePriority */, /* lFocSel */ )
        nLin += 30
        //SXA
        oTGet7 := TGet():New( nLin+10,01, bSetGet( cTGet7 ),oDlg, 250,009,"",/* [ bValid ]*/,/**nClrFore */,/**nClrBack */,/**oFont */,/**uParam12 */,/**uParam13 */, .t.,/**uParam15 */,/**uParam16 */, {|| .T.},/*uParam18*/ ,/**uParam19 */, /*bChange*/, /* lReadOnly */, /* lPassword */, /* uParam23 */, /* cReadVar */, /* uParam25 */, /* uParam26 */, /* uParam27 */, /* lHasButton */, /* lNoButton */, /* uParam30 */, "Information for SXA - Folder Alias or Alias+Order Ex. AA1|ACA_1"/* cLabelText */, 1/* nLabelPos */, /* oLabelFont */, /* nLabelColor */, /* cPlaceHold */, /* lPicturePriority */, /* lFocSel */ )
        nLin += 30
        //SXB
        oTGet8 := TGet():New( nLin+10,01, bSetGet( cTGet8 ),oDlg, 250,009,"",/* [ bValid ]*/,/**nClrFore */,/**nClrBack */,/**oFont */,/**uParam12 */,/**uParam13 */, .t.,/**uParam15 */,/**uParam16 */, {|| .T.},/*uParam18*/ ,/**uParam19 */, /*bChange*/, /* lReadOnly */, /* lPassword */, /* uParam23 */, /* cReadVar */, /* uParam25 */, /* uParam26 */, /* uParam27 */, /* lHasButton */, /* lNoButton */, /* uParam30 */, "Information for SXB - Standard Query  Alias Ex. SA1|SA2|SB1"/* cLabelText */, 1/* nLabelPos */, /* oLabelFont */, /* nLabelColor */, /* cPlaceHold */, /* lPicturePriority */, /* lFocSel */ )

    ACTIVATE MSDIALOG oDlg CENTER ON INIT EnchoiceBar(oDlg,{|| nOpcA:= 1,;
        FWMsgRun(, {|oSay| FSGERFILES(oSay,oDlg,cTGet1, cTGet2, cTGet3, cTGet4, cTGet5, cTGet6, cTGet7, cTGet8) }, "Processando", "Aguarde Iniciando exportacao")},{|| oDlg:End() })
//Endif

Return .t.


/*/{Protheus.doc} FSGERFILES
Rotina gera arquivos
@type function
@author Rafael Goncalves
@since Set|2020
/*/
Static Function FSGERFILES(oSay,oDlg,cTGet1, cTGet2, cTGet3, cTGet4, cTGet5, cTGet6, cTGet7, cTGet8) as logical
Local _Ni as Numeric
Local _Nj as Numeric
Local lGerF as Logical
Local aGer as Array
Local aGer1 as Array
Local aFIELD as Array
Local aSX2 as Array
Local aSX3 as Array
Local aSIX as Array

Local aSX6 as Array
Local aSX7 as Array
Local aSXA as Array
Local aSXB as Array


//Excel Information
Local cArquivo    := GetTempPath()+'ExpDic_'+dtos(dDataBAse)+'_'+cvaltochar(hora())+'.xml'
Local oFWMSEx     := FWMsExcelEx():New()
Local oExcel

default oSay := nil
default oDlg := nil

lGerF := .F.
//Start SX2
If !Empty(alltrim(cTGet1))
    lGerF := .T.
    If (GetRemoteType() == 1)
        oSay:cCaption := "Gerando SX2"
        ProcessMessages()
    Endif
    aGer := {}
    aSX2 := {}
    aGer := StrTokArr(alltrim(cTGet1), '|' ) //default optional fields
    aFIELD := StrTokArr(alltrim(CSX2FIELD), '|' ) //Fields to export
    aLabel := StrTokArr(alltrim(CSX2Label), '|' ) //Labels to export
    For _Ni := 1 to len(aGer)
        //Found lines
        DbSelectArea("SX2")
        SX2->( dbSetOrder( 1 ) ) //ARQUIVO
        If SX2->( msSeek( aGer[_Ni], .F. ) )
            //Loop Fields
            aGer1 := {}
            For _Nj := 1 to len(aFIELD)
                If !Empty(aFIELD[_Nj])
                    aAdd(aGer1,alltrim(SX2->&(aFIELD[_Nj])))
                Elseif alltrim(aLabel[_Nj]) == "Action"
                    /*If empty(SX2->X2_LOCTYP)
                        aAdd(aGer1,"Creation")
                    Else
                        aAdd(aGer1,"Update")
                    Endif */ 
                    aAdd(aGer1," ")                    
                Else
                    aAdd(aGer1," ")
                EndIf
            Next
            //add to array
            aAdd(aSX2,aGer1)
        Endif
    Next
Endif

//Start SX3

If !Empty(alltrim(cTGet2))
    lGerF := .T.
    If (GetRemoteType() == 1)
        oSay:cCaption := "Gereando SX3"
        ProcessMessages()
    Endif
    aGer := {}
    aSX3 := {}
    aGer := StrTokArr(alltrim(cTGet2), '|' ) //default optional fields
    aFIELD := StrTokArr(alltrim(CSX3FIELD), '|' ) //Fields to export
    aLabel := StrTokArr(alltrim(CSX3Label), '|' ) //Labels to export
    For _Ni := 1 to len(aGer)
        //Checa se gera tabela toda ou um campo
        If len(aGer[_Ni]) < 4 //tabela toda
            SX3->(dbSetOrder(1))
            SX3->(msSeek(aGer[_Ni]))
            While SX3->(!EOF()) .And.  SX3->X3_ARQUIVO == aGer[_Ni]
                aGer1 := {}
                For _Nj := 1 to len(aFIELD)
                    If !Empty(aFIELD[_Nj])
                        xValue:=&(aFIELD[_Nj])
                        If ValType(xValue) == 'C' //Char
                            aAdd(aGer1,alltrim(&(aFIELD[_Nj])))
                        ElseIf ValType(xValue) == 'L' //Char
                            IF xValue
                                aAdd(aGer1,"Yes")
                            Else
                                aAdd(aGer1,"No")     
                            EndIf                       
                        else
                            aAdd(aGer1,&(aFIELD[_Nj]))
                        Endif                        
                        //aAdd(aGer1,alltrim(SX3->&(aFIELD[_Nj])))
                    Elseif aLabel[_Nj] == "Action"
                        /*If empty(SX3->X3_LOCTYP)
                            aAdd(aGer1,"Creation")
                        Else
                            aAdd(aGer1,"Update")
                        Endif */
                        aAdd(aGer1," ")                   
                    Else
                        aAdd(aGer1," ")
                    EndIf
                Next
                //add to array
                aAdd(aSX3,aGer1)
                SX3->(dbSkip())
            EndDo
        Else //campo especifico
            DbSelectArea("SX3")
            SX3->(DbSetOrder(2))
            If SX3->(msSeek(aGer[_Ni]))
                aGer1 := {}
                For _Nj := 1 to len(aFIELD)
                    If !Empty(aFIELD[_Nj])
                        aAdd(aGer1,alltrim(&(aFIELD[_Nj])))
                    Elseif alltrim(aLabel[_Nj]) == "Action"
                        /*If empty(SX3->X3_LOCTYP)
                            aAdd(aGer1,"Creation")
                        Else
                            aAdd(aGer1,"Update")
                        Endif */ 
                        aAdd(aGer1," ")                    
                    Else
                        aAdd(aGer1," ")
                    EndIf
                Next
                //add to array
                aAdd(aSX3,aGer1)
                //cTitulo := TRIM(X3Titulo())
            EndIf
        Endif
    Next
Endif

//Start SIX
If !Empty(alltrim(cTGet3))
    lGerF := .T.
    If (GetRemoteType() == 1)
        oSay:cCaption := "Gereando SIX"
        ProcessMessages()
    Endif
    aGer := {}
    aSIX := {}
    aGer := StrTokArr(alltrim(cTGet3), '|' ) //default optional fields
    aFIELD := StrTokArr(alltrim(CSIXFIELD), '|' ) //Fields to export
    aLabel := StrTokArr(alltrim(CSIXLabel), '|' ) //Labels to export
    For _Ni := 1 to len(aGer)
        //Information for SIX - Index in total or Index+Order order Ex. SA1|SA1_1|SA1_5|
        cKey := aGer[_Ni]
        If !len(aGer[_Ni])<4 //expecific
            cKey := substring(aGer[_Ni],1,3) + substring(aGer[_Ni],5,len(aGer[_Ni]))
        Endif

        //Found lines
        dbSelectArea("SIX")
        SIX->( dbSetOrder( 1 ) ) //ARQUIVO
        If SIX->( msSeek( cKey, .F. ) )
            While !eof() .and. (SIX->INDICE == cKey .or. SIX->INDICE+SIX->ORDEM == cKey)
                //Loop Fields
                aGer1 := {}
                For _Nj := 1 to len(aFIELD)
                    If !Empty(aFIELD[_Nj])
                        aAdd(aGer1,alltrim(SIX->&(aFIELD[_Nj])))
                    Elseif aLabel[_Nj] == "Action"
                        /*If empty(SIX->IX_LOCTYP)
                            aAdd(aGer1,"Creation")
                        Else
                            aAdd(aGer1,"Update")
                        Endif */
                        aAdd(aGer1," ")                     
                    Else
                        aAdd(aGer1," ")
                    EndIf
                Next

                //add to array
                aAdd(aSIX,aGer1)

                dbSelectArea("SIX")
                SIX->(DbSkip())
            EndDo

        Endif
    Next
Endif


/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// E X P O R T   S X 1 //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

If !Empty(alltrim(cTGet4))
    lGerF := .T.
    If (GetRemoteType() == 1)
        oSay:cCaption := "Gereando SX1"
        ProcessMessages()
    Endif
    aGer := {}
    aSX1 := {}
    aGer := StrTokArr(alltrim(cTGet4), '|' ) //default optional fields
    aFIELD := StrTokArr(alltrim(CSX1FIELD), '|' ) //Fields to export
    For _Ni := 1 to len(aGer)
        //Found lines
        dbSelectArea("SX1")
        SX1->( dbSetOrder( 1 ) )
        If SX1->( msSeek( aGer[_Ni], .F. ) )
            While !eof() .and. (alltrim(SX1->X1_GRUPO) == alltrim(aGer[_Ni]) )
                //Loop Fields
                aGer1 := {}
                For _Nj := 1 to len(aFIELD)
                    If !Empty(aFIELD[_Nj])
                        aAdd(aGer1,(SX1->&(aFIELD[_Nj])))
                    Else
                        aAdd(aGer1," ")
                    EndIf
                Next
                //add to array
                aAdd(aSX1,aGer1)
                dbSelectArea("SX1")
                SX1->(DbSkip())
            EndDo

        Endif
    Next
Endif


/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// E X P O R T   S X 6 //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

If !Empty(alltrim(cTGet5))
    lGerF := .T.
    If (GetRemoteType() == 1)
        oSay:cCaption := "Gereando SX6"
        ProcessMessages()
    Endif
    aGer := {}
    aSX6 := {}
    aGer := StrTokArr(alltrim(cTGet5), '|' ) //default optional fields
    aFIELD := StrTokArr(alltrim(CSX6FIELD), '|' ) //Fields to export
    aLabel := StrTokArr(alltrim(CSX6Label), '|' ) //Labels to export
    For _Ni := 1 to len(aGer)
        //Found lines
        dbSelectArea("SX6")
        SX6->( dbSetOrder( 1 ) )
        If SX6->( msSeek(xFilial('SX6') +  aGer[_Ni], .F. ) )
            aGer1 := {}
            For _Nj := 1 to len(aFIELD)
                If !Empty(aFIELD[_Nj])
                    aAdd(aGer1,alltrim(SX6->&(aFIELD[_Nj])))
                Elseif aLabel[_Nj] == "Action"
                    /*If empty(SIX->IX_LOCTYP)
                        aAdd(aGer1,"Creation")
                    Else
                        aAdd(aGer1,"Update")
                    Endif*/
                    aAdd(aGer1," ")                      
                Else
                    aAdd(aGer1," ")
                EndIf
            Next
            //add to array
            aAdd(aSX6,aGer1)
        Endif
    Next
Endif





/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// E X P O R T   S X 7 //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

If !Empty(alltrim(cTGet6))
    lGerF := .T.
    If (GetRemoteType() == 1)
        oSay:cCaption := "Gereando SX7"
        ProcessMessages()
    Endif
    aGer := {}
    aSX7 := {}
    aGer := StrTokArr(alltrim(cTGet6), '|' ) //default optional fields
    aFIELD := StrTokArr(alltrim(CSX7FIELD), '|' ) //Fields to export
    For _Ni := 1 to len(aGer)
        //Found lines
        dbSelectArea("SX7")
        SX7->( dbSetOrder( 1 ) )
        If SX7->( msSeek( aGer[_Ni], .F. ) )
            While SX7->X7_CAMPO == aGer[_Ni]
                aGer1 := {}                    
                For _Nj := 1 to len(aFIELD)
                    If !Empty(aFIELD[_Nj])
                    aAdd(aGer1,alltrim(SX7->&(aFIELD[_Nj])))
                    Else
                        aAdd(aGer1," ")
                    EndIf
                Next
                SX7->(DbSkip())
                //add to array
                aAdd(aSX7,aGer1)                
            EndDo
        Endif
    Next
Endif



/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// E X P O R T   S X A //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

If !Empty(alltrim(cTGet7))
    lGerF := .T.
    If (GetRemoteType() == 1)
        oSay:cCaption := "Gereando SXA"
        ProcessMessages()
    Endif
    aGer := {}
    aSXA := {}
    aGer := StrTokArr(alltrim(cTGet7), '|' ) //default optional fields
    aFIELD := StrTokArr(alltrim(CSXAFIELD), '|' ) //Fields to export
    For _Ni := 1 to len(aGer)
        //Found lines
        dbSelectArea("SXA")
//        SX7->( dbSetOrder( 1 ) )
        cIndex := CriaTrab(Nil, .F.)
        cChave := IndexKey()
        IndRegua("SXA", cIndex, "XA_ALIAS + XA_TIPO + XA_ORDEM", , , "Selecionando Registros...")
		nIndex := RetIndex("SXA") + 1        
        dbSelectArea("SXA")
		dbSetOrder(nIndex)

        If SXA->( msSeek( aGer[_Ni], .F. ) )
            While SXA->XA_ALIAS == aGer[_Ni]
                aGer1 := {}                    
                For _Nj := 1 to len(aFIELD)
                    If !Empty(aFIELD[_Nj])
                    aAdd(aGer1,alltrim(SXA->&(aFIELD[_Nj])))
                    Else
                        aAdd(aGer1," ")
                    EndIf
                Next
                SXA->(DbSkip())
                //add to array
                aAdd(aSXA,aGer1)                
            EndDo
        Endif
    Next
Endif




/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// E X P O R T   S X B //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

If !Empty(alltrim(cTGet8))
    lGerF := .T.
    If (GetRemoteType() == 1)
        oSay:cCaption := "Gereando SXB"
        ProcessMessages()
    Endif
    aGer := {}
    aSXB := {}
    aGer := StrTokArr(alltrim(cTGet8), '|' ) //default optional fields
    aFIELD := StrTokArr(alltrim(CSXBFIELD), '|' ) //Fields to export
    For _Ni := 1 to len(aGer)
        //Found lines
        dbSelectArea("SXB")
        SXB->( dbSetOrder( 1 ) )
        If SXB->( msSeek(aGer[_Ni], .F. ) )
            While alltrim(SXB->XB_ALIAS) == alltrim(aGer[_Ni])
                aGer1 := {}
                For _Nj := 1 to len(aFIELD)
                    If !Empty(aFIELD[_Nj])
                        aAdd(aGer1,alltrim(SXB->&(aFIELD[_Nj])))
                    Else
                        aAdd(aGer1," ")
                    EndIf
                Next
                //add to array
                aAdd(aSXB,aGer1)
                SXB->(DbSkip())
            EndDo
        Endif
    Next
Endif


//Create Excel with informations
If lGerF := .T.
    If (GetRemoteType() == 1)
        oSay:cCaption := "Gereando Excel"
        ProcessMessages()
    Endif

    //SX2 Folder
    If !Empty(alltrim(cTGet1))
        aLabel := StrTokArr(alltrim(CSX2Label), '|' ) //Labels to export
        FSTABLE(@oFWMSEx,"SX2","Table Information",aSX2,aLabel)
    EndIf

    //SX3 Folder
    If !Empty(alltrim(cTGet2))
        aLabel := StrTokArr(alltrim(CSX3Label), '|' ) //Labels to export
        FSTABLE(@oFWMSEx,"SX3","Fields Information",aSX3,aLabel)
    EndIf

    //SIX Folder
    If !Empty(alltrim(cTGet3))
        aLabel := StrTokArr(alltrim(CSIXLabel), '|' ) //Labels to export
        FSTABLE(@oFWMSEx,"SIX","Index Information",aSIX,aLabel)
    EndIf

    //SX1 Folder
    If !Empty(alltrim(cTGet4))
        aLabel := StrTokArr(alltrim(CSX1Label), '|' ) //Labels to export
        FSTABLE(@oFWMSEx,"SX1","Question Information",aSX1,aLabel)
    EndIf

    //SX6 Folder
    If !Empty(alltrim(cTGet5))
        aLabel := StrTokArr(alltrim(CSX6Label), '|' ) //Labels to export
        FSTABLE(@oFWMSEx,"SX6","Parameter Information",aSX6,aLabel)
    EndIf

    //SX7 Folder
    If !Empty(alltrim(cTGet6))
        aLabel := StrTokArr(alltrim(CSX7Label), '|' ) //Labels to export
        FSTABLE(@oFWMSEx,"SX7","Triguer Information",aSX7,aLabel)
    EndIf

    //SXA Folder
    If !Empty(alltrim(cTGet7))
        aLabel := StrTokArr(alltrim(CSXALabel), '|' ) //Labels to export
        FSTABLE(@oFWMSEx,"SXA","Grouping Information",aSXA,aLabel)
    EndIf

    //SXA Folder
    If !Empty(alltrim(cTGet8))
        aLabel := StrTokArr(alltrim(CSXBLabel ), '|' ) //Labels to export
        FSTABLE(@oFWMSEx,"SXB","Standard Query Information",aSXB,aLabel)
    EndIf

    //Criando o XML
    oFWMSEx:Activate()
    oFWMSEx:GetXMLFile(cArquivo)

    //Abrindo o excel e abrindo o arquivo xml
    oExcel := MsExcel():New()               //Abre uma nova conexão com Excel
    oExcel:WorkBooks:Open(cArquivo)         //Abre uma planilha
    oExcel:SetVisible(.T.)                  //Visualiza a planilha
    oExcel:Destroy()                        //Encerra o processo do gerenciador de tarefas
Endif

If !(GetRemoteType() == 1)
    msginfo("Gerados")
Else
    Conout("End table creation")
Endif



return .t.



//Gera a tabela
Static function FSTABLE(oFWMSEx,cTable,cDesc,aInfo,aLabel) as logical
Local _Ni as Numeric
Local _Nj as Numeric
 //Criando a Aba Teste 1
oFWMSEx:AddworkSheet(cTable)
    //Adicionando a tabela
    oFWMSEx:AddTable (cTable,cDesc)
        //Adicionando as colunas
        oFWMSEx:AddColumn(cTable,cDesc,"Atribute",1,1)
        oFWMSEx:AddColumn(cTable,cDesc,"Value"   ,1,1)

        //Adicionando Linhas
        //aLabel := StrTokArr(alltrim(CSX2Label), '|' ) //Labels to export
        For _Ni := 1 to len(aInfo) //Loop informations
            //Define colors
            oFWMSEx:SetCelFrColor("#FFFFFF")
            oFWMSEx:SetCelBgColor("#4682B4")
            //headers
            For _Nj := 1 to len(aLabel) //loop campos
                //aAdd(aGer1,alltrim(SX2->&(aFIELD[_Nj])))
                oFWMSEx:AddRow(cTable,cDesc,{alltrim(aLabel[_Nj]),(aInfo[_Ni,_Nj])},{1})
            Next

            //Pula uma linha
            oFWMSEx:SetCelFrColor("#FFFFFF")
            oFWMSEx:SetCelBgColor("#FFFFFF")
            oFWMSEx:AddRow(cTable,cDesc,{" "," "},{1,2})
        Next

return .t.



Static Function cTypefield(cChar)
    Local cRet as Character 
    cRet:=""
    If cChar == 'C'
        cRet:="Character"
    ElseIf cChar == 'D'
        cRet:="Date"
    ElseIf cChar == 'N'
        cRet:="Numeric"
    Else
        cRet:="Unknow"
    Endif     

return cRet