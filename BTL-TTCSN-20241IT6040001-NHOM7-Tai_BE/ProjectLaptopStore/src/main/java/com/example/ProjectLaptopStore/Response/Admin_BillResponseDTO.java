package com.example.ProjectLaptopStore.Response;

import com.example.ProjectLaptopStore.DTO.Order_InvoiceDetailDTO;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
public class Admin_BillResponseDTO {
    private BigDecimal totalAmountPayOnline;
    private BigDecimal totalAmountPayOffline;
    private List<Order_InvoiceDetailDTO> listInvoiceDetail;
}
