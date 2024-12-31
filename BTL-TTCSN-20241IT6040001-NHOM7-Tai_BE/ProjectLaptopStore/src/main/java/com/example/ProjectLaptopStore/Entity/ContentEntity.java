package com.example.ProjectLaptopStore.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
@Getter
@Setter
@Entity
@Table(name = "Contens")
public class ContentEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer ContenID;
    @Column(name = "Content")
    private String content;
    @ManyToOne
    @JoinColumn(name = "ProductID")
    private ProductsEntity product;
}
