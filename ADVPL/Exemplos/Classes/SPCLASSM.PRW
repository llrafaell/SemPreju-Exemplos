#Include "Protheus.ch"

/*/{Protheus.doc} areaQuad
Essa classe retorna um array multidimensional com todas as informa��es sobre os m�todos do objeto passado no par�metro.
@type function
@author  Rafael Gon�alves
@since janeiro/2020
@version 12.1.25
@param nil
@return nil
/*/
User Function SPCLASSM()

//Exemplo de objeto
oMsDialog := MSDialog():New(180,180,550,700,'Exemplo MSDialog',,,,,CLR_BLACK,CLR_WHITE,,,.T.)

//Parametro 1 - Objeto
//Parametro 2 - Se verdadeiro (.T.) retorna todos os parametros, inclusive os par�metros herdados de outras classes, adiciona o nome da classe na 3� coluna do array
aMethods := ClassMethArr(oMsDialog, .T.)
cMethods := PadR("METHOD", 30) + "|OWNER" + CRLF

//Concateno todas as informa��es
For nI := 01 To Len(aMethods)
    cMethods += PadR(AllTrim(aMethods[nI, 01]), 30) + "|" + AllTrim(aMethods[nI, 03]) + CRLF
Next nI

//Salvo
MemoWrite("D:\Rafael\Workspace_SemPreju\SemPreju-Exemplos\Exemplos\Classes\FWMBrowse_Methods.txt", cMethods) //Salva resultado da ClassMethArr

Return .t.