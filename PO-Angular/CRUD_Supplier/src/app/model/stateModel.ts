export class State {
    stateId: string ;
    stateInternalId: string ;
    stateDescription: string ;
    constructor(obj = {}) {
        Object.assign(this, obj);
    }
  }