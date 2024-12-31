package com.example.ProjectLaptopStore.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;

@Getter
@Setter
@Entity
@Table(name = "ProductsInWarehouse")
public class ProductInWarehouseEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productsInWarehouseID;
    @Column(name = "ProductName",nullable = false)
    private String productName;
    @Column(name = "ProductionBatchCode")
    private String productionBatchCode;
    @Column(name = "Dimensions")
    private String dimensions;
    @Column(name = "Volume")
    private BigDecimal volume;
    @Column(name = "MinStockLevel")
    private Integer minStockLevel;
    @Column(name = "MaxStockLevel")
    private Integer maxStockLevel;
    @Column(name = "Quantity")
    private Integer quantity;
    @ManyToOne
    @JoinColumn(name = "WarehouseID")
    private WareHouseEntity warehouse;
    @ManyToOne
    @JoinColumn(name = "ProductID")
    private ProductsEntity product;
}
