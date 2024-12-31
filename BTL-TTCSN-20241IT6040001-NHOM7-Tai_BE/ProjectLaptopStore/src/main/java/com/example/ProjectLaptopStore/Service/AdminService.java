package com.example.ProjectLaptopStore.Service;

import com.example.ProjectLaptopStore.Response.Admin_BillResponseDTO;
import com.example.ProjectLaptopStore.Response.Admin_DashBoardResponseDTO;
import com.example.ProjectLaptopStore.Response.Admin_WarehouseResponseDTO;

public interface AdminService {
    Admin_DashBoardResponseDTO adminDashBoardAtService();
    Admin_BillResponseDTO adminBillingAtService();
    Admin_WarehouseResponseDTO adminReceiptAtService(Integer warehouseID);
}
