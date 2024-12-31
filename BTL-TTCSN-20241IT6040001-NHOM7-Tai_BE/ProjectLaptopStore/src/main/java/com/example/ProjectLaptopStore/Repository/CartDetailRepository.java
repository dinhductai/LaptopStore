package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.CartDetailsEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CartDetailRepository extends JpaRepository<CartDetailsEntity,Integer> {

    // lay danh sach cartdetail
    @Query(value = "SELECT cd.CartDetailsID,p.ProductID,p.ImageURL, p.ProductName, cd.Price, cd.Quantity, cd.LineTotal " +
            "FROM cartdetails cd " +
            "JOIN products p ON p.ProductID = cd.ProductID " +
            "WHERE cd.CartID = :cartID",nativeQuery = true)
    List<Object[]> getListCartDetail(@Param("cartID") int cartID);
    //tim kiem cartdetail bằng cartid
    CartDetailsEntity findByCart_CartID(Integer cartID);
}
