package com.example.ProjectLaptopStore.DTO;

public class OrderDetail_CountQuantityProductPerMonthDTO {
    private Integer month;
    private Long totalSold;
    public OrderDetail_CountQuantityProductPerMonthDTO( Integer month, Long totalSold) {
        this.month = month;
        this.totalSold = totalSold;
    }


    public Integer getMonth() {
        return month;
    }

    public void setMonth(Integer month) {
        this.month = month;
    }

    public Long getTotalSold() {
        return totalSold;
    }

    public void setTotalSold(Long totalSold) {
        this.totalSold = totalSold;
    }
}
