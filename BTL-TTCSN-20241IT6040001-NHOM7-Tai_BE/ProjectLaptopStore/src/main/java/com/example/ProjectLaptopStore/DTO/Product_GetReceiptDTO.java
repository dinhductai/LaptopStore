package com.example.ProjectLaptopStore.DTO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class Product_GetReceiptDTO {
    private Integer productId;
    private String productName;
    private String productImage;

    public Product_GetReceiptDTO() {
    }

    public Product_GetReceiptDTO(Integer productId, String productName, String productImage) {
        this.productId = productId;
        this.productName = productName;
        this.productImage = productImage;
    }
}
