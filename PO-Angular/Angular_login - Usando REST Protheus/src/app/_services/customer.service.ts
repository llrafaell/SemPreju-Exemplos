import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import { environment } from '@environments/environment';
import { Customer,ApiResult } from '@app/_models';
import { map } from 'rxjs/internal/operators/map';

@Injectable({ providedIn: 'root' })
export class CustomerService {
    constructor(private http: HttpClient) { }

    getAll() {
                                                                                        //1=Cliente, 2-Fornecedor, vazio = ambos
        return this.http.get<Customer[]>(`${environment.apiERP}/api/crm/v1/customerVendor/1`).pipe(map(res => <Customer[]>res)); 
        
        

    }
}