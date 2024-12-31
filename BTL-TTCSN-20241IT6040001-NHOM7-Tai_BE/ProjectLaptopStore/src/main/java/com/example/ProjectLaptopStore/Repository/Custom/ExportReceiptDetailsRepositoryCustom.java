package com.example.ProjectLaptopStore.Repository.Custom;

import com.example.ProjectLaptopStore.DTO.ImportExport_ReceiptDisplayDTO;

import java.util.List;

public interface ExportReceiptDetailsRepositoryCustom {
    List<ImportExport_ReceiptDisplayDTO> listExportReceipt(Integer warehouseID);
}
