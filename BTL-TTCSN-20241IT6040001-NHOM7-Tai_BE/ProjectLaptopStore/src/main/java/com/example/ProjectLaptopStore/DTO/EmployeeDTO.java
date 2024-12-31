package com.example.ProjectLaptopStore.DTO;

import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Builder
public class EmployeeDTO {
    private String name;
    private String email;
    private String password;
    private String phoneNumber;
    private Integer employeeId;
    private String status;

    public EmployeeDTO() {

    }

    public EmployeeDTO(String name, String email, String password, String phoneNumber, Integer employeeId, String status) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.employeeId = employeeId;
        this.status = status;
    }
}
