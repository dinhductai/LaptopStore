package com.example.ProjectLaptopStore.DTO;

import java.util.Date;

public class Supplier_CreateSupplierDTO {
    private String supplierName;
    private String address;
    private String phoneNumber;
    private String email;
    private String taxcode;
    private String website;
    private String representative;
    private Date partnershipStartDate;

    public Supplier_CreateSupplierDTO(String supplierName, String address, String phoneNumber, String email, String taxcode, String website, String representative, Date partnershipStartDate) {
        this.supplierName = supplierName;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.taxcode = taxcode;
        this.website = website;
        this.representative = representative;
        this.partnershipStartDate = partnershipStartDate;
    }

    public String getSupplierName() {
        return supplierName;
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

    public String getTaxcode() {
        return taxcode;
    }

    public void setTaxcode(String taxcode) {
        this.taxcode = taxcode;
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
}
