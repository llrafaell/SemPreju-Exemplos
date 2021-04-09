
Repositório de fontes customizados e open-source
====
_Neste repositório você encontrará projetos open-source em linguagem advpl, tl++, framework po-ui, além de algumas ferramentas úteis_ 
    

____  

Descrição
---

Fontes desenvolvidos com o intuito de ajudar analistas que trabalham com ADVPL. Você irá encontrar funcionalidades, tutoriais, em sua maioria com embasamento na arquitetura Protheus. Lembre-se que pode contribuir com os projetos. Algumas novas funcionalidades e implementações na arquiteutra também são abordados nos projetos.

Saiba mais sobre os fontes em - www.sempreju.com.br

FOLDER - PO-Angular
 * **Angular_login - Usando REST Protheus**: exemplo em angular para loguin usando WS do protheus e utilização de JWT.
 * **CRUD_Supplier**: CRUD feito em Angular(PO.UI) para manipular o cadastro de fornecedor (SA2).

FOLDER - ADVPL\Projetos
  * **SPEXPTABL.prw**: Fonte para exportar o dicionario de dados em HTML (inlcuido Google Analytics e Wordpress).
  * **SPSLACK.prw**: Fonte para integrar o protheus ao slack.
  * **SPDOCAUT.prw**: Fonte para exportar informações do dicionario em excel para documentação de customizações.

FOLDER - ADVPL\Exemplos\
   * **SPCORES.prw**: Fonte exemplo de uso das principais cores em componente SAY.
   * **SPDTEXT.prw**: Fonte exemplo para converter data em extenso.
   * **SPDVALSQL.prw**: Fonte exemplo para validar se uma string SQL são valida.
   * **SPPROGR.prw**: Fonte exemplo com diversas barras de progresso.
   * **SPHELPCP.prw**: Função para inclusão de help em campos MSGET e como usar Place Hold no TGET.
   * **SPFLDPOS.prw**: Função demonstrando como usar o FieldPos.
   * **SPDIALO.prw**: Como remover o botão de fechar de uma dialog, fechar automaticamente dialog em ADVPL.
   * **SPFORMT.prw**: Como formatar string para serem utilizadas em select na condicao IN.
   * **SPINPUT.prw**: Como utilizar a função FWInputBox e interegir com o usuário facilmente.
   * **SPMARKTE.prw**: Cria um markBrowse editavel usando um array como origem das informações.
   * **SPNEWMOD.prw**: Como criar os três módulos especificos disponíveis.
   * **SPWEBENG.prw**: Exemplo como usar a classe TWebEngine para abrir página dentro do protheus.
   * **SPCHAVIN.prw**: Aprenda como usar a função GetPvProfString para buscar informações do appserver.ini e smartclient.ini
   * **SPEXISTG.prw**: Aprenda como usar a função ExistTrigger para consultar se determinado campo possui gatilho.
   * **SPEXCTG.prw**: Aprenda como usar a função RunTrigger para executar os gatihlos de um determinado campo.
   * **SPSF3DIA.prw**: Aprenda como usar a cGetfile no SF3 de um campo.
   
FOLDER - ADVPL\Exemplos\Ponto de entrada
   * **AfterLogin.prw**: PE chamado após login ou abertura de telas se acesso em MDI.
   * **MsQuit.prw**: PE chamado após logoff do sistema.
   
FOLDER - ADVPL\Exemplos\Classes
  * **SPCLASSM.prw**: Fonte exemplo de uso da classe ClassMethArr

FOLDER - ADVPL\Exemplos\WS
  * **SPCliente.prw**: Fonte exemplo de Ws para listar o cadastro de cliente

FOLDER - ADVPL\Exemplos\Scripts
  * **Compilar_automaticamente_ADVPL**: Script para compilação e desfragmentação em ADVPL automaticamente

FOLDER - SQL
  * **rebuildIndex.SQL**: Script para ajudar na administração do SQL Server sobre index.


Tecnologia e Requisitos
----

Todos os fontes deste projeto foram desenvolvidos e testado usando o ambiente a seguir:

<p><b>Essenciais:</b></p>
<ul>
  <li>Windows 10 / Ubuntu 20.04</li>
  <li><a href="https://tdn.totvs.com/display/tec/DBAccess">DbAccess</a> atualizado</li>
  <li><a href="https://www.totvs.com/blog/protheus-da-totvs">Protheus</a> na última release recorrente e binários atualizados</li>
  <li>Conexão com o banco de dados</li>
  <li>PostgreSQL, ultima versão homologada</li>
  <li>Conhecimentos básicos sobre <a href="http://www.tutorialspoint.com/sql">queries</a> e banco de dados</li>
  <li>Dicionário de dados\compatibilizador geral UPDDISTR e do módulo\ex: UPDTAF atualizado</li>
  <li>Menus atualizados</li>
</ul>
<p><b>Talvez:</b></p>
<ul>
  <li>VSCode e Plugin para linguagem</li>
  <li>Visual Studio</li>
  <li>IntelliSense</li>
</ul>


Licença
----

_Distribuído sob_ a licença [MIT](LICENSE). _Veja mais sobre licenciamento [aqui](https://choosealicense.com/licenses/)_


