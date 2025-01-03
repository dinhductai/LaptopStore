package com.example.ProjectLaptopStore.DTO;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Pattern;
import lombok.Builder;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Builder
public class SupplierDTOtest {
    private Integer supplierId;
    @NotBlank(message = "Supplier name cant be blank")
    private String supplierName;
    @NotBlank(message = "Supplier address cant be blank")
    private String address;
//    @Pattern(regexp = "\\d{10,15}",message = "Phone number must be between 10 and 15 digits")
    @NotBlank(message = "Phone number cant be blank")
    private String phoneNumber;
    @Email(message = "Invalid email format")
    private String email;
    @NotBlank(message = "Tax code is required.")
    private String taxcode;
    private String website;
    private String representative;
    @PastOrPresent(message = "Partnership start date cannot be in the future.")
    private Date partnershipStartDate;

    public SupplierDTOtest(Integer supplierId, String supplierName, String address, String phoneNumber, String email, String taxcode, String website, String representative, Date partnershipStartDate) {
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
