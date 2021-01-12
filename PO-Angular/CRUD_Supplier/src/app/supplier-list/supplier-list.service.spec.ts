import { TestBed } from '@angular/core/testing';

import { SupplierListService } from './supplier-list.service';

describe('SupplierListService', () => {
  let service: SupplierListService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(SupplierListService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
