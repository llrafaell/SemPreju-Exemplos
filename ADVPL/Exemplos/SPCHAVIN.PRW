#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"


/*/{Protheus.doc} SPCHAVIN
Função SPCHAVIN para buscar uma chave no ini e retornar o valor
@param chave e valor padrao 
@return Não retorna nada
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
cSecao := "General" //vamos ser os parametros da seção [General]
cChave := "InstallPath" //qual chave queremos retornar o valor
cPadrao := "NaoEncontrado" //se nao encontrar esse é o valor padrao a ser retornado

cMensagem := "Arquivo de configuração do servidor: [" + cServerIni + "]" + CRLF
cMensagem += "  Seção [" + cSecao + "] Chave [" + cChave + "] Valor [" + ;
GetPvProfString(cSecao, cChave, cPadrao, cServerIni) + "]" + CRLF+ CRLF+ CRLF

cMensagem += "Arquivo de configuração da estação: [" + cClientIni + "]" + CRLF
cMensagem += "  Seção [" + cSecao + "] Chave [" + cChave + "] Valor [" + ;
GetPvProfString(cSecao, cChave, cPadrao, cClientIni) + "]" + CRLF
//+----------------------------------------------------------------------------+
//|Apresenta uma mensagem com os resultados obtidos                            |
//+----------------------------------------------------------------------------+
MsgInfo(cMensagem, "Exemplo do GetPvProfString")


//é possivel assim criarmos uma chave customizada e usar ela em nossos fontes, como abaixo


cSecao := "SEMPREJU" //vamos ser os parametros da seção [SEMPREJU]
cChave := "url" //qual chave queremos retornar o valor
cPadrao := "URL Não encontrada" //se nao encontrar esse é o valor padrao a ser retornado

cMensagem := "Arquivo de configuração do servidor: [" + cServerIni + "]" + CRLF
cMensagem += "  Seção [" + cSecao + "] Chave [" + cChave + "] Valor [" + ;
GetPvProfString(cSecao, cChave, cPadrao, cServerIni) + "]" + CRLF+ CRLF+ CRLF
//+----------------------------------------------------------------------------+
//|Apresenta uma mensagem com os resultados obtidos                            |
//+----------------------------------------------------------------------------+
MsgInfo(cMensagem, "Exemplo do GetPvProfString")


Return .T.
