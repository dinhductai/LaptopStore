package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Repository.Custom.OrderRepositoryCustom;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;
import java.math.BigDecimal;
import java.util.List;

import com.example.ProjectLaptopStore.Entity.OrdersEntity;

@Repository
public interface OrderRepository extends JpaRepository<OrdersEntity, Integer> , OrderRepositoryCustom {
    //lấy tổng tiền từ các hóa đơn từ cột TotalAmount từ bảng Order ,được thanh toán trong tháng hiện tại
    @Query(value = "SELECT SUM(o.TotalAmount) " +
        "FROM Orders o " +
        "WHERE o.OrderDate >= DATE_FORMAT(CURDATE(), '%Y-%m-01') " +
        "AND o.OrderDate <= CURDATE()", nativeQuery = true)
    BigDecimal getTotalAmount();

    //đếm số khách hàng trong tháng hiện tại
    @Query(value = "SELECT COUNT(DISTINCT o.CustomerID) " +
            "FROM Orders o " +
            "WHERE o.OrderDate >= DATE_FORMAT(CURDATE(), '%Y-%m-01') " +
            "AND o.OrderDate <= CURDATE()", nativeQuery = true )
    Integer countCustomersForCurrentMonth();

    @Query(value = "select sum( o.TotalAmount) as totalAmount " +
            "from Orders o " +
            "join PaymentMethods pm on o.PaymentMethodID = pm.PaymentMethodID " +
            "where pm.PaymentType = 'ONLINE'",nativeQuery = true)
    BigDecimal getTotalAmountPayOnline();

    @Query(value = "select sum( o.TotalAmount) as totalAmount " +
            "from Orders o " +
            "join PaymentMethods pm on o.PaymentMethodID = pm.PaymentMethodID " +
            "where pm.PaymentType = 'OFFLINE'",nativeQuery = true)
    BigDecimal getTotalAmountPayOffline();

    // lay danh sach cac don hang
    @Query(value = "SELECT * FROM Orders o WHERE o.customerID = :customerID",nativeQuery = true)
    List<OrdersEntity> findByCustomerID(@Param("customerID") int customerID);


    @Query(value = "SELECT * FROM Orders o WHERE o.OrderID = :orderID",nativeQuery = true)
    OrdersEntity findByOrderID(@Param("orderID") int orderID);

    // lay danh sach id order
    @Query(value = "SELECT o.OrderID FROM Orders o WHERE o.CustomerID = :customerID",nativeQuery = true)
    List<Integer> findOrderIDByCustomerID(@Param("customerID") int customerID);


}