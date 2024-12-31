package com.example.ProjectLaptopStore.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "Promotions")
public class PromotionEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer PromotionID;
    @Column(name = "PromotionName",nullable = false)
    private String promotionName;
    @Column(name = "DiscountPercentage",precision = 5,scale = 2,nullable = false)
    private BigDecimal discountPercentage;
    @Column(name = "PromotionDetails")
    private String promotionDetails;
    @OneToMany(mappedBy = "promotion",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    private List<PromotionProductEntity> promotionProducts = new ArrayList<>();
    @OneToMany(mappedBy = "promotion",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    private List<OrdersEntity> ordersEntities = new ArrayList<>();
}
