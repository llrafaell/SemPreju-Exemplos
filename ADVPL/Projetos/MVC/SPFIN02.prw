#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMBROWSE.CH"
#INCLUDE "FWMVCDEF.CH"

/*/{Protheus.doc} SPFIN02
Tela de cadastro grupo de despesa (modelo 3)
@author
@since
@version 1.0
@project
/*/
User Function SPFIN02()
Local oBrowse   as Object
Private aRotina as ARRAY

// Instanciamento da Classe de Browse
oBrowse := FWMBrowse():New()

// Definição da tabela do Browse
oBrowse:SetAlias('ZRB')

// Titulo da Browse
oBrowse:SetDescription('Cadastro de Grupo de Despesa')

// Ativação da Classe
oBrowse:Activate()

Return Nil




/*/{Protheus.doc} MenuDef
MenuDef definition
@author
@since
@version 1.0
@project
*/
Static Function MenuDef()
Local aRotina as array

aRotina := {}
ADD OPTION aRotina Title "Vizualizar" 	Action 'VIEWDEF.SPFIN02'	OPERATION MODEL_OPERATION_VIEW ACCESS   0 //View
ADD OPTION aRotina Title "Incluir"	    Action 'VIEWDEF.SPFIN02'	OPERATION MODEL_OPERATION_INSERT ACCESS 0 //Add
ADD OPTION aRotina Title "Alterar"      Action 'VIEWDEF.SPFIN02'   	OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //Change
ADD OPTION aRotina Title "Deletar" 	    Action 'VIEWDEF.SPFIN02'    OPERATION MODEL_OPERATION_DELETE ACCESS 0 //Delete

/*
maneira simplificada
Será criado um menu padrão com as opções: Visualizar, Incluir, Alterar, Excluir, Imprimir e Copiar

Static Function MenuDef()
Return FWMVCMenu( 'SPFIN01' ))
*/

Return aRotina


/*/{Protheus.doc}
ModelDef definition
@author
@since
@version 1.0
@project
/*/
Static Function ModelDef()
Local oStrZRB 		as Object
Local oStrZRC 		as Object
Local oModel 		as Object  // Modelo de dados que será construído

oModel 		:= MPFormModel():New("_SPFIN02") // Cria o objeto do Modelo de Dados
oStrZRB		:= FWFormStruct(1, "ZRB") // Cria a estrutura a ser usada no Modelo de Dados
oStrZRC		:= FWFormStruct(1, "ZRC") // Cria a estrutura a ser usada no Modelo de Dados
oModel:AddFields("ZRBMASTER",, oStrZRB)// Adiciona ao modelo um componente de formulário


oModel:AddGrid("ZRCDETAIL", "ZRBMASTER", oStrZRC)// Adiciona ao modelo um componente de Grid
oModel:GetModel("ZRCDETAIL"):SetDescription('Despesas/Receitas  ') //Sections
oModel:GetModel("ZRCDETAIL"):SetUniqueLine({"ZRC_FILIAL","ZRC_CODGRP","ZRC_CODZRA"},/*bCodeLineIsNotUnique*/)
oModel:GetModel("ZRCDETAIL"):SetOptional(.T.)//opcionaol informar ou nao os itens

//Define o relacionamento
oModel:SetRelation("ZRCDETAIL", {{"ZRC_FILIAL","xFilial('ZRB')"},;
                                  {"ZRC_CODGRP","ZRB_CODIGO"}},ZRC->(IndexKey(1)))

// Adiciona a descrição do Modelo de Dados
oModel:SetDescription( 'Cadastro de Grupo de despesa ou receita' )

//Cria gatilho para preencher a descricao da despesa/receita, poderia seer feito via SX7 ou SXB
//oStrZRC:AddTrigger("ZRC_CODZRA" , "ZRC_DESCRI" ,,  {|oModel| SPTRIGGER("ZRC_CODZRA")})

//oUpdF5VEvt := SPFIN02Event():New()
//oModel:InstallEvent("SPFIN02EventID",,oUpdF5VEvt)

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
Local oModel := FWLoadModel( 'SPFIN02' )

// Cria a estrutura a ser usada na View
Local oStruZRB := FWFormStruct( 2, 'ZRB')
Local oStruZRC := FWFormStruct( 2, 'ZRC', {|x| !AllTrim(x) $ "ZRC_CODGRP"}) //remover codigo do grupo da tela
//oStruZRC:RemoveField("ZRC_CODGRP") //outra opcao para remover o campo da tela

// Interface de visualização construída
Local oView

// Cria o objeto de View
oView := FWFormView():New()

// Define qual o Modelo de dados será utilizado na View
oView:SetModel( oModel )

// Adiciona no nosso View um controle do tipo formulário  // (antiga Enchoice)
oView:AddField( 'VIEW_ZRB', oStruZRB, 'ZRBMASTER' )

//Adiciona o grid
oView:AddGrid("VIEW_ZRC", oStruZRC, "ZRCDETAIL")

// Criar um "box" horizontal para receber algum elemento da view
oView:CreateHorizontalBox( 'TELA' , 35 )
oView:CreateHorizontalBox( 'ITEM' , 65 )

// Relaciona o identificador (ID) da View com o "box" para exibição
oView:SetOwnerView( 'ZRBMASTER', 'TELA' )
oView:SetOwnerView( 'ZRCDETAIL', 'ITEM' )

Return oView


