#Include "Protheus.ch"
#INCLUDE "fileio.ch"

#define CAMINHO 'D:\TOTVS\Tabelas\'
Static lBySQL := .T. //inserir dados via SQL



User Function SPEXPALL()
//Exporta tabelas
u_SPEXPTABL() //sem threads

//gera pagina principal com todas os links para paginas das tabelas
U_SPEXP1()

//gera pagina principal com todas os links para paginas das consultas padrões
U_SPEXP2()

//gera pagina principal com todas os links para paginas de grupo de campo
U_SPEXP3()

//gera pagina principal com todas os links para paginas de gatilhoss
U_SPEXP4()

//gera tabelas de consulta padrão
U_SPEXP5()

//gera tabelas de gatilhos
U_SPEXP6()

//gera tabelas de Grupo de Campos
U_SPEXP7()

Return .t.

/*/{Protheus.doc} SPEXPTABL
Função responsável por gerar documentação das tabelas do Protheus
@type function
@author Rafael Gonçalves da Silva
@since 16/12/2019
@version 1.0
/*/
User Function SPEXPTABL()
Local aArea    as array
Local cDiretori as character
Local cArquivo  as character
Local nHdl      as numeric
Local aFields   as array // arary com campos de uma determinada tabela
Local _nI       as numeric


cDiretori  := CAMINHO+'\tabelas\'
//remover se for chamar do menu
RpcSetType(3)
RpcSetEnv('99', '01')

DbSelectArea('SX2')
SX2->(DbGoTop())
While !SX2->(EoF())
    aArea := GETAREA()
        FSGERA()
    RESTAREA(aArea)
    SX2->(DbSkip())
EndDo

Return .t.


//gera arquivo SX2
Static Function FSGERA()
Local aArea    as array

Local cDiretori as character
Local cArquivo  as character
Local nHdl      as numeric
Local aFields   as array // arary com campos de uma determinada tabela
Local _nI       as numeric

cDiretori  := CAMINHO+'\tabelas\'
cArquivo := 'tabela_'+lower(X2_CHAVE)+'.html'
conout("Iniciando: "+cArquivo)
nHdl := fCreate(cDiretori+cArquivo)
//Se houve falhas, encerra a rotina
If nHdl == -1
    MsgAlert("O arquivo '"+cDiretori+cArquivo+"' não pode ser criado!", "Atenção")
    Return .t.
Endif

//inicio da montagem do HTML
fWrite(nHdl, '<html>' + CRLF)
fWrite(nHdl, '<head><meta charset="UTF-8"><title>Tabela: '+SX2->X2_CHAVE + ' - '+ EncodeUTF8(alltrim(FwSX2Util():GetX2Name( SX2->X2_CHAVE )))+'</title></head>' + CRLF)
fWrite(nHdl, '<body>' + CRLF)
fWrite(nHdl, '<font color="orange"><h2 id="'+SX2->X2_CHAVE+'">Tabela: '+SX2->X2_CHAVE + ' - '+ EncodeUTF8(alltrim(FwSX2Util():GetX2Name( SX2->X2_CHAVE )))+'</h2></font>' + CRLF)
fWrite(nHdl, '<br>' + CRLF)

//Informações da Tabela
fWrite(nHdl, '<br><table border="1">' + CRLF)
fWrite(nHdl, '<tr><td colspan="5" align="center"><b><i>Tabela(SX2)</i></b></td></tr>')
fWrite(nHdl, '<tr>')
fWrite(nHdl,    '<td colspan="2"><b>X2_NOME</b></td>')
fWrite(nHdl,    '<td colspan="2"><b>X2_UNICO</b></td>')
fWrite(nHdl,    '<td><b>X2_SYSOBJ</b></td>')
fWrite(nHdl, '</tr>')
fWrite(nHdl, '<tr>')
fWrite(nHdl,    EncodeUTF8('<td colspan="2"><b>'+alltrim(SX2->X2_NOME)+'</b></td>'))
fWrite(nHdl,    EncodeUTF8('<td colspan="2"><b>'+alltrim(SX2->X2_UNICO)+'</b></td>'))
fWrite(nHdl,    '<td><b>'+alltrim(SX2->X2_SYSOBJ)+'</b></td>')
fWrite(nHdl, '</tr>')
fWrite(nHdl, '</table>' + CRLF)
fWrite(nHdl, '<br>' + CRLF)
fWrite(nHdl, '<hr>' + CRLF)
fWrite(nHdl, '<br>' + CRLF)


//imprime os indices da tabela
DbSelectArea('SIX')
SIX->(DbSetOrder(1))
If SIX->(DbSeek(SX2->X2_CHAVE))
    fWrite(nHdl, '<br><table border="1">' + CRLF)
    fWrite(nHdl, '<tr>')
    fWrite(nHdl, '<td colspan="5" align="center"><b><i>Indices(SIX)</i></b></td>')
    fWrite(nHdl, '</tr>')
    fWrite(nHdl, '<tr>')
    fWrite(nHdl, '<td><b>Ordem</b></td>')
    fWrite(nHdl, '<td colspan="2"><b>Chave</b></td>')
    fWrite(nHdl, EncodeUTF8('<td><b>Descrição</b></td>'))
    fWrite(nHdl, '<td><b>NickName</b></td>')
    fWrite(nHdl, '</tr>')

    //Percorre os campos
    While ! SIX->(Eof()) .And. SIX->INDICE == SX2->X2_CHAVE
        fWrite(nHdl, '<tr>')
        fWrite(nHdl, '<td>'+SIX->ORDEM+'</td>')
        fWrite(nHdl, '<td colspan="2">'+Alltrim(SIX->CHAVE)+'</td>')
        fWrite(nHdl, '<td>'+EncodeUTF8(Alltrim(SIX->DESCRICAO))+'</td>')
        fWrite(nHdl, '<td>'+Alltrim(SIX->NICKNAME)+'</td>')
        fWrite(nHdl, '</tr>' + CRLF)
        SIX->(DbSkip())
    EndDo
    fWrite(nHdl, '</table>' + CRLF)
EndIf

fWrite(nHdl, '<br>' + CRLF)
fWrite(nHdl, '<hr>' + CRLF)
fWrite(nHdl, '<br>' + CRLF)


