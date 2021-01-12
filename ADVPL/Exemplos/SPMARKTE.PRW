#Include "Protheus.ch"

/*/{Protheus.doc} SPMarkTe
Função SPMarkTe, cria um markbrowse editavel.
@param Não recebe parâmetros
@return Não retorna nada
@author Rafael Goncalves
@owner sempreju.com.br
@version Protheus 12
@since Out|2020
/*/

User Function SPMarkTe()
Private lMarker     := .T.
Private aDespes := {}

//Alimenta o array
BUSDATA()


DEFINE MsDIALOG o3Dlg TITLE 'Clientes' From 0, 4 To 650, 1180 Pixel
    
    oPnMaster := tPanel():New(0,0,,o3Dlg,,,,,,0,0)
    oPnMaster:Align := CONTROL_ALIGN_ALLCLIENT

    oDespesBrw := fwBrowse():New()
    oDespesBrw:setOwner( oPnMaster )

    oDespesBrw:setDataArray()
    oDespesBrw:setArray( aDespes )
    oDespesBrw:disableConfig()
    oDespesBrw:disableReport()

    oDespesBrw:SetLocate() // Habilita a Localização de registros

    //Create Mark Column
    oDespesBrw:AddMarkColumns({|| IIf(aDespes[oDespesBrw:nAt,01], "LBOK", "LBNO")},; //Code-Block image
        {|| SelectOne(oDespesBrw, aDespes)},; //Code-Block Double Click
        {|| SelectAll(oDespesBrw, 01, aDespes) }) //Code-Block Header Click

    oDespesBrw:addColumn({"Codigo"              , {||aDespes[oDespesBrw:nAt,02]}, "C", "@!"    , 1,  20    ,                            , .T. , , .F.,, "aDespes[oDespesBrw:nAt,02]",, .F., .T.,                                    , "ETDESPES1"    })
    oDespesBrw:addColumn({"Nome"                , {||aDespes[oDespesBrw:nAt,03]}, "C", "@!"    , 1, 100    ,                            , .T. , , .F.,, "aDespes[oDespesBrw:nAt,03]",, .F., .T.,                                    , "ETDESPES2"    })
    oDespesBrw:addColumn({"End"                 , {||aDespes[oDespesBrw:nAt,04]}, "C", "@!"    , 1, 100    ,                            , .T. , , .F.,, "aDespes[oDespesBrw:nAt,04]",, .F., .T.,                                    , "ETDESPES3"    })
    oDespesBrw:addColumn({"Cidade"              , {||aDespes[oDespesBrw:nAt,05]}, "C", "@!"    , 1, 100    ,                            , .T. , , .F.,, "aDespes[oDespesBrw:nAt,05]",, .F., .T.,                                    , "ETDESPES4"    })

    oDespesBrw:setEditCell( .T. , { || .T. } ) //activa edit and code block for validation

    /*
    oDespesBrw:acolumns[2]:ledit     := .T.
    oDespesBrw:acolumns[2]:cReadVar:= 'aDespes[oBrowse:nAt,2]'*/

    oDespesBrw:Activate(.T.)

Activate MsDialog o3Dlg

return .t.



Static Function SelectOne(oBrowse, aArquivo)
aArquivo[oDespesBrw:nAt,1] := !aArquivo[oDespesBrw:nAt,1]
oBrowse:Refresh()
Return .T.



Static Function SelectAll(oBrowse, nCol, aArquivo)
Local _ni := 1
For _ni := 1 to len(aArquivo)
    aArquivo[_ni,1] := lMarker
Next
oBrowse:Refresh()
lMarker:=!lMarker
Return .T.





//Alimenta a tabela temporaria
Static Function BUSDATA()
Local cQuery    as Character
Local cQryT3    as Character

cQuery      := ""
cQryT3      := GetNextAlias()
aDespes := {}

cQuery+="SELECT * FROM " + RetSqlName("SA1")
cQuery+=" WHERE D_E_L_E_T_=''"
cQuery:=ChangeQuery(cQuery)
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ) , cQryT3, .T., .F. )

(cQryT3)->(DbGoTop())
While (cQryT3)->(!EOF())

    aadd(aDespes,{.f.,alltrim((cQryT3)->A1_COD+(cQryT3)->A1_LOJA),alltrim((cQryT3)->A1_NOME),alltrim((cQryT3)->A1_END),alltrim((cQryT3)->A1_MUN)    })

    (cQryT3)->(dbSkip())
EndDo
(cQryT3)->(dbCloseArea())
DbSelectArea('SA1')

Return .t.
