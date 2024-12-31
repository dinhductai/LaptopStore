package com.example.ProjectLaptopStore.Response;

import com.example.ProjectLaptopStore.DTO.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;
@Getter
@Setter
public class Admin_DashBoardResponseDTO {
    private Integer quantitySellProductCurrentMonth;
    private Integer totalCustomerInCurrentMonth;
    private Integer totalNewCustomerInCurrentMonth;
    private BigDecimal totalAmountInCurrentMonth;
    private List<Customer_CountNewCustomerPerMonthDTO> newCustomerPerMonthMap;
    private List<Order_CountTotalAmountDTO> totalAmountPerMonthMap;
    private List<OrderDetail_CountQuantityProductPerMonthDTO> totalQuantitySellProductPerMonthMap;
    private List<ProductDetailDTO> topPurchasedProductInMonth;
    private List<CustomerDTO> topCustomerInMonth;

    public Admin_DashBoardResponseDTO() {
    }



}
