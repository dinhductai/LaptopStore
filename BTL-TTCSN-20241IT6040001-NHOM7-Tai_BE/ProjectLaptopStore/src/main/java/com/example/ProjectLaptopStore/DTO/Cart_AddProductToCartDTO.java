package com.example.ProjectLaptopStore.DTO;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Builder
@Getter
@Setter
public class Cart_AddProductToCartDTO {
    private Integer customerID;
    private Integer productID;

}
