#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

#Define ENTER Chr(13)+Chr(10)

/*/{Protheus.doc} SPFLDPOS
Função SPFLDPOS, para exemplificar o uso da função FieldPos().
@param Não recebe parâmetros
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Mai|2020
/*/
User Function SPFLDPOS()
	Local cMsgHead := "TDRFocus - Conhecimento sem limite"
	//-> Verifica se o novo campo existe.
	If FieldPos("A1_ZCOD") > 0
		MsgInfo("O campo A1_ZCOD existe!", cMsgHead)
	Else
		MsgStop("O campo A1_ZCOD não existe!", cMsgHead)
	EndIf
Return