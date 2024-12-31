package com.example.ProjectLaptopStore.Service;

import com.example.ProjectLaptopStore.DTO.Supplier_FindTopSupplierDTO;
import com.example.ProjectLaptopStore.DTO.SupplierDTO;
import com.example.ProjectLaptopStore.Entity.SuppliersEntity;

import java.util.List;
import java.util.Map;

public interface SuppliersService {
    // phuong thuc lay ra top nha cung cap
    List<Supplier_FindTopSupplierDTO> listTopSupplier();

    // phuong thuc tao moi nha cung cap
    void createSupplier(SupplierDTO supplierNew);

    // phuong thuc xoa nha cung cap
    void deleteSupplier(Long[] ids);

    // phuong thuc cap nhat nha cung cap
    void updateSupplier(SupplierDTO supplierUpdate);



    // phuong thuc lay ra danh sach nha cung cap
    List<SuppliersEntity> getListSupplier();

    // phuong thuc lay ra thong tin nha cung cap theo ID
    SuppliersEntity getSupplierByID(Integer supplierId);

}
