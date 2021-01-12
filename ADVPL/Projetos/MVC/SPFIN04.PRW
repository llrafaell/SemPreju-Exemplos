#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMBROWSE.CH"
#INCLUDE "FWMVCDEF.CH"

/*/{Protheus.doc} SPFIN04
Tela de regitro de despesa e/ou receita versao 2
@author Rafael Gonçalves
@since Abril/2020
@version 1.0
@project
/*/
User Function SPFIN04()
Local oBrowse   as Object
Private aRotina as ARRAY

// Instanciamento da Classe de Browse
oBrowse := FWMBrowse():New()

// Definição da tabela do Browse
oBrowse:SetAlias('ZRD')

// Titulo da Browse
oBrowse:SetDescription('Movimentação')

// Ativação da Classe
oBrowse:Activate()

Return Nil


/*/{Protheus.doc}
MenuDef definition
@author
@since
@version 1.0
@project
*/
Static Function MenuDef()
Local aRotina as array

aRotina := {}
ADD OPTION aRotina Title "Vizualizar" 	Action 'VIEWDEF.SPFIN04'	OPERATION MODEL_OPERATION_VIEW ACCESS   0 //View
ADD OPTION aRotina Title "Incluir"	    Action 'VIEWDEF.SPFIN04'	OPERATION MODEL_OPERATION_INSERT ACCESS 0 //Add
ADD OPTION aRotina Title "Alterar"      Action 'VIEWDEF.SPFIN04'   	OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //Change
ADD OPTION aRotina Title "Deletar" 	    Action 'VIEWDEF.SPFIN04'    OPERATION MODEL_OPERATION_DELETE ACCESS 0 //Delete

Return aRotina


/*/{Protheus.doc}
ModelDef definition
@author
@since
@version 1.0
@project
/*/
Static Function ModelDef()
Local oStrZRD 		as Object
Local oModel 		as Object  // Modelo de dados que será construído

oModel 		:= MPFormModel():New("_SPFIN04") // Cria o objeto do Modelo de Dados
oStrZRD		:= FWFormStruct(1, "ZRD") // Cria a estrutura a ser usada no Modelo de Dados
oModel:AddFields("ZRDMASTER",, oStrZRD)// Adiciona ao modelo um componente de formulário

// Adiciona a descrição do Modelo de Dados
oModel:SetDescription( 'Movimentação' )

// Retorna o Modelo de dados
Return oModel


/*/{Protheus.doc}
ViewDef definition
@author
@since
@version 1.0
@project
/*/
Static Function ViewDef()
// Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado
Local oModel := FWLoadModel( 'SPFIN04' )

// Cria a estrutura a ser usada na View
Local oStruZRD := FWFormStruct( 2, 'ZRD')

// Interface de visualização construída
Local oView

// Cria o objeto de View
oView := FWFormView():New()

// Define qual o Modelo de dados será utilizado na View
oView:SetModel( oModel )

// Adiciona no nosso View um controle do tipo formulário  // (antiga Enchoice)
oView:AddField( 'VIEW_ZRD', oStruZRD, 'ZRDMASTER' )

// Criar um "box" horizontal para receber algum elemento da view
oView:CreateHorizontalBox( 'TELA' , 100 )

// Relaciona o identificador (ID) da View com o "box" para exibição
oView:SetOwnerView( 'ZRDMASTER', 'TELA' )

Return oView
