package com.example.ProjectLaptopStore.DTO;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;
@Getter
@Setter
public class ImportExport_ReceiptDisplayDTO {
    private String productName;
    private String brand;
    private String model;
    private Float price;
    private Date date;
    private String nameIm_Export;
    private Integer quantity;

    public ImportExport_ReceiptDisplayDTO(String productName, String brand, String model, Float price, Date date, String nameIm_Export, Integer quantity) {
        this.productName = productName;
        this.brand = brand;
        this.model = model;
        this.price = price;
        this.date = date;
        this.nameIm_Export = nameIm_Export;
        this.quantity = quantity;
    }
}
