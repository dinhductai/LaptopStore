package com.example.ProjectLaptopStore.DTO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@Builder
public class OrderDetail_displayForStatusDTO {
    private String imageURL;
    private String productName;
    private int quantity;
    private BigDecimal lineTotal;
}
