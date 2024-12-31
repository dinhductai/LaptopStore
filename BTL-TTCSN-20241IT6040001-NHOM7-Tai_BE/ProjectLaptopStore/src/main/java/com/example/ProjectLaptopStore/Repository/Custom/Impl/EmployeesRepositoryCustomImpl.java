package com.example.ProjectLaptopStore.Repository.Custom.Impl;

import com.example.ProjectLaptopStore.DTO.EmployeeDTO;
import com.example.ProjectLaptopStore.Entity.EmployeeEntity;
import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.example.ProjectLaptopStore.Entity.Enum.User_Enum;
import com.example.ProjectLaptopStore.Entity.UserEntity;
import com.example.ProjectLaptopStore.Repository.Custom.EmployeesRepositoryCustom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Repository
@Transactional
public class EmployeesRepositoryCustomImpl implements EmployeesRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;
    @Override
    public List<EmployeeDTO> getAllEmployees() {
        String query = "Select u.FullName , u.Email , u.Password , u.PhoneNumber, e.EmployeeID , e.Status " +
                "from employees e " +
                "join users u on u.UserID = e.UserID " +
                "WHERE e.Status ='active' ";
        Query queryNative = entityManager.createNativeQuery(query);
        List<Object[]> resultQuery = queryNative.getResultList();
        List<EmployeeDTO> listEmployeeDTO = new ArrayList<>();
        for (Object[] rowOfResults : resultQuery) {
            EmployeeDTO employeeDTO = EmployeeDTO.builder()
                    .name((String) rowOfResults[0])
                    .email((String) rowOfResults[1])
                    .password((String) rowOfResults[2])
                    .phoneNumber((String) rowOfResults[3])
                    .employeeId((Integer) rowOfResults[4])
                    .status((String) rowOfResults[5])
                    .build();
            listEmployeeDTO.add(employeeDTO);
        }
        return listEmployeeDTO;
    }

    @Override
    public void createEmployee(EmployeeDTO employeeDTO, EmployeeEntity employeeEntity, UserEntity userEntity) {
        userEntity.setFullName(employeeDTO.getName());
        userEntity.setEmail(employeeDTO.getEmail());
        userEntity.setPassword(employeeDTO.getPassword());
        userEntity.setPhoneNumber(employeeDTO.getPhoneNumber());
        userEntity.setUserType(User_Enum.employee);
        Date date = new Date();
        userEntity.setRegistrationDate(date);
        employeeEntity.setUser(userEntity);
        employeeEntity.setName(employeeDTO.getName());
        employeeEntity.setCreatedDate(date);
        employeeEntity.setStatus(Status_Enum.active);
        entityManager.persist(userEntity);
        entityManager.persist(employeeEntity);
    }

    @Override
    public void updateEmployee(EmployeeDTO employeeDTO, EmployeeEntity employeeEntity, UserEntity userEntity) {
        userEntity.setFullName(employeeDTO.getName());
        userEntity.setEmail(employeeDTO.getEmail());
        userEntity.setPassword(employeeDTO.getPassword());
        userEntity.setPhoneNumber(employeeDTO.getPhoneNumber());
        employeeEntity.setUser(userEntity);
        employeeEntity.setName(employeeDTO.getName());
        if(employeeDTO.getStatus().equals("inactive")) {
            employeeEntity.setStatus(Status_Enum.inactive);
        }else {
            employeeEntity.setStatus(Status_Enum.active);
        }
        entityManager.merge(userEntity);
        entityManager.merge(employeeEntity);
        entityManager.flush();
    }

    @Override
    public void deleteEmployee(EmployeeEntity employeeEntity) {
        employeeEntity.setStatus(Status_Enum.inactive);
    }

    @Override
    public EmployeeDTO getEmployeeByID(Integer employeeID) {
        String query = "Select u.FullName , u.Email , u.Password , u.PhoneNumber, e.EmployeeID , e.Status " +
                "from employees e " +
                "join users u on u.UserID = e.UserID " +
                "where e.Status ='active' and e.EmployeeID = :employeeID";
        Query queryNative = entityManager.createNativeQuery(query);
        queryNative.setParameter("employeeID", employeeID);
        List<Object[]> resultQuery = queryNative.getResultList();
        EmployeeDTO EmployeeDTO = new EmployeeDTO();
        for (Object[] rowOfResults : resultQuery) {
            EmployeeDTO = new EmployeeDTO(
                    (String) rowOfResults[0],
                    (String) rowOfResults[1],
                    (String) rowOfResults[2],
                    (String) rowOfResults[3],
                    (Integer) rowOfResults[4],
                    (String) rowOfResults[5]
            );
        }
        return EmployeeDTO;
    }



}
