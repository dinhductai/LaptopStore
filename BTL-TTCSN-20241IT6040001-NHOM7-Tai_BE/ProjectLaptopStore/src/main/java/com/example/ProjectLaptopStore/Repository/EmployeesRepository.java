package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.EmployeeEntity;
import com.example.ProjectLaptopStore.Repository.Custom.EmployeesRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmployeesRepository extends JpaRepository<EmployeeEntity,Integer>, EmployeesRepositoryCustom {
}
