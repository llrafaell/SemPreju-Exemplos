export class City {
    cityCode: string ;
    cityInternalId: string ;
    cityDescription: string ;
    constructor(obj = {}) {
        Object.assign(this, obj);
    }
  }