package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.CustomerEntity;
import com.example.ProjectLaptopStore.Repository.Custom.CustomerRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CustomerRepository extends JpaRepository<CustomerEntity,Integer>, CustomerRepositoryCustom {
    List<CustomerEntity> findAllByCustomerIDIn(Long[] ids);

    //đếm số lượng khách hàng mới trong tháng
    @Query(value =
                    "SELECT count(c.CustomerID) as newcustomer " +
                    "FROM Customers c " +
                    "WHERE MONTH(c.RegistrationDate) = MONTH(CURDATE()) " +
                    "AND YEAR(c.RegistrationDate) = YEAR(CURDATE());", nativeQuery = true)
    Integer getNewCustomerCurrentMonth();

    @Query(value = "SELECT * FROM customers c WHERE c.UserID = :userID",nativeQuery = true)
    CustomerEntity getCustomerID(@Param("userID")int userID);
}
