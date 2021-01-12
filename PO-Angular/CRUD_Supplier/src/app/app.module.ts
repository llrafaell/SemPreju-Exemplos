import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { PoModule } from '@po-ui/ng-components';
import { RouterModule } from '@angular/router';
import { PoNotificationModule  } from '@po-ui/ng-components';
import { PoDynamicModule } from '@po-ui/ng-components';
import { PoButtonModule } from '@po-ui/ng-components';
import {PoTemplatesModule  } from '@po-ui/ng-templates';

//incluir o componente para lista de fornecedores
import { SupplierListComponent } from './supplier-list/supplier-list.component';
import { SupplierFormComponent } from './supplier-form/supplier-form.component'; //formulario de inclusão/alteração

@NgModule({
  declarations: [
    AppComponent,SupplierListComponent,SupplierFormComponent
  ],
  imports: [
    PoNotificationModule,PoDynamicModule,PoButtonModule  ,PoTemplatesModule,
    BrowserModule,
    AppRoutingModule,
    PoModule,
    RouterModule.forRoot([])
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
