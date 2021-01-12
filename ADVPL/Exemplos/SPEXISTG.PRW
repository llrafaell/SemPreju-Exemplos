#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

#Define ENTER Chr(13)+Chr(10)

/*/{Protheus.doc} SPEXISTG
Função SPEXISTG, para exemplificar o uso da Função ExistTrigger().
@param Não recebe 
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Dez|2020
/*/
User Function SPEXISTG()
Local cCampo := 'A1_CGC'

If ExistTrigger( cCampo )
    MsgInfo( 'Campo: ' + cCampo + ENTER + "Possui Gatilho.", 'SemPreju' )
else
    MsgInfo( 'Campo: ' + cCampo + ENTER + "Não Possui Gatilho.", 'SemPreju' )
Endif
Return
