package com.example.ProjectLaptopStore.Entity.JDBC;

import com.example.ProjectLaptopStore.AnnotationCustom.*;
import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@EntityCustom
@TableCustom(name = "suppliers")
public class SuppliersJDBCEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @IdCustom
    @GeneratedValueCustom
    private Integer supplierID;
    @ColumnCustom(name = "SupplierName",nullable = false)
    private String supplierName;
    @ColumnCustom(name = "Address")
    private String address;
    @ColumnCustom(name = "PhoneNumber")
    private String phoneNumber;
    @ColumnCustom(name = "Email")
    private String email;
    @ColumnCustom(name = "TaxCode")
    private String taxCode;
    @ColumnCustom(name = "Website")
    private String website;
    @ColumnCustom(name = "Representative")
    private String representative;
    @ColumnCustom(name = "PartnershipStartDate")
    private Date partnershipStartDate;
    @ColumnCustom(name = "Status")
    @EnumeratedCustom
    private Status_Enum status = Status_Enum.active;

    @OneToManyCustom(mappedBy = "supplier",fetch = FetchType.LAZY,cascade = CascadeType.ALL,orphanRemoval = false)
    @JsonIgnoreCustom
    private List<ProductsEntity> products = new ArrayList<>();


}
