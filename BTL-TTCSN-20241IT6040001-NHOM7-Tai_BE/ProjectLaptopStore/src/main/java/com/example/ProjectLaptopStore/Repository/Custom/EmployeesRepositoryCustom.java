package com.example.ProjectLaptopStore.Repository.Custom;

import com.example.ProjectLaptopStore.DTO.EmployeeDTO;
import com.example.ProjectLaptopStore.Entity.EmployeeEntity;
import com.example.ProjectLaptopStore.Entity.UserEntity;

import java.util.List;

public interface EmployeesRepositoryCustom {
    List<EmployeeDTO> getAllEmployees();
    void createEmployee(EmployeeDTO employeeDTO, EmployeeEntity employeeEntity, UserEntity userEntity);
    void updateEmployee(EmployeeDTO employeeDTO, EmployeeEntity employeeEntity, UserEntity userEntity);
    void deleteEmployee(EmployeeEntity employeeEntity );
    EmployeeDTO getEmployeeByID(Integer employeeID);

}
