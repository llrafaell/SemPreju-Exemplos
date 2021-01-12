import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';


import { SupplierListComponent } from './supplier-list/supplier-list.component';
import { SupplierFormComponent } from './supplier-form/supplier-form.component';

const routes: Routes = [
  { path: '', component: SupplierListComponent },
  { path: 'supplier', component: SupplierListComponent }, //lista de fornecedor
  { path: 'supplierform', component: SupplierFormComponent }, //form do fornecedor - Incluir
  { path: 'supplierform/:id/:type', component: SupplierFormComponent }, //form do fornecedor - Editar
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
