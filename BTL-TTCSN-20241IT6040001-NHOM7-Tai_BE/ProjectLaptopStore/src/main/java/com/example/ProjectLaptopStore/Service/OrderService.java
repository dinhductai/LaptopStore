package com.example.ProjectLaptopStore.Service;

import com.example.ProjectLaptopStore.DTO.*;

import java.math.BigDecimal;
import java.util.List;

public interface OrderService {
    BigDecimal getTotalAmountInMountAtService();
    Integer TotalCustomerInMonthAtService();
    List<Order_ListBillDTO> ListBillAtService();
    List<Order_InvoiceDetailDTO> ListInvoiceDetailAtService();
    List<Order_CountTotalAmountDTO> listCountTotalAmountAtService();
    BigDecimal getTotalAmountOnline();
    BigDecimal getTotalAmountOffline();


    // tao moi don hang
    void createOrder(OrderDTO dto);

    //hien thi cac don hang
    List<Order_OrderDetailDTO> ListOrderDetail(int id);

    //hien thi don hang theo status
    List<Order_OrderDetailDTO> ListOrderDetailByStatus(int customerID, String status);

    // huy don hang
    void cancelOrder(int orderID);
}
