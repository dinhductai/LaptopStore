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
    @ColumnCustom(name = "SupplierID", nullable = false)
    private Integer supplierID;
    @ColumnCustom(name = "SupplierName",nullable = false)
    private String supplierName;
    @ColumnCustom(name = "Address")
    private String address;
    @ColumnCustom(name = "PhoneNumber")
    private String phoneNumber;
    @ColumnCustom(name = "Email")
    private String email;
    @ColumnCustom(name = "Website")
    private String website;
    @ColumnCustom(name = "TaxCode")
    private String taxCode;
    @ColumnCustom(name = "Representative")
    private String representative;
    @ColumnCustom(name = "PartnershipStartDate")
    private Date partnershipStartDate;
    @EnumeratedCustom
    @ColumnCustom(name = "Status")
    private Status_Enum status = Status_Enum.active;

    @OneToManyCustom(mappedBy = "supplier",fetch = FetchType.LAZY,cascade = CascadeType.ALL,orphanRemoval = false)
    @JsonIgnoreCustom
    private List<ProductsEntity> products = new ArrayList<>();

    public Integer getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(Integer supplierID) {
        this.supplierID = supplierID;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public String getTaxCode() {
        return taxCode;
    }

    public void setTaxCode(String taxCode) {
        this.taxCode = taxCode;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getRepresentative() {
        return representative;
    }

    public void setRepresentative(String representative) {
        this.representative = representative;
    }

    public Date getPartnershipStartDate() {
        return partnershipStartDate;
    }

    public void setPartnershipStartDate(Date partnershipStartDate) {
        this.partnershipStartDate = partnershipStartDate;
    }

    public Status_Enum getStatus() {
        return status;
    }

    public void setStatus(Status_Enum status) {
        this.status = status;
    }

    public List<ProductsEntity> getProducts() {
        return products;
    }

    public void setProducts(List<ProductsEntity> products) {
        this.products = products;
    }
}
