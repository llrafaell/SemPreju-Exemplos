#Include "Protheus.ch"
#INCLUDE "fileio.ch"


/*/{Protheus.doc} SPSLACK
(long_description)
@type  Function
@author user
@since 22/01/2020
@version version
@param param_name, param_type, param_descr
@return return_var, return_type, return_description
@example
(examples)
@see (links_or_references)
/*/
user Function SPSLACK()
Local cUrl := ''//TODO insira aqui a sua url do slack, similar a https://hooks.slack.com/services/TSN3MSKFD/BTG0YNAMQ/M1bSfoBKUEyUX4uc7DezlC
Local nTimeOut := 120
Local aHeadOut := {}
Local cHeadRet := ""
Local sPostRet := ""
Local _ni := 0

Local aMsg := u_FSLERLOG() //get messages


//aadd(aHeadOut,'User-Agent: Mozilla/4.0 (compatible; Protheus '+GetBuild()+')')
aadd(aHeadOut,'Content-type: application/json')
For _ni := 1 to len(aMsg)
    sPostRet := HttpPost(cUrl,,'{"text":"'+aMsg[_ni]+'"}',nTimeOut,aHeadOut,@cHeadRet)
next
if !empty(sPostRet)
  conout("HttpPost Ok")
  varinfo("WebPage", sPostRet)
else
  conout("HttpPost Failed.")
  varinfo("Header", cHeadRet)
Endif

Return .T.


/*/{Protheus.doc} User Function FSLERLOG
    (long_description)
    @type  Function
    @author user
    @since 22/01/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function FSLERLOG(cLogFile)
Local aMensagem as Array
Local cDelimt   as Character
default cLogFile := '\system\error.log'
aMensagem := {}
cDelimt := 'SP_JA_ENVIADO'



nHdl := fOpen(cLogFile, FO_READWRITE + FO_SHARED) //fopen('\sigaadv\error.log' , FO_READWRITE + FO_SHARED )
If nHdl == -1
    IF FERROR()== 516
        ALERT("Feche a planilha que gerou o arquivo.")
    EndIF
EndIf

//+---------------------------------------------------------------------+
//| Verifica se foi poss�vel abrir o arquivo                            |
//+---------------------------------------------------------------------+
If nHdl == -1
    cMsg := "O arquivo de nome "+cLogFile+" nao pode ser aberto! Verifique os parametros."
    MsgAlert(cMsg,"Atencao!")
    Return
Endif

//+---------------------------------------------------------------------+
//| Posiciona no Inicio do Arquivo                                      |
//+---------------------------------------------------------------------+
FSEEK(nHdl,0,0)

//+---------------------------------------------------------------------+
//| Traz o Tamanho do Arquivo TXT                                       |
//+---------------------------------------------------------------------+
nTamArq:=FSEEK(nHdl,0,2)

//+---------------------------------------------------------------------+
//| Posicona novamemte no Inicio                                        |
//+---------------------------------------------------------------------+
FSEEK(nHdl,0,0)

//+---------------------------------------------------------------------+
//| Fecha o Arquivo                                                     |
//+---------------------------------------------------------------------+
fClose(nHdl)
FT_FUse(cLogFile)  //abre o arquivo
FT_FGOTOP()         //posiciona na primeira linha do arquivo
nTamLinha := Len(FT_FREADLN()) //Ve o tamanho da linha
FT_FGOTOP()

//+---------------------------------------------------------------------+
//| Verifica quantas linhas tem o arquivo                               |
//+---------------------------------------------------------------------+
nLinhas := nTamArq/nTamLinha


nCont := 0
lAchou := .F.
lAchou2 := .F.
aDados:={}
While !FT_FEOF() //Ler todo o arquivo enquanto n�o for o final dele

    //Se achou o delimetador, zera array pq as inform��es ja foram enviadas
    If cDelimt $ FT_FREADLN()
        aMensagem  := {}
        lAchou2 := .T.
    Endif

    //Grava o erro para ser postado no Slack
    If 'THREAD ERROR' $ FT_FREADLN()
        aAdd(aMensagem," ") //Adcionar uma nova mensagem
        lAchou := .T.
    Endif
    If lAchou .and. nCont <= 8 //gravar 8 linhas
        aMensagem[len(aMensagem)] += FT_FREADLN() +CHR(13)+CHR(10)+CHR(13)+CHR(10)
        nCont ++
    else
        lAchou := .F.
        nCont := 0
    Endif
    clinha := FT_FREADLN()
    conout(clinha)

    FT_FSKIP()
EndDo

FT_FUse()
fClose(nHdl)
If !lAchou2
    nHdl := fOpen(cLogFile, FO_READWRITE + FO_SHARED) //fopen('\sigaadv\error.log' , FO_READWRITE + FO_SHARED )
    //add delimetador
    FSeek(nHdl, 0, FS_END)         // Posiciona no fim do arquivo
    fWrite(nHdl,cDelimt + chr(13)+chr(10) )
    fClose(nHdl)
Endif
Return aMensagem