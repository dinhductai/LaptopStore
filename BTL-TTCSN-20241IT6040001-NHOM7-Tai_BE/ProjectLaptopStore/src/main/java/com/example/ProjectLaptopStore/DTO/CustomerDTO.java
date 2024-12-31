package com.example.ProjectLaptopStore.DTO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
public class CustomerDTO {
    private BigDecimal totalAmount;
    private Integer userID;
    private Integer customerID;
    private Integer addressID;
    private String fullName;
    private String email;
    private String passWord;
    private String phoneNumber;
    private Date registrationDate;
    private String address;
    private String city;
    private String district;
    private String ward;
    private String streetAddress;

    public CustomerDTO() {
    }

    public CustomerDTO(BigDecimal totalAmount, Integer userID, Integer customerID, Integer addressID, String fullName, String email, String passWord, String phoneNumber, Date registrationDate, String address, String city, String district, String ward, String streetAddress) {
        this.totalAmount = totalAmount;
        this.userID = userID;
        this.customerID = customerID;
        this.addressID = addressID;
        this.fullName = fullName;
        this.email = email;
        this.passWord = passWord;
        this.phoneNumber = phoneNumber;
        this.registrationDate = registrationDate;
        this.address = address;
        this.city = city;
        this.district = district;
        this.ward = ward;
        this.streetAddress = streetAddress;
    }
}
