package com.example.ProjectLaptopStore.Entity;

import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.fasterxml.jackson.annotation.JsonIgnore;
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
@Table(name = "suppliers")
public class SuppliersEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int supplierID;
    @Column(name = "SupplierName",nullable = false)
    private String supplierName;
    @Column(name = "Address")
    private String address;
    @Column(name = "PhoneNumber")
    private String phoneNumber;
    @Column(name = "Email")
    private String email;
    @Column(name = "TaxCode")
    private String taxCode;
    @Column(name = "Website")
    private String website;
    @Column(name = "Representative")
    private String representative;
    @Column(name = "PartnershipStartDate")
    private Date partnershipStartDate;
    @Column(name = "Status")
    @Enumerated(EnumType.STRING)
    private Status_Enum status = Status_Enum.active;

    @OneToMany(mappedBy = "supplier",fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JsonIgnore
    private List<ProductsEntity> products = new ArrayList<>();

}
