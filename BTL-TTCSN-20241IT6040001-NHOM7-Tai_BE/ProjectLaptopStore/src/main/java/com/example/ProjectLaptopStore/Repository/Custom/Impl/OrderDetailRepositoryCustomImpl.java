package com.example.ProjectLaptopStore.Repository.Custom.Impl;

import com.example.ProjectLaptopStore.DTO.OrderDetail_CountQuantityProductPerMonthDTO;
import com.example.ProjectLaptopStore.Repository.Custom.OrderDetailRepositoryCustom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailRepositoryCustomImpl implements OrderDetailRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<OrderDetail_CountQuantityProductPerMonthDTO> listCountQuantityProductPerMonth() {
        String query = "SELECT MONTH(o.OrderDate) AS month, SUM(od.Quantity) AS totalSell " +
                "FROM OrderDetails od " +
                "JOIN Orders o ON od.OrderID = o.OrderID " +
                "JOIN Products p on p.ProductID =  od.ProductID " +
                "JOIN Suppliers s on s.SupplierID = p.SupplierID " +
                "WHERE YEAR(o.OrderDate) = YEAR(CURDATE()) " +
//                "AND s.Status ='active' " +
                "GROUP BY  MONTH(o.OrderDate) " +
                "Order By MONTH(o.OrderDate)";
        Query queryNative = entityManager.createNativeQuery(query);
        List<Object[]> resultQuery = queryNative.getResultList();
        List<OrderDetail_CountQuantityProductPerMonthDTO> listQuantityProductPerMonth = new ArrayList<>();
        for(Object[] rowOfResult : resultQuery) {
            Integer month = (Integer) rowOfResult[0];
            BigDecimal quantity = (BigDecimal) rowOfResult[1];
            OrderDetail_CountQuantityProductPerMonthDTO dto = new OrderDetail_CountQuantityProductPerMonthDTO(
                    month,
                    quantity.longValue()
            );
            listQuantityProductPerMonth.add(dto);
        }
        return listQuantityProductPerMonth;
    }
}
