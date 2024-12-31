package com.example.ProjectLaptopStore.Entity;

import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "Warehouses")
public class WareHouseEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer warehouseID;
    @Column(name = "WarehouseName",nullable = false)
    private String warehouseName;
    @Column(name = "Address")
    private String address;
    @Column(name = "WarehouseType")
    private String warehouseType;
    @Column(name = "Status")
    @Enumerated(EnumType.STRING)
    private Status_Enum status;
    @OneToMany(mappedBy = "warehouse",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<ImportReceiptEntity> importReceiptEntities = new ArrayList<>();
    @OneToMany(mappedBy = "warehouse",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<ExportReceiptEntity> exportReceiptEntities = new ArrayList<>();
    @OneToMany(mappedBy = "warehouse",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<ProductInWarehouseEntity> productInWarehouseEntities = new ArrayList<>();
}
