#Include "Protheus.ch"
#Include "TopConn.ch"
  

/*/{Protheus.doc} SPDTVAL
Fun��o SPDTVAL, exemplo de uso de data valida
@return N�o retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Abr|2021
/*/
User Function SPDTVAL()  

    /*
    Parametros
        1-Data para iniciar o c�lculo da fun��o
        2-Se .T. posterga a data recebida para o pr�ximo dia �til � Se .F. retrocede a data recebida para o dia �til anterior (default .f.)
    Retorno
    	Data v�lida do sistema

    Obs.: Para cadastrar um feriado use a tabela gen�rica 63
    */
    MsgInfo(    'DataValida ou pr�xima: '  + cValtoChar( DataValida( Date(), .T. ) ) + CRLF + ;
                'DataValida ou anterior: ' + cValtoChar( DataValida( Date(), .F. ) ) ;
 , 'Sempreju =)' )


Return .t.
