import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { environment } from '@environments/environment';
import { User,Token } from '@app/_models';

@Injectable({ providedIn: 'root' })
export class AuthenticationService {
    private urlpost = '/api/oauth2/v1/token'; //url autentication

    private currentUserSubject: BehaviorSubject<Token>;
    public currentUser: Observable<Token>;

    constructor(private http: HttpClient) {
        this.currentUserSubject = new BehaviorSubject<Token>(JSON.parse(localStorage.getItem('currentUser')));
        this.currentUser = this.currentUserSubject.asObservable();
    }

    public get currentUserValue(): Token {
        return this.currentUserSubject.value;
    }

    login(username: string, password: string) {
        console.log(environment.apiERP);
        let parampost = '?grant_type=password&password='+username+'&username='+password;
        return this.http.post<any>(`${environment.apiERP}`+this.urlpost+parampost, { username, password })
            .pipe(map(token => {
                // store user details and jwt token in local storage to keep user logged in between page refreshes
                localStorage.setItem('currentUser', JSON.stringify(token));
                this.currentUserSubject.next(token);
                return token;
            }));
    }

    logout() {
        // remove user from local storage to log user out
        localStorage.removeItem('currentUser');
        this.currentUserSubject.next(null);
    }
}