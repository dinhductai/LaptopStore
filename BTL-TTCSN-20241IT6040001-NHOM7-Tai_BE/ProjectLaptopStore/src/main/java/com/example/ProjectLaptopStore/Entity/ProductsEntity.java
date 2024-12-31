package com.example.ProjectLaptopStore.Entity;

import com.example.ProjectLaptopStore.DTO.Product_FindTopPurchasedProductsDTO;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

//lớp map dữ liệu với bảng Products trong db
@Entity
@Getter
@Setter
@Table(name = "products")
public class ProductsEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productID;
//    @Column(name = "SupplierID") khóa ngoài
//    private Integer suppierId;
    @Column(name = "ProductName", nullable = false)
    private String productName;
    @Column(name = "Brand")
    private String brand;
    @Column(name = "Model")
    private String model;
    @Column(name = "Price",nullable = false)
    private Float price;
    @Column(name = "StockQuantity",nullable = false)
    private Integer stockQuantity;
    @Column(name = "ReleaseDate")
    private Date releaseDate;
    @Column(name = "WarrantyPeriod")
    private Integer warrantyPeriod;
    @Column(name = "ImageURL")
    private String imageURL;

    @ManyToOne
    @JoinColumn(name = "SupplierID")
    @JsonIgnore
    private SuppliersEntity supplier;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<OrderDetailEntity> orderDetails = new ArrayList<>();

    @OneToMany(mappedBy = "product",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<CartDetailsEntity> cartDetails = new ArrayList<>();

    @OneToMany(mappedBy = "product",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<ProductReviewsEntity> productReviews = new ArrayList<>();

    @OneToMany(mappedBy = "product",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<ProductDescriptionEntity> productDescriptions = new ArrayList<>();

    @OneToMany(mappedBy = "product",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<ImportReceiptDetailEntity> importReceiptDetails = new ArrayList<>();

    @OneToMany(mappedBy = "product",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<ProductInWarehouseEntity> productInWarehouseEntities = new ArrayList<>();

    @OneToMany(mappedBy = "product",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<ExportReceipDetailEntity> exportReceipDetailEntities = new ArrayList<>();

    @OneToMany(mappedBy = "product",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<PromotionProductEntity> promotionProductEntities = new ArrayList<>();

    @OneToMany(mappedBy = "product",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<ContentEntity> contentEntities = new ArrayList<>();
}
