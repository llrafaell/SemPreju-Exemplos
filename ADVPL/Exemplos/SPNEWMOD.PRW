#include 'totvs.ch'


/*/{Protheus.doc} SIGAESP - Módulo 97
Função ESPNOME - Define o nome para o módulo especifico - 97
@param Não recebe parâmetros
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Out|2020
/*/
User Function ESPNOME
Return ("Novo Modulo 97")

/*/{Protheus.doc} ESP1NOME - Módulo 98
Função ESP1NOME - Define o nome para o módulo especifico - 98
@param Não recebe parâmetros
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Out|2020
/*/
User Function ESP1NOME
Return ("Novo Modulo 98")

/*/{Protheus.doc} ESP2NOME - Módulo 99
Função ESP2NOME - Define o nome para o módulo especifico - 99
@param Não recebe parâmetros
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Out|2020
/*/
User Function ESP2NOME
Return ("Novo Modulo 98")


//Tambem temos assim o ponto de entrada de carregamento do sistema, o nome da função é o mesmo da chamado do programa inicial.
user Function SigaEsp()
Alert( Time() )
Return .t. 
