package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.ShippingAddressEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ShippingAddressesRepository extends JpaRepository<ShippingAddressEntity,Integer> {
    List<ShippingAddressEntity> findAllByAddressIDIn(Long[] ids);


    @Query(value = "SELECT sa.AddressID, sa.Address, sa.City, sa.District, Ward, sa.StreetAddress , u.PhoneNumber\n" +
            "FROM ShippingAddresses sa \n" +
            "JOIN Customers c ON c.CustomerID = sa.CustomerID\n" +
            "JOIN Users u ON u.UserID = c.UserID\n" +
            "WHERE sa.CustomerID = :customerID",nativeQuery = true)
    List<Object[]> getAllShippingAddresses(@Param("customerID")int customerID);

    @Query(value = "SELECT * FROM ShippingAddresses WHERE AddressID = :id",nativeQuery = true)
    ShippingAddressEntity getShippingAddressById(@Param("id")int id);
}
