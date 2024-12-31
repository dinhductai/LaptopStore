package com.example.ProjectLaptopStore.DTO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@Builder
public class ImportReceiptDTO {
    private Integer adminId;
    private Integer productId;
    private Integer warehouseId;
    private String productBatchCode;
    private String dimension;
    private BigDecimal volume;
    private Integer minStock;
    private Integer maxStock;
    private Integer quantity;

    public ImportReceiptDTO() {
    }

    public ImportReceiptDTO(Integer adminId, Integer productId, Integer warehouseId, String productBatchCode, String dimension, BigDecimal volume, Integer minStock, Integer maxStock, Integer quantity) {
        this.adminId = adminId;
        this.productId = productId;
        this.warehouseId = warehouseId;
        this.productBatchCode = productBatchCode;
        this.dimension = dimension;
        this.volume = volume;
        this.minStock = minStock;
        this.maxStock = maxStock;
        this.quantity = quantity;
    }
}
