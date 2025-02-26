package com.example.ProjectLaptopStore.DTO;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
public class Promotion_getPromotionProductDTO {
    int productID;
    String productName;
    String brand;
    Long hasPromotion;
}
