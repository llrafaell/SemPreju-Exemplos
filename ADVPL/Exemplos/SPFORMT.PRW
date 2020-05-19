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
Local cTemp2 as Character
Local cSqlIN as Character
Local cSqlIN2 as Character

//inicializa as variaveis
cQuery  := ""
cTemp   := '000001/000002/000003/000004/000005'
cTemp2   := '001002003004'
cSqlIN  := FormatIN( cTemp, '/' ) //retorna o valor formatado separando por /
cSqlIN2  := FormatIN( cTemp, ,3 ) //quebra a cada 3 caracteres

//Montagem da Query
cQuery := " SELECT * FROM " + RetSqlName( "SB1" ) + " "
cQuery += " WHERE B1_COD IN " + cSqlIN + " and B1_GRUPO IN " + cSqlIN + " "

//Apresenta a query.
MsgInfo(cQuery, "SemPreju")

Return .t.