#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"


/*/{Protheus.doc} P.E. AfterLogin
Fun��o chamada ap�s o login do usu�rio e no MDI a cada nova aba
@author TOTVS http://tdn.totvs.com/pages/releaseview.action?pageId=6815186
@author Rafael Gon�alves
@since  Mar�o/2020
@version 1.0
@project
@param
    Vetor PARAMIXB
    O vetor PARAMIXB possui a seguinte estrutura:
    [1] - Id do usu�rio
    [2] - Nome do usu�rio
/*/

User Function AfterLogin()
Local cPessoa := RetCodUsr()
Local cId	:= ParamIXB[1] //Id do usu�rio
Local cNome := ParamIXB[2] //Nome do usu�rio
conout("AfterLogin executado por: Usuario "+ cId + " - " + Alltrim(cNome)+" efetuou login as "+Time())

Do Case
    //Filtra somente os pedidos que o usu�rio fez
    Case nModulo == 5 //Faturamento
        DbSelectArea('SC5')
        If cPessoa != '000000' .and. fieldpos(C5_ZZUSR)>0//nao for adm
            SC5->(DbSetFilter({|| C5_ZZUSR == cPessoa }, "C5_ZZUSR == '"+cPessoa+"'"))
        EndIf
    Case cModulo == "GPE"
            //Verificar F�rias e Termino de Periodo de Experiencia

    Case cModulo == "COM"
        //Verificar Pedidos com previsao de Entrega na data
        //u_ChkPed()
EndCase

Return .t.