package com.example.ProjectLaptopStore.DTO;

import com.example.ProjectLaptopStore.Entity.Enum.User_Enum;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class User_LoginDTO {
    private String password;
    private String phoneNumber;
}
