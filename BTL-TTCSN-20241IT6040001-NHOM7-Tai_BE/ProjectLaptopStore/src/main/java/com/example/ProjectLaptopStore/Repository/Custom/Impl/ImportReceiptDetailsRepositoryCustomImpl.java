package com.example.ProjectLaptopStore.Repository.Custom.Impl;

import com.example.ProjectLaptopStore.DTO.ImportExport_ReceiptDisplayDTO;
import com.example.ProjectLaptopStore.DTO.ImportReceiptDTO;
import com.example.ProjectLaptopStore.Entity.*;
import com.example.ProjectLaptopStore.Repository.Custom.ImportReceiptDetailsRepositoryCustom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Repository
@Transactional
public class ImportReceiptDetailsRepositoryCustomImpl implements ImportReceiptDetailsRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;
    @Override
    public List<ImportExport_ReceiptDisplayDTO> listImportReceipt(Integer warehouseID) {
        String query = "SELECT " +
                "p.ProductName AS productName, " +
                "p.Brand AS brand, " +
                "p.Model AS model, " +
                "p.Price AS price, " +
                "ir.ImportDate AS importDate, " +
                "ir.Importer AS importer, " +
                "ird.Quantity AS quantity " +
                "FROM ImportReceiptDetails ird " +
                "JOIN Products p ON ird.ProductID = p.ProductID " +
                "JOIN ImportReceipts ir ON ird.ImportReceiptID = ir.ImportReceiptID " +
                "Join Warehouses w on w.WarehouseID = ir.WarehouseID " +
                "where w.WarehouseID = :warehouseID;";
        Query nativeQuery = entityManager.createNativeQuery(query);
        nativeQuery.setParameter("warehouseID", warehouseID);
        List<Object[]> result = nativeQuery.getResultList();
        List<ImportExport_ReceiptDisplayDTO> listImportReceipt = new ArrayList<>();
        for(Object[] rowOfResult : result) {
            ImportExport_ReceiptDisplayDTO item = new ImportExport_ReceiptDisplayDTO(
                    (String) rowOfResult[0],
                    (String) rowOfResult[1],
                    (String) rowOfResult[2],
                    (Float) rowOfResult[3],
                    (Date) rowOfResult[4],
                    (String) rowOfResult[5],
                    (Integer) rowOfResult[6]
            );
            listImportReceipt.add(item);
        }
        return listImportReceipt;
    }


}
