#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

User Function SPDIALO()
Local nTimeMsg as numeric

nTimeMsg := 60000 //defini um minuto para fechar a janela

//Adiciona linha no array com as cores
DEFINE 	MSDIALOG oDlg FROM  36,1 TO 300,540 TITLE "Fecha Automatico" PIXEL STYLE DS_MODALFRAME //dialog sem o X para fechar
    oDlg:lEscClose := .F. //desabilita fechar a janela ao pressinar esc.
    oDlg:lCentered := .T. //abre a janela centralizado.


    @ 0.5, 1.8 Say "Esta tela será finalizada automaticamente em " Of oDlg	
    @ 1.5, 1.8 Say AllTrim(Str((nTimeMsg/1000)/60))+" minutos."	 Of oDlg	


    oTimer2:= TTimer():New(nTimeMsg,{|| oDlg:End() },oDlg)
    oTimer2:Activate()

    DEFINE SBUTTON 	FROM 05, (oDlg:nRight / 2) - 40  TYPE 2  ENABLE OF oDlg ACTION ( oDlg:End() )
ACTIVATE MSDIALOG oDlg CENTERED
Return .T.