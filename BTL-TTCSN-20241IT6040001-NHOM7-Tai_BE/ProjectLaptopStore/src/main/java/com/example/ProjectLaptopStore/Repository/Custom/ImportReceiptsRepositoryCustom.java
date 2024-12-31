package com.example.ProjectLaptopStore.Repository.Custom;

import com.example.ProjectLaptopStore.DTO.ImportReceiptDTO;
import com.example.ProjectLaptopStore.Entity.AdminEntity;
import com.example.ProjectLaptopStore.Entity.ProductInWarehouseEntity;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import com.example.ProjectLaptopStore.Entity.WareHouseEntity;

public interface ImportReceiptsRepositoryCustom {
    void addImportReceipt(ImportReceiptDTO importReceiptDTO, WareHouseEntity wareHouseEntity, AdminEntity adminEntity, ProductsEntity productsEntity, ProductInWarehouseEntity productInWarehouseEntity, Integer task);

}
