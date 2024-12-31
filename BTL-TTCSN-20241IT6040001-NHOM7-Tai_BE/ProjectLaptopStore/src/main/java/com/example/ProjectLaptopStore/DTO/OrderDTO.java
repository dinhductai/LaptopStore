package com.example.ProjectLaptopStore.DTO;

import com.example.ProjectLaptopStore.Entity.Enum.OrderStatus_Enum;
import com.example.ProjectLaptopStore.Entity.OrderDetailEntity;
import com.example.ProjectLaptopStore.Entity.PayMentMethodsEntity;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class OrderDTO {
    private int customerID;
    private Date orderDate;
    private BigDecimal totalAmount;
    private BigDecimal shippingFee;
    private OrderStatus_Enum orderStatus;
    private Date estimatedDeliveryDate;
    private Date actualDeliveryDate;
    private int paymentMethodID;
    private int addressID;
    private List<OrderDetail_createOrderDTO> orderDetails;
    public OrderDTO() {
    }
}
