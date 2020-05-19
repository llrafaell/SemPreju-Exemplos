#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "FONT.CH"  


/*/{Protheus.doc} SPFORMT
Função SPFORMT - Formata uma string para ser utilizada no clausula IN do comando SELECT em ambiente SQL 
@param Não recebe parâmetros
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since May|2020
/*/
User Function SPFORMT()   
Local cQuery  as Character
Local cTemp as Character
Local cSqlIN as Character

//inicializa as variaveis
cQuery  := ""
cTemp   := '000001/000002/000003/000004/000005'
cSqlIN  := FormatIN( cTemp, '/' ) //retorna o valor formatado separando por /

//Montagem da Query
cQuery := " SELECT * FROM " + RetSqlName( "SB1" ) + " "
cQuery += " WHERE B1_COD IN " + cSqlIN

//Apresenta a query.
MsgInfo(cQuery, "SemPreju")

Return .t.