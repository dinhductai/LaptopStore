package com.example.ProjectLaptopStore.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
@Getter
@Setter
@Entity
@Table(name = "ImportReceiptDetails")
public class ImportReceiptDetailEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer ImportReceiptDetailID;
    @Column(name = "Quantity",nullable = false)
    private Integer quantity;
    @ManyToOne
    @JoinColumn(name = "ImportReceiptID")
    private ImportReceiptEntity importReceipt;
    @ManyToOne
    @JoinColumn(name = "ProductID")
    private ProductsEntity product;
}
