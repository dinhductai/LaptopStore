package com.example.ProjectLaptopStore.Service;

import com.example.ProjectLaptopStore.DTO.EmployeeDTO;
import com.example.ProjectLaptopStore.Entity.EmployeeEntity;

import java.util.List;

public interface EmployeesService {
    List<EmployeeDTO> getAllEmployee();
    void createEmployee(EmployeeDTO employeeDTO);
    void updateEmployee(EmployeeDTO employeeDTO);
    void deleteEmployee(Integer idEmployee);
    EmployeeDTO getEmployeeById(Integer idEmployee);
}
