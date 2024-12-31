package com.example.ProjectLaptopStore.Repository.Custom;

import com.example.ProjectLaptopStore.DTO.Supplier_FindTopSupplierDTO;
import com.example.ProjectLaptopStore.DTO.SupplierDTO;
import com.example.ProjectLaptopStore.Entity.SuppliersEntity;

import java.util.List;

public interface SuppliersRepositoryCustom {
    // phuong thuc lay ra top nha cung cap
    List<Supplier_FindTopSupplierDTO> listTopSuppliers();

    // phuong thuc tao moi nha cung cap
    void createSupplier(SupplierDTO supplierNew,SuppliersEntity suppliersEntity);

    // phuong thuc cap nhat thong tin nha cung cap
    void updateSupplier(SupplierDTO supplierUpdate, SuppliersEntity suppliersEntity);

    // phuong thuc xoa nha cung cap
    void deleteSupplier(SuppliersEntity suppliersEntity);
}
