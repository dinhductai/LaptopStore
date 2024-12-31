package com.example.ProjectLaptopStore.DTO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
@Getter
@Setter
@Builder
public class Customer_GetListCusDTO {
    private Integer userID;
    private Integer customerID;
    private String fullName;
    private String email;
    private String passWord;
    private String phoneNumber;
    private Date registrationDate;

}
