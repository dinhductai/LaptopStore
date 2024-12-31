package com.example.ProjectLaptopStore.Repository.Custom.Impl;

import com.example.ProjectLaptopStore.DTO.ExportReceiptDTO;
import com.example.ProjectLaptopStore.Entity.*;
import com.example.ProjectLaptopStore.Repository.Custom.ExportReceiptsRepositoryCustom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.NoSuchElementException;

@Transactional
@Repository
public class ExportReceiptsRepositoryCustomImpl implements ExportReceiptsRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void addExportReceipt(AdminEntity adminEntity, ExportReceiptDTO exportReceiptDTO, ProductInWarehouseEntity productInWarehouseEntity, ProductsEntity productsEntity, Integer task) {
        ExportReceiptEntity exportReceiptEntity = new ExportReceiptEntity();
        ExportReceipDetailEntity exportReceipDetailEntity = new ExportReceipDetailEntity();
        exportReceiptEntity.setAdmin(adminEntity);
        exportReceiptEntity.setWarehouse(productInWarehouseEntity.getWarehouse());
        LocalDate currentDate = LocalDate.now();
        exportReceiptEntity.setExportDate(currentDate);
        exportReceiptEntity.setExporter("Admin");
        exportReceipDetailEntity.setExportReceipt(exportReceiptEntity);
        exportReceipDetailEntity.setProduct(productInWarehouseEntity.getProduct());
        exportReceipDetailEntity.setQuantity(exportReceiptDTO.getQuantity());
        productsEntity.setStockQuantity( productsEntity.getStockQuantity() + exportReceiptDTO.getQuantity());
        entityManager.persist(exportReceiptEntity);
        entityManager.persist(exportReceipDetailEntity);
        entityManager.merge(productsEntity);
        //khong xuat het hang
        if (task == 1) {
            productInWarehouseEntity.setQuantity(productInWarehouseEntity.getQuantity() - exportReceiptDTO.getQuantity());
            entityManager.merge(productInWarehouseEntity);
            entityManager.flush();
        } else if (task == 2) {
            //xoa het
            entityManager.remove(productInWarehouseEntity);
            entityManager.flush();
        }
    }
}
