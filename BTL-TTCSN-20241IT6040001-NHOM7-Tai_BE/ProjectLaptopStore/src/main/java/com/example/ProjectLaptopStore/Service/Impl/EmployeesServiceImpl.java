package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.DTO.EmployeeDTO;
import com.example.ProjectLaptopStore.Entity.EmployeeEntity;
import com.example.ProjectLaptopStore.Entity.UserEntity;
import com.example.ProjectLaptopStore.Repository.EmployeesRepository;
import com.example.ProjectLaptopStore.Repository.UserRepository;
import com.example.ProjectLaptopStore.Service.EmployeesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class EmployeesServiceImpl implements EmployeesService {
    @Autowired
    private EmployeesRepository employeesRepository;
    @Autowired
    private UserRepository userRepository;
    @Override
    public List<EmployeeDTO> getAllEmployee() {
        return employeesRepository.getAllEmployees();
    }

    @Override
    public void createEmployee(EmployeeDTO employeeDTO) {
        EmployeeEntity employeeEntity = new EmployeeEntity();
        UserEntity userEntity = new UserEntity();
        List<UserEntity> userEntities = userRepository.findAll();
        for(UserEntity user : userEntities){
            if(user.getPhoneNumber().equals(employeeDTO.getPhoneNumber())){
                throw new NoSuchElementException("Phone number already exists");
            }
        }
        employeesRepository.createEmployee(employeeDTO,employeeEntity,userEntity);
    }

    @Override
    public void updateEmployee(EmployeeDTO employeeDTO) {
        EmployeeEntity employeeEntity = employeesRepository.findById(employeeDTO.getEmployeeId()).orElseThrow(() -> new NoSuchElementException("Employee Not Found"));
        Integer userId = userRepository.findUserIdByEmployeeId(employeeDTO.getEmployeeId());
        UserEntity userEntity = userRepository.findById(userId).orElseThrow(() -> new NoSuchElementException("User Not Found"));
        employeesRepository.updateEmployee(employeeDTO,employeeEntity,userEntity);
    }

    @Override
    public void deleteEmployee(Integer idEmployee) {
        EmployeeEntity employeeEntity = employeesRepository.findById(idEmployee).orElseThrow(() -> new NoSuchElementException("Employee Not Found"));
        employeesRepository.deleteEmployee(employeeEntity);
    }

    @Override
    public EmployeeDTO getEmployeeById(Integer idEmployee) {
        return employeesRepository.getEmployeeByID(idEmployee);
    }


}
