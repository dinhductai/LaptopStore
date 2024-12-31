package com.example.ProjectLaptopStore.DTO;

import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Date;

@Getter
@Setter
public class ProductDescriptionDTO {
    private String cpuCompany;
    private String cpuTechnology;
    private String cpuType;
    private String minimumCPUspeed;
    private BigDecimal maximunSpeed;
    private long multiplier;
    private String processorCache;
    private String brandCardOboard;
    private String modelCardOboard;
    private String fullNameCardOboard;
    private String vgaBrand;
    private String vgaFullName;
    private long ramCapacity;
    private String ramType;
    private String ramSpeed;
    private long numberOfRemovableSlots;
    private long numberOfOnboardRAM;
    private long maximumRAMSupport;
    private String hardDriveType;
    private long totalSSDHDDSlots;
    private long numberOfSSDHDDSlotsRemaining;
    private long maximumHardDriveUpgradeCapacity;
    private String ssdType;
    private long capacity;
    private BigDecimal screenSize;
    private String displayTechnology;
    private String resolution;
    private String screenType;
    private BigDecimal scanningFrequency;
    private String basePlate;
    private long brightness;
    private String colorCoverage;
    private BigDecimal screenRatio;
    private String communicationPort;
    private String wifi;
    private String bluetooth;
    private String webcam;
    private String os;
    private String version;
    private String security;
    private String keyboardType;
    private boolean numericKeypad;
    private String keyboardLight;
    private String touchPad;
    private String batteryType;
    private long batteryCapacity;
    private String powerSupply;
    private String accessoriesInTheBox;
    private String size;
    private BigDecimal productWeight;
    private String material;
    private String pn;
    private String origin;
    private Date releaseDate;
    private long warrantyPeriodMonths;
    private String storageInstructions;
    private String userManual;
    private String color;

}
