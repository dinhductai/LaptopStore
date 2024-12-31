package com.example.ProjectLaptopStore.DTO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Setter
@Getter
@Builder
public class CartDetailDTO {
    private int cartDetailID;
    private int productId;
    private String productImage;
    private String productName;
    private BigDecimal price;
    private int quantity;
    private BigDecimal lineTotal;
    private List<Promotions_DisplayPromotionsDTO> promotion;
}
