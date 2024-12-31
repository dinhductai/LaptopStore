package com.example.ProjectLaptopStore.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
@Getter
@Setter
@Entity
@Table(name = "ExportReceiptDetails")
public class ExportReceipDetailEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer ExportReceiptDetailID;
    @Column(name = "Quantity",nullable = false)
    private Integer quantity;
    @ManyToOne
    @JoinColumn(name = "ExportReceiptID")
    private ExportReceiptEntity exportReceipt;
    @ManyToOne
    @JoinColumn(name = "ProductID")
    private ProductsEntity product;
}
