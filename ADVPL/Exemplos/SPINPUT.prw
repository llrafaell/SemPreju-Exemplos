#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*/{Protheus.doc} SPCORES
Fun��o SPINPUT - simples dialog com um tget
@param N�o recebe par�metros
@return N�o retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Mar|2020
/*/
User function SPINPUT()
Local oError     as Block
Local nRetorno   as Numeric

nRetorno := 0
oError := ErrorBlock({|e|ChecErro(e)}) //Para exibir um erro mais amig�vel

Begin Sequence
    nRetorno := Val(FWInputBox("Informe um valor no intervalo [1-100]:", ""))    
    MsgInfo( cValToChar(nRetorno) ) // valor informado
End Sequence
ErrorBlock(oError)
Return