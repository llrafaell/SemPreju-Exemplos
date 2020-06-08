#Include 'Protheus.ch'
#Include 'ParmType.ch'

/*/{Protheus.doc} xSemPre
função xSemPre - Rotina para execução de funçoes igual formulas no protheus
@param Não recebe parametros
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since May|2020
/*/
user function xSemPre()

Local bError 
Local cGet1Frm := PadR("Ex.: u_Funcao(xparametros) ", 50)
Local oDlg1Frm := Nil
Local oSay1Frm := Nil
Local oGet1Frm := Nil
Local oBtn1Frm := Nil
Local oBtn2Frm := Nil

//tratativa para avaliar quando ocorrer um erro em execução
//bError := ErrorBlock( {|e| cError := e:Description } )

//controle de transação
//BEGIN SEQUENCE

    oDlg1Frm := MSDialog():New( 091, 232, 225, 574, "SemPreju | Execução" ,,, .F.,,,,,, .T.,,, .T. )
    oSay1Frm := TSay():New( 008 ,008 ,{ || "Informe a função:" } ,oDlg1Frm ,,,.F. ,.F. ,.F. ,.T. ,CLR_BLACK ,CLR_WHITE ,084 ,008 )
    oGet1Frm := TGet():New( 020 ,008 ,{ | u | If( PCount() == 0 ,cGet1Frm ,cGet1Frm := u ) } ,oDlg1Frm ,150 ,008 ,'!@' ,,CLR_BLACK ,CLR_WHITE ,,,,.T. ,"" ,,,.F. ,.F. ,,.F. ,.F. ,"" ,"cGet1Frm" ,,)
    oBtn1Frm := TButton():New( 040 ,008 ,"Executar" ,oDlg1Frm ,{ || &(alltrim(cGet1Frm))    } ,037 ,012 ,,,,.T. ,,"" ,,,,.F. )
    oBtn2Frm := TButton():New( 040 ,120 ,"Sair"     ,oDlg1Frm ,{ || oDlg1Frm:End() } ,037 ,012 ,,,,.T. ,,"" ,,,,.F. )
    oDlg1Frm:Activate( ,,,.T.)
/*
RECOVER    
    // exibe o erro se existir
    ErrorBlock( bError )
    MsgStop( cError )    
END SEQUENCE*/

return (.t.)