//Informações folders
DbSelectArea("SXA")
DbSetOrder(1)
If DbSeek(SX2->X2_CHAVE)
    fWrite(nHdl, '<br><table border="1">' + CRLF)
    fWrite(nHdl, '<tr>')
    fWrite(nHdl, '<td colspan="6" align="center"><b><i>Abas(SXA)</i></b></td>')
    fWrite(nHdl, '</tr>')
    fWrite(nHdl, '<tr>')
    fWrite(nHdl, '<td><b>XA_ALIAS</b></td>')
    fWrite(nHdl, '<td><b>XA_ORDEM</b></td>')
    fWrite(nHdl, '<td colspan="2"><b>XA_DESCRIC</b></td>')
    fWrite(nHdl, '<td><b>XA_AGRUP</b></td>')
    fWrite(nHdl, '<td><b>XA_TIPO</b></td>')
    fWrite(nHdl, '</tr>')
    While (!Eof()) .AND. (SXA->XA_ALIAS == SX2->X2_CHAVE)
        fWrite(nHdl, '<tr>')
        fWrite(nHdl, '<td><b>'+Alltrim(SXA->XA_ALIAS)+'</b></td>')
        fWrite(nHdl, '<td><b>'+Alltrim(SXA->XA_ORDEM)+'</b></td>')
        fWrite(nHdl, '<td colspan="2"><b>'+Alltrim(SXA->XA_DESCRIC)+'</b></td>')
        fWrite(nHdl, '<td><b>'+Alltrim(SXA->XA_AGRUP)+'</b></td>')
        fWrite(nHdl, '<td><b>'+Alltrim(SXA->XA_TIPO)+'</b></td>')
        fWrite(nHdl, '</tr>')
        DbSelectArea("SXA")
        DbSkip()
    Enddo
    fWrite(nHdl, '</table>' + CRLF)
EndIf

fWrite(nHdl, '<br>' + CRLF)
fWrite(nHdl, '<hr>' + CRLF)
fWrite(nHdl, '<br>' + CRLF)

//Percorre o SX3 para montar os campos
aFields := {}//Zera array de execuções anteriores
aFields := FWSX3Util():GetAllFields(SX2->X2_CHAVE,.T.) //
If len(aFields) <= 0
    MsgAlert("Não foi encontrato nenhum campo para a tabela "+SX2->X2_CHAVE+"!", "Atenção")
    SX2->(DbSkip())
    fClose(nHdl)
    Return .t.
else
    //Cria tebela html para campos
    fWrite(nHdl, '<br><table border="1">' + CRLF)
    fWrite(nHdl, '<tr>' + CRLF)
    fWrite(nHdl, '<td colspan="24" align="center"><b><i>Campos(SX3)</i></b></td>' + CRLF)
    fWrite(nHdl, '</tr>' + CRLF)
    fWrite(nHdl, '<tr>' + CRLF)
    fWrite(nHdl, '<td><b>X3_CAMPO</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_TITULO</b></td>' + CRLF)
    fWrite(nHdl, '<td colspan="2"><b>X3_DESCRIC</b></td>' + CRLF)
    fWrite(nHdl, '<td colspan="4"><b>HELP Campo</b></td>' + CRLF)
    // fWrite(nHdl, '<td colspan="2"><b>HELP Solucao</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_TIPO</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_TAMANHO</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_DECIMAL</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_VALID</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_RELACAO</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_F3</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_TRIGGER</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_BROWSE</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_VISUAL</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_CONTEXT</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_OBRIGAT</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_CBOX</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_WHEN</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_INIBRW</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_GRPSXG</b></td>' + CRLF)
    fWrite(nHdl, '<td><b>X3_FOLDER</b></td>' + CRLF)
    fWrite(nHdl, '</tr>' + CRLF)

Endif

