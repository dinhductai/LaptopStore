package com.example.ProjectLaptopStore.DTO;

import java.math.BigInteger;

public class Customer_CountNewCustomerPerMonthDTO {
    private Long month;
    private Long customerCount;

    public Customer_CountNewCustomerPerMonthDTO(Long month, Long customerCount) {
        this.month = month;
        this.customerCount = customerCount;
    }

    public Long getMonth() {
        return month;
    }

    public void setMonth(Long month) {
        this.month = month;
    }

    public Long getCustomerCount() {
        return customerCount;
    }

    public void setCustomerCount(Long customerCount) {
        this.customerCount = customerCount;
    }
}
