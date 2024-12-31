package com.example.ProjectLaptopStore.Entity;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;

@Getter
@Setter
@Entity
@Table(name = "PromotionProduct")
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PromotionProductEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer PromotionProductID;
    @ManyToOne
    @JoinColumn(name = "PromotionID")
    private PromotionEntity promotion;
    @ManyToOne
    @JoinColumn(name = "ProductID")
    private ProductsEntity product;


}
