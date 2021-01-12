#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

#Define ENTER Chr(13)+Chr(10)

/*/{Protheus.doc} SPHELPCP
Função SPHELPCP, inclusão de help em campos MSGET
@param Não recebe parâmetros
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Abr|2020
/*/
User Function SPHELPCP()  
Local aArea := GetArea()
Private cPerson     := Space(100) //help personalizado
Private cFieldDB    := Space(100) //Help campo existente
Private cPlaceHold  := Space(100) //placeHold no Get
 
ShowHelpDlg( "Exemplo Help", { "Este é um exemplo de help Dlg" }, , { "Fechar" } )

DEFINE MSDIALOG oDlg TITLE "Janela" FROM 000, 000  TO 170, 430 PIXEL
//Help texto personalizado
@ 006, 006 SAY        oSayNor PROMPT "Personalizado:"                  SIZE 100, 007 OF oDlg PIXEL
@ 003, 060 MSGET      oGetNor VAR    cPerson                    SIZE 100, 010 OF oDlg PIXEL
oGetNor:bHelp := {||ShowHelpCpo("personalizado",;
{"Texto Linha 1"+ENTER+"Texto Linha 2"},2,;
{"Solução Linha 1"},2)}
 
//Help com base em campo existente
@ 026, 006 SAY        oSayBD  PROMPT "Base SA1: "                      SIZE 100, 007 OF oDlg PIXEL
@ 023, 060 MSGET      oGetBD  VAR    cFieldDB                   SIZE 100, 010 OF oDlg PIXEL
oGetBD:bHelp := {||ShowHelpCpo("existente",;
{GetHlpSoluc("A1_COD")[1]},2,;
{GetHlpSoluc("A1_COD")[2]},2)}


cPlaceHold := "Place Hold Exemplo com Help"
//TGet():New( [ nRow ], [ nCol ], [ bSetGet ], [ oWnd ], [ nWidth ], [ nHeight ], [ cPict ], [ bValid ], [ nClrFore ], [ nClrBack ], [ oFont ], [ uParam12 ], [ uParam13 ], [ lPixel ], [ uParam15 ], [ uParam16 ], [ bWhen ], [ uParam18 ], [ uParam19 ], [ bChange ], [ lReadOnly ], [ lPassword ], [ uParam23 ], [ cReadVar ], [ uParam25 ], [ uParam26 ], [ uParam27 ], [ lHasButton ], [ lNoButton ], [ uParam30 ], [ cLabelText ], [ nLabelPos ], [ oLabelFont ], [ nLabelColor ], [ cPlaceHold ], [ lPicturePriority ], [ lFocSel ] )
oTGet1 := TGet():New( 053,01, bSetGet( cPlaceHold ),oDlg, 250,009,"",/* [ bValid ]*/,/**nClrFore */,/**nClrBack */,/**oFont */,/**uParam12 */,/**uParam13 */, .t.,/**uParam15 */,/**uParam16 */, {|| .T.},/*uParam18*/ ,/**uParam19 */, /*bChange*/, /* lReadOnly */, /* lPassword */, /* uParam23 */, /* cReadVar */, /* uParam25 */, /* uParam26 */, /* uParam27 */, /* lHasButton */, /* lNoButton */, /* uParam30 */, "Ajuda de preenchimento - F1 para ver help"/* cLabelText */, 1/* nLabelPos */, /* oLabelFont */, /* nLabelColor */, /* cPlaceHold */, /* lPicturePriority */, /* lFocSel */ )
oTGet1:bHelp := {||ShowHelpCpo("cPerson",;
{"Texto Linha 1"+ENTER+"Texto Linha 2"},2,;
{"Solução Linha 1"},2)}

ACTIVATE MSDIALOG oDlg CENTERED
 
RestArea(aArea)
Return