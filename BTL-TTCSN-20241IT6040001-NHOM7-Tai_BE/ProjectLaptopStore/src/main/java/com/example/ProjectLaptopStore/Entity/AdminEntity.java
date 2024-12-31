package com.example.ProjectLaptopStore.Entity;

import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "admins")
public class AdminEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer AdminID;
    @Column(name = "CreatedDate",nullable = false)
    private Date createdDate;
    @Enumerated(EnumType.STRING)
    @Column(name = "Status")
    private Status_Enum status;
    @ManyToOne
    @JoinColumn(name = "UserID")
    @JsonBackReference
    private UserEntity user;
    @OneToMany(mappedBy = "admin",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    private List<ImportReceiptEntity> importReceipts = new ArrayList<>();
    @OneToMany(mappedBy = "admin",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    private List<ExportReceiptEntity> exportReceipts = new ArrayList<>();
}
