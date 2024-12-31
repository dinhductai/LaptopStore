package com.example.ProjectLaptopStore.DTO;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Date;
@Getter
@Setter
public class Customer_FindTopCustomerInMonthDTO {
    private Integer customerId;
    private String userName;
    private String email;
    private String phoneNumber;
    private Date registrationDate;
    private String address;
    private String city;
    private String district;
    private String ward;
    private String streetAddress;
    private BigDecimal totalAmount;
    private Integer quantity;

    public Customer_FindTopCustomerInMonthDTO(Integer customerId, String userName, String email, String phoneNumber, Date registrationDate, String address, String city, String district, String ward, String streetAddress, BigDecimal totalAmount, Integer quantity) {
        this.customerId = customerId;
        this.userName = userName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.registrationDate = registrationDate;
        this.address = address;
        this.city = city;
        this.district = district;
        this.ward = ward;
        this.streetAddress = streetAddress;
        this.totalAmount = totalAmount;
        this.quantity = quantity;
    }
}
