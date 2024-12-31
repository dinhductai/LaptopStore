package com.example.ProjectLaptopStore.DTO;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;

@Setter
@Getter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Promotions_DisplayPromotionsDTO {
    int promotionID;
    String promotionName;
    BigDecimal discountPercentage;
    String promotionDetails;
}
