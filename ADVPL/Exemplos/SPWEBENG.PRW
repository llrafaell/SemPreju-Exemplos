#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"


/*/{Protheus.doc} SPWEBENG
Função SPWEBENG exemplo de uso da classe TWebEngine
@param Não recebe parâmetros
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Oct|2020
/*/
User Function SPWEBENG()
	If (aLLTRIM(FwRetIdiom()) =='en-us')
 		U_OpenPage('https://www.totvs.com/','TOTVS')
	Else
 		U_OpenPage('https://sempreju.com.br','Sempreju')
	Endif
Return


User Function OpenPage(cUrl,cTitle)
Local oModal
Local aSize           := {}
Local aObjects        := {} 
Local aInfo            := {} // Obt?m a a ?rea de trabalho e tamanho da dialog
Local nPort     :=  0
PRIVATE oWebChannel := TWebChannel():New()
PRIVATE oWebEngine 

DEFAULT cUrl	:=	"https://sempreju.com.br"
DEFAULT cTitle := cUrl
DEFAULT cRootPath	:=	"/"

aSize := MsAdvSize()
AAdd( aObjects, { 100, 100, .T., .T. } ) // Dados da Enchoice 
// Dados da ?rea de trabalho e separa??o
aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 } 
aPosObj := MsObjSize( aInfo, aObjects,.T.)
DEFINE MSDIALOG oModal TITLE cTitle From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL // Usar sempre PIXEL !!!
    nPort := oWebChannel::connect()
    oWebEngine := TWebEngine():New(oModal, 0, 0, 100, 100,, nPort)
    //oWebEngine:cLang := FwRetIdiom() Only in smartclient higher than 19.3.1.0
    oWebEngine:bLoadFinished := {|self,url| conout("Fim do carregamento da pagina " + url) }
    oWebEngine:navigate(cUrl)
    oWebEngine:Align := CONTROL_ALIGN_ALLCLIENT
  
  ACTIVATE DIALOG oModal CENTERED

Return
