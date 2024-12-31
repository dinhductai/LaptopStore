package com.example.ProjectLaptopStore.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "ProductDescription")
public class ProductDescriptionEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productDescriptionID;

    @ManyToOne
    @JoinColumn(name = "ProductID")
    private ProductsEntity product;

    @Column(name = "CPUcompany")
    private String cpuCompany;

    @Column(name = "CPUtechnology")
    private String cpuTechnology;

    @Column(name = "CPUtype")
    private String cpuType;

    @Column(name = "MinimumCPUspeed",precision = 4, scale = 2)
    private BigDecimal minimumCPUspeed;

    @Column(name = "MaximunSpeed",precision = 4, scale = 2)
    private BigDecimal maximunSpeed;

    @Column(name = "Multiplier")
    private Integer multiplier;

    @Column(name = "ProcessorCache")
    private String processorCache;

    @Column(name = "BrandCardOboard")
    private String brandCardOboard;

    @Column(name = "ModelCardOboard")
    private String modelCardOboard;

    @Column(name = "FullNameCardOboard")
    private String fullNameCardOboard;

    @Column(name = "VGABrand")
    private String vgaBrand;

    @Column(name = "VGAFullName")
    private String vgaFullName;

    @Column(name = "RAMcapacity")
    private Integer ramCapacity;

    @Column(name = "RAMType")
    private String ramType;

    @Column(name = "RAMspeed")
    private String ramSpeed;

    @Column(name = "NumberOfRemovableSlots")
    private Integer numberOfRemovableSlots;

    @Column(name = "NumberOfOnboardRAM")
    private Integer numberOfOnboardRAM;

    @Column(name = "MaximumRAMSupport")
    private Integer maximumRAMSupport;

    @Column(name = "HardDriveType")
    private String hardDriveType;

    @Column(name = "TotalSSDHDDSlots")
    private Integer totalSSDHDDSlots;

    @Column(name = "NumberOfSSDHDDSlotsRemaining")
    private Integer numberOfSSDHDDSlotsRemaining;

    @Column(name = "MaximumHardDriveUpgradeCapacity")
    private Integer maximumHardDriveUpgradeCapacity;

    @Column(name = "SSDType")
    private String ssdType;

    @Column(name = "Capacity")
    private Integer capacity;

    @Column(name = "ScreenSize")
    private String screenSize;

    @Column(name = "DisplayTechnology")
    private String displayTechnology;

    @Column(name = "Resolution")
    private String resolution;

    @Column(name = "ScreenType")
    private String screenType;

    @Column(name = "ScanningFrequency",precision =4, scale = 2)
    private String scanningFrequency;

    @Column(name = "BasePlate")
    private String basePlate;

    @Column(name = "Brightness")
    private Integer brightness;

    @Column(name = "ColorCoverage")
    private String colorCoverage;

    @Column(name = "ScreenRatio")
    private BigDecimal screenRatio;

    @Column(name = "CommunicationPort")
    private String communicationPort;

    @Column(name = "Wifi")
    private String wifi;

    @Column(name = "Bluetooth")
    private String bluetooth;

    @Column(name = "Webcam")
    private String webcam;

    @Column(name = "OS")
    private String os;

    @Column(name = "Version")
    private String version;

    @Column(name = "Security")
    private String security;

    @Column(name = "KeyboardType")
    private String keyboardType;

    @Column(name = "NumericKeypad")
    private boolean numericKeypad;

    @Column(name = "KeyboardLight")
    private String keyboardLight;

    @Column(name = "TouchPad")
    private String touchPad;

    @Column(name = "BatteryType")
    private String batteryType;

    @Column(name = "BatteryCapacity")
    private Integer batteryCapacity;

    @Column(name = "PowerSupply")
    private String powerSupply;

    @Column(name = "AccessoriesInTheBox")
    private String accessoriesInTheBox;

    @Column(name = "Size")
    private Float size;

    @Column(name = "ProductWeight", precision = 4, scale = 2)
    private BigDecimal productWeight;

    @Column(name = "Material")
    private String material;

    @Column(name = "PN")
    private String pn;

    @Column(name = "Origin")
    private String origin;

//    @Column(name = "ReleaseDate")
//    private Date releaseDate;

    @Column(name = "WarrantyPeriodMonths")
    private Integer warrantyPeriodMonths;

    @Column(name = "StorageInstructions")
    private String storageInstructions;

    @Column(name = "UserManual")
    private String userManual;

    @Column(name = "Color")
    private String color;

}
