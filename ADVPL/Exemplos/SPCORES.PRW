#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "FONT.CH"  


/*/{Protheus.doc} SPCORES
Função SPCORES
@param Não recebe parâmetros
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Mar|2020
/*/
User Function SPCORES()          
Local nLin as Numeric


//Adiciona linha no array com as cores
DEFINE 	MSDIALOG oDlg FROM  36,1 TO 300,540 TITLE "Cores Fontes" PIXEL
    nLin := 20
	@ nLin, 005	SAY "CLR_BLACK"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_BLACK 
    nLin += 10
	@ nLin, 005	SAY "CLR_BLUE"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_BLUE 
    nLin += 10
	@ nLin, 005	SAY "CLR_GREEN"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_GREEN 
    nLin += 10
	@ nLin, 005	SAY "CLR_CYAN"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_CYAN 
    nLin += 10
	@ nLin, 005	SAY "CLR_RED"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_RED 
    nLin += 10
	@ nLin, 005	SAY "CLR_MAGENTA"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_MAGENTA 
    nLin += 10
	@ nLin, 005	SAY "CLR_BROWN"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_BROWN 
    nLin += 10
	@ nLin, 005	SAY "CLR_GRAY"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_GRAY 


    nLin := 20
	@ nLin, 055	SAY "CLR_HBLUE"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_HBLUE 
    nLin += 10
	@ nLin, 055	SAY "CLR_HGREEN"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_HGREEN 
    nLin += 10
	@ nLin, 055	SAY "CLR_HCYAN"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_HCYAN 
    nLin += 10
	@ nLin, 055	SAY "CLR_HRED"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_HRED 
    nLin += 10
	@ nLin, 055	SAY "CLR_HMAGENTA"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_HMAGENTA 
    nLin += 10
	@ nLin, 055	SAY "CLR_YELLOW"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_YELLOW 
    nLin += 10
	@ nLin, 055	SAY "CLR_HGRAY"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_HGRAY 
    nLin += 10
	@ nLin, 055	SAY "CLR_WHITE"	SIZE 32, 7 OF oDlg PIXEL FONT oDlg:oFont COLOR CLR_WHITE 

    

    DEFINE SBUTTON 	FROM 05, (oDlg:nRight / 2) - 40  TYPE 2  ENABLE OF oDlg ACTION ( oDlg:End() )
ACTIVATE MSDIALOG oDlg CENTERED

Return .T.