package com.example.ProjectLaptopStore.Repository.Custom.Impl;

import com.example.ProjectLaptopStore.DTO.ImportReceiptDTO;
import com.example.ProjectLaptopStore.Entity.*;
import com.example.ProjectLaptopStore.Repository.Custom.ImportReceiptsRepositoryCustom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

@Repository
@Transactional
public class ImportReceiptsRepositoryCustomImpl implements ImportReceiptsRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;
    @Override
    public void addImportReceipt(ImportReceiptDTO importReceiptDTO, WareHouseEntity wareHouseEntity, AdminEntity adminEntity, ProductsEntity productsEntity,ProductInWarehouseEntity productInWarehouseEntity,Integer task) {
            ImportReceiptEntity importReceiptEntity = new ImportReceiptEntity();
            importReceiptEntity.setWarehouse(wareHouseEntity);
            importReceiptEntity.setAdmin(adminEntity);
            LocalDate currentDate = LocalDate.now();
            importReceiptEntity.setImportDate(currentDate);
            importReceiptEntity.setImporter("Admin");
            //tao moi
            if(task == 2) {
                    productInWarehouseEntity.setWarehouse(wareHouseEntity);
                    productInWarehouseEntity.setProduct(productsEntity);
                    productInWarehouseEntity.setProductName(productsEntity.getProductName());
                    productInWarehouseEntity.setProductionBatchCode(importReceiptDTO.getProductBatchCode());
                    productInWarehouseEntity.setDimensions(importReceiptDTO.getDimension());
                    productInWarehouseEntity.setVolume(importReceiptDTO.getVolume());
                    productInWarehouseEntity.setMinStockLevel(importReceiptDTO.getMinStock());
                    productInWarehouseEntity.setMaxStockLevel(importReceiptDTO.getMaxStock());
                    productInWarehouseEntity.setQuantity(importReceiptDTO.getQuantity());
                    entityManager.persist(productInWarehouseEntity);
            }
            //da ton tai
            if(task == 1) {
                    productInWarehouseEntity.setQuantity(productInWarehouseEntity.getQuantity() +  importReceiptDTO.getQuantity());
                    entityManager.merge(productInWarehouseEntity);
                    entityManager.flush();
            }
            ImportReceiptDetailEntity importReceiptDetailEntity = new ImportReceiptDetailEntity();
            importReceiptDetailEntity.setImportReceipt(importReceiptEntity);
            importReceiptDetailEntity.setProduct(productsEntity);
            importReceiptDetailEntity.setQuantity(importReceiptDTO.getQuantity());
            entityManager.persist(importReceiptEntity);
            entityManager.persist(importReceiptDetailEntity);

    }
}
