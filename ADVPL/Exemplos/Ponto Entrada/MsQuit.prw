#INCLUDE "RWMAKE.CH"


/*/{Protheus.doc} P.E. MsQuit
Função chamada após o login do usuário e no MDI a cada nova aba
@author TOTVS https://tdn.totvs.com/display/public/PROT/MsQuit+-+Controle+de+acesso+ao+sistema
@author Rafael Gonçalves
@since  Setembro/2020
@version 1.0
@project
@param
    Vetor PARAMIXB
    O vetor PARAMIXB possui a seguinte estrutura:
    [1] - Tipo de ação
        .T. = Logoff
        .F. = Saiu do sistema
/*/

User Function MSQUIT()
Local lLogoff 	:= ParamIxb[1] //variável lógica que identifica se o P.E. está sendo executado pelo Logoff ou pela saida definitiva.
Local cMsg 	:= ""
If lLogOff	
	cMsg := "O Usuário: "+Alltrim(cUserName)+" efetuou logoff do sistema"
Else	
	cMsg := "O Usuário: "+Alltrim(cUserName)+" saiu totalmente do sistema"
EndIf

ApMsgAlert(cMsg)

Return .T.



