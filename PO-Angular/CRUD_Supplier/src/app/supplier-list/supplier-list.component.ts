import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { PoNotificationService, PoTableAction } from '@po-ui/ng-components';
import { SupplierListService } from './supplier-list.service';

@Component({
  selector: 'app-supplier-list',
  templateUrl: './supplier-list.component.html',
  styleUrls: ['./supplier-list.component.css']
})
export class SupplierListComponent implements OnInit {

  supplierList: Array<any> = new Array();
  colunasTable: Array<any> = new Array();

  //Parte 3 
  //Adicionado ação deleter e editar
  actions: Array<PoTableAction> = [
    { action: this.updateSupplier.bind(this), icon: 'po-icon-edit', label: 'Alterar Fornecedor'},
    { action: this.deleteSupplier.bind(this), icon: 'po-icon-delete', label: 'Excluir Fornecedor' }
  ];

  //Parte 3 
  //método para editar
  updateSupplier(row: any) {
    console.log('Edit');
    const supplierId = row.code + row.storeId;
    this.router.navigate([`/supplierform/${supplierId}/${row.type}`]);
  }
    
  //Parte 3 
  //método para deleter o fornecedor
  deleteSupplier(row: any) {
    console.log('deleteSupplier');
    const supplierId = row.code + row.storeId;
    this.SupplierListService
    .deleteSupplier(supplierId, row.type)
    .subscribe(() => {
      this.updateSupplierList(); //atualiza a lista
      this.poNotification.success('o Fornecedor foi excluido com sucesso');
    }
    , err => this.poNotification.error(err)); //exibe erro 
  }


  constructor(private SupplierListService: SupplierListService,
    private router: Router,
    private poNotification: PoNotificationService) { }

  ngOnInit(): void {
    this.updateSupplierList(); //busca a lista de fornecedores do nosso Api
    this.colunasTable = this.SupplierListService.getColumns(); //atualiza as colunas que queremos ser listadas em nossa tabela.
  }
  //Metódo responsável por se isncrever no serviço e atualizar a lista de fornecedores
  updateSupplierList(): void {
    this.SupplierListService.getSupplierList().subscribe(response => {
      this.supplierList = response.items;
    });
  }
}
