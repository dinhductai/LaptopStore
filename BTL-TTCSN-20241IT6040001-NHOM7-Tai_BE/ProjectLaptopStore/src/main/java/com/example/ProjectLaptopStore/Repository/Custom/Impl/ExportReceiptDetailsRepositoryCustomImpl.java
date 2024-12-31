package com.example.ProjectLaptopStore.Repository.Custom.Impl;

import com.example.ProjectLaptopStore.DTO.ImportExport_ReceiptDisplayDTO;
import com.example.ProjectLaptopStore.Repository.Custom.ExportReceiptDetailsRepositoryCustom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Repository
@Transactional
public class ExportReceiptDetailsRepositoryCustomImpl implements ExportReceiptDetailsRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;
    @Override
    public List<ImportExport_ReceiptDisplayDTO> listExportReceipt(Integer warehouseID) {
        String query = "SELECT " +
                "p.ProductName AS productName, " +
                "p.Brand as brand, " +
                "p.Model as model, " +
                "p.Price as price, " +
                "er.ExportDate AS exportDate, " +
                "er.Exporter AS exporter, " +
                "erd.Quantity AS quantity " +
                "FROM ExportReceiptDetails erd " +
                "JOIN Products p ON erd.ProductID = p.ProductID " +
                "JOIN ExportReceipts er ON erd.ExportReceiptID = er.ExportReceiptID " +
                "Join Warehouses w on w.WarehouseID = er.WarehouseID " +
                "where w.WarehouseID = :idwarehouse ";

        Query nativeQuery = entityManager.createNativeQuery(query);
        nativeQuery.setParameter("idwarehouse", warehouseID);
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
