package com.example.ProjectLaptopStore.DTO;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;


@Getter
@Setter
public class OrderDetail_createOrderDTO {
    private int productID;
    private int quantity;
    private BigDecimal price;

}
