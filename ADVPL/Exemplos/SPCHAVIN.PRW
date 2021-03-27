#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"


/*/{Protheus.doc} SPCHAVIN
FunÃ§Ã£o SPCHAVIN para buscar uma chave no ini e retornar o valor
@param chave e valor padrao 
@return NÃ£o retorna nada
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
cSecao := "General" //vamos ser os parametros da seÃ§Ã£o [General]
cChave := "InstallPath" //qual chave queremos retornar o valor
cPadrao := "NaoEncontrado" //se nao encontrar esse Ã© o valor padrao a ser retornado

cMensagem := "Arquivo de configurção do servidor: [" + cServerIni + "]" + CRLF
cMensagem += "  Seção [" + cSecao + "] Chave [" + cChave + "] Valor [" + ;
GetPvProfString(cSecao, cChave, cPadrao, cServerIni) + "]" + CRLF+ CRLF+ CRLF

cMensagem += "Arquivo de configurção da estação: [" + cClientIni + "]" + CRLF
cMensagem += "  Seção [" + cSecao + "] Chave [" + cChave + "] Valor [" + ;
GetPvProfString(cSecao, cChave, cPadrao, cClientIni) + "]" + CRLF
//+----------------------------------------------------------------------------+
//|Apresenta uma mensagem com os resultados obtidos                            |
//+----------------------------------------------------------------------------+
MsgInfo(cMensagem, "Exemplo do GetPvProfString")


//é possivel assim criarmos uma chave customizada e usar ela em nossos fontes, como abaixo


cSecao := "SEMPREJU" //vamos ser os parametros da Seção [SEMPREJU]
cChave := "url" //qual chave queremos retornar o valor
cPadrao := "URL não encontrada" //se nao encontrar esse Ã© o valor padrao a ser retornado

cMensagem := "Arquivo de configurção do servidor: [" + cServerIni + "]" + CRLF
cMensagem += "  Seção [" + cSecao + "] Chave [" + cChave + "] Valor [" + ;
GetPvProfString(cSecao, cChave, cPadrao, cServerIni) + "]" + CRLF+ CRLF+ CRLF
//+----------------------------------------------------------------------------+
//|Apresenta uma mensagem com os resultados obtidos                            |
//+----------------------------------------------------------------------------+
MsgInfo(cMensagem, "Exemplo do GetPvProfString")


Return .T.
