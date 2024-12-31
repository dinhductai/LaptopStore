package com.example.ProjectLaptopStore.DTO;

import com.example.ProjectLaptopStore.Entity.Enum.User_Enum;
import jakarta.persistence.Column;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Setter
@Getter
public class User_RegisterDTO {
    private int id;
    private String fullName;
    private String email;

    @Size(min = 6, max = 20,message = "Password must be at least 6 characters")
    private String password;

    @Size(min = 10, max = 10,message = "Phone number must be 10 digits")
    @NotNull
    private String phoneNumber;
    private LocalDateTime registerDate = LocalDateTime.now();
}
