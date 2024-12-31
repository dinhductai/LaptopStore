package com.example.ProjectLaptopStore.DTO;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;
@Getter
@Setter
public class SupplierDTO {
    private Integer supplierId;
    private String supplierName;
    private String address;
    private String phoneNumber;
    private String email;
    private String taxcode;
    private String website;
    private String representative;
    private Date partnershipStartDate;

    public SupplierDTO(Integer supplierId, String supplierName, String address, String phoneNumber, String email, String taxcode, String website, String representative, Date partnershipStartDate) {
        this.supplierId = supplierId;
        this.supplierName = supplierName;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.taxcode = taxcode;
        this.website = website;
        this.representative = representative;
        this.partnershipStartDate = partnershipStartDate;
    }
}
