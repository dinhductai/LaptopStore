package com.example.ProjectLaptopStore.DTO;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Date;

@Getter
@Setter
public class ProductsInWarehouse_DTO {
    private Integer productId;
    private String productName;
    private String brand;
    private String model;
    private Float price;
    private Date releaseDate;
    private Integer warrantyPeriod;
    private String productImage;
    private String productBatchCode;
    private String dimension;
    private BigDecimal volume;
    private Integer minStockLevel;
    private Integer maxStockLevel;
    private Integer quantity;
    private Integer productInWareHouseId;
    private Integer wareHouseId;

    public ProductsInWarehouse_DTO() {
    }

    public ProductsInWarehouse_DTO(Integer productId, String productName, String brand, String model, Float price, Date releaseDate, Integer warrantyPeriod, String productImage, String productBatchCode, String dimension, BigDecimal volume, Integer minStockLevel, Integer maxStockLevel, Integer quantity, Integer productInWareHouseId, Integer wareHouseId) {
        this.productId = productId;
        this.productName = productName;
        this.brand = brand;
        this.model = model;
        this.price = price;
        this.releaseDate = releaseDate;
        this.warrantyPeriod = warrantyPeriod;
        this.productImage = productImage;
        this.productBatchCode = productBatchCode;
        this.dimension = dimension;
        this.volume = volume;
        this.minStockLevel = minStockLevel;
        this.maxStockLevel = maxStockLevel;
        this.quantity = quantity;
        this.productInWareHouseId = productInWareHouseId;
        this.wareHouseId = wareHouseId;
    }
}
