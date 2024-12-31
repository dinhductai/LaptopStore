package com.example.ProjectLaptopStore.DTO;

import java.math.BigDecimal;

public class Order_CountTotalAmountPerMonthDTO {
    private Integer month;
    private BigDecimal totalRevenue;

    public Order_CountTotalAmountPerMonthDTO(Integer month, BigDecimal totalRevenue) {
        this.month = month;
        this.totalRevenue = totalRevenue;
    }

    public Integer getMonth() {
        return month;
    }

    public void setMonth(Integer month) {
        this.month = month;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}
