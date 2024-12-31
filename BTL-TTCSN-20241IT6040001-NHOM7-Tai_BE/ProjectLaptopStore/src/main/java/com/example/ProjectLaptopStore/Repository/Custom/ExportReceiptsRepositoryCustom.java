package com.example.ProjectLaptopStore.Repository.Custom;

import com.example.ProjectLaptopStore.DTO.ExportReceiptDTO;
import com.example.ProjectLaptopStore.Entity.AdminEntity;
import com.example.ProjectLaptopStore.Entity.ProductInWarehouseEntity;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;

public interface ExportReceiptsRepositoryCustom {
    void addExportReceipt(AdminEntity adminEntity, ExportReceiptDTO exportReceiptDTO, ProductInWarehouseEntity productInWarehouseEntity, ProductsEntity productsEntity, Integer task);
}
