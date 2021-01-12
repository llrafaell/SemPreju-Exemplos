import { State } from './stateModel';
import { City } from './cityModel';

export class Address {
  address: string ;
  number: string ;
  zipCode: string ;
  complement: string ;
  district: string ;
  city: City = new City();
  state: State = new State();
  constructor(obj = {}) {
    Object.assign(this, obj);
}
}