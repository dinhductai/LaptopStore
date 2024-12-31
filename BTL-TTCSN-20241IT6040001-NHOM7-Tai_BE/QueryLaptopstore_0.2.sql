
-- Xóa cơ sở dữ liệu nếu tồn tại và tạo mới
DROP DATABASE IF EXISTS LaptopStoreFinal;
CREATE DATABASE IF NOT EXISTS LaptopStoreFinal;
USE LaptopStoreFinal;
-- Tạo bảng Users trước
DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(15),
    UserType ENUM('customer', 'admin','employee') NOT NULL, -- Loại người dùng
    RegistrationDate DATE NOT NULL,
    INDEX idx_email (Email) -- Chỉ mục cho cột Email để tăng hiệu suất tìm kiếm
);

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Name VARCHAR(100) NOT NULL,
    CreatedDate DATE NOT NULL,
    Status ENUM('active', 'inactive') DEFAULT 'active',
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);


-- Tạo bảng Customers với khóa ngoại tham chiếu tới bảng Cart
DROP TABLE IF EXISTS Customers; 
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    RegistrationDate DATE NOT NULL, 
    Status ENUM('active', 'suspended', 'locked') DEFAULT 'active',
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE

);
-- Tạo bảng Admins
DROP TABLE IF EXISTS Admins;
CREATE TABLE Admins (
    AdminID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    CreatedDate DATE NOT NULL,
    Status ENUM('active', 'inactive') DEFAULT 'active',
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE -- Xóa admin khi user bị xóa
);

-- Tạo bảng Cart
DROP TABLE IF EXISTS Cart;
CREATE TABLE Cart (
    CartID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT UNIQUE, -- Mỗi khách hàng chỉ có 1 giỏ hàng (1-1)
    Status ENUM('active', 'checked_out') DEFAULT 'active',
    CreatedDate DATE NOT NULL,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE -- Khóa ngoại tham chiếu tới Users
);

-- Tạo bảng Suppliers
DROP TABLE IF EXISTS Suppliers;
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    TaxCode VARCHAR(50),
    Website VARCHAR(100),
    Representative VARCHAR(100),
    PartnershipStartDate DATE,
    Status ENUM('active', 'inactive') DEFAULT 'active'
);

-- Tạo bảng Products
DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierID INT,
    ProductName VARCHAR(250) NOT NULL,
    Brand VARCHAR(50),
    Model VARCHAR(250),
    Price FLOAT NOT NULL,
    StockQuantity INT NOT NULL,
    ReleaseDate DATE,
    WarrantyPeriod INT, -- Warranty period in months
    ImageURL VARCHAR(255),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

DROP TABLE IF EXISTS ProductDescription;
CREATE TABLE ProductDescription (
	ProductDescriptionID INT PRIMARY KEY AUTO_INCREMENT,
	ProductID INT,
	CPUcompany VARCHAR(255),  -- Tên công ty sản xuất CPU
	CPUtechnology VARCHAR(255),  -- Công nghệ của CPU (ví dụ: Intel Core i7, AMD Ryzen 5)
	CPUtype VARCHAR(255),  -- Loại CPU (ví dụ: Intel Core i7-12700K)
	MinimumCPUspeed DECIMAL(4,2),  -- Tốc độ tối thiểu của CPU (ví dụ: 2.5 GHz)
	MaximunSpeed DECIMAL(4,2),  -- Tốc độ tối đa của CPU (ví dụ: 5.0 GHz)
	Multiplier INT,  -- Hệ số nhân của CPU
	ProcessorCache VARCHAR(255),  -- Dung lượng bộ nhớ cache của CPU (ví dụ: 16 MB)
	BrandCardOboard VARCHAR(255),  -- Thương hiệu bo mạch chủ
	ModelCardOboard VARCHAR(255),  -- Model bo mạch chủ
	FullNameCardOboard VARCHAR(255),  -- Tên đầy đủ bo mạch chủ
	VGABrand VARCHAR(255),  -- Thương hiệu card đồ họa
	VGAFullName VARCHAR(255),  -- Tên đầy đủ card đồ họa
    RAMcapacity INT,  -- Dung lượng RAM (GB)
	RAMType VARCHAR(255),  -- Loại RAM (ví dụ: DDR4, DDR5)
	RAMspeed VARCHAR(255),  -- Tốc độ RAM (ví dụ: 3200 MHz)
	NumberOfRemovableSlots INT,  -- Số lượng khe RAM có thể tháo rời
	NumberOfOnboardRAM INT,  -- Số lượng khe RAM tích hợp
	MaximumRAMSupport INT,  -- Dung lượng RAM tối đa hỗ trợ
	HardDriveType VARCHAR(255),  -- Loại ổ cứng (ví dụ: HDD, SSD)
	TotalSSDHDDSlots INT,  -- Tổng số khe ổ cứng
	NumberOfSSDHDDSlotsRemaining INT,  -- Số lượng khe ổ cứng còn trống
	MaximumHardDriveUpgradeCapacity INT,  -- Dung lượng ổ cứng nâng cấp tối đa (TB)
	SSDType VARCHAR(255),  -- Loại SSD (ví dụ: NVMe, SATA)
	Capacity INT,  -- Dung lượng ổ cứng (GB)
	ScreenSize VARCHAR(250),  -- Kích thước màn hình (inch)
	DisplayTechnology VARCHAR(255),  -- Công nghệ màn hình (ví dụ: IPS, TN, VA)
	Resolution VARCHAR(800),  -- Độ phân giải màn hình (ví dụ: 1920x1080)
	ScreenType VARCHAR(255),  -- Loại màn hình (ví dụ: Màn hình LCD, Màn hình cảm ứng)
	ScanningFrequency VARCHAR(255),  -- Tần số quét (Hz)
	BasePlate VARCHAR(255),  -- Loại mặt đế (ví dụ: Kim loại, Nhựa)
	Brightness INT,  -- Độ sáng (cd/m2)
	ColorCoverage VARCHAR(255),  -- Độ bao phủ màu sắc (ví dụ: 99% sRGB)
	ScreenRatio DECIMAL(4,2),  -- Tỷ lệ màn hình (ví dụ: 16:9)
	CommunicationPort VARCHAR(800),  -- Cổng kết nối (ví dụ: USB, HDMI, LAN)
	Wifi VARCHAR(255),  -- Chuẩn Wifi (ví dụ: Wi-Fi 6)
	Bluetooth VARCHAR(255),  -- Phiên bản Bluetooth (ví dụ: Bluetooth 5.0)
	Webcam VARCHAR(255),  -- Độ phân giải webcam (ví dụ: 720p)
	OS VARCHAR(255),  -- Hệ điều hành (ví dụ: Windows 10)
	Version VARCHAR(255),  -- Phiên bản hệ điều hành
	Security VARCHAR(255),  -- Các tính năng bảo mật (ví dụ: Windows Hello)
	KeyboardType VARCHAR(255),  -- Loại bàn phím (ví dụ: Bàn phím cơ)
	NumericKeypad BOOLEAN,  -- Có bàn phím số hay không (true/false)
	KeyboardLight VARCHAR(255),  -- Loại đèn bàn phím (ví dụ: RGB)
	TouchPad VARCHAR(255),  -- Loại touchpad (ví dụ: Precision Touchpad)
	BatteryType VARCHAR(255),  -- Loại pin (ví dụ: Lithium-ion)
	BatteryCapacity INT,  -- Dung lượng pin (mAh)
	PowerSupply VARCHAR(255),  -- Công suất nguồn (W)
	AccessoriesInTheBox TEXT,  -- Phụ kiện đi kèm
	Size FLOAT,  -- Kích thước sản phẩm (cm)    
	ProductWeight DECIMAL(4,2),  -- Trọng lượng sản phẩm (kg)
	Material VARCHAR(255),  -- Chất liệu sản phẩm
	PN VARCHAR(255),  -- Mã sản phẩm
	Origin VARCHAR(255),  -- Xuất xứ
	ReleaseDate DATE,  -- Ngày phát hành
	WarrantyPeriodMonths INT,  -- Thời hạn bảo hành (tháng)
	StorageInstructions TEXT,  -- Hướng dẫn bảo quản
 	UserManual TEXT,  -- Hướng dẫn sử dụng
	Color VARCHAR(255) ,  -- Màu sắc sản phẩm
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
    
);

-- Bảng ProductDescription rút gọn
-- DROP TABLE IF EXISTS ProductDescription;
-- CREATE TABLE ProductDescription (
-- 	ProductDescriptionID INT PRIMARY KEY AUTO_INCREMENT,
-- 	ProductID INT,
-- 	CPUtechnology VARCHAR(255),  -- Công nghệ của CPU (ví dụ: Intel Core i7, AMD Ryzen 5)
-- 	CPUtype VARCHAR(255),  -- Loại CPU (ví dụ: Intel Core i7-12700K)
-- 	MinimumCPUspeed DECIMAL(4,2),  -- Tốc độ tối thiểu của CPU (ví dụ: 2.5 GHz)
-- 	MaximunSpeed DECIMAL(4,2),  -- Tốc độ tối đa của CPU (ví dụ: 5.0 GHz)
-- 	ProcessorCache VARCHAR(255),  -- Dung lượng bộ nhớ cache của CPU (ví dụ: 16 MB)
-- 	VGAFullName VARCHAR(255),  -- Tên đầy đủ card đồ họa
--     RAMcapacity INT,  -- Dung lượng RAM (GB)
-- 	RAMType VARCHAR(255),  -- Loại RAM (ví dụ: DDR4, DDR5)
-- 	Resolution VARCHAR(800),  -- Độ phân giải màn hình (ví dụ: 1920x1080)
-- 	ScanningFrequency VARCHAR(255),  -- Tần số quét (Hz)
-- 	Brightness INT,  -- Độ sáng (cd/m2)
-- 	CommunicationPort VARCHAR(800),  -- Cổng kết nối (ví dụ: USB, HDMI, LAN)
-- 	Bluetooth VARCHAR(255),  -- Phiên bản Bluetooth (ví dụ: Bluetooth 5.0)
-- 	Webcam VARCHAR(255),  -- Độ phân giải webcam (ví dụ: 720p)
-- 	OS VARCHAR(255),  -- Hệ điều hành (ví dụ: Windows 10)
-- 	Version VARCHAR(255),  -- Phiên bản hệ điều hành
-- 	KeyboardType VARCHAR(255),  -- Loại bàn phím (ví dụ: Bàn phím cơ)
-- 	BatteryType VARCHAR(255),  -- Loại pin (ví dụ: Lithium-ion) 
-- 	ProductWeight DECIMAL(4,2),  -- Trọng lượng sản phẩm (kg)
-- 	Material VARCHAR(255),  -- Chất liệu sản phẩm
-- 	ReleaseDate DATE,  -- Ngày phát hành
-- 	WarrantyPeriodMonths INT,  -- Thời hạn bảo hành (tháng)
-- 	Color VARCHAR(255) ,  -- Màu sắc sản phẩm
--     FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
-- );


-- Tạo bảng PaymentMethods
DROP TABLE IF EXISTS PaymentMethods;
CREATE TABLE PaymentMethods (
    PaymentMethodID INT PRIMARY KEY AUTO_INCREMENT,
    PaymentType ENUM('ONLINE', 'OFFLINE') NOT NULL,
    BankBrandName VARCHAR(100),
    Status ENUM('active', 'inactive') DEFAULT 'active'
);

DROP TABLE IF EXISTS Promotions;
CREATE TABLE Promotions (
    PromotionID INT PRIMARY KEY AUTO_INCREMENT,
    PromotionName VARCHAR(100) NOT NULL,
	ProductID int ,
    DiscountPercentage DECIMAL(5, 2) NOT NULL CHECK (DiscountPercentage BETWEEN 0 AND 100),
    PromotionDetails TEXT ,
    FOREIGN KEY (ProductID) REFERENCES Products( ProductID ) ON DELETE CASCADE
);

DROP TABLE IF EXISTS ShippingAddresses;
CREATE TABLE ShippingAddresses (
    AddressID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    Address VARCHAR(255),
    City VARCHAR(50),
    District VARCHAR(50),
    Ward VARCHAR(50),
    StreetAddress VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

-- Tạo bảng Orders
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    ShippingFee DECIMAL(10, 2),
    PaymentMethodID INT,
    OrderStatus ENUM('Pending', 'Confirmed', 'Shipped', 'Delivered', 'Canceled') NOT NULL,
    EstimatedDeliveryDate DATE,
    ActualDeliveryDate DATE,
    PromotionID INT,
    AddressID INT , 
    FOREIGN KEY (AddressID) REFERENCES ShippingAddresses(AddressID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID),
    FOREIGN KEY (PromotionID) REFERENCES Promotions(PromotionID)
);

