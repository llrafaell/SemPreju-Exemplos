import { Component } from '@angular/core';
import { first } from 'rxjs/operators';

import { Customer } from '@app/_models';
import { CustomerService, AuthenticationService } from '@app/_services';

@Component({ templateUrl: 'home.component.html' })
export class HomeComponent {
    loading = false;
    clientes: Customer[];

    constructor(private customerService: CustomerService) { }

    ngOnInit() {
        this.loading = true;
        console.log('Buscando clientes')
        this.customerService.getAll().pipe(first()).subscribe(clientes => {
            this.loading = false;
            this.clientes = clientes.items;
           // this.users = users;
           console.log(clientes);
        });
    }
}