#Include "Protheus.ch"
#Include "TopConn.ch"
  

/*/{Protheus.doc} SPDTVAL
Função SPDTVAL, exemplo de uso de data valida
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Abr|2021
/*/
User Function SPDTVAL()  

    /*
    Parametros
        1-Data para iniciar o cálculo da função
        2-Se .T. posterga a data recebida para o próximo dia útil – Se .F. retrocede a data recebida para o dia útil anterior (default .f.)
    Retorno
    	Data válida do sistema

    Obs.: Para cadastrar um feriado use a tabela genérica 63
    */
    MsgInfo(    'DataValida ou próxima: '  + cValtoChar( DataValida( Date(), .T. ) ) + CRLF + ;
                'DataValida ou anterior: ' + cValtoChar( DataValida( Date(), .F. ) ) ;
 , 'Sempreju =)' )


Return .t.