//Percorre array de campos
_nI := 1
For _nI:=1 to len(aFields)
    //https://tdn.totvs.com/pages/releaseview.action?pageId=6815033
    fWrite(nHdl, '<tr>' + CRLF)
    fWrite(nHdl, '<td>'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_CAMPO' ))+'</td>' + CRLF)
    fWrite(nHdl, EncodeUTF8('<td>'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_TITULO'))+'</td>') + CRLF)
    fWrite(nHdl, EncodeUTF8('<td colspan="2">'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_DESCRIC'))+'</td>') + CRLF)

    fWrite(nHdl, '<td colspan="4">'+EncodeUTF8(Alltrim(GetHlpSoluc(aFields[_nI])[1]))+'</td>' + CRLF)
    // fWrite(nHdl, '<td colspan="2">'+Alltrim(GetHlpSoluc(aFields[_nI])[2])+'</td>' + CRLF)

    fWrite(nHdl, '<td>'+GetSx3Cache( aFields[_nI], 'X3_TIPO') +'</td>' + CRLF)
    fWrite(nHdl, '<td>'+cvaltochar(GetSx3Cache( aFields[_nI], 'X3_TAMANHO')) +'</td>' + CRLF)
    fWrite(nHdl, '<td>'+cvaltochar(GetSx3Cache( aFields[_nI], 'X3_DECIMAL')) +'</td>' + CRLF)
    fWrite(nHdl, '<td>'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_VALID')) +'</td>' + CRLF)
    fWrite(nHdl, '<td>'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_RELACAO')) +'</td>' + CRLF)
    fWrite(nHdl, '<td><a href="/Tabelas_Protheus/tabelas/F3/'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_F3'))+'.html">'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_F3')) +'</a></td>' + CRLF)
    if !Empty(GetSx3Cache( aFields[_nI], 'X3_TRIGGER'))
        fWrite(nHdl, '<td><a href="/Tabelas_Protheus/tabelas/gatilhos/'+Alltrim(aFields[_nI])+'.html">'+GetSx3Cache( aFields[_nI], 'X3_TRIGGER') +'</td>' + CRLF)
    else
        fWrite(nHdl, '<td>'+GetSx3Cache( aFields[_nI], 'X3_TRIGGER') +'</td>' + CRLF)
    endif
    fWrite(nHdl, '<td>'+GetSx3Cache( aFields[_nI], 'X3_BROWSE') +'</td>' + CRLF)
    fWrite(nHdl, '<td>'+GetSx3Cache( aFields[_nI], 'X3_VISUAL') +'</td>' + CRLF)
    fWrite(nHdl, '<td>'+GetSx3Cache( aFields[_nI], 'X3_CONTEXT') +'</td>' + CRLF)
    fWrite(nHdl, '<td>'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_OBRIGAT')) +'</td>' + CRLF)
    fWrite(nHdl, '<td>'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_CBOX')) +'</td>' + CRLF)
    fWrite(nHdl, '<td>'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_WHEN')) +'</td>' + CRLF)
    fWrite(nHdl, '<td>'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_INIBRW')) +'</td>' + CRLF)
    fWrite(nHdl, '<td><a href="/Tabelas_Protheus/tabelas/grupoCampo/'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_GRPSXG'))+'.html">'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_GRPSXG')) +'</a></td>' + CRLF)
    fWrite(nHdl, '<td>'+Alltrim(GetSx3Cache( aFields[_nI], 'X3_FOLDER')) +'</td>' + CRLF)
    fWrite(nHdl, '</tr>' + CRLF)
Next

If len(aFields) > 0
    fWrite(nHdl, '</table>' + CRLF)
endif

fWrite(nHdl, '<br>' + CRLF)
fWrite(nHdl, '<hr>' + CRLF)
fWrite(nHdl, '<br>' + CRLF)

//Relacionamentos
DbSelectArea('SX9')
SX9->(DbSetOrder(1))
If SX9->(DbSeek(SX2->X2_CHAVE))
    fWrite(nHdl, '<br><table border="1">' + CRLF)
    fWrite(nHdl, '<tr>' + CRLF)
    fWrite(nHdl, '<td colspan="5" align="center"><b><i>Relacionamentos(SX9)</i></b></td>' + CRLF)
    fWrite(nHdl, '</tr>' + CRLF)
    fWrite(nHdl, '<tr>' + CRLF)
    fWrite(nHdl, '<td><b>X9_CDOM - Tabela Destino</b></td>' + CRLF)
    fWrite(nHdl, EncodeUTF8('<td colspan="2"><b>X9_EXPDOM - Expressão Origem</b></td>') + CRLF)
    fWrite(nHdl, EncodeUTF8('<td colspan="2"><b>X9_EXPCDOM - Expressão Destino</b></td>') + CRLF)
    fWrite(nHdl, '</tr>' + CRLF)

    //Percorre os campos
    While ! SX9->(Eof()) .And. SX9->X9_DOM == SX2->X2_CHAVE
        fWrite(nHdl, '<tr>' + CRLF)
        fWrite(nHdl, '<td>'+SX9->X9_CDOM+'</td>' + CRLF)
        fWrite(nHdl, '<td colspan="2">'+Alltrim(SX9->X9_EXPDOM)+'</td>' + CRLF)
        fWrite(nHdl, '<td colspan="2">'+Alltrim(SX9->X9_EXPCDOM)+'</td>' + CRLF)
        fWrite(nHdl, '</tr>' + CRLF)

        SX9->(DbSkip())
    EndDo
EndIf

fWrite(nHdl, '</center><br>' + CRLF)
//Fecha ponteiro do arquivo
fWrite(nHdl, '</html>' + CRLF)
fClose(nHdl)
conout("Finalizado: "+cArquivo)


return .t.



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//gera tabelas de consulta padrão
User Function SPEXP5()
Local cDiretori as character
Local cArquivo  as character
Local nHdl      as numeric

cDiretori  := CAMINHO +'F3\'
If !ExistDir( cDiretori )  //Checar se diretorio existe
    Conout('O Diretório: '+cDiretori+' Não existe, crie antes de continuar')
    Return .t.
else
    Conout('O arquivo será gerado no caminho: '+cDiretori+'.')
Endif

conout(IsBlind())
If !IsBlind() //nao for executado do menu
    RpcSetType(3)
    RpcSetEnv('99', '01')
Endif

conout("Iniciando exportação do SXB")

if select("SXB_EXP") > 0
    SXB_EXP->(DBCLOSEAREA())
endif
//-------------------
//Criação do objeto
//-------------------
oTempTable := FWTemporaryTable():New( "SXB_EXP" )
//--------------------------
//Monta os campos da tabela
//--------------------------
aFields := {}
aadd(aFields,{"XB_ALIAS","C",240,0})
aadd(aFields,{"XB_TIPO","C",240,0})
aadd(aFields,{"XB_SEQ","C",240,0})
aadd(aFields,{"XB_COLUNA","C",240,0})
aadd(aFields,{"XB_DESCRI","C",240,0})
aadd(aFields,{"XB_CONTEM","C",290,0})
oTemptable:SetFields( aFields )
oTempTable:AddIndex("01", {"XB_ALIAS"} )
//------------------
//Criação da tabela
//------------------
oTempTable:Create()

//------------------
//Grava os dados na tabela temporaria by SQL
//------------------
if lBySQL
    conout('inserindo dados no arquivo temporario por SQL')
    cQuery := "INSERT INTO " + oTempTable:GetRealName() + ' ( '
    For ii := 1 To Len(aFields)
		cQuery += aFields[ii][1] + ","
	Next ii
	cQuery := SubStr(cQuery,1,Len(cQuery)-1)
	cQuery += ") "
    cQuery += " SELECT XB_ALIAS,XB_TIPO,XB_SEQ,XB_COLUNA,XB_DESCRI,substring(XB_CONTEM,1,290)   "
    cQuery += " FROM SXB990 SXB " //TODO mudar para o alias de sua tabela
    cQuery += " WHERE SXB.D_E_L_E_T_ =' '"
    conout(cQuery)
    if TCSqlExec(cQuery) > 0
        conout('ERRO AO INSERIR DADOS NA TABELA TEMPORARIA')
        return .t.
    endif
else
    conout('inserindo dados no arquivo temporario')
    DbSelectArea('SXB')
    SXB->(DbGoTop())
    While !SXB->(EOF())

        DbSelectArea('SXB_EXP')
        reclock('SXB_EXP',.t.)
            SXB_EXP->XB_ALIAS   := alltrim(SXB->XB_ALIAS)
            SXB_EXP->XB_TIPO    := alltrim(SXB->XB_TIPO)
            SXB_EXP->XB_SEQ     := alltrim(SXB->XB_SEQ)
            SXB_EXP->XB_COLUNA  := alltrim(SXB->XB_COLUNA)
            SXB_EXP->XB_DESCRI  := alltrim(SXB->XB_DESCRI)
            SXB_EXP->XB_CONTEM  := alltrim(SXB->XB_CONTEM)
        SXB_EXP->(MsUnlock())
        DbSelectArea('SXB')
        SXB->(DBSKIP())
    Enddo

Endif

//------------------------------------
//Executa query para leitura da tabela
//------------------------------------
cQuery := "select * from "+ oTempTable:GetRealName() + " Order by  XB_ALIAS,XB_TIPO,XB_SEQ,XB_COLUNA,XB_DESCRI,XB_CONTEM"
MPSysOpenQuery( cQuery, 'QRYTMP' )
DbSelectArea('QRYTMP')
cAliAnt := '' //controle novo arquivo
while !eof()
    if cAliAnt <> QRYTMP->XB_ALIAS
        //Se nao for a primeira execucao, finaliza o arquivo anterior
        if !empty(cAliAnt)
            fWrite(nHdl, '</table><br>' + CRLF)
            //Fecha ponteiro do arquivo
            fWrite(nHdl, '</html>' + CRLF)
            fClose(nHdl)
            conout("Finalizado: "+cArquivo)
        endif

        cAliAnt := QRYTMP->XB_ALIAS
        cArquivo := lower(alltrim(QRYTMP->XB_ALIAS))+'.html'
        conout("Iniciando: "+cArquivo)
        nHdl := fCreate(cDiretori+cArquivo)
        //Se houve falhas, encerra a rotina
        If nHdl == -1
            MsgAlert("O arquivo '"+cDiretori+cArquivo+"' não pode ser criado!", "Atenção")
            exit
        Endif

        //inicio da montagem do HTML
        fWrite(nHdl, '<html>' + CRLF)
        fWrite(nHdl, EncodeUTF8('<head><title>Consulta Pasdrão: '+ alltrim(QRYTMP->XB_ALIAS) + ' - '+ alltrim(QRYTMP->XB_DESCRI)+'</title></head>') + CRLF)
        fWrite(nHdl, '<body>' + CRLF)
        fWrite(nHdl, '<font color="orange"><h2 id="'+SX2->X2_CHAVE+'">Consulta Padrï¿½o: '+alltrim(QRYTMP->XB_ALIAS) + ' - '+ alltrim(QRYTMP->XB_DESCRI)+'</h2></font>' + CRLF)
        fWrite(nHdl, '<br>' + CRLF)

        fWrite(nHdl, '<br><table border="1">' + CRLF)
        fWrite(nHdl, '<tr>')
        fWrite(nHdl, EncodeUTF8('<td colspan="6" align="center"><b><i>Consulta Padrão(SXB): '+alltrim(QRYTMP->XB_ALIAS) + ' - '+ alltrim(QRYTMP->XB_DESCRI)+'</i></b></td>'))
        fWrite(nHdl, '</tr>')
        fWrite(nHdl, '<tr>')
        fWrite(nHdl, '<td><b>XB_ALIAS</b></td>')
        fWrite(nHdl, '<td><b>XB_TIPO</b></td>')
        fWrite(nHdl, '<td><b>XB_SEQ</b></td>')
        fWrite(nHdl, '<td><b>XB_COLUNA</b></td>')
        fWrite(nHdl, '<td><b>XB_DESCRI</b></td>')
        fWrite(nHdl, '<td><b>XB_CONTEM</b></td>')
        fWrite(nHdl, '</tr>')
    endif

    //imprime todas as linhas
    fWrite(nHdl, '<tr>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->XB_ALIAS)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->XB_TIPO)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->XB_SEQ)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->XB_COLUNA)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->XB_DESCRI)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->XB_CONTEM)+'</b></td>')
    fWrite(nHdl, '</tr>')

    DbSelectArea('QRYTMP')
    QRYTMP->(dbskip())
Enddo

//Se executou algum SXB, fecha ultimo arquivo
if !empty(cAliAnt)
    fWrite(nHdl, '</table><br>' + CRLF)
    //Fecha ponteiro do arquivo
    fWrite(nHdl, '</html>' + CRLF)
    fClose(nHdl)
    conout("Finalizado: "+cArquivo)
endif

//Fecha alias SQL
if select("QRYTMP") > 0
    QRYTMP->(DBCLOSEAREA())
endif
//---------------------------------
//Exclui a tabela
//---------------------------------
oTempTable:Delete()


Return .t.




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//gera tabelas de gatilhos
User Function SPEXP6()
Local cDiretori as character
Local cArquivo  as character
Local nHdl      as numeric

cDiretori  := CAMINHO +'gatilhos\'
If !ExistDir( cDiretori )  //Checar se diretorio existe
    Conout('O Diretório: '+cDiretori+' Não existe, crie antes de continuar')
    Return .t.
else
    Conout('O arquivo será gerado no caminho: '+cDiretori+'.')
Endif

conout(IsBlind())
If !IsBlind() //nao for executado do menu
    RpcSetType(3)
    RpcSetEnv('99', '01')
Endif
conout("Iniciando SX7")
//Exportar SXB

if select("SX7_EXP") > 0
    SX7_EXP->(DBCLOSEAREA())
endif
//-------------------
//Criaï¿½ï¿½o do objeto
//-------------------
oTempTable := FWTemporaryTable():New( "SX7_EXP" )
//--------------------------
//Monta os campos da tabela
//--------------------------
aFields := {}
aadd(aFields,{"X7_CAMPO","C",240,0})
aadd(aFields,{"X7_SEQUENC","C",240,0})
aadd(aFields,{"X7_REGRA","C",240,0})
aadd(aFields,{"X7_CDOMIN","C",240,0})
aadd(aFields,{"X7_TIPO","C",240,0})
aadd(aFields,{"X7_SEEK","C",240,0})
aadd(aFields,{"X7_ALIAS","C",240,0})
aadd(aFields,{"X7_ORDEM","N",20,1})
aadd(aFields,{"X7_CHAVE","C",240,0})
aadd(aFields,{"X7_CONDIC","C",240,0})
oTemptable:SetFields( aFields )
oTempTable:AddIndex("01", {"X7_CAMPO"} )
//------------------
//Criaï¿½ï¿½o da tabela
//------------------
oTempTable:Create()

//------------------
//Grava os dados na tabela temporaria by SQL
//------------------
if lBySQL
    conout('inserindo dados no arquivo temporario por SQL')
    cQuery := "INSERT INTO " + oTempTable:GetRealName()+' ( '
        For ii := 1 To Len(aFields)
		cQuery += aFields[ii][1] + ","
	Next ii
	cQuery := SubStr(cQuery,1,Len(cQuery)-1)
	cQuery += ") "
    cQuery += " SELECT substring(X7_CAMPO,1,240),substring(X7_SEQUENC,1,240),substring(X7_REGRA,1,240),substring(X7_CDOMIN,1,240),substring(X7_TIPO,1,240),substring(X7_SEEK,1,240),substring(X7_ALIAS,1,240),X7_ORDEM,substring(X7_CHAVE,1,240),substring(X7_CONDIC,1,240) "
    cQuery += " FROM SX7990 SX7 " //TODO mudar para o alias de sua tabela
    cQuery += " WHERE SX7.D_E_L_E_T_ =' '  "
    conout(cQuery)
    if TCSqlExec(cQuery) > 0
        conout('ERRO AO INSERIR DADOS NA TABELA TEMPORARIA')
        return .t.
    endif
else
    conout('inserindo dados no arquivo temporario')
    DbSelectArea('SX7')
    SX7->(DbGoTop())
    While !SX7->(EOF())
        DbSelectArea('SX7_EXP')
        reclock('SX7_EXP',.t.)
            SX7_EXP->X7_CAMPO   := alltrim(SX7->X7_CAMPO)
            SX7_EXP->X7_SEQUENC := alltrim(SX7->X7_SEQUENC)
            SX7_EXP->X7_REGRA   := alltrim(SX7->X7_REGRA)
            SX7_EXP->X7_CDOMIN  := alltrim(SX7->X7_CDOMIN)
            SX7_EXP->X7_TIPO    := alltrim(SX7->X7_TIPO)
            SX7_EXP->X7_SEEK    := alltrim(SX7->X7_SEEK)
            SX7_EXP->X7_ALIAS   := alltrim(SX7->X7_ALIAS)
            SX7_EXP->X7_ORDEM   := SX7->X7_ORDEM
            SX7_EXP->X7_CHAVE   := alltrim(SX7->X7_CHAVE)
            SX7_EXP->X7_CONDIC  := alltrim(SX7->X7_CONDIC)
        SX7_EXP->(MsUnlock())
        DbSelectArea('SX7')
        SX7->(DBSKIP())
    Enddo

Endif

//------------------------------------
//Executa query para leitura da tabela
//------------------------------------
if Select('QRYTMP') > 0
    QRYTMP->(DbCloseAlias())
endif
cQuery := "select * from "+ oTempTable:GetRealName() + " Order by  X7_CAMPO, X7_SEQUENC "
MPSysOpenQuery( cQuery, 'QRYTMP' )
DbSelectArea('QRYTMP')
cAliAnt := '' //controle novo arquivo
while !eof()
    if cAliAnt <> QRYTMP->X7_CAMPO
        //Se nao for a primeira execucao, finaliza o arquivo anterior
        if !empty(cAliAnt)
            fWrite(nHdl, '</table><br>' + CRLF)
            //Fecha ponteiro do arquivo
            fWrite(nHdl, '</html>' + CRLF)
            fClose(nHdl)
            conout("Finalizado: "+cArquivo)
        endif

        cAliAnt := QRYTMP->X7_CAMPO
        cArquivo := alltrim(QRYTMP->X7_CAMPO)+'.html'
        conout("Iniciando: "+cArquivo)
        nHdl := fCreate(cDiretori+cArquivo)
        //Se houve falhas, encerra a rotina
        If nHdl == -1
            MsgAlert("O arquivo '"+cDiretori+cArquivo+"' nï¿½o pode ser criado!", "Atenï¿½ï¿½o")
            exit
        Endif

        //inicio da montagem do HTML
        fWrite(nHdl, '<html>' + CRLF)
        fWrite(nHdl, '<head><title>Gatilhos Campo: '+ alltrim(QRYTMP->X7_CAMPO)+'</title></head>' + CRLF)
        fWrite(nHdl, '<body>' + CRLF)
        fWrite(nHdl, '<font color="orange"><h2 id="'+SX2->X2_CHAVE+'">Gatilhos no Campo: '+alltrim(QRYTMP->X7_CAMPO)+'</h2></font>' + CRLF)
        fWrite(nHdl, '<br>' + CRLF)

        fWrite(nHdl, '<br><table border="1">' + CRLF)
        fWrite(nHdl, '<tr>')
        fWrite(nHdl, '<td colspan="10" align="center"><b><i>Gatilhos(SX7) no Campo: '+alltrim(QRYTMP->X7_CAMPO)+'</i></b></td>')
        fWrite(nHdl, '</tr>')
        fWrite(nHdl, '<tr>')
        fWrite(nHdl, '<td><b>X7_CAMPO</b></td>')
        fWrite(nHdl, '<td><b>X7_SEQUENC</b></td>')
        fWrite(nHdl, '<td><b>X7_REGRA</b></td>')
        fWrite(nHdl, '<td><b>X7_CDOMIN</b></td>')
        fWrite(nHdl, '<td><b>X7_TIPO</b></td>')
        fWrite(nHdl, '<td><b>X7_SEEK</b></td>')
        fWrite(nHdl, '<td><b>X7_ALIAS</b></td>')
        fWrite(nHdl, '<td><b>X7_ORDEM</b></td>')
        fWrite(nHdl, '<td><b>X7_CHAVE</b></td>')
        fWrite(nHdl, '<td><b>X7_CONDIC</b></td>')
        fWrite(nHdl, '</tr>')
    endif

    //imprime todas as linhas
    fWrite(nHdl, '<tr>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->X7_CAMPO)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->X7_SEQUENC)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->X7_REGRA)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->X7_CDOMIN)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->X7_TIPO)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->X7_SEEK)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->X7_ALIAS)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(cvaltochar(QRYTMP->X7_ORDEM))+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->X7_CHAVE)+'</b></td>')
    fWrite(nHdl, '<td><b>'+alltrim(QRYTMP->X7_CONDIC)+'</b></td>')
    fWrite(nHdl, '</tr>')

    DbSelectArea('QRYTMP')
    QRYTMP->(dbskip())
Enddo

//Se executou algum SXB, fecha ultimo arquivo
if !empty(cAliAnt)
    fWrite(nHdl, '</table><br>' + CRLF)
    //Fecha ponteiro do arquivo
    fWrite(nHdl, '</html>' + CRLF)
    fClose(nHdl)
    conout("Finalizado: "+cArquivo)
endif

//Fecha alias SQL
if select("QRYTMP") > 0
    QRYTMP->(DBCLOSEAREA())
endif
//---------------------------------
//Exclui a tabela
//---------------------------------
oTempTable:Delete()


Return .t.


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//gera tabelas de Grupo de Campos
User Function SPEXP7()
Local cDiretori as character
Local cArquivo  as character
Local nHdl      as numeric

cDiretori  := CAMINHO +'grupoCampo\'
If !ExistDir( cDiretori )  //Checar se diretorio existe
    Conout('O Diretório: '+cDiretori+' Não existe, crie antes de continuar')
    Return .t.
else
    Conout('O arquivo será gerado no caminho: '+cDiretori+'.')
Endif

conout(IsBlind())
If !IsBlind() //nao for executado do menu
    RpcSetType(3)
    RpcSetEnv('99', '01')
Endif
conout("Iniciando SXG")
//Exportar SXB

dbselectArea('SXG')
DbGoTop()
While !eof()
    cArquivo := alltrim(SXG->XG_GRUPO)+'.html'
    conout("Iniciando: "+cArquivo)
    nHdl := fCreate(cDiretori+cArquivo)
    //Se houve falhas, encerra a rotina
    If nHdl == -1
        MsgAlert("O arquivo '"+cDiretori+cArquivo+"' não pode ser criado!", "Atenção")
        exit
    Endif

     //inicio da montagem do HTML
    fWrite(nHdl, '<html>' + CRLF)
    fWrite(nHdl, '<head><title>Grupo de Campo(SXG): '+ alltrim(SXG->XG_GRUPO)+'</title></head>' + CRLF)
    fWrite(nHdl, '<body>' + CRLF)
    fWrite(nHdl, '<font color="orange"><h2 id="'+SX2->X2_CHAVE+'">Grupo de Campo(SXG): '+alltrim(SXG->XG_GRUPO)+'</h2></font>' + CRLF)
    fWrite(nHdl, '<br>' + CRLF)

    fWrite(nHdl, '<br><table border="1">' + CRLF)
    fWrite(nHdl, '<tr>')
    fWrite(nHdl, '<td colspan="10" align="center"><b><i>Grupo de Campo(SXG): '+alltrim(SXG->XG_GRUPO)+'</i></b></td>')
    fWrite(nHdl, '</tr>')
    fWrite(nHdl, '<tr>')
    fWrite(nHdl, '<td><b>XG_GRUPO</b></td>')
    fWrite(nHdl, '<td><b>XG_DESCRI</b></td>')
    fWrite(nHdl, '<td><b>XG_SIZEMAX</b></td>')
    fWrite(nHdl, '<td><b>XG_SIZEMIN</b></td>')
    fWrite(nHdl, '<td><b>XG_SIZE</b></td>')
    fWrite(nHdl, '<td><b>XG_PICTURE</b></td>')
    fWrite(nHdl, '</tr>')

    fWrite(nHdl, '<tr>')
    fWrite(nHdl, '<td><b>'+ Alltrim(SXG->XG_GRUPO)+'</b></td>')
    fWrite(nHdl, '<td><b>'+ Alltrim(SXG->XG_DESCRI)+'</b></td>')
    fWrite(nHdl, '<td><b>'+ Alltrim(cvaltochar(SXG->XG_SIZEMAX))+'</b></td>')
    fWrite(nHdl, '<td><b>'+ Alltrim(cvaltochar(SXG->XG_SIZEMIN))+'</b></td>')
    fWrite(nHdl, '<td><b>'+ Alltrim(cvaltochar(SXG->XG_SIZE))+'</b></td>')
    fWrite(nHdl, '<td><b>'+Alltrim( SXG->XG_PICTURE)+'</b></td>')
    fWrite(nHdl, '</tr>')

    fWrite(nHdl, '</table><br>' + CRLF)
    //Fecha ponteiro do arquivo
    fWrite(nHdl, '</html>' + CRLF)
    fClose(nHdl)
    conout("Finalizado: "+cArquivo)

    dbselectArea('SXG')
    SXG->(DbSkip())
enddo

Return .t.







//Retorna o Header da Pagina
static function FSHeader()
Local cReturn as character
cReturn := ' '


//inicio da montagem do HTML
cReturn += '<?php' + CRLF
cReturn += "if(file_exists('../../../wp-load.php')) {" + CRLF
cReturn += '  require_once("../../../wp-load.php");' + CRLF
cReturn += "} else if(file_exists('../../wp-load.php')) { " + CRLF
cReturn += 'require_once("../../wp-load.php");' + CRLF
cReturn += "} else if(file_exists('../wp-load.php')) {" + CRLF
cReturn += ' 	require_once("../wp-load.php");' + CRLF
cReturn += "} else if(file_exists('wp-load.php')) {  " + CRLF
cReturn += ' 	require_once("wp-load.php");' + CRLF
cReturn += "} else if(file_exists('../../../../wp-load.php')) {" + CRLF
cReturn += 'require_once("../../../../wp-load.php"); ' + CRLF
cReturn += " } else if(file_exists('../../../../wp-load.php')) {" + CRLF
cReturn += 'require_once("../../../../wp-load.php");' + CRLF
cReturn += "} else { " + CRLF
cReturn += "	if(file_exists('../../../wp-config.php')) { " + CRLF
cReturn += ' 		require_once("../../../wp-config.php");' + CRLF
cReturn += "	} else if(file_exists('../../wp-config.php')) { " + CRLF
cReturn += '		require_once("../../wp-config.php"); ' + CRLF
cReturn += "	} else if(file_exists('../wp-config.php')) { " + CRLF
cReturn += '		require_once("../wp-config.php"); ' + CRLF
cReturn += "	} else if(file_exists('wp-config.php')) { " + CRLF
cReturn += '		require_once("wp-config.php"); ' + CRLF
cReturn += "	} else if(file_exists('../../../../wp-config.php')) {   " + CRLF
cReturn += '		require_once("../../../../wp-config.php"); ' + CRLF
cReturn += "	} else if(file_exists('../../../../wp-config.php')) { " + CRLF
cReturn += '		require_once("../../../../wp-config.php"); ' + CRLF
cReturn += "	} else { " + CRLF
cReturn += '		exit; ' + CRLF
cReturn += "	} " + CRLF
cReturn += '} ' + CRLF
cReturn += 'get_header(); ' + CRLF
cReturn += '?> ' + CRLF

cReturn += '<style> ' + CRLF
cReturn += '#table-scroll { ' + CRLF
cReturn += ' height:450px;' + CRLF
cReturn += '  overflow:auto; ' + CRLF
cReturn += '  margin-top:20px; ' + CRLF
cReturn += '} ' + CRLF
cReturn += '#table-wrapper table thead th .text { ' + CRLF
cReturn += '  position:absolute; ' + CRLF
cReturn += '  top:-20px; ' + CRLF
cReturn += '  z-index:2; ' + CRLF
cReturn += '  height:20px; ' + CRLF
cReturn += '  width:35%; ' + CRLF
cReturn += '  border:1px solid red; ' + CRLF
cReturn += '} ' + CRLF
cReturn +='</style> ' + CRLF

return cReturn


//Retorna o rodapé
Static Function FSFooter()
Local cReturn as character

cReturn := ' '
cReturn += '<script>' + CRLF
cReturn += 'function myFunction() {' + CRLF
cReturn += '  // Declare variables' + CRLF
cReturn += '  var input, filter, table, tr, td, i, txtValue;' + CRLF
cReturn += '  input = document.getElementById("myInput");' + CRLF
cReturn += '  filter = input.value.toUpperCase();' + CRLF
cReturn += '  table = document.getElementById("myTable");' + CRLF
cReturn += '  tr = table.getElementsByTagName("tr");' + CRLF

cReturn += '  // Loop through all table rows, and hide those who dont match the search query' + CRLF
cReturn += '  for (i = 0; i < tr.length; i++) {' + CRLF
cReturn += '    td = tr[i].getElementsByTagName("td")[0];' + CRLF
cReturn += '    if (td) {' + CRLF
cReturn += '      txtValue = td.textContent || td.innerText;' + CRLF
cReturn += '      if (txtValue.toUpperCase().indexOf(filter) > -1) {' + CRLF
cReturn += '        tr[i].style.display = "";' + CRLF
cReturn += '      } else {' + CRLF
cReturn += '        tr[i].style.display = "none";' + CRLF
cReturn += '      }' + CRLF
cReturn += '    }' + CRLF
cReturn += '  }' + CRLF
cReturn += '}' + CRLF
cReturn += '</script>' + CRLF
cReturn += '<?php' + CRLF
cReturn += 'get_footer();' + CRLF
cReturn += '?>' + CRLF

return cReturn




//gera arquivo com todas as tabelas(listagem)
User Function SPEXP1()
Local cDiretori as character
Local cArquivo  as character
Local nHdl      as numeric

cDiretori  := CAMINHO
If !ExistDir( cDiretori )  //Checar se diretorio existe
    Conout('O Diretório: '+cDiretori+' Não existe, crie antes de continuar')
    Return .t.
else
    Conout('O arquivo será gerado no caminho: '+cDiretori+'.')
Endif

conout(IsBlind())
If !IsBlind() //nao for executado do menu
    RpcSetType(3)
    RpcSetEnv('99', '01')
Endif

cArquivo := 'Tabelas_Protheus.php' //arquivo pai que chamas todos as demais tabelas
conout("Iniciando: "+cArquivo)

nHdl := fCreate(cDiretori+cArquivo)
//Se houve falhas, encerra a rotina
If nHdl == -1
    MsgAlert("O arquivo '"+cDiretori+cArquivo+"' não pode ser criado!", "Atenção")
    return
Endif

fWrite(nHdl, FSHeader() + CRLF) //header para Wordpress, se não usar remover

fWrite(nHdl, '<body> ' + CRLF)
fWrite(nHdl, '<center> <br><br><br><br><br>' + CRLF)
fWrite(nHdl, '	<h2>Tabelas Protheus </h2> ' + CRLF)
fWrite(nHdl, EncodeUTF8('	<input type="text" id="myInput" style="width: 400px;" onkeyup="myFunction()" placeholder="Digite código da tabela ou descrição.."> ') + CRLF)
fWrite(nHdl, '	<div id="table-wrapper" style="width: 450px; height: 700px" > ' + CRLF)
fWrite(nHdl, '	  <div id="table-scroll" 	> ' + CRLF)
fWrite(nHdl, '		<table  border="1" id="myTable" > ' + CRLF)
fWrite(nHdl, '			<thead> ' + CRLF)
fWrite(nHdl, '				<tr> ' + CRLF)
fWrite(nHdl, '					<th >Tabela</th> ' + CRLF)
fWrite(nHdl, '				</tr> ' + CRLF)
fWrite(nHdl, '			</thead> ' + CRLF)
fWrite(nHdl, '			<tbody> ' + CRLF)

DbSelectArea('SX2')
SX2->(DbGoTop())
While !SX2->(EoF())

    fWrite(nHdl, '				<tr> ' + CRLF)
    fWrite(nHdl, '					<td><a href="/Tabelas_Protheus/tabelas/tabela_'+alltrim(lower(SX2->X2_CHAVE))+'.html">'+EncodeUTF8(alltrim(Upper(SX2->X2_CHAVE)+' - '+(FwSX2Util():GetX2Name( SX2->X2_CHAVE ))))+'</a></td> ' + CRLF)
    fWrite(nHdl, '				</tr> ' + CRLF)
    SX2->(DbSkip())

EndDo

fWrite(nHdl, '        </tbody>' + CRLF)
fWrite(nHdl, '        </table>' + CRLF)
fWrite(nHdl, '   </div>' + CRLF)
fWrite(nHdl, '</div>' + CRLF)
fWrite(nHdl, '</center>' + CRLF)

fWrite(nHdl, FSFooter() + CRLF) //rodapé para usar wordpress

fClose(nHdl)
conout("Finalizado exportação da pagina de tabela: "+cArquivo)

Return .t.





//gera arquivo com todas as consulta padrões(listagem)
User Function SPEXP2()
Local cDiretori as character
Local cArquivo  as character
Local nHdl      as numeric
Local ii as numeric

cDiretori  := CAMINHO
If !ExistDir( cDiretori )  //Checar se diretorio existe
    Conout('O Diretório: '+cDiretori+' Não existe, crie antes de continuar')
    Return .t.
else
    Conout('O arquivo será gerado no caminho: '+cDiretori+'.')
Endif

conout(IsBlind())
If !IsBlind() //nao for executado do menu
    RpcSetType(3)
    RpcSetEnv('99', '01')
Endif

cArquivo := 'Consulta_Padrao_Protheus.php' //arquivo pai que chamas todos as demais tabelas
conout("Iniciando: "+cArquivo)

nHdl := fCreate(cDiretori+cArquivo)
//Se houve falhas, encerra a rotina
If nHdl == -1
    MsgAlert("O arquivo '"+cDiretori+cArquivo+"' não pode ser criado!", "Atenção")
    return
Endif

fWrite(nHdl, FSHeader() + CRLF) //header para Wordpress, se não usar remover

fWrite(nHdl, '<body> ' + CRLF)
fWrite(nHdl, '<center> <br><br><br><br><br>' + CRLF)
fWrite(nHdl, EncodeUTF8('	<h2>Consulta Padrão  Protheus </h2> ') + CRLF)
fWrite(nHdl, EncodeUTF8('	<input type="text" id="myInput" style="width: 400px;" onkeyup="myFunction()" placeholder="Digite código da consulta ou descrição.."> ') + CRLF)
fWrite(nHdl, '	<div id="table-wrapper" style="width: 450px; height: 700px" > ' + CRLF)
fWrite(nHdl, '	  <div id="table-scroll" 	> ' + CRLF)
fWrite(nHdl, '		<table  border="1" id="myTable" > ' + CRLF)
fWrite(nHdl, '			<thead> ' + CRLF)
fWrite(nHdl, '				<tr> ' + CRLF)
fWrite(nHdl, EncodeUTF8('					<th >Consulta Padrão</th> ') + CRLF)
fWrite(nHdl, '				</tr> ' + CRLF)
fWrite(nHdl, '			</thead> ' + CRLF)
fWrite(nHdl, '			<tbody> ' + CRLF)

If select("SXB_EXP") > 0
    SXB_EXP->(DBCLOSEAREA())
EndIf
//-------------------
//Criação do objeto tebela temporaria
//-------------------
oTempTable := FWTemporaryTable():New( "SXB_EXP" )
//--------------------------
//Monta os campos da tabela
//--------------------------
aFields := {}
aadd(aFields,{"XB_ALIAS","C",240,0})
aadd(aFields,{"XB_DESCRI","C",240,0})
oTemptable:SetFields( aFields )
oTempTable:AddIndex("01", {"XB_ALIAS"} )
//------------------
//Criação da tabela temporaria
//------------------
oTempTable:Create()

//------------------
//Grava os dados na tabela temporaria by SQL
//------------------
if lBySQL
    conout('inserindo dados no arquivo temporario por SQL')
    cQuery := "INSERT INTO " + oTempTable:GetRealName() +" ( "
	For ii := 1 To Len(aFields)
		cQuery += aFields[ii][1] + ","
	Next ii
	cQuery := SubStr(cQuery,1,Len(cQuery)-1)
	cQuery += ") "
    cQuery += " select XB_ALIAS,XB_DESCRI  from SXB990 SXB "
    cQuery += " where XB_TIPO=1 and SXB.D_E_L_E_T_ =' ' "
    //cQuery += " order by XB_ALIAS "
    //conout(cQuery)
    if TCSqlExec(cQuery) > 0
        conout('ERRO AO INSERIR DADOS NA TABELA TEMPORARIA')
        return .t.
    endif
else
    conout('inserindo dados no arquivo temporario')
    DbSelectArea('SXB')
    SXB->(DbGoTop())
    While !SXB->(EOF())
        If alltrim(SXB->XB_TIPO) <> '1'
            DbSelectArea('SXB')
            SXB->(DBSKIP())
            loop
        endif

        DbSelectArea('SXB_EXP')
        reclock('SXB_EXP',.t.)
            SXB_EXP->XB_ALIAS   := alltrim(SXB->XB_ALIAS)
            SXB_EXP->XB_DESCRI  := alltrim(SXB->XB_DESCRI)
        SXB_EXP->(MsUnlock())
        DbSelectArea('SXB')
        SXB->(DBSKIP())
    Enddo

Endif

//------------------------------------
//Executa query para leitura da tabela
//------------------------------------
cQuery := "select * from "+ oTempTable:GetRealName() + " Order by  XB_ALIAS"
MPSysOpenQuery( cQuery, 'QRYTMP' )
DbSelectArea('QRYTMP')
cAliAnt := '' //controle novo arquivo
while !(QRYTMP->(eof()))

    fWrite(nHdl, '				<tr> ' + CRLF)
    fWrite(nHdl, '					<td><a href="/Tabelas_Protheus/F3/'+alltrim(lower(QRYTMP->XB_ALIAS))+'.html">'+EncodeUTF8(alltrim(Upper(QRYTMP->XB_ALIAS)+' - '+Capital(QRYTMP->XB_DESCRI)))+'</a></td> ' + CRLF)
    fWrite(nHdl, '				</tr> ' + CRLF)

    QRYTMP->(dbskip())
Enddo

fWrite(nHdl, '        </tbody>' + CRLF)
fWrite(nHdl, '        </table>' + CRLF)
fWrite(nHdl, '   </div>' + CRLF)
fWrite(nHdl, '</div>' + CRLF)
fWrite(nHdl, '</center>' + CRLF)

fWrite(nHdl, FSFooter() + CRLF) //rodapé para usar wordpress

fClose(nHdl)
conout("Finalizado exportação da pagina de tabela: "+cArquivo)

Return .t.





//gera arquivo com todas os grupo de campo
User Function SPEXP3()
Local cDiretori as character
Local cArquivo  as character
Local nHdl      as numeric

cDiretori  := CAMINHO
If !ExistDir( cDiretori )  //Checar se diretorio existe
    Conout('O Diretório: '+cDiretori+' Não existe, crie antes de continuar')
    Return .t.
else
    Conout('O arquivo será gerado no caminho: '+cDiretori+'.')
Endif

conout(IsBlind())
If !IsBlind() //nao for executado do menu
    RpcSetType(3)
    RpcSetEnv('99', '01')
Endif

cArquivo := 'grupo_campos_Protheus.php' //arquivo pai que chamas todos as demais tabelas
conout("Iniciando: "+cArquivo)

nHdl := fCreate(cDiretori+cArquivo)
//Se houve falhas, encerra a rotina
If nHdl == -1
    MsgAlert("O arquivo '"+cDiretori+cArquivo+"' não pode ser criado!", "Atenção")
    return
Endif

fWrite(nHdl, FSHeader() + CRLF) //header para Wordpress, se não usar remover

fWrite(nHdl, '<body> ' + CRLF)
fWrite(nHdl, '<center> <br><br><br><br><br>' + CRLF)
fWrite(nHdl, '	<h2>Grupo de Campos Protheus </h2> ' + CRLF)
fWrite(nHdl, EncodeUTF8('	<input type="text" id="myInput" style="width: 400px;" onkeyup="myFunction()" placeholder="Digite código da Grupo ou descrição.."> ') + CRLF)
fWrite(nHdl, '	<div id="table-wrapper" style="width: 450px; height: 700px" > ' + CRLF)
fWrite(nHdl, '	  <div id="table-scroll" 	> ' + CRLF)
fWrite(nHdl, '		<table  border="1" id="myTable" > ' + CRLF)
fWrite(nHdl, '			<thead> ' + CRLF)
fWrite(nHdl, '				<tr> ' + CRLF)
fWrite(nHdl, '					<th >Grupo de Campos</th> ' + CRLF)
fWrite(nHdl, '				</tr> ' + CRLF)
fWrite(nHdl, '			</thead> ' + CRLF)
fWrite(nHdl, '			<tbody> ' + CRLF)

DbSelectArea('SXG')
SXG->(DbGoTop())
While !SXG->(EoF())

    fWrite(nHdl, '				<tr> ' + CRLF)
    fWrite(nHdl, '					<td><a href="/Tabelas_Protheus/grupoCampo/'+alltrim(lower(SXG->XG_GRUPO))+'.html">'+EncodeUTF8(alltrim(Upper(SXG->XG_GRUPO)+' - '+capital(SXG->XG_DESCRI)))+'</a></td> ' + CRLF)
    fWrite(nHdl, '				</tr> ' + CRLF)
    SXG->(DbSkip())

EndDo

fWrite(nHdl, '        </tbody>' + CRLF)
fWrite(nHdl, '        </table>' + CRLF)
fWrite(nHdl, '   </div>' + CRLF)
fWrite(nHdl, '</div>' + CRLF)
fWrite(nHdl, '</center>' + CRLF)

fWrite(nHdl, FSFooter() + CRLF) //rodapé para usar wordpress

fClose(nHdl)
conout("Finalizado exportação da pagina de grupo campos: "+cArquivo)

Return .t.




//gera arquivo com todas os gatilhos
User Function SPEXP4()
Local cDiretori as character
Local cArquivo  as character
Local nHdl      as numeric

cDiretori  := CAMINHO
If !ExistDir( cDiretori )  //Checar se diretorio existe
    Conout('O Diretório: '+cDiretori+' Não existe, crie antes de continuar')
    Return .t.
else
    Conout('O arquivo será gerado no caminho: '+cDiretori+'.')
Endif

//conout(IsBlind())
If !IsBlind() //nao for executado do menu
    RpcSetType(3)
    RpcSetEnv('99', '01')
Endif

cArquivo := 'Gatilhos_Protheus.php' //arquivo pai que chamas todos as demais tabelas
conout("Iniciando: "+cArquivo)

nHdl := fCreate(cDiretori+cArquivo)
//Se houve falhas, encerra a rotina
If nHdl == -1
    MsgAlert("O arquivo '"+cDiretori+cArquivo+"' não pode ser criado!", "Atenção")
    return
Endif

fWrite(nHdl, FSHeader() + CRLF) //header para Wordpress, se não usar remover

fWrite(nHdl, '<body> ' + CRLF)
fWrite(nHdl, '<center> <br><br><br><br><br>' + CRLF)
fWrite(nHdl, '	<h2>Gatilhos Protheus </h2> ' + CRLF)
fWrite(nHdl, EncodeUTF8('	<input type="text" id="myInput" style="width: 400px;" onkeyup="myFunction()" placeholder="Digite código do campo.."> ') + CRLF)
fWrite(nHdl, '	<div id="table-wrapper" style="width: 450px; height: 700px" > ' + CRLF)
fWrite(nHdl, '	  <div id="table-scroll" 	> ' + CRLF)
fWrite(nHdl, '		<table  border="1" id="myTable" > ' + CRLF)
fWrite(nHdl, '			<thead> ' + CRLF)
fWrite(nHdl, '				<tr> ' + CRLF)
fWrite(nHdl, '					<th >Gatilhos</th> ' + CRLF)
fWrite(nHdl, '				</tr> ' + CRLF)
fWrite(nHdl, '			</thead> ' + CRLF)
fWrite(nHdl, '			<tbody> ' + CRLF)

DbSelectArea('SX7')
dbsetorder(1)
SX7->(DbGoTop())
cCampo := ' '
While !SX7->(EoF())
    If cCampo <> SX7->X7_CAMPO
        cCampo := SX7->X7_CAMPO
        fWrite(nHdl, '				<tr> ' + CRLF)
        fWrite(nHdl, '					<td><a href="/Tabelas_Protheus/gatilhos/'+alltrim(lower(SX7->X7_CAMPO))+'.html">'+EncodeUTF8(alltrim(Upper(SX7->X7_CAMPO)))+'</a></td> ' + CRLF)
        fWrite(nHdl, '				</tr> ' + CRLF)
    Endif
    SX7->(DbSkip())
EndDo

fWrite(nHdl, '        </tbody>' + CRLF)
fWrite(nHdl, '        </table>' + CRLF)
fWrite(nHdl, '   </div>' + CRLF)
fWrite(nHdl, '</div>' + CRLF)
fWrite(nHdl, '</center>' + CRLF)

fWrite(nHdl, FSFooter() + CRLF) //rodapé para usar wordpress

fClose(nHdl)
conout("Finalizado exportação da pagina de gatilhos: "+cArquivo)

Return .t.

