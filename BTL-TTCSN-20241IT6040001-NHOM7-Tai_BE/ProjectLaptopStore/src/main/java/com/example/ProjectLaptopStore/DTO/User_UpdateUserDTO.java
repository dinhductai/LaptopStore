package com.example.ProjectLaptopStore.DTO;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class User_UpdateUserDTO {
    private int userID;
    private String fullName;
    private String phoneNumber;
    private String email;
    private String password;
    private String newPassword;


}
