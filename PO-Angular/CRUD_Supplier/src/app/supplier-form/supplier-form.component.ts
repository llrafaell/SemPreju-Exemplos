import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { PoDynamicFormField, PoNotificationService } from '@po-ui/ng-components';
import { Supplier } from '../model/supplierModel';
import { SupplierFormService } from './supplier-form.service';
import { first } from 'rxjs/operators';

@Component({
  selector: 'app-supplier-form',
  templateUrl: './supplier-form.component.html',
  styleUrls: ['./supplier-form.component.css']
})
export class SupplierFormComponent implements OnInit {

  //fields: Array<PoDynamicFormField> = []; //campos "dinamicos" para usar no formulário
  supplier: Supplier = new Supplier();//model de um fornecedor
  supplierValues = {    type: 2, code: "", storeId: "", shortName: "", name: "", strategicCustomerType: "J", entityType: "J",
  number: "", address: "", zipCode: "", stateId: "", stateInternalId: "", registerSituation: "1",
  stateDescription: "", complement: "", district: "", cityCode: "", cityDescription: ""}; //array com os valores do fomulário
  supplierType: string | any = '2'; //no nosso exemplo será sempre 2=fornecedor, mas poderia ser 1=cliente
  supplierId: string | any;
  title = 'Inclusão de Fornecedor';

  constructor(private supplierFormService: SupplierFormService, //servico do form
    private poNotification: PoNotificationService, //usar as notificações do PO.UI
    private route: ActivatedRoute,
    private router: Router,
  ) { }

  ngOnInit(): void {
    //define valores padrão para formulário
    this.supplierValues = {
      type: 2, code: "", storeId: "", shortName: "", name: "", strategicCustomerType: "J", entityType: "J",
      number: "", address: "", zipCode: "", stateId: "", stateInternalId: "",registerSituation: "1",
      stateDescription: "", complement: "", district: "", cityCode: "", cityDescription: ""
    }
    this.route.paramMap.subscribe(parameters => {
      this.supplierId = parameters.get('id');
      this.supplierType = parameters.get('type');
    });

    if (this.supplierId) { //se tem o ID na URL, significa alteração
      this.title = 'Alteração de Fornecedor';
      this.setFormValue(); //atribui os valores do API para o formulário
    }
  }

  //Método para inserir um novo fornecedor
  insertSupplier(): void {
    this.getSupplierFromForm();
    this.supplierFormService.postNewSupplier(JSON.stringify(this.supplier)) //grava o novo fornecedor
      .pipe(first())
      .subscribe(() => {
        this.poNotification.success('Fornecedor foi inserido com Sucesso');
        this.router.navigate(['/supplier']); //redireciona para lista de fornecedor
      }, err => {
        //se error devolve o erro do Backend para o usuário
        let messErr = JSON.parse(err.error.errorMessage);
        this.poNotification.error(`Erro código ${messErr.code},  ${decodeURIComponent(escape(messErr.message))}, detalhe: ${decodeURIComponent(escape(messErr.detailedMessage))}.`)
      }
        
        ); //exibe erro ao inserir fornecedor
  }

   //alimenta o modelo de dados
  private getSupplierFromForm(): void {
    // dados pessoais
    this.supplier.code = this.supplierValues.code;
    this.supplier.storeId = this.supplierValues.storeId;
    this.supplier.name = this.supplierValues.name;
    this.supplier.shortName = this.supplierValues.shortName;
    this.supplier.strategicCustomerType = this.supplierValues.strategicCustomerType;
    this.supplier.entityType = this.supplierValues.entityType;
    this.supplier.type = this.supplierValues.type;
    this.supplier.registerSituation = this.supplierValues.registerSituation;

    // Endereço
    this.supplier.address.address = this.supplierValues.address;
    this.supplier.address.city.cityCode = this.supplierValues.cityCode;
    this.supplier.address.city.cityDescription = this.supplierValues.cityCode;
    this.supplier.address.city.cityInternalId = this.supplierValues.cityCode;
    this.supplier.address.state.stateId = this.supplierValues.stateId;
    this.supplier.address.state.stateInternalId = this.supplierValues.stateId;



  }

