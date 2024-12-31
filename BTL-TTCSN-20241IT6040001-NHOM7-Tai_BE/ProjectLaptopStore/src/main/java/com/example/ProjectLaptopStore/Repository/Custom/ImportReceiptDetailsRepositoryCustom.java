package com.example.ProjectLaptopStore.Repository.Custom;

import com.example.ProjectLaptopStore.DTO.ImportExport_ReceiptDisplayDTO;
import com.example.ProjectLaptopStore.DTO.ImportReceiptDTO;
import com.example.ProjectLaptopStore.Entity.AdminEntity;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import com.example.ProjectLaptopStore.Entity.WareHouseEntity;

import java.util.List;

public interface ImportReceiptDetailsRepositoryCustom {
    List<ImportExport_ReceiptDisplayDTO> listImportReceipt(Integer warehouseID);
}
