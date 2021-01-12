import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { PoTableColumn } from '@po-ui/ng-components';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SupplierListService {

  ApiRest = 'http://localhost:8084/rest/api/crm/v1/customerVendor'; //Endereço da nossa API responsável por lista os fornecedores
  
  constructor(private http: HttpClient) { }

  //Método responsável por buscar e listar nossos fornecedores
  getSupplierList(): Observable<any> {
    return this.http.get(this.ApiRest + `/2`); //supplier
  }

  
  //Método para remover Fornecedor
  deleteSupplier(Id: string, type: string = '2') {
    return this.http.delete(this.ApiRest + `/${type}/${Id}`);
  }


  //Método responsável por converter em nomes mais legiveis para usuário
  getColumns(): Array<PoTableColumn> {
    return [
      { property: 'code', label: 'Código'},
      { property: 'storeId', label: 'Loja' },
      { property: 'name', label: 'Nome' },
      { property: 'strategicCustomerType', label: 'Fisica/Juridica' ,
        type: 'label', //part3 add 
        labels: [
          { value: 'F',color: 'color-08', label: 'Física' },
          { value: 'J', color: 'color-12',label: 'Juridica' }
        ] },
      { property: 'registerSituation', label: 'Situação' ,
      type: 'label', //part3 add 
      labels: [
        { value: '1', color: 'color-07', label: 'Inativo' },
        { value: '2', color: 'color-11', label: 'Ativo' },
        { value: '3', color: 'color-09', label: 'Cancelado' },
        { value: '4', color: 'color-12', label: 'Pendente' },
        { value: '5', color: 'color-08', label: 'Suspenso' }
      ]  },
    ];
  }

}