-- Tạo bảng OrderDetails
DROP TABLE IF EXISTS OrderDetails;
CREATE TABLE OrderDetails (
    OrderDetailsID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    LineTotal DECIMAL(10, 2) GENERATED ALWAYS AS (Quantity * Price) STORED,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Tạo bảng CartDetails
DROP TABLE IF EXISTS CartDetails;
CREATE TABLE CartDetails (
    CartDetailsID INT PRIMARY KEY AUTO_INCREMENT,
    CartID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    LineTotal DECIMAL(10, 2) GENERATED ALWAYS AS (Quantity * Price) STORED,
    FOREIGN KEY (CartID) REFERENCES Cart(CartID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Tạo bảng ProductReviews
DROP TABLE IF EXISTS ProductReviews;
CREATE TABLE ProductReviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    ProductID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewContent TEXT,
    ReviewDate DATE NOT NULL,
    Status ENUM('approved', 'pending') DEFAULT 'pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

DROP TABLE IF EXISTS Warehouses;
CREATE TABLE Warehouses (
    WarehouseID INT PRIMARY KEY AUTO_INCREMENT,
    WarehouseName VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    WarehouseType VARCHAR(50),
    Status ENUM('active', 'inactive') DEFAULT 'active'
);

DROP TABLE IF EXISTS ProductsInWarehouse;
CREATE TABLE ProductsInWarehouse (
    ProductsInWarehouseID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT ,
    WarehouseID INT,
    ProductName VARCHAR(100) NOT NULL,
    ProductionBatchCode VARCHAR(50),
    Dimensions VARCHAR(50),
    Volume DECIMAL(10, 2),
    MinStockLevel INT,
    MaxStockLevel INT,
    Quantity INT,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
    
);

DROP TABLE IF EXISTS ImportReceipts;
CREATE TABLE ImportReceipts (
    ImportReceiptID INT PRIMARY KEY AUTO_INCREMENT,
    AdminID INT,
    WarehouseID INT,
    ImportDate DATE NOT NULL,
    Importer VARCHAR(255),
    FOREIGN KEY (AdminID) REFERENCES Admins(AdminID) ON DELETE SET NULL,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS ImportReceiptDetails;
CREATE TABLE ImportReceiptDetails (
    ImportReceiptDetailID INT PRIMARY KEY AUTO_INCREMENT,
    ImportReceiptID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (ImportReceiptID) REFERENCES ImportReceipts(ImportReceiptID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS ExportReceipts;
CREATE TABLE ExportReceipts (
    ExportReceiptID INT PRIMARY KEY AUTO_INCREMENT,
    AdminID INT,
    WarehouseID INT,
    ExportDate DATE NOT NULL,
    Exporter VARCHAR(255),
    FOREIGN KEY (AdminID) REFERENCES Admins(AdminID) ON DELETE SET NULL,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS ExportReceiptDetails;
CREATE TABLE ExportReceiptDetails (
    ExportReceiptDetailID INT PRIMARY KEY AUTO_INCREMENT,
    ExportReceiptID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (ExportReceiptID) REFERENCES ExportReceipts(ExportReceiptID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- DROP TABLE IF EXISTS ShippingAddresses;
-- CREATE TABLE ShippingAddresses (
--     AddressID INT PRIMARY KEY AUTO_INCREMENT,
--     CustomerID INT,
--     Address VARCHAR(255),
--     City VARCHAR(50),
--     District VARCHAR(50),
--     Ward VARCHAR(50),
--     StreetAddress VARCHAR(255),
--     FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
-- );

-- chitet khuyen mai
DROP TABLE IF EXISTS PromotionProduct;
CREATE TABLE PromotionProduct (
    PromotionProductID INT PRIMARY KEY AUTO_INCREMENT,
    PromotionID INT,
    ProductID INT ,
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
	FOREIGN KEY (PromotionID) REFERENCES Promotions(PromotionID) ON DELETE CASCADE
);

CREATE TABLE Contens (
    ContenID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT, 
    Content TEXT ,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);


INSERT INTO Users (FullName, Email, Password, PhoneNumber, UserType, RegistrationDate) VALUES
('John Doe', 'john.doe1@example.com', 'hashedpassword1', '1234567890', 'customer', '2024-10-05'),
('Jane Smith', 'jane.smith@example.com', 'hashedpassword2', '0987654321', 'customer', '2024-09-21'),
('Alice Brown', 'alice.brown@example.com', 'hashedpassword3', '1122334455', 'customer', '2024-08-14'),
('Bob Johnson', 'bob.johnson@example.com', 'hashedpassword4', '2233445566', 'customer', '2024-07-30'),
('Charlie Green', 'charlie.green@example.com', 'hashedpassword5', '3344556677', 'customer', '2024-06-18'),
('Diana White', 'diana.white@example.com', 'hashedpassword6', '4455667788', 'customer', '2024-05-02'),
('Eve Black', 'eve.black@example.com', 'hashedpassword7', '5566778899', 'customer', '2024-04-15'),
('Frank Brown', 'frank.brown@example.com', 'hashedpassword8', '6677889900', 'customer', '2024-03-10'),
('Grace Lee', 'grace.lee@example.com', 'hashedpassword9', '7788990011', 'customer', '2024-02-25'),
('Hank Hill', 'hank.hill@example.com', 'hashedpassword10', '8899001122', 'customer', '2024-01-15'),
('Isabel King', 'isabel.king@example.com', 'hashedpassword11', '9900112233', 'customer', '2023-12-30'),
('Jake Long', 'jake.long@example.com', 'hashedpassword12', '1029384756', 'customer', '2023-11-20'),
('Kara Fox', 'kara.fox@example.com', 'hashedpassword13', '2938475610', 'customer', '2023-10-15'),
('Liam Gray', 'liam.gray@example.com', 'hashedpassword14', '3847561029', 'customer', '2023-09-05'),
('Mona Blue', 'mona.blue@example.com', 'hashedpassword15', '4756102938', 'customer', '2023-08-23'),
('Nina Pink', 'nina.pink@example.com', 'hashedpassword16', '2938475610', 'customer', '2023-07-11'),
('Oscar Silver', 'oscar.silver@example.com', 'hashedpassword17', '3746592830', 'customer', '2023-06-06'),
('Paul Gold', 'paul.gold@example.com', 'hashedpassword18', '1029384756', 'customer', '2023-05-21'),
('Quinn Stone', 'quinn.stone@example.com', 'hashedpassword19', '2938475610', 'customer', '2023-04-17'),
('Rose Wood', 'rose.wood@example.com', 'hashedpassword20', '3847561029', 'customer', '2023-03-12');

INSERT INTO Admins (UserID, CreatedDate, Status) VALUES
(1, '2024-02-22', 'active'),
(2, '2024-05-07', 'active');

-- Thêm dữ liệu vào bảng Customers
INSERT INTO Customers (UserID, RegistrationDate, Status) VALUES
(3, '2024-11-01', 'active'),
(4, '2024-10-15', 'suspended'),
(5, '2024-09-22', 'active'),
(6, '2024-08-30', 'suspended'),
(7, '2024-07-19', 'active'),
(8, '2024-06-25', 'suspended'),
(9, '2024-05-14', 'active'),
(10, '2024-04-11', 'suspended'),
(11, '2024-03-20', 'active'),
(12, '2024-02-28', 'suspended');



INSERT INTO Employees (UserID, Name, CreatedDate, Status) VALUES
(13, 'Alice Brown', '2024-10-15', 'active'),
(14, 'Bob Green', '2024-10-02', 'inactive'),
(15, 'Daisy Black', '2024-09-27', 'active'),
(16, 'Ethan Grey', '2024-09-15', 'inactive'),
(17, 'Fiona Blue', '2024-08-10', 'active'),
(18, 'George Pink', '2024-08-02', 'active'),
(19, 'Hannah Red', '2024-07-21', 'inactive'),
(20, 'Ian Gold', '2024-07-05', 'active');




INSERT INTO Suppliers (SupplierName, Address, PhoneNumber, Email, TaxCode, Website, Representative, PartnershipStartDate, Status) VALUES
('Alpha Electronics', '123 Alpha Lane', '2345678901', 'info@alphaelectronics.com', 'AE123890', 'www.alphaelectronics.com', 'Alice Alpha', '2023-01-10', 'active'),
('Beta Solutions', '234 Beta Rd', '3456789012', 'contact@betasolutions.com', 'BS345678', 'www.betasolutions.com', 'Bob Beta', '2023-02-15', 'inactive'),
('Gamma Industries', '345 Gamma St', '4567890123', 'support@gammaindustries.com', 'GI456789', 'www.gammaindustries.com', 'George Gamma', '2023-03-22', 'active'),
('Delta Technologies', '456 Delta Ave', '5678901234', 'sales@deltatech.com', 'DT567890', 'www.deltatech.com', 'Diana Delta', '2023-04-12', 'active'),
('Epsilon Supplies', '567 Epsilon Dr', '6789012345', 'info@epsilonsupplies.com', 'ES678901', 'www.epsilonsupplies.com', 'Evan Epsilon', '2023-05-25', 'inactive'),
('Zeta Products', '678 Zeta Blvd', '7890123456', 'contact@zetaproducts.com', 'ZP789012', 'www.zetaproducts.com', 'Zara Zeta', '2023-06-30', 'active'),
('Eta Corporation', '789 Eta Lane', '8901234567', 'info@etacorp.com', 'EC890123', 'www.etacorp.com', 'Edward Eta', '2023-07-10', 'active'),
('Theta Innovations', '890 Theta Rd', '9012345678', 'support@thetainnovations.com', 'TI901234', 'www.thetainnovations.com', 'Tina Theta', '2023-08-19', 'inactive'),
('Iota Tech', '901 Iota Ave', '1234567899', 'sales@iotatech.com', 'IT123456', 'www.iotatech.com', 'Ivy Iota', '2023-09-05', 'active'),
('Kappa Ventures', '123 Kappa St', '2345678902', 'contact@kappaventures.com', 'KV234567', 'www.kappaventures.com', 'Ken Kappa', '2023-10-25', 'inactive'),
('Lambda Goods', '234 Lambda Blvd', '3456789013', 'info@lambdagoods.com', 'LG345678', 'www.lambdagoods.com', 'Linda Lambda', '2023-11-15', 'active'),
('Mu Resources', '345 Mu Dr', '4567890124', 'support@muresources.com', 'MR456789', 'www.muresources.com', 'Mike Mu', '2023-12-03', 'active'),
('Nu Supplies', '456 Nu Lane', '5678901235', 'contact@nusupplies.com', 'NS567890', 'www.nusupplies.com', 'Nancy Nu', '2024-01-18', 'inactive'),
('Xi Enterprises', '567 Xi Rd', '6789012346', 'sales@xienterprises.com', 'XE678901', 'www.xienterprises.com', 'Xander Xi', '2024-02-25', 'active'),
('Omicron Systems', '678 Omicron Ave', '7890123457', 'info@omicronsystems.com', 'OS789012', 'www.omicronsystems.com', 'Olivia Omicron', '2024-03-12', 'active'),
('Pi Components', '789 Pi St', '8901234568', 'support@picomponents.com', 'PC890123', 'www.picomponents.com', 'Peter Pi', '2024-04-07', 'inactive'),
('Rho Manufacturing', '890 Rho Blvd', '9012345679', 'contact@rhomfg.com', 'RM901234', 'www.rhomfg.com', 'Rachel Rho', '2024-05-19', 'active'),
('Sigma Warehouses', '901 Sigma Dr', '1234567890', 'info@sigmawarehouses.com', 'SW123456', 'www.sigmawarehouses.com', 'Sam Sigma', '2024-06-28', 'active'),
('Tau Equipment', '123 Tau Lane', '2345678901', 'sales@tauequipment.com', 'TE234567', 'www.tauequipment.com', 'Tara Tau', '2024-07-25', 'inactive'),
('Upsilon Trade', '234 Upsilon Rd', '3456789012', 'contact@upsilontrade.com', 'UT345678', 'www.upsilontrade.com', 'Umar Upsilon', '2024-08-30', 'active');


INSERT INTO Products (SupplierID, ProductName, Brand, Model, Price, StockQuantity, ReleaseDate, WarrantyPeriod, ImageURL) VALUES
(1, 'Laptop F', 'BrandF', 'ModelF1', 1500.00, 12, '2024-01-05', 24, 'url_to_image6.jpg'),
(2, 'Laptop G', 'BrandG', 'ModelG1', 1300.00, 25, '2023-12-20', 18, 'url_to_image7.jpg'),
(3, 'Laptop H', 'BrandH', 'ModelH1', 1600.00, 10, '2023-11-25', 24, 'url_to_image8.jpg'),
(4, 'Laptop I', 'BrandI', 'ModelI1', 1450.00, 30, '2023-10-30', 12, 'url_to_image9.jpg'),
(5, 'Laptop J', 'BrandJ', 'ModelJ1', 1700.00, 8, '2023-11-01', 36, 'url_to_image10.jpg'),
(6, 'Laptop K', 'BrandK', 'ModelK1', 1800.00, 15, '2023-09-18', 24, 'url_to_image11.jpg'),
(7, 'Laptop L', 'BrandL', 'ModelL1', 1900.00, 5, '2023-08-25', 12, 'url_to_image12.jpg'),
(8, 'Laptop M', 'BrandM', 'ModelM1', 2200.00, 18, '2023-07-15', 24, 'url_to_image13.jpg'),
(9, 'Laptop N', 'BrandN', 'ModelN1', 1350.00, 22, '2023-06-10', 36, 'url_to_image14.jpg'),
(10, 'Laptop O', 'BrandO', 'ModelO1', 1600.00, 10, '2023-05-05', 24, 'url_to_image15.jpg'),
(11, 'Laptop P', 'BrandP', 'ModelP1', 2000.00, 7, '2023-04-12', 12, 'url_to_image16.jpg'),
(12, 'Laptop Q', 'BrandQ', 'ModelQ1', 1750.00, 14, '2023-03-22', 36, 'url_to_image17.jpg'),
(13, 'Laptop R', 'BrandR', 'ModelR1', 1500.00, 25, '2023-02-28', 24, 'url_to_image18.jpg'),
(14, 'Laptop S', 'BrandS', 'ModelS1', 1300.00, 30, '2023-01-10', 18, 'url_to_image19.jpg'),
(15, 'Laptop T', 'BrandT', 'ModelT1', 1600.00, 10, '2022-12-15', 24, 'url_to_image20.jpg'),
(16, 'Laptop U', 'BrandU', 'ModelU1', 1550.00, 16, '2022-11-10', 12, 'url_to_image21.jpg'),
(17, 'Laptop V', 'BrandV', 'ModelV1', 1700.00, 12, '2022-10-01', 36, 'url_to_image22.jpg'),
(18, 'Laptop W', 'BrandW', 'ModelW1', 1850.00, 10, '2022-09-12', 24, 'url_to_image23.jpg'),
(19, 'Laptop X', 'BrandX', 'ModelX1', 1450.00, 5, '2022-08-05', 12, 'url_to_image24.jpg'),
(20, 'Laptop Y', 'BrandY', 'ModelY1', 1500.00, 8, '2022-07-15', 24, 'url_to_image25.jpg');



INSERT INTO Cart (CustomerID, Status, CreatedDate, TotalPrice) VALUES
(1, 'active', '2024-01-15', 1500.00),
(2, 'checked_out', '2023-12-20', 1300.00),
(3, 'active', '2023-11-25', 1450.00),
(4, 'checked_out', '2023-10-30', 1700.00),
(5, 'active', '2023-10-15', 1600.00),
(6, 'checked_out', '2023-09-10', 1800.00),
(7, 'active', '2023-08-05', 1550.00),
(8, 'checked_out', '2023-07-18', 1400.00),
(9, 'active', '2023-06-25', 1450.00),
(10, 'checked_out', '2023-05-30', 1650.00);


INSERT INTO PaymentMethods (PaymentType, BankBrandName, Status) VALUES
('ONLINE', 'Mb bank', 'active'), 
('OFFLINE', 'Vietcombank', 'active'), 
('OFFLINE', NULL, 'active'),
('ONLINE', 'BIDV', 'inactive'), 
('OFFLINE', NULL, 'active'),
('ONLINE', 'Techcombank', 'active'),
('OFFLINE', 'VPBank', 'inactive'),
('ONLINE', 'ACB', 'active'),
('OFFLINE', NULL, 'inactive'),
('ONLINE', 'Sacombank', 'active'),
('OFFLINE', 'Eximbank', 'active'),
('ONLINE', 'TPBank', 'inactive'),
('OFFLINE', 'SHB', 'active'),
('ONLINE', 'MB', 'inactive'),
('OFFLINE', NULL, 'inactive'),
('ONLINE', 'OBC', 'active'),
('OFFLINE', 'LienVietPostBank', 'active'),
('ONLINE', 'VietinBank', 'inactive'),
('OFFLINE', NULL, 'inactive'),
('ONLINE', 'PVcomBank', 'active');

INSERT INTO ShippingAddresses ( CustomerID, Address, City, District, Ward, StreetAddress) VALUES
( 1, 'Vietnam', 'Hanoi', 'Bac Tu Liem', 'Cau Dien', '132'),
( 2, 'Vietnam', 'Hanoi', 'Dong Da', 'Khuong Thuong', '256'),
( 3, 'Vietnam', 'Hanoi', 'Thanh Xuan', 'Phuong Liet', '78'),
( 4, 'Vietnam', 'Hanoi', 'Cau Giay', 'Dich Vong', '104'),
( 5, 'Vietnam', 'Hanoi', 'Hoan Kiem', 'Hang Bong', '12A'),
( 6, 'Vietnam', 'Ho Chi Minh City', 'District 1', 'Ben Nghe', '150'),
( 7, 'Vietnam', 'Ho Chi Minh City', 'District 3', 'Vo Thi Sau', '89'),
( 8, 'Vietnam', 'Ho Chi Minh City', 'District 5', 'Ward 7', '342'),
( 9, 'Vietnam', 'Da Nang', 'Hai Chau', 'Thanh Binh', '77'),
( 10, 'Vietnam', 'Da Nang', 'Son Tra', 'Man Thai', '43'),
( 8, 'Vietnam', 'Ninh Binh', 'Hoa Lu', 'Trung Son', '16'),
( 1, 'Vietnam', 'Thai Binh', 'Nam Cuong', 'Thanh Binh', '19'),
( 10, 'Vietnam', 'Gia Lai', 'Dong Huong', 'Tuan Thao', '145');

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, ShippingFee, PaymentMethodID, OrderStatus, EstimatedDeliveryDate, ActualDeliveryDate , AddressID ) VALUES
(1, '2024-11-20', 1550.00, 50.00, 1, 'Confirmed', '2024-11-25', '2024-01-24' , 1),
(3, '2024-11-13', 1220.00, 20.00, 2, 'Shipped', '2024-11-20', '2024-03-18' , 2),
(4, '2024-02-10', 1800.00, 30.00, 3, 'Pending', '2024-02-15', '2024-02-14' , 3),
(5, '2024-11-08', 2100.00, 40.00, 4, 'Confirmed', '2024-11-15', '2024-04-14' , 4),
(6, '2024-11-20', 950.00, 25.00, 2, 'Shipped', '2024-11-22', '2024-03-24' , 5),
(7, '2024-05-15', 1250.00, 35.00, 3, 'Pending', '2024-05-22', '2024-05-20' , 5),
(8, '2024-01-27', 1600.00, 15.00, 1, 'Confirmed', '2024-02-02', '2024-02-01' , 6),
(9, '2024-02-18', 990.00, 10.00, 4, 'Shipped', '2024-02-24', '2024-02-23' , 5),
(10, '2024-03-05', 1450.00, 20.00, 2, 'Pending', '2024-03-12', '2024-03-11' , 7);

-- INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, ShippingFee, PaymentMethodID, OrderStatus, EstimatedDeliveryDate, ActualDeliveryDate , AddressID ) VALUES
-- (1, '2024-11-20', 1550.00, 50.00, 1, 'Confirmed', '2024-11-25', '2024-01-24'),
-- (3, '2024-11-13', 1220.00, 20.00, 2, 'Shipped', '2024-11-20', '2024-03-18'),
-- (4, '2024-02-10', 1800.00, 30.00, 3, 'Pending', '2024-02-15', '2024-02-14'),
-- (5, '2024-11-08', 2100.00, 40.00, 4, 'Confirmed', '2024-11-15', '2024-04-14'),
-- (6, '2024-11-20', 950.00, 25.00, 2, 'Shipped', '2024-11-22', '2024-03-24'),
-- (7, '2024-05-15', 1250.00, 35.00, 3, 'Pending', '2024-05-22', '2024-05-20'),
-- (8, '2024-01-27', 1600.00, 15.00, 1, 'Confirmed', '2024-02-02', '2024-02-01'),
-- (9, '2024-02-18', 990.00, 10.00, 4, 'Shipped', '2024-02-24', '2024-02-23'),
-- (10, '2024-03-05', 1450.00, 20.00, 2, 'Pending', '2024-03-12', '2024-03-11');


INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1500.00),
(2, 2, 1, 1200.00),
(3, 3, 2, 850.00),
(4, 1, 3, 450.00),
(5, 5, 1, 1100.00),
(6, 4, 2, 780.00),
(7, 3, 4, 600.00),
(8, 6, 1, 1500.00),
(9, 7, 2, 950.00);
-- (10, 8, 1, 1250.00);

-- Thêm dữ liệu vào bảng CartDetails
INSERT INTO CartDetails (CartID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1500.00),
(2, 2, 1, 1200.00),
(3, 3, 2, 850.00),
(4, 1, 3, 450.00),
(5, 5, 1, 1100.00),
(6, 4, 2, 780.00),
(7, 3, 4, 600.00),
(8, 6, 1, 1500.00),
(9, 7, 2, 950.00),
(10, 8, 1, 1250.00);

INSERT INTO ProductReviews (CustomerID, ProductID, Rating, ReviewContent, ReviewDate, Status) VALUES
(1, 1, 5, 'Great laptop!', '2024-01-21', 'approved'),
(2, 2, 4, 'Good performance', '2024-03-14', 'approved'),
(3, 3, 3, 'Average experience', '2024-04-29', 'pending'),
(4, 4, 5, 'Excellent quality', '2024-09-15', 'approved'),
(5, 5, 2, 'Not as expected', '2024-07-20', 'pending'),
(6, 6, 4, 'Very useful', '2024-06-10', 'approved'),
(7, 7, 1, 'Poor battery life', '2024-05-18', 'pending'),
(8, 8, 5, 'Amazing product!', '2024-02-11', 'approved'),
(9, 9, 3, 'It\'s okay', '2024-03-05', 'pending'),
(10, 10, 4, 'Satisfactory', '2024-08-01', 'approved');
-- (11, 11, 5, 'Highly recommend', '2024-04-22', 'approved'),
-- (12, 12, 2, 'Disappointed with this', '2024-01-30', 'rejected'),
-- (13, 13, 4, 'Pretty good', '2024-09-29', 'approved'),
-- (14, 14, 5, 'Worth the money', '2024-10-03', 'approved'),
-- (15, 15, 1, 'Terrible experience', '2024-02-19', 'rejected'),
-- (16, 16, 5, 'Top-notch quality', '2024-03-28', 'approved'),
-- (17, 17, 3, 'Could be better', '2024-07-15', 'pending'),
-- (18, 18, 4, 'Good value for the price', '2024-04-10', 'approved'),
-- (19, 19, 2, 'Underwhelming', '2024-06-25', 'rejected'),
-- (20, 20, 5, 'Love it!', '2024-05-07', 'approved');



INSERT INTO Warehouses (WarehouseName, Address, WarehouseType, Status) VALUES
('Main Warehouse', '123 Warehouse St', 'Central', 'active'),
('Secondary Warehouse', '456 Backup Ave', 'Backup', 'active'),
('Temporary Warehouse', '789 Temporary Rd', 'Temporary', 'inactive'),
('Regional Warehouse 1', '101 North St', 'Regional', 'active'),
('Regional Warehouse 2', '202 South St', 'Regional', 'inactive'),
('City Warehouse', '303 Central Ave', 'City', 'active'),
('Overflow Warehouse', '404 Extra Space Ln', 'Overflow', 'inactive'),
('Express Warehouse', '505 Quick Delivery Rd', 'Express', 'active'),
('Seasonal Warehouse', '606 Seasonal Dr', 'Seasonal', 'inactive'),
('Distribution Center 1', '707 Distribution Blvd', 'Distribution', 'active'),
('Distribution Center 2', '808 Supply Rd', 'Distribution', 'inactive'),
('Remote Warehouse', '909 Remote St', 'Remote', 'active'),
('Cold Storage 1', '111 Cold Ave', 'Cold Storage', 'active'),
('Cold Storage 2', '222 Ice St', 'Cold Storage', 'inactive'),
('Transit Warehouse', '333 Transit Way', 'Transit', 'active'),
('Central Hub', '444 Hub Ave', 'Hub', 'active'),
('Quarantine Warehouse', '555 Quarantine Blvd', 'Quarantine', 'inactive'),
('Large Storage', '666 Storage Rd', 'Storage', 'active'),
('Warehouse Facility A', '777 Facility Ln', 'Facility', 'inactive'),
('Warehouse Facility B', '888 Facility Ln', 'Facility', 'active');



INSERT INTO ProductsInWarehouse (ProductID, WarehouseID, ProductName, ProductionBatchCode, Dimensions, Volume, MinStockLevel, MaxStockLevel, Quantity) VALUES
(1, 1, 'Laptop A', 'Batch001', '15x10x1', 1.5, 5, 200, 100),
(2, 2, 'Laptop B', 'Batch002', '14x9x1', 1.3, 3, 150, 170),
(3, 1, 'Laptop C', 'Batch003', '16x11x1', 1.7, 4, 100, 1),
(4, 3, 'Laptop D', 'Batch004', '15x10x1', 1.4, 2, 120, 1),
(5, 2, 'Laptop E', 'Batch005', '17x12x1', 1.9, 6, 205, 50),
(6, 4, 'Monitor A', 'Batch006', '24x18x2', 3.5, 10, 300, 150),
(7, 5, 'Monitor B', 'Batch007', '27x20x2', 4.0, 8, 250, 90),
(8, 1, 'Keyboard A', 'Batch008', '18x6x1', 0.8, 5, 200, 60),
(9, 3, 'Keyboard B', 'Batch009', '20x7x1', 0.9, 6, 220, 50),
(10, 2, 'Mouse A', 'Batch010', '4x3x2', 0.2, 10, 500, 300),
(11, 4, 'Mouse B', 'Batch011', '5x4x2', 0.25, 15, 450, 270),
(12, 5, 'Printer A', 'Batch012', '15x10x10', 7.5, 2, 50, 25),
(13, 2, 'Printer B', 'Batch013', '16x11x10', 8.0, 1, 45, 30),
(14, 1, 'Scanner A', 'Batch014', '20x15x10', 6.5, 3, 80, 70),
(15, 3, 'Scanner B', 'Batch015', '18x12x9', 5.9, 4, 85, 60),
(16, 4, 'Tablet A', 'Batch016', '10x7x1', 1.1, 5, 150, 130),
(17, 5, 'Tablet B', 'Batch017', '11x8x1', 1.2, 6, 140, 120),
(18, 1, 'Camera A', 'Batch018', '6x4x3', 0.9, 3, 100, 80),
(19, 2, 'Camera B', 'Batch019', '7x5x4', 1.0, 4, 90, 75),
(20, 3, 'Projector A', 'Batch020', '12x8x6', 5.0, 2, 60, 55);


INSERT INTO ImportReceipts (AdminID, WarehouseID, ImportDate, Importer) VALUES
(1, 1, '2024-01-15', 'Admin John'),
(2, 2, '2024-02-10', 'Admin Jane');
-- (3, 3, '2024-10-01', 'Admin Alice'),
-- (4, 4, '2024-09-18', 'Admin Bob'),
-- (5, 5, '2024-08-22', 'Admin Chris'),
-- (6, 1, '2024-07-15', 'Admin Dana'),
-- (7, 2, '2024-06-05', 'Admin Eve'),
-- (8, 3, '2024-05-29', 'Admin Frank'),
-- (9, 4, '2024-04-20', 'Admin Grace'),
-- (10, 5, '2024-03-15', 'Admin Henry'),
-- (11, 1, '2024-02-17', 'Admin Irene'),
-- (12, 2, '2024-01-25', 'Admin Jack'),
-- (13, 3, '2024-09-02', 'Admin Karen'),
-- (14, 4, '2024-07-08', 'Admin Leo'),
-- (15, 5, '2024-06-12', 'Admin Mike'),
-- (16, 1, '2024-05-03', 'Admin Nina'),
-- (17, 2, '2024-03-09', 'Admin Oscar'),
-- (18, 3, '2024-02-28', 'Admin Paul'),
-- (19, 4, '2024-10-05', 'Admin Quinn'),
-- (20, 5, '2024-08-19', 'Admin Ruth');

-- Them du lieu vao bang ImportReceiptsDetails
INSERT INTO ImportReceiptDetails (ImportReceiptID, ProductID, Quantity) VALUES
(1, 1, 10),
(1, 2, 20),
(2, 3, 15);
-- (3, 4, 25),
-- (3, 5, 30),
-- (4, 1, 12),
-- (4, 2, 18),
-- (5, 3, 20),
-- (5, 4, 22),
-- (6, 5, 16),
-- (6, 6, 28),
-- (7, 7, 35),
-- (7, 8, 14),
-- (8, 9, 20),
-- (8, 10, 18),
-- (9, 1, 30),
-- (9, 2, 25),
-- (10, 3, 19),
-- (10, 4, 22),
-- (10, 5, 15);



INSERT INTO ExportReceipts (AdminID, WarehouseID, ExportDate, Exporter) VALUES
(1, 1, '2024-01-25', 'Admin John'),
(2, 2, '2024-03-01', 'Admin Jane'),
-- (3, 3, '2024-10-02', 'Admin Alice'),
-- (4, 4, '2024-09-10', 'Admin Bob'),
-- (5, 5, '2024-08-15', 'Admin Chris'),
(1, 1, '2024-07-20', 'Admin Dana'),
(2, 2, '2024-06-18', 'Admin Eve'),
-- (3, 3, '2024-05-30', 'Admin Frank'),
-- (4, 4, '2024-04-25', 'Admin Grace'),
-- (5, 5, '2024-03-28', 'Admin Henry'),
(1, 1, '2024-02-10', 'Admin Irene'),
(2, 2, '2024-01-15', 'Admin Jack'),
-- (3, 3, '2024-09-05', 'Admin Karen'),
-- (4, 4, '2024-08-07', 'Admin Leo'),
-- (5, 5, '2024-07-12', 'Admin Mike'),
(1, 1, '2024-06-22', 'Admin Nina'),
(2, 2, '2024-05-11', 'Admin Oscar');
-- (3, 3, '2024-04-19', 'Admin Paul'),
-- (4, 4, '2024-03-14', 'Admin Quinn'),
-- (5, 5, '2024-02-18', 'Admin Ruth');


INSERT INTO ExportReceiptDetails (ExportReceiptID, ProductID, Quantity) VALUES
(1, 1, 10),
(1, 2, 20),
(2, 3, 15);
-- (3, 4, 25),
-- (3, 5, 30),
-- (4, 1, 12),
-- (4, 2, 18),
-- (5, 3, 20),
-- (5, 4, 22),
-- (6, 5, 16),
-- (6, 6, 28),
-- (7, 7, 35),
-- (7, 8, 14),
-- (8, 9, 20),
-- (8, 10, 18),
-- (9, 1, 30),
-- (9, 2, 25),
-- (10, 3, 19),
-- (10, 4, 22),
-- (10, 5, 15);



-- INSERT INTO ShippingAddresses (AddressID, CustomerID, Address, City, District, Ward, StreetAddress) VALUES
-- (1, 1, 'Vietnam', 'Hanoi', 'Bac Tu Liem', 'Cau Dien', '132'),
-- (2, 2, 'Vietnam', 'Hanoi', 'Dong Da', 'Khuong Thuong', '256'),
-- (3, 3, 'Vietnam', 'Hanoi', 'Thanh Xuan', 'Phuong Liet', '78'),
-- (4, 4, 'Vietnam', 'Hanoi', 'Cau Giay', 'Dich Vong', '104'),
-- (5, 5, 'Vietnam', 'Hanoi', 'Hoan Kiem', 'Hang Bong', '12A'),
-- (6, 6, 'Vietnam', 'Ho Chi Minh City', 'District 1', 'Ben Nghe', '150'),
-- (7, 7, 'Vietnam', 'Ho Chi Minh City', 'District 3', 'Vo Thi Sau', '89'),
-- (8, 8, 'Vietnam', 'Ho Chi Minh City', 'District 5', 'Ward 7', '342'),
-- (9, 9, 'Vietnam', 'Da Nang', 'Hai Chau', 'Thanh Binh', '77'),
-- (10, 10, 'Vietnam', 'Da Nang', 'Son Tra', 'Man Thai', '43');
-- (11, 11, 'Vietnam', 'Hai Phong', 'Ngo Quyen', 'May To', '56B'),
-- (12, 12, 'Vietnam', 'Hai Phong', 'Le Chan', 'Dinh Dong', '102'),
-- (13, 13, 'Vietnam', 'Can Tho', 'Ninh Kieu', 'Tan An', '35'),
-- (14, 14, 'Vietnam', 'Can Tho', 'Binh Thuy', 'Tra Noc', '88'),
-- (15, 15, 'Vietnam', 'Hue', 'Huong Thuy', 'Phu Bai', '47A'),
-- (16, 16, 'Vietnam', 'Hue', 'Phu Vang', 'Thuan An', '58C'),
-- (17, 17, 'Vietnam', 'Nha Trang', 'Loc Tho', 'Phuoc Tien', '24'),
-- (18, 18, 'Vietnam', 'Nha Trang', 'Van Thang', 'Vinh Nguyen', '135'),
-- (19, 19, 'Vietnam', 'Vung Tau', 'Ba Ria', 'Phuoc Hung', '92'),
-- (20, 20, 'Vietnam', 'Vung Tau', 'Xuyen Moc', 'Phuoc Buu', '73');

-- Code Insert SQL Bảng ProductDescription
-- INSERT INTO ProductDescription (ProductDescriptionID, ProductID, CPUcompany, CPUtechnology, CPUtype, MinimumCPUspeed, MaximunSpeed, Multiplier, ProcessorCache, BrandCardOboard, ModelCardOboard, FullNameCardOboard, VGABrand, VGAFullName, RAMcapacity, RAMType, RAMspeed, NumberOfRemovableSlots, NumberOfOnboardRAM, MaximumRAMSupport, HardDriveType, TotalSSDHDDSlots, NumberOfSSDHDDSlotsRemaining, MaximumHardDriveUpgradeCapacity, SSDType, Capacity, ScreenSize, DisplayTechnology, Resolution, ScreenType, ScanningFrequency, BasePlate, Brightness, ColorCoverage, ScreenRatio, CommunicationPort, Wifi, Bluetooth, Webcam, OS, Version, Security, KeyboardType, NumericKeypad, KeyboardLight, TouchPad, BatteryType, BatteryCapacity, PowerSupply, AccessoriesInTheBox, Size, ProductWeight, Material, PN, Origin, ReleaseDate, WarrantyPeriodMonths, StorageInstructions, UserManual, Color) VALUES
-- (1, 1, 'Intel', 'Core i7', 'i7-11800H', 2.30, 4.60, 8, '24 MB', 'ASUS', 'ROG Z590', 'ASUS ROG Strix Z590-E', 'NVIDIA', 'GeForce RTX 3070', 16, 'DDR4', '3200 MHz', 2, 0, 64, 'SSD', 2, 1, 2, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'Non-Touch', 144.00, 'Metal', 300, '100% sRGB', 16.00, 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.2', '720p', 'Windows 10', 'Pro', 'Windows Hello', 'Mechanical', true, 'RGB', 'Precision Touchpad', 'Lithium-ion', 5000, '150W', 'Charger, User Guide', 35.6, 2.3, 'Aluminum', 'PN12345', 'Vietnam', '2023-08-01', 24, 'Store in dry place', 'Refer to user manual', 'Black'),
-- (2, 2, 'AMD', 'Ryzen 5', 'Ryzen 5 5600H', 3.30, 4.20, 6, '19 MB', 'MSI', 'B450 Tomahawk', 'MSI B450 Tomahawk Max', 'AMD', 'Radeon RX 6600M', 16, 'DDR4', '3200 MHz', 2, 0, 32, 'SSD', 2, 1, 2, 'NVMe', 512, '14.0', 'IPS', '1920x1080', 'Non-Touch', 60.00, 'Plastic', 250, '72% NTSC', 16.00, 'USB, HDMI', 'Wi-Fi 6', 'Bluetooth 5.1', '720p', 'Windows 10', 'Home', 'TPM 2.0', 'Standard', false, 'Single Color', 'Precision Touchpad', 'Lithium-ion', 4500, '135W', 'Charger, User Guide', 32.5, 2.0, 'Plastic', 'PN67890', 'China', '2022-05-15', 12, 'Keep away from direct sunlight', 'Refer to user manual', 'Gray'),
-- (3, 3, 'Intel', 'Core i5', 'i5-11400H', 2.20, 4.50, 6, '12 MB', 'Gigabyte', 'Z590 AORUS', 'Gigabyte Z590 AORUS Ultra', 'NVIDIA', 'GeForce GTX 1660 Ti', 8, 'DDR4', '2666 MHz', 2, 0, 32, 'HDD', 1, 0, 1, 'SATA', 1024, '17.3', 'IPS', '2560x1440', 'Non-Touch', 144.00, 'Metal', 300, '100% sRGB', 16.00, 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.2', '1080p', 'Windows 11', 'Pro', 'Fingerprint', 'Standard', true, 'White Backlit', 'Standard Touchpad', 'Lithium-ion', 6000, '180W', 'Charger, Documentation', 39.5, 2.5, 'Aluminum', 'PN11111', 'Japan', '2024-01-20', 24, 'Store in cool place', 'Refer to user manual', 'Silver'),
-- (4, 4, 'Apple', 'M1', 'M1 Pro', 3.20, 3.20, 10, '12 MB', 'Apple', 'Custom Logic Board', 'Apple M1 Pro Logic Board', 'Apple', 'Integrated M1 Pro GPU', 16, 'Unified', 'Not Applicable', 0, 0, 32, 'SSD', 1, 0, 2, 'NVMe', 1024, '16.2', 'Liquid Retina', '3456x2234', 'Touch', 120.00, 'Metal', 500, '100% DCI-P3', 16.00, 'Thunderbolt, HDMI', 'Wi-Fi 6', 'Bluetooth 5.0', '1080p', 'macOS', 'Monterey', 'Face ID', 'Magic Keyboard', false, 'White Backlit', 'Force Touch', 'Lithium Polymer', 10000, '140W', 'Charger, Documentation', 35.8, 2.1, 'Aluminum', 'PN22222', 'USA', '2023-12-01', 12, 'Store in ambient temperature', 'Refer to user manual', 'Space Gray'),
-- (5, 5, 'Intel', 'Core i9', 'i9-11900K', 3.50, 5.30, 8, '20 MB', 'ASUS', 'ROG Z590', 'ASUS ROG Maximus XIII Hero', 'NVIDIA', 'GeForce RTX 3080', 32, 'DDR4', '3600 MHz', 4, 0, 128, 'SSD', 3, 2, 4, 'NVMe', 1024, '15.6', 'OLED', '3840x2160', 'Touch', 60.00, 'Metal', 400, '100% Adobe RGB', 16.00, 'USB, HDMI, LAN', 'Wi-Fi 6E', 'Bluetooth 5.3', '1080p', 'Windows 11', 'Home', 'Windows Hello', 'Mechanical', true, 'RGB', 'Precision Touchpad', 'Lithium-ion', 7000, '200W', 'Charger, User Guide', 37.1, 2.4, 'Aluminum', 'PN33333', 'Taiwan', '2024-05-10', 24, 'Store in dry environment', 'Refer to user manual', 'Black'),
-- (6, 6, 'Intel', 'Core i5', 'i5-1135G7', 2.40, 4.20, 4, '8 MB', 'Dell', 'Inspiron 5000', 'Dell Inspiron 5502', 'Intel', 'Iris Xe Graphics', 8, 'DDR4', '2666 MHz', 2, 0, 32, 'SSD', 1, 1, 2, 'NVMe', 512, '14.0', 'IPS', '1920x1080', 'Non-Touch', 60.00, 'Plastic', 250, '72% NTSC', 16.00, 'USB, HDMI', 'Wi-Fi 6', 'Bluetooth 5.1', '720p', 'Windows 10', 'Home', 'Fingerprint', 'Standard', false, 'White Backlit', 'Precision Touchpad', 'Lithium-ion', 4000, '65W', 'Charger, User Guide', 32.0, 1.7, 'Plastic', 'PN44444', 'Vietnam', '2023-09-10', 12, 'Store in cool place', 'Refer to user manual', 'Silver'),
-- (7, 7, 'AMD', 'Ryzen 7', 'Ryzen 7 5800U', 1.90, 4.40, 8, '16 MB', 'HP', 'Envy x360', 'HP Envy x360 13-ay', 'AMD', 'Radeon Graphics', 16, 'DDR4', '3200 MHz', 1, 0, 32, 'SSD', 1, 1, 1, 'NVMe', 512, '13.3', 'OLED', '1920x1080', 'Touch', 60.00, 'Metal', 400, '100% sRGB', 16.00, 'USB-C, HDMI', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 11', 'Home', 'None', 'Standard', false, 'White Backlit', 'Precision Touchpad', 'Lithium-ion', 4500, '90W', 'Charger, Documentation', 30.0, 1.3, 'Aluminum', 'PN55555', 'China', '2023-08-20', 12, 'Avoid extreme temperatures', 'Refer to user manual', 'Black'),
-- (8, 8, 'Intel', 'Core i9', 'i9-12900HK', 2.50, 5.00, 10, '24 MB', 'Alienware', 'm15 R7', 'Alienware m15 R7', 'NVIDIA', 'GeForce RTX 3070 Ti', 32, 'DDR5', '4800 MHz', 2, 0, 64, 'SSD', 2, 1, 4, 'NVMe', 1024, '15.6', 'IPS', '2560x1440', 'Non-Touch', 165.00, 'Metal', 300, '99% DCI-P3', 16.00, 'USB, HDMI, LAN', 'Wi-Fi 6E', 'Bluetooth 5.2', '1080p', 'Windows 11', 'Pro', 'Windows Hello', 'Mechanical', true, 'RGB', 'Precision Touchpad', 'Lithium-ion', 8600, '240W', 'Charger, Documentation', 39.0, 2.6, 'Aluminum', 'PN66666', 'USA', '2024-02-01', 24, 'Store in a dry place', 'Refer to user manual', 'Dark Gray'),
-- (9, 9, 'Apple', 'M2', 'M2 Max', 3.20, 3.20, 12, '16 MB', 'Apple', 'MacBook Pro Logic Board', 'Apple M2 Max Logic Board', 'Apple', 'Integrated M2 GPU', 32, 'Unified', 'Not Applicable', 0, 0, 64, 'SSD', 1, 0, 4, 'NVMe', 1024, '14.2', 'Liquid Retina', '3024x1964', 'Touch', 120.00, 'Metal', 500, '100% P3', 16.00, 'Thunderbolt', 'Wi-Fi 6E', 'Bluetooth 5.3', '1080p', 'macOS', 'Ventura', 'Face ID', 'Magic Keyboard', false, 'White Backlit', 'Force Touch', 'Lithium Polymer', 9900, '140W', 'Charger, Documentation', 31.3, 1.6, 'Aluminum', 'PN77777', 'USA', '2023-10-10', 12, 'Store in cool, dry place', 'Refer to user manual', 'Space Gray'),
-- (10, 10, 'Intel', 'Core i7', 'i7-1265U', 1.80, 4.80, 8, '12 MB', 'Lenovo', 'ThinkPad T14s', 'Lenovo ThinkPad T14s Gen 3', 'Intel', 'Iris Xe Graphics', 16, 'LPDDR4x', '4267 MHz', 0, 2, 16, 'SSD', 1, 0, 2, 'NVMe', 512, '14.0', 'IPS', '1920x1200', 'Non-Touch', 60.00, 'Plastic', 300, '100% sRGB', 16.00, 'USB-C, HDMI', 'Wi-Fi 6', 'Bluetooth 5.2', '720p', 'Windows 11', 'Pro', 'Fingerprint', 'Standard', false, 'None', 'Precision Touchpad', 'Lithium-ion', 5700, '65W', 'Charger, Guide', 32.6, 1.3, 'Plastic', 'PN88888', 'Vietnam', '2023-11-15', 36, 'Store at room temperature', 'Refer to user manual', 'Black'),
-- (11, 11, 'AMD', 'Ryzen 9', 'Ryzen 9 6900HS', 3.30, 4.90, 8, '20 MB', 'ASUS', 'ROG Zephyrus G14', 'ASUS ROG Zephyrus G14 GA402', 'AMD', 'Radeon RX 6700S', 16, 'DDR5', '4800 MHz', 2, 0, 32, 'SSD', 2, 1, 4, 'NVMe', 1024, '14.0', 'IPS', '2560x1600', 'Non-Touch', 120.00, 'Metal', 400, '100% DCI-P3', 16.00, 'USB-C, HDMI, LAN', 'Wi-Fi 6E', 'Bluetooth 5.2', '1080p', 'Windows 11', 'Home', 'TPM 2.0', 'Standard', false, 'White Backlit', 'Precision Touchpad', 'Lithium-ion', 6000, '180W', 'Charger, Guide', 31.4, 1.7, 'Aluminum', 'PN99999', 'China', '2024-04-01', 24, 'Store in dry area', 'Refer to user manual', 'Moonlight White'),
-- (16, 16, 'Intel', 'Core i5', 'i5-11300H', 3.10, 4.40, 4, '8 MB', 'Acer', 'Aspire 5', 'Acer Aspire 5 A515', 'Intel', 'Iris Xe Graphics', 8, 'DDR4', '3200 MHz', 1, 1, 32, 'SSD', 1, 1, 2, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'Non-Touch', 60.00, 'Plastic', 250, '72% NTSC', 16.00, 'USB, HDMI', 'Wi-Fi 6', 'Bluetooth 5.1', '720p', 'Windows 11', 'Home', 'Fingerprint', 'Standard', false, 'White Backlit', 'Precision Touchpad', 'Lithium-ion', 4200, '65W', 'Charger, Documentation', 32.0, 1.8, 'Plastic', 'PN101010', 'Vietnam', '2024-02-20', 12, 'Store in cool place', 'Refer to user manual', 'Silver'),
-- (17, 17, 'AMD', 'Ryzen 5', 'Ryzen 5 5500U', 2.10, 4.00, 6, '8 MB', 'Dell', 'Vostro 3405', 'Dell Vostro 3405', 'AMD', 'Radeon Vega 8', 8, 'DDR4', '2400 MHz', 1, 0, 16, 'HDD', 1, 1, 2, 'SATA', 1000, '14.0', 'TN', '1366x768', 'Non-Touch', 60.00, 'Plastic', 200, '45% NTSC', 16.00, 'USB, HDMI', 'Wi-Fi 5', 'Bluetooth 4.2', '720p', 'Windows 10', 'Pro', 'None', 'Standard', false, 'None', 'Precision Touchpad', 'Lithium-ion', 3000, '45W', 'Charger, User Guide', 30.2, 1.6, 'Plastic', 'PN202020', 'China', '2023-09-25', 24, 'Store in dry area', 'Refer to user manual', 'Black'),
-- (18, 18, 'Intel', 'Core i7', 'i7-11800H', 2.30, 4.60, 8, '24 MB', 'MSI', 'Katana GF66', 'MSI Katana GF66', 'NVIDIA', 'GeForce RTX 3060', 16, 'DDR4', '3200 MHz', 2, 0, 64, 'SSD', 2, 1, 4, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'Non-Touch', 144.00, 'Metal', 250, '100% sRGB', 16.00, 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.2', '720p', 'Windows 11', 'Home', 'Windows Hello', 'Mechanical', true, 'Red Backlit', 'Precision Touchpad', 'Lithium-ion', 5300, '150W', 'Charger, Guide', 35.0, 2.2, 'Aluminum', 'PN303030', 'Taiwan', '2023-10-01', 12, 'Store in a dry place', 'Refer to user manual', 'Black'),
-- (19, 19, 'Apple', 'M1', 'M1', 3.20, 3.20, 8, '16 MB', 'Apple', 'MacBook Air Board', 'MacBook Air M1 Board', 'Apple', 'Integrated M1 GPU', 8, 'Unified', 'Not Applicable', 0, 0, 16, 'SSD', 1, 0, 2, 'NVMe', 256, '13.3', 'Retina', '2560x1600', 'Non-Touch', 60.00, 'Metal', 400, '100% P3', 16.00, 'USB-C, Thunderbolt', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS', 'Monterey', 'Face ID', 'Magic Keyboard', false, 'White Backlit', 'Force Touch', 'Lithium Polymer', 4900, '30W', 'Charger, Documentation', 30.0, 1.3, 'Aluminum', 'PN404040', 'USA', '2023-12-12', 12, 'Avoid direct sunlight', 'Refer to user manual', 'Space Gray'),
-- (20, 20, 'Intel', 'Core i3', 'i3-10110U', 2.10, 4.10, 4, '4 MB', 'Lenovo', 'IdeaPad 3', 'Lenovo IdeaPad 3 15', 'Intel', 'UHD Graphics', 4, 'DDR4', '2666 MHz', 1, 1, 16, 'HDD', 1, 1, 1, 'SATA', 1000, '15.6', 'TN', '1366x768', 'Non-Touch', 60.00, 'Plastic', 200, '45% NTSC', 16.00, 'USB, HDMI', 'Wi-Fi 5', 'Bluetooth 4.2', '720p', 'Windows 10', 'Home', 'None', 'Standard', false, 'None', 'Standard Touchpad', 'Lithium-ion', 2200, '45W', 'Charger, Documentation', 35.5, 1.9, 'Plastic', 'PN505050', 'Vietnam', '2023-06-15', 12, 'Store at room temperature', 'Refer to user manual', 'Blue');
-- (21, 21, 'AMD', 'Ryzen 7', 'Ryzen 7 4800H', 2.90, 4.20, 8, '12 MB', 'ASUS', 'TUF Gaming A15', 'ASUS TUF Gaming A15', 'NVIDIA', 'GeForce GTX 1660 Ti', 16, 'DDR4', '3200 MHz', 2, 0, 32, 'SSD', 1, 1, 2, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'Non-Touch', 144.00, 'Plastic', 300, '72% NTSC', 16.00, 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 11', 'Home', 'Fingerprint', 'Standard', false, 'RGB', 'Precision Touchpad', 'Lithium-ion', 4800, '180W', 'Charger, Guide', 32.5, 2.3, 'Aluminum', 'PN606060', 'Vietnam', '2023-07-20', 24, 'Store in a cool place', 'Refer to user manual', 'Gray'),
-- (22, 22, 'Intel', 'Core i9', 'i9-11980HK', 2.60, 5.00, 8, '24 MB', 'Gigabyte', 'Aero 15', 'Gigabyte Aero 15 OLED', 'NVIDIA', 'GeForce RTX 3080', 32, 'DDR4', '3200 MHz', 2, 0, 64, 'SSD', 2, 1, 4, 'NVMe', 1024, '15.6', 'OLED', '3840x2160', 'Non-Touch', 60.00, 'Metal', 400, '100% AdobeRGB', 16.00, 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.2', '1080p', 'Windows 11', 'Pro', 'Windows Hello', 'Mechanical', true, 'RGB', 'Precision Touchpad', 'Lithium-ion');

INSERT INTO contens ( contens.ProductID , contens.Content ) values 
(1 , "Content1" ) ,
(2 , "Content2" ) ,
(3 , "Content3" ) ,
(4 , "Content4" ) ,
(5 , "Content5" ) ,
(6 , "Content6" ) ,
(7 , "Content7" ) ,
(8 , "Content8" ) ;

INSERT INTO promotions (PromotionName, ProductID, DiscountPercentage, PromotionDetails)
VALUES
  ("Khuyến mãi thu đông", 1, 15, "Giảm 15% cho mỗi sản phẩm"),
  ("Khuyến mãi xuân hè", 2, 25, "Giảm 25% cho mỗi sản phẩm"),
  ("Khuyến mãi thu đông", 3, 15, "Giảm 15% cho mỗi sản phẩm"),
  ("Khuyến mãi thu đông", 4, 10, "Giảm 10% cho mỗi sản phẩm"),
  ("Khuyến mãi xuân hè", 5, 20, "Giảm 20% cho mỗi sản phẩm"),
  ("Khuyến mãi Halloween", 6, 5, "Giảm 5% cho mỗi sản phẩm"),
  ("Khuyến mãi Tết", 7, 15, "Giảm 15% cho mỗi sản phẩm"),
  ("Khuyến mãi Trung Thu", 8, 10, "Giảm 10% cho mỗi sản phẩm");

INSERT INTO promotionproduct ( promotionproduct.PromotionID , promotionproduct.ProductID )
values 
	(1 , 1 ) ,
    (2 , 2 ) ,
    (3 , 3 ) ,
    (4 , 4 ) ,
    (5 , 5 ) ,
    (6 , 6 ) ,
    (7 , 7 ) ,
    (8 , 8 ) ;
