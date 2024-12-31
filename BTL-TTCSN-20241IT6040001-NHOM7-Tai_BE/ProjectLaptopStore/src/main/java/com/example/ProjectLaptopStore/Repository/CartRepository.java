package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.CartEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CartRepository extends JpaRepository<CartEntity,Integer> {

    @Query(value = "SELECT * FROM cart c WHERE c.CustomerID = :customerID",nativeQuery = true)
    CartEntity getCartByCustomerId(@Param("customerID")int customerId);
}
