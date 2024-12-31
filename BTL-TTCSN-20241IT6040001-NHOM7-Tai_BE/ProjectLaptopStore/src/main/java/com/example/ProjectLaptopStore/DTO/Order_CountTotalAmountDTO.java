package com.example.ProjectLaptopStore.DTO;

import java.math.BigDecimal;

public class Order_CountTotalAmountDTO {
    private Integer month;
    private BigDecimal totalAmount;

    public Order_CountTotalAmountDTO(Integer month, BigDecimal totalAmount) {
        this.month = month;
        this.totalAmount = totalAmount;
    }

    public Integer getMonth() {
        return month;
    }

    public void setMonth(Integer month) {
        this.month = month;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
}
