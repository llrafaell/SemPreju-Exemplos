#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"


/*/{Protheus.doc} SPCHAVIN
Fun��o SPCHAVIN para buscar uma chave no ini e retornar o valor
@param chave e valor padrao 
@return N�o retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Mar|2020
/*/
User Function SPCHAVIN()          
Local cMensagem as Character        
Local cServerIni as Character        
Local cClientIni as Character
Local cSecao as Character
Local cChave as Character
Local cPadrao as Character


cServerIni := GetAdv97()
cClientIni := GetRemoteIniName()
cSecao := "General" //vamos ser os parametros da sess�o [General]
cChave := "InstallPath" //qual chave queremos retornar o valor
cPadrao := "NaoEncontrado" //se nao encontrar esse � o valor padrao a ser retornado

cMensagem := "Arquivo de configura��o do servidor: [" + cServerIni + "]" + CRLF
cMensagem += "  sess�o [" + cSecao + "] Chave [" + cChave + "] Valor [" + ;
GetPvProfString(cSecao, cChave, cPadrao, cServerIni) + "]" + CRLF+ CRLF+ CRLF

cMensagem += "Arquivo de configura��o da esta��o: [" + cClientIni + "]" + CRLF
cMensagem += "  sess�o [" + cSecao + "] Chave [" + cChave + "] Valor [" + ;
GetPvProfString(cSecao, cChave, cPadrao, cClientIni) + "]" + CRLF
//+----------------------------------------------------------------------------+
//|Apresenta uma mensagem com os resultados obtidos                            |
//+----------------------------------------------------------------------------+
MsgInfo(cMensagem, "Exemplo do GetPvProfString")


//� possivel assim criarmos uma chave customizada e usar ela em nossos fontes, como abaixo


cSecao := "SEMPREJU" //vamos ser os parametros da sess�o [SEMPREJU]
cChave := "url" //qual chave queremos retornar o valor
cPadrao := "URL n�o encontrada" //se nao encontrar esse � o valor padrao a ser retornado

cMensagem := "Arquivo de configur��o do servidor: [" + cServerIni + "]" + CRLF
cMensagem += "  sess�o [" + cSecao + "] Chave [" + cChave + "] Valor [" + ;
GetPvProfString(cSecao, cChave, cPadrao, cServerIni) + "]" + CRLF+ CRLF+ CRLF
//+----------------------------------------------------------------------------+
//|Apresenta uma mensagem com os resultados obtidos                            |
//+----------------------------------------------------------------------------+
MsgInfo(cMensagem, "Exemplo do GetPvProfString")


Return .T.