  //part 3
  //Método para editar um fornecedor
  updateSupplier(): void {
    this.getSupplierFromForm(); //seta no modelo fornecedor os valores do Formulário para então enviar para API
    this.supplierFormService
      .putSupplier(this.supplier.code + this.supplier.storeId, JSON.stringify(this.supplier), this.supplierType)
      .pipe(first())
      .subscribe(() => {
        this.poNotification.success('Fornecedor alterado com Sucesso');
        this.router.navigate(['/supplier']);//redireciona para lista de fornecedor
      }, err => this.poNotification.error(err));//exibe erro ao editar fornecedor
  }


  //part 3
  //Método para atribuir valores aos campos para formulário
  private setFormValue(): void {
    this.supplierFormService
      .getSupplier(this.supplierId, this.supplierType)
      .pipe(first())
      .subscribe((supplier:Supplier) => {
        console.log(supplier);
        this.supplierValues.code = supplier.code;
        this.supplierValues.storeId = supplier.storeId;
        this.supplierValues.name = supplier.name;
        this.supplierValues.shortName = supplier.shortName;
        this.supplierValues.strategicCustomerType = supplier.strategicCustomerType;
        this.supplierValues.entityType = supplier.strategicCustomerType;
        this.supplierValues.type = supplier.type;
        this.supplierValues.registerSituation = supplier.registerSituation;
        // Endereço
        this.supplierValues.address = supplier.address.address;
        this.supplierValues.cityCode = supplier.address.city.cityCode;
        this.supplierValues.cityCode = supplier.address.city.cityDescription;
        this.supplierValues.cityCode = supplier.address.city.cityInternalId;
        this.supplierValues.stateId = supplier.address.state.stateId;
        this.supplierValues.stateId = supplier.address.state.stateInternalId;

      });

  }



  //array para definir os nomes dos campos do formulário
  fields: Array<PoDynamicFormField> = [
    {
      property: 'code',
      label: 'Código',
      divider: 'Dados Pessoais',
      maxLength: 6
    },
    {
      property: 'storeId',
      label: 'Loja',
      maxLength: 2
    },
    {
      property: 'name',
      label: 'Nome',
      maxLength: 40
    },
    {
      property: 'shortName',
      label: 'Nome Reduzido',
      maxLength: 20
    },
    {
      property: 'strategicCustomerType',
      label: 'Tipo do cliente',
      options: [
        { label: 'Cons. Final', value: 'F' },
        { label: 'Produtor Rural', value: 'L' },
        { label: 'Revendedor', value: 'R' },
        { label: 'Solidario', value: 'S' },
        { label: 'Exportação', value: 'X' }
      ]
    },
    {
      property: 'entityType',
      label: 'Tipo da entidade',
      options: [
        { label: 'Juridica', value: 'J' },
        { label: 'Fisica', value: 'F' }
      ]
    },
    {
      property: 'registerSituation', //Campo: A1_MSBLQL / A2_MSBLQL  == Status: 1 - Ativo, 2 - Inativo, 3 - Cancelado, 4 - Pendente, 5 -Suspenso
      label: 'Situação(MSBLQL)',
      options: [
        { label: 'Inativo', value: '1' },
        { label: 'Ativo', value: '2' }
      ]
    },
    {
      property: 'type',
      label: 'Tipo',
      options: [
        { label: 'Cliente', value: 1 },
        { label: 'Fornecedor', value: 2 }
      ]
    },
    {
      property: 'zipCode',
      label: 'CEP',
      divider: 'Endereço',
      maxLength: 9
    },
    {
      property: 'address',
      label: 'Endereço'
    },
    {
      property: 'cityCode',
      label: 'Cidade',
      options: [
        { label: 'Adolfo', value: '00204' },
        { label: 'São José do Rio Preto', value: '49805' },
        { label: 'José Bonifácio', value: '25706' },
        { label: 'Joinville', value: '09102' }
      ]
    },
    {
      property: 'stateId',
      label: 'Estado',
      options: [
        { label: 'Santa Catarina', value: 'SC' },
        { label: 'São Paulo', value: 'SP' },
        { label: 'Rio de Janeiro', value: 'RJ' },
        { label: 'Minas Gerais', value: 'MG' }
      ]
    },
    /*{
      property: 'branchId',
      label: 'Filial',
      divider: 'Sistemico'
    },
    {
      property: 'companyInternalId',
      label: 'Empresa'
    }*/
  ]
}