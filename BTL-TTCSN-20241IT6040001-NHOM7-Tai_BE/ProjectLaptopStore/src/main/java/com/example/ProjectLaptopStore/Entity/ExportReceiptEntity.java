package com.example.ProjectLaptopStore.Entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "ExportReceipts")
public class ExportReceiptEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer ExportReceiptID;
    @Column(name = "ExportDate",nullable = false)
    private LocalDate exportDate;
    @Column(name = "Exporter")
    private String exporter;
    @ManyToOne
    @JoinColumn(name = "AdminID")
    private AdminEntity admin;
    @ManyToOne
    @JoinColumn(name = "WarehouseID")
    private WareHouseEntity warehouse;
    @OneToMany(mappedBy = "exportReceipt",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    private List<ExportReceipDetailEntity> exportReceipDetails = new ArrayList<>();
}
