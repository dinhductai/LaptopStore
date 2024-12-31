package com.example.ProjectLaptopStore.DTO;

import com.example.ProjectLaptopStore.Entity.Enum.OrderStatus_Enum;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Date;

//Chi tiết hóa đơn
@Getter
@Setter
public class Order_InvoiceDetailDTO {
    private Date orderDate;
    private String fullName;
    private String phoneNumber;
    private String shippingAddress;
    private String shippingCity;
    private String shippingDistrict;
    private String shippingWard;
    private String shippingStreet;
    private String productName;
    private String model;
    private String brand;
    private BigDecimal price;
    private Integer quantity;
    private BigDecimal lineTotal;
    private BigDecimal shippingFee;
    private String promotionName;
    private BigDecimal discountPercentage;
    private BigDecimal totalAmount;
    private Date estimatedDeliveryDate;
    private OrderStatus_Enum orderStatus;
    private Integer orderId;

    public Order_InvoiceDetailDTO(Date orderDate, String fullName, String phoneNumber, String shippingAddress, String shippingCity, String shippingDistrict, String shippingWard, String shippingStreet, String productName, String model, String brand, BigDecimal price, Integer quantity, BigDecimal lineTotal, BigDecimal shippingFee, String promotionName, BigDecimal discountPercentage, BigDecimal totalAmount, Date estimatedDeliveryDate, OrderStatus_Enum orderStatus, Integer orderId) {
        this.orderDate = orderDate;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.shippingAddress = shippingAddress;
        this.shippingCity = shippingCity;
        this.shippingDistrict = shippingDistrict;
        this.shippingWard = shippingWard;
        this.shippingStreet = shippingStreet;
        this.productName = productName;
        this.model = model;
        this.brand = brand;
        this.price = price;
        this.quantity = quantity;
        this.lineTotal = lineTotal;
        this.shippingFee = shippingFee;
        this.promotionName = promotionName;
        this.discountPercentage = discountPercentage;
        this.totalAmount = totalAmount;
        this.estimatedDeliveryDate = estimatedDeliveryDate;
        this.orderStatus = orderStatus;
        this.orderId = orderId;
    }

}
