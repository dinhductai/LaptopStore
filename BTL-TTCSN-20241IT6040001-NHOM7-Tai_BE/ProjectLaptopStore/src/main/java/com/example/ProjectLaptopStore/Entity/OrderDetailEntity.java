package com.example.ProjectLaptopStore.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;

@Entity
@Getter
@Setter
@Table(name = "orderdetails")
public class OrderDetailEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer OrderDetailsID;
    @Column(name = "Quantity")
    private int quantity;
    @Column(name = "Price", precision = 10, scale = 2,nullable = false)
    private BigDecimal price;
    @Column(name = "LineTotal", precision = 10, scale = 2, insertable = false, updatable = false)
    private BigDecimal lineTotal;
    @ManyToOne
    @JoinColumn(name = "ProductID")
    private ProductsEntity product;
    @ManyToOne
    @JoinColumn(name = "OrderID")
    private OrdersEntity order;

}
