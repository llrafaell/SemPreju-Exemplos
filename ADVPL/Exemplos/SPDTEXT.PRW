#Include "Protheus.ch"

/*/{Protheus.doc} SPDtExt
Retorna a data informada por extenso
@author Rafael Gonçalves
@since Mar|2020
@version 1.0
    @param 
        dData, data que será considerada
        lDiaExt, se retorna o dia por extenso
        lMesExt, se retorna o Mes por extenso
        lAnoExt, se retorna o Ano por extenso

    @example
    u_SPDTEXT(dDataBase) //13 de Março de 2020
    u_SPDTEXT(dDataBase,.T.) //Treze de Março de 2020
    u_SPDTEXT(dDataBase,.T.,.F.) //Treze de 03 de 2020
    u_SPDTEXT(dDataBase,.T.,.F.,.T.) //Treze de 03 de Dois Mil e Vinte
    u_SPDTEXT(dDataBase,.F.,.T.,.T.) //13 de Março de 2020
    @see https://sempreju.com.br
/*/
user function SPDTEXT(dData, lDiaExt, lMesExt, lAnoExt)  
Local cRetDat as Character
Default lDiaExt := .F.
Default lMesExt := .T.
Default lAnoExt := .F.

cRetDat := ""
If lDiaExt //convert dia por exenso
    cRetDat += capital(extenso(day(dData), .t.))
else
    cRetDat += cValToChar(day(dData)) 
Endif
cRetDat += " de "  

If lMesExt //convert dia por exenso
    cRetDat += mesextenso(dData) 
else
    cRetDat += cValToChar(Month(dData)) 
Endif
cRetDat += " de "

If lAnoExt //convert dia por exenso
    cRetDat += capital(extenso(year(dData), .t.))
else
    cRetDat += cValToChar(year(dData)) 
Endif
return cRetDat  


