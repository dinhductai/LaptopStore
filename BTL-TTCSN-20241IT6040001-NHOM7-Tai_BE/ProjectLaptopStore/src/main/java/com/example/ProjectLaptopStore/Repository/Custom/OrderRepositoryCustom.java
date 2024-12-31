package com.example.ProjectLaptopStore.Repository.Custom;

import com.example.ProjectLaptopStore.DTO.Order_CountTotalAmountDTO;
import com.example.ProjectLaptopStore.DTO.Order_InvoiceDetailDTO;
import com.example.ProjectLaptopStore.DTO.Order_ListBillDTO;

import java.util.List;

public interface OrderRepositoryCustom {
    List<Order_ListBillDTO> listBill();
    List<Order_InvoiceDetailDTO> listInvoiceDetail();
    List<Order_CountTotalAmountDTO> listCountTotalAmount();
}
