package com.example.ProjectLaptopStore.Repository.Custom.Impl;

import com.example.ProjectLaptopStore.DTO.Order_CountTotalAmountDTO;
import com.example.ProjectLaptopStore.DTO.Order_InvoiceDetailDTO;
import com.example.ProjectLaptopStore.DTO.Order_ListBillDTO;
import com.example.ProjectLaptopStore.Entity.Enum.OrderStatus_Enum;
import com.example.ProjectLaptopStore.Repository.Custom.OrderRepositoryCustom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Repository
public class OrderRepositoryCustomImpl implements OrderRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;
    @Override
    public List<Order_ListBillDTO> listBill() {
        String query = "Select o.OrderID, o.TotalAmount, p.CreatedDate "+
                "from Orders o "+
                "join PaymentMethods p on p.PaymentMethodID = o.PaymentMethodID "+
                "order by p.CreatedDate desc ";
        Query nativeQuery = entityManager.createNativeQuery(query);
        List<Object[]> result = nativeQuery.getResultList();
        //set thủ công
        List<Order_ListBillDTO> listBillDTO = new ArrayList<>();
        for (Object[] item : result) {
            Order_ListBillDTO dto = new Order_ListBillDTO(
                    (Integer) item[0],
                    (BigDecimal) item[1],
                    (Date) item[2]
            );
            listBillDTO.add(dto);
        }
        return listBillDTO;

    }

    @Override
    public List<Order_InvoiceDetailDTO> listInvoiceDetail() {
        String query = "SELECT o.OrderDate,u.FullName, u.PhoneNumber,sp.Address, sp.City, sp.District, sp.Ward, sp.StreetAddress, p.ProductName, p.Model, \n" +
                "p.Brand, od.Price, od.Quantity, od.LineTotal, o.ShippingFee, pr.PromotionName, pr.DiscountPercentage, o.TotalAmount, o.EstimatedDeliveryDate, o.OrderStatus, o.OrderID \n" +
                "FROM Orders o \n" +
                "LEFT JOIN Customers c ON o.CustomerID = c.CustomerID \n" +
                "LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID \n" +
                "LEFT JOIN Promotions pr ON o.PromotionID = pr.PromotionID \n" +
                "LEFT JOIN Products p ON od.ProductID = p.ProductID \n" +
                "LEFT JOIN Users u ON c.UserID = u.UserID \n" +
                "LEFT JOIN ShippingAddresses sp ON c.CustomerID = sp.CustomerID\n" +
                "WHERE MONTH(o.OrderDate) = MONTH(CURDATE())  AND YEAR(o.OrderDate) = YEAR(CURDATE())     and o.OrderStatus = 'Confirmed'  \n" +
                "AND o.AddressID = sp.AddressID\n" +
                "ORDER BY o.OrderDate DESC;";

        Query nativeQuery = entityManager.createNativeQuery(query);
        List<Object[]> result = nativeQuery.getResultList();

        // Chuyển đổi kết quả thành DTO
        List<Order_InvoiceDetailDTO> listInvoiceDTO = new ArrayList<>();
        for (Object[] item : result) {
            Order_InvoiceDetailDTO dto = new Order_InvoiceDetailDTO(
                    (Date) item[0],                // orderDate
                    (String) item[1],              // nameCustomer
                    (String) item[2],
                    (String) item[3],              // shippingAddress
                    (String) item[4],              // shippingCity
                    (String) item[5],              // shippingDistrict
                    (String) item[6],              // shippingWard
                    (String) item[7],              // shippingStreet
                    (String) item[8],              // productName
                    (String) item[9],              // model
                    (String) item[10],              // brand
                    (BigDecimal) item[11],         // price
                    (Integer) item[12],            // quantity
                    (BigDecimal) item[13],         // lineTotal
                    (BigDecimal) item[14],         // shippingFee
                    (String) item[15],
                    (BigDecimal) item[16],
                    (BigDecimal) item[17],         // totalAmount
                    (Date) item[18],               // estimatedDeliveryDate
                    OrderStatus_Enum.valueOf((String) item[19]) ,// orderStatus
                    (Integer) item[20]
            );
            listInvoiceDTO.add(dto);
        }
        return listInvoiceDTO;
    }

    @Override
    public List<Order_CountTotalAmountDTO> listCountTotalAmount() {
        String query ="SELECT MONTH(OrderDate) AS month, SUM(TotalAmount) AS totalRevenue " +
                "FROM Orders WHERE YEAR(OrderDate) = YEAR(CURDATE()) " +
                "GROUP BY MONTH(OrderDate) " +
                "Order By MONTH(OrderDate) ";
        Query queryNative = entityManager.createNativeQuery(query);
        List<Object[]> result = queryNative.getResultList();
        List<Order_CountTotalAmountDTO> listCountTotalAmountDTO = new ArrayList<>();
        for (Object[] rowOfResult : result) {
            Order_CountTotalAmountDTO dto = new Order_CountTotalAmountDTO(
                    (Integer) rowOfResult[0],
                    (BigDecimal) rowOfResult[1]
            );
            listCountTotalAmountDTO.add(dto);
        }
        return listCountTotalAmountDTO;
    }
}
