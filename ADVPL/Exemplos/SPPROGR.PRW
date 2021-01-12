#Include "Protheus.ch"
#Include "TopConn.ch"
  

/*/{Protheus.doc} SPPROGR
Função SPPROGR, exemplo de uso de barras de progresso
@param Não recebe parametros
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Mar|2020
/*/
User Function SPPROGR(lLoop)          
Local nTipo as Numeric
default lLoop := .T.

//Seleção qual tipo de progresso deseja visualizar
nTipoRegua := Aviso('Atenção', 'Qual barra de progresso gostaria de executar?', {'FWMsgRun', 'Processa','MsAguarde', 'MsNewProcess', 'MsgRun','RptStatus', 'Fechar'}, 2)


//Conforme botão selecionado, monta a régua
If nTipoRegua == 1 
    FwMsgRun(,{|oSay|U_TDRFW1(oSay)},'Processando',"",)
ElseIf nTipoRegua == 2
    Processa({|| U_TDRFW2()}, "Calculando...")
ElseIf nTipoRegua == 3
     MsAguarde({|| U_TDRFW3()}, "Aguarde...", "Processando Registros...")
ElseIf nTipoRegua == 4
    oProcess := MsNewProcess():New({|| U_TDRFW4(oProcess)}, "Processando...", "Aguarde...", .T.)
    oProcess:Activate()
ElseIf nTipoRegua == 5
    MsgRun( "Processando" ,, {|| u_TDRFW5() } )
ElseIf nTipoRegua == 6
    RptStatus({|| u_TDRFW5()}, "Aguarde...", "Executando rotina...")
else
    lLoop := .F.
EndIf


If lLoop//chama a rotina novamente apos o processamento selecionado, até selecionar fechar
    u_SPPROGR()
EndIf

Return .T.

  
/*
Exemplo de uso de FWMSGRUM
*/
user Function TDRFW1(oSay)
Local nTotal as Numeric
Local _ni as Numeric
nTotal := 20
For _ni := 1 to nTotal
    //oSay
    Sleep( 500 ) // Para o processamento por 1/2 segundo
Next
Return .t.


/*
Exemplo de uso de PROCESSA
*/
user Function TDRFW2()
Local nTotal as Numeric
Local _ni as Numeric
nTotal :=30
ProcRegua(nTotal) //seta o total de registros
For _ni := 1 to nTotal
    IncProc("Processando registro " + cValToChar(_ni) + " de " + cValToChar(nTotal) + ", aguarde.")
    PROCESSMESSAGES() //Esse methodo deixa o processamento mais lento pois vai atualizar a tela todo momento, para melhor performance, remova esta parte
    Sleep( 500 ) // Para o processamento por 1/2 segundo
Next
Return .t.



/*
Exemplo de uso de MSAGUARDE
*/
user Function TDRFW3()
Local nTotal as Numeric
Local _ni as Numeric
nTotal := 30
ProcRegua(nTotal) //seta o total de registros
For _ni := 1 to nTotal
    MsProcTxt("Analisando registro " + cValToChar(_ni) + " de " + cValToChar(nTotal) + ", aguarde.")
    PROCESSMESSAGES()
    Sleep( 500 ) // Para o processamento por 1/2 segundo
Next
Return .t.



/*
Exemplo de uso de MsNewProcess
*/
user Function TDRFW4(oObj)
Local nTotal as Numeric
Local nTotal2 as Numeric
Local _ni as Numeric
Local _nj as Numeric
nTotal := 5
nTotal2 := 12

oObj:SetRegua1(nTotal) //Total da barra superior
For _nj := 1 to nTotal

    oObj:IncRegua1("Analisando registro " + cValToChar(_nj) + " de " + cValToChar(nTotal) + "...")
    PROCESSMESSAGES()
    oObj:SetRegua2(nTotal2) //Total da barra Inferior
    For _ni := 1 to nTotal2
        oObj:IncRegua2("Posição " + cValToChar(_ni) + " de " + cValToChar(nTotal2) + "...")
        PROCESSMESSAGES()
        Sleep( 500 ) // Para o processamento por 1/2 segundo
    Next

Next _nj

Return .t.



/*
Exemplo de uso de MSGRUN
*/
user Function TDRFW5()
Local nTotal as Numeric
Local _ni as Numeric
nTotal := 60
For _ni := 1 to nTotal
    Sleep( 500 ) // Para o processamento por 1/2 segundo
Next
Return .t.




/*
Exemplo de uso de RptStatus
*/
user Function TDRFW6()
Local nTotal as Numeric
Local _ni as Numeric
nTotal := 60
SetRegua(nTotal)
For _ni := 1 to nTotal
    IncRegua()
    Sleep( 500 ) // Para o processamento por 1/2 segundo
Next
Return .t.
