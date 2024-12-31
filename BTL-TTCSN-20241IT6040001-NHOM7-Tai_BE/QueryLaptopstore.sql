
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
('Dell Technologies', '1 Dell Way, Round Rock, TX', '1234567890', 'contact@dell.com', 'TX123456', 'http://dell.com', 'Michael Dell', '2020-01-01', 'active'),
('Samsung Electronics', '129 Samsung-ro, Yeongtong-gu, Suwon-si, Gyeonggi-do', '0987654321', 'contact@samsung.com', 'KR987654', 'http://samsung.com', 'Kim Ki-nam', '2019-05-15', 'active'),
('Apple Inc.', 'One Apple Park Way, Cupertino, CA', '1122334455', 'contact@apple.com', 'US112233', 'http://apple.com', 'Tim Cook', '2018-03-20', 'active'),
('LG Electronics', '128 Yeoui-daero, Yeongdeungpo-gu, Seoul', '2233445566', 'contact@lg.com', 'KR223344', 'http://lg.com', 'Kwon Bong-seok', '2021-07-10', 'active'),
('Sony Corporation', '1-7-1 Konan, Minato-ku, Tokyo', '3344556677', 'contact@sony.com', 'JP334455', 'http://sony.com', 'Kenichiro Yoshida', '2022-02-05', 'active'),
('Logitech International', '1500 Atwater Ave, Lausanne, Switzerland', '4455667788', 'contact@logitech.com', 'CH445566', 'http://logitech.com', 'Bracken Darrell', '2017-09-25', 'active'),
('Razer Inc.', '175 California St, San Francisco, CA', '5566778899', 'contact@razer.com', 'US556677', 'http://razer.com', 'Min-Liang Tan', '2016-11-30', 'active'),
('Bose Corporation', '100 Waters Edge, Framingham, MA', '6677889900', 'contact@bose.com', 'US667788', 'http://bose.com', 'Lorenzo Simonelli', '2015-04-18', 'active'),
('Canon Inc.', '30-2 Kamata-cho, Ota-ku, Tokyo', '7788990011', 'contact@canon.com', 'JP778899', 'http://canon.com', 'Yoshiyuki Hatta', '2014-06-22', 'active'),
('Apple Accessories', 'One Apple Park Way, Cupertino, CA', '1122334455', 'contact@apple.com', 'US112233', 'http://apple.com', 'Tim Cook', '2020-01-01', 'active');




INSERT INTO Products (SupplierID, ProductName, Brand, Model, Price, StockQuantity, ReleaseDate, WarrantyPeriod, ImageURL) VALUES
(1, 'Dell XPS 13', 'Dell', 'XPS 13', 1500.00, 50, '2024-01-15', 24, 'http://example.com/images/dell_xps13.jpg'),
(2, 'Samsung Galaxy S24', 'Samsung', 'Galaxy S24', 800.00, 100, '2024-02-20', 12, 'http://example.com/images/samsung_galaxy_s24.jpg'),
(3, 'Apple MacBook Pro 14"', 'Apple', 'MacBook Pro 14"', 2500.00, 30, '2024-03-10', 12, 'http://example.com/images/apple_macbook_pro14.jpg'),
(4, 'LG UltraWide 34"', 'LG', 'UltraWide 34"', 350.00, 20, '2024-04-05', 12, 'http://example.com/images/lg_ultrawide34.jpg'),
(5, 'Sony WH-1000XM5', 'Sony', 'WH-1000XM5', 275.00, 80, '2024-05-15', 6, 'http://example.com/images/sony_wh1000xm5.jpg'),
(6, 'Logitech MX Keys', 'Logitech', 'MX Keys', 162.50, 60, '2024-06-20', 24, 'http://example.com/images/logitech_mx_keys.jpg'),
(7, 'Razer DeathAdder V3', 'Razer', 'DeathAdder V3', 75.00, 150, '2024-07-10', 12, 'http://example.com/images/razer_deathadder_v3.jpg'),
(8, 'Apple Watch Series 8', 'Apple', 'Watch Series 8', 425.00, 40, '2024-08-05', 12, 'http://example.com/images/apple_watch_series8.jpg'),
(9, 'Bose SoundLink Revolve', 'Bose', 'SoundLink Revolve', 316.67, 70, '2024-09-15', 24, 'http://example.com/images/bose_soundlink_revolve.jpg'),
(10, 'Canon EOS R6', 'Canon', 'EOS R6', 1050.00, 25, '2024-10-20', 24, 'http://example.com/images/canon_eos_r6.jpg'),
(1, 'Dell Inspiron 15', 'Dell', 'Inspiron 15', 1200.00, 40, '2024-01-20', 24, 'http://example.com/images/dell_inspiron15.jpg'),
(2, 'Samsung Galaxy Tab S8', 'Samsung', 'Galaxy Tab S8', 700.00, 90, '2024-02-25', 12, 'http://example.com/images/samsung_galaxy_tab_s8.jpg'),
(3, 'Apple iPad Air 5', 'Apple', 'iPad Air 5', 800.00, 35, '2024-03-15', 12, 'http://example.com/images/apple_ipad_air5.jpg'),
(4, 'LG Gram 17"', 'LG', 'Gram 17"', 1400.00, 15, '2024-04-10', 12, 'http://example.com/images/lg_gram17.jpg'),
(5, 'Sony Alpha a7 IV', 'Sony', 'Alpha a7 IV', 2500.00, 10, '2024-05-20', 24, 'http://example.com/images/sony_alpha_a7iv.jpg'),
(6, 'Logitech G Pro Keyboard', 'Logitech', 'G Pro', 130.00, 55, '2024-06-25', 24, 'http://example.com/images/logitech_gpro_keyboard.jpg'),
(7, 'Razer Naga X', 'Razer', 'Naga X', 100.00, 140, '2024-07-15', 12, 'http://example.com/images/razer_nagax.jpg'),
(8, 'Apple Watch SE', 'Apple', 'Watch SE', 300.00, 45, '2024-08-10', 12, 'http://example.com/images/apple_watch_se.jpg'),
(9, 'Bose QuietComfort 45', 'Bose', 'QuietComfort 45', 330.00, 65, '2024-09-20', 24, 'http://example.com/images/bose_qc45.jpg'),
(10, 'Canon PowerShot G7 X Mark III', 'Canon', 'PowerShot G7 X Mark III', 750.00, 20, '2024-10-25', 24, 'http://example.com/images/canon_powershot_g7x_mark3.jpg'),
(1, 'Dell Latitude 7420', 'Dell', 'Latitude 7420', 1800.00, 20, '2024-01-25', 24, 'http://example.com/images/dell_latitude7420.jpg'),
(2, 'Samsung Galaxy Buds Pro', 'Samsung', 'Galaxy Buds Pro', 200.00, 120, '2024-02-28', 12, 'http://example.com/images/samsung_galaxy_buds_pro.jpg'),
(3, 'Apple MacBook Air M2', 'Apple', 'MacBook Air M2', 1300.00, 25, '2024-03-20', 12, 'http://example.com/images/apple_macbook_air_m2.jpg'),
(4, 'LG UltraFine 5K Monitor', 'LG', 'UltraFine 5K', 1200.00, 10, '2024-04-15', 12, 'http://example.com/images/lg_ultrafine5k.jpg'),
(5, 'Sony PlayStation 5', 'Sony', 'PS5', 500.00, 200, '2024-05-30', 24, 'http://example.com/images/sony_ps5.jpg'),
(6, 'Logitech C920 Webcam', 'Logitech', 'C920', 80.00, 95, '2024-06-10', 24, 'http://example.com/images/logitech_c920.jpg'),
(7, 'Razer Huntsman V2', 'Razer', 'Huntsman V2', 180.00, 110, '2024-07-25', 12, 'http://example.com/images/razer_huntsman_v2.jpg'),
(8, 'Apple AirPods Pro', 'Apple', 'AirPods Pro', 250.00, 75, '2024-08-15', 12, 'http://example.com/images/apple_airpods_pro.jpg'),
(9, 'Bose Frames Audio Sunglasses', 'Bose', 'Frames', 300.00, 60, '2024-09-18', 24, 'http://example.com/images/bose_frames.jpg'),
(10, 'Canon EOS R10', 'Canon', 'EOS R10', 850.00, 28, '2024-10-05', 24, 'http://example.com/images/canon_eos_r10.jpg'),
(1, 'Dell Latitude 5420', 'Dell', 'Latitude 5420', 1600.00, 20, '2024-01-10', 24, 'http://example.com/images/dell_latitude5420.jpg'),
(2, 'Samsung Galaxy Z Fold4', 'Samsung', 'Galaxy Z Fold4', 2000.00, 60, '2024-02-12', 12, 'http://example.com/images/samsung_zfold4.jpg'),
(3, 'Apple iMac 24"', 'Apple', 'iMac 24"', 1800.00, 15, '2024-03-22', 12, 'http://example.com/images/apple_imac24.jpg'),
(4, 'LG OLED CX Series', 'LG', 'OLED CX', 1500.00, 12, '2024-04-20', 12, 'http://example.com/images/lg_oled_cx.jpg'),
(5, 'Sony Alpha a7 III', 'Sony', 'Alpha a7 III', 2000.00, 18, '2024-05-30', 24, 'http://example.com/images/sony_alpha_a7iii.jpg'),
(6, 'Logitech G502 Mouse', 'Logitech', 'G502', 50.00, 150, '2024-06-15', 24, 'http://example.com/images/logitech_g502.jpg'),
(7, 'Razer Blade 15', 'Razer', 'Blade 15', 2200.00, 22, '2024-07-28', 12, 'http://example.com/images/razer_blade15.jpg'),
(8, 'Apple Mac Mini M2', 'Apple', 'Mac Mini M2', 700.00, 40, '2024-08-20', 12, 'http://example.com/images/apple_macmini_m2.jpg'),
(9, 'Bose SoundLink Micro', 'Bose', 'SoundLink Micro', 120.00, 90, '2024-09-30', 24, 'http://example.com/images/bose_soundlink_micro.jpg'),
(10, 'Canon PowerShot G5 X Mark II', 'Canon', 'PowerShot G5 X Mark II', 900.00, 18, '2024-10-12', 24, 'http://example.com/images/canon_powershot_g5x_mark2.jpg'),
(1, 'Dell Alienware M15', 'Dell', 'Alienware M15', 2500.00, 30, '2024-01-30', 24, 'http://example.com/images/dell_alienware_m15.jpg'),
(2, 'Samsung Galaxy Watch 5', 'Samsung', 'Galaxy Watch 5', 350.00, 85, '2024-02-05', 12, 'http://example.com/images/samsung_galaxy_watch5.jpg'),
(3, 'Apple iMac Pro', 'Apple', 'iMac Pro', 5000.00, 8, '2024-03-25', 12, 'http://example.com/images/apple_imacpro.jpg'),
(4, 'LG UltraGear 27"', 'LG', 'UltraGear 27"', 400.00, 25, '2024-04-18', 12, 'http://example.com/images/lg_ultragear27.jpg'),
(5, 'Sony PlayStation VR2', 'Sony', 'PlayStation VR2', 800.00, 50, '2024-05-10', 24, 'http://example.com/images/sony_psvr2.jpg'),
(6, 'Logitech MX Master 3', 'Logitech', 'MX Master 3', 100.00, 70, '2024-06-20', 24, 'http://example.com/images/logitech_mxmaster3.jpg'),
(7, 'Razer Kishi Controller', 'Razer', 'Kishi Controller', 100.00, 100, '2024-07-30', 12, 'http://example.com/images/razer_kishi.jpg'),
(8, 'Apple HomePod Mini', 'Apple', 'HomePod Mini', 99.00, 60, '2024-08-25', 12, 'http://example.com/images/apple_homepod_mini.jpg'),
(9, 'Bose SoundSport Wireless', 'Bose', 'SoundSport Wireless', 200.00, 80, '2024-09-22', 24, 'http://example.com/images/bose_soundsport_wireless.jpg'),
(10, 'Canon EOS R10', 'Canon', 'EOS R10', 850.00, 28, '2024-10-05', 24, 'http://example.com/images/canon_eos_r10.jpg'),
(1, 'Dell Precision 5550', 'Dell', 'Precision 5550', 2200.00, 18, '2024-01-05', 24, 'http://example.com/images/dell_precision5550.jpg'),
(2, 'Samsung Galaxy Z Flip4', 'Samsung', 'Galaxy Z Flip4', 1800.00, 55, '2024-02-18', 12, 'http://example.com/images/samsung_zflip4.jpg'),
(3, 'Apple MacBook Pro 16"', 'Apple', 'MacBook Pro 16"', 3200.00, 20, '2024-03-30', 12, 'http://example.com/images/apple_macbook_pro16.jpg'),
(4, 'LG UltraWide 49"', 'LG', 'UltraWide 49"', 600.00, 8, '2024-04-25', 12, 'http://example.com/images/lg_ultrawide49.jpg'),
(5, 'Sony A7S III', 'Sony', 'A7S III', 3500.00, 12, '2024-05-15', 24, 'http://example.com/images/sony_a7siii.jpg'),
(6, 'Logitech G915 TKL', 'Logitech', 'G915 TKL', 230.00, 65, '2024-06-25', 24, 'http://example.com/images/logitech_g915tkl.jpg'),
(7, 'Razer Viper Ultimate', 'Razer', 'Viper Ultimate', 150.00, 140, '2024-07-20', 12, 'http://example.com/images/razer_viper_ultimate.jpg'),
(8, 'Apple TV 4K', 'Apple', 'TV 4K', 179.00, 50, '2024-08-30', 12, 'http://example.com/images/apple_tv4k.jpg'),
(9, 'Bose SoundTouch 30', 'Bose', 'SoundTouch 30', 300.00, 40, '2024-09-10', 24, 'http://example.com/images/bose_soundtouch30.jpg'),
(10, 'Canon EOS R5', 'Canon', 'EOS R5', 4000.00, 15, '2024-10-15', 24, 'http://example.com/images/canon_eos_r5.jpg'),
(1, 'Dell G5 15', 'Dell', 'G5 15', 1200.00, 35, '2024-01-12', 24, 'http://example.com/images/dell_g515.jpg'),
(2, 'Samsung Galaxy Note20', 'Samsung', 'Galaxy Note20', 999.00, 75, '2024-02-22', 12, 'http://example.com/images/samsung_not20.jpg'),
(3, 'Apple iMac M1', 'Apple', 'iMac M1', 1300.00, 22, '2024-03-18', 12, 'http://example.com/images/apple_imac_m1.jpg'),
(4, 'LG 27GN950-B', 'LG', '27GN950-B', 800.00, 14, '2024-04-28', 12, 'http://example.com/images/lg_27gn950b.jpg'),
(5, 'Sony PlayStation 5 Digital Edition', 'Sony', 'PS5 Digital', 400.00, 180, '2024-05-18', 24, 'http://example.com/images/sony_ps5_digital.jpg'),
(6, 'Logitech C922 Pro Stream', 'Logitech', 'C922 Pro Stream', 100.00, 85, '2024-06-30', 24, 'http://example.com/images/logitech_c922.jpg'),
(7, 'Razer Kaira Pro', 'Razer', 'Kaira Pro', 120.00, 95, '2024-07-22', 12, 'http://example.com/images/razer_kaira_pro.jpg'),
(8, 'Apple AirTag', 'Apple', 'AirTag', 29.00, 200, '2024-08-12', 12, 'http://example.com/images/apple_airtag.jpg'),
(9, 'Bose Frames Tempo', 'Bose', 'Frames Tempo', 250.00, 55, '2024-09-05', 24, 'http://example.com/images/bose_frames_tempo.jpg'),
(10, 'Canon EOS Rebel T8i', 'Canon', 'EOS Rebel T8i', 850.00, 30, '2024-10-22', 24, 'http://example.com/images/canon_rebel_t8i.jpg'),
(1, 'Dell XPS 17', 'Dell', 'XPS 17', 2000.00, 25, '2024-01-18', 24, 'http://example.com/images/dell_xps17.jpg'),
(2, 'Samsung Galaxy Watch 5 Pro', 'Samsung', 'Galaxy Watch 5 Pro', 450.00, 65, '2024-02-28', 12, 'http://example.com/images/samsung_galaxy_watch5_pro.jpg'),
(3, 'Apple MacBook Pro 16" M1 Max', 'Apple', 'MacBook Pro 16" M1 Max', 4000.00, 10, '2024-03-28', 12, 'http://example.com/images/apple_macbook_pro16_m1max.jpg'),
(4, 'LG 32UL950-W', 'LG', '32UL950-W', 1000.00, 9, '2024-04-30', 12, 'http://example.com/images/lg_32ul950w.jpg'),
(5, 'Sony A6600', 'Sony', 'Alpha a6600', 1400.00, 20, '2024-05-22', 24, 'http://example.com/images/sony_a6600.jpg'),
(6, 'Logitech G703 Lightspeed', 'Logitech', 'G703 Lightspeed', 150.00, 80, '2024-06-05', 24, 'http://example.com/images/logitech_g703.jpg'),
(7, 'Razer Seiren X', 'Razer', 'Seiren X', 90.00, 100, '2024-07-30', 12, 'http://example.com/images/razer_seiren_x.jpg'),
(8, 'Apple HomePod', 'Apple', 'HomePod', 299.00, 40, '2024-08-25', 12, 'http://example.com/images/apple_homepod.jpg'),
(9, 'Bose Portable Smart Speaker', 'Bose', 'Portable Smart Speaker', 399.00, 35, '2024-09-12', 24, 'http://example.com/images/bose_portable_speaker.jpg'),
(10, 'Canon EOS R50', 'Canon', 'EOS R50', 950.00, 18, '2024-10-18', 24, 'http://example.com/images/canon_eos_r50.jpg'),
(1, 'Dell Vostro 14', 'Dell', 'Vostro 14', 1100.00, 45, '2024-01-08', 24, 'http://example.com/images/dell_vostro14.jpg'),
(2, 'Samsung Galaxy A54', 'Samsung', 'Galaxy A54', 500.00, 130, '2024-02-15', 12, 'http://example.com/images/samsung_galaxy_a54.jpg'),
(3, 'Apple MacBook Air M1', 'Apple', 'MacBook Air M1', 999.00, 28, '2024-03-12', 12, 'http://example.com/images/apple_macbook_air_m1.jpg'),
(4, 'LG 27GN950-B', 'LG', '27GN950-B', 800.00, 16, '2024-04-22', 12, 'http://example.com/images/lg_27gn950b.jpg'),
(5, 'Sony Xperia 1 IV', 'Sony', 'Xperia 1 IV', 1200.00, 40, '2024-05-18', 24, 'http://example.com/images/sony_xperia1iv.jpg'),
(6, 'Logitech G915 TKL', 'Logitech', 'G915 TKL', 230.00, 60, '2024-06-22', 24, 'http://example.com/images/logitech_g915tkl.jpg'),
(7, 'Razer Hammerhead True Wireless', 'Razer', 'Hammerhead True Wireless', 120.00, 85, '2024-07-18', 12, 'http://example.com/images/razer_hammerhead_tw.jpg'),
(8, 'Apple Magic Keyboard', 'Apple', 'Magic Keyboard', 99.00, 70, '2024-08-05', 12, 'http://example.com/images/apple_magic_keyboard.jpg'),
(9, 'Bose Portable Home Speaker', 'Bose', 'Portable Home Speaker', 499.00, 30, '2024-09-25', 24, 'http://example.com/images/bose_portable_home_speaker.jpg'),
(10, 'Canon EOS M6 Mark II', 'Canon', 'EOS M6 Mark II', 850.00, 22, '2024-10-08', 24, 'http://example.com/images/canon_eos_m6_mark2.jpg'),
(1, 'Dell G7 17', 'Dell', 'G7 17', 1600.00, 19, '2024-01-19', 24, 'http://example.com/images/dell_g717.jpg'),
(2, 'Samsung Galaxy Z Fold3', 'Samsung', 'Galaxy Z Fold3', 1800.00, 50, '2024-02-19', 12, 'http://example.com/images/samsung_zfold3.jpg'),
(3, 'Apple MacBook Pro 13"', 'Apple', 'MacBook Pro 13"', 1500.00, 32, '2024-03-25', 12, 'http://example.com/images/apple_macbook_pro13.jpg'),
(4, 'LG 32UN880-B', 'LG', '32UN880-B', 700.00, 14, '2024-04-28', 12, 'http://example.com/images/lg_32un880b.jpg'),
(5, 'Sony PlayStation VR', 'Sony', 'PlayStation VR', 400.00, 90, '2024-05-12', 24, 'http://example.com/images/sony_psvr.jpg'),
(6, 'Logitech G Pro Wireless', 'Logitech', 'G Pro Wireless', 150.00, 100, '2024-06-18', 24, 'http://example.com/images/logitech_gpro_wireless.jpg'),
(7, 'Razer Seiren Elite', 'Razer', 'Seiren Elite', 150.00, 95, '2024-07-25', 12, 'http://example.com/images/razer_seiren_elite.jpg'),
(8, 'Apple HomePod Mini', 'Apple', 'HomePod Mini', 99.00, 65, '2024-08-10', 12, 'http://example.com/images/apple_homepod_mini.jpg'),
(9, 'Bose SoundLink Color', 'Bose', 'SoundLink Color', 150.00, 75, '2024-09-05', 24, 'http://example.com/images/bose_soundlink_color.jpg'),
(10, 'Canon EOS R50', 'Canon', 'EOS R50', 950.00, 18, '2024-10-20', 24, 'http://example.com/images/canon_eos_r50.jpg'),
(1, 'Dell Inspiron 14', 'Dell', 'Inspiron 14', 1100.00, 38, '2024-01-14', 24, 'http://example.com/images/dell_inspiron14.jpg'),
(2, 'Samsung Galaxy A34', 'Samsung', 'Galaxy A34', 550.00, 140, '2024-02-20', 12, 'http://example.com/images/samsung_a34.jpg'),
(3, 'Apple iPad Pro 11"', 'Apple', 'iPad Pro 11"', 999.00, 27, '2024-03-19', 12, 'http://example.com/images/apple_ipad_pro11.jpg'),
(4, 'LG 27GL850-B', 'LG', '27GL850-B', 450.00, 19, '2024-04-22', 12, 'http://example.com/images/lg_27gl850b.jpg'),
(5, 'Sony WH-CH710N', 'Sony', 'WH-CH710N', 180.00, 95, '2024-05-28', 6, 'http://example.com/images/sony_whch710n.jpg'),
(6, 'Logitech K380 Multi-Device', 'Logitech', 'K380', 39.00, 120, '2024-06-12', 24, 'http://example.com/images/logitech_k380.jpg'),
(7, 'Razer BlackShark V2 Pro', 'Razer', 'BlackShark V2 Pro', 180.00, 80, '2024-07-18', 12, 'http://example.com/images/razer_blackshark_v2_pro.jpg'),
(8, 'Apple AirTag Holder', 'Apple', 'AirTag Holder', 20.00, 150, '2024-08-08', 12, 'http://example.com/images/apple_airtag_holder.jpg'),
(9, 'Bose SoundSport Free', 'Bose', 'SoundSport Free', 180.00, 65, '2024-09-10', 24, 'http://example.com/images/bose_soundsport_free.jpg'),
(10, 'Canon EOS RP', 'Canon', 'EOS RP', 1000.00, 20, '2024-10-18', 24, 'http://example.com/images/canon_eos_rp.jpg'),
(1, 'Dell G3 15', 'Dell', 'G3 15', 950.00, 42, '2024-01-22', 24, 'http://example.com/images/dell_g315.jpg'),
(2, 'Samsung Galaxy Watch Active2', 'Samsung', 'Galaxy Watch Active2', 200.00, 130, '2024-02-27', 12, 'http://example.com/images/samsung_galaxy_watch_active2.jpg'),
(3, 'Apple Mac Mini M1', 'Apple', 'Mac Mini M1', 699.00, 33, '2024-03-25', 12, 'http://example.com/images/apple_macmini_m1.jpg'),
(4, 'LG 24GN600-B', 'LG', '24GN600-B', 250.00, 21, '2024-04-27', 12, 'http://example.com/images/lg_24gn600b.jpg'),
(5, 'Sony WH-XB900N', 'Sony', 'WH-XB900N', 250.00, 85, '2024-05-22', 6, 'http://example.com/images/sony_whxb900n.jpg'),
(6, 'Logitech MX Anywhere 3', 'Logitech', 'MX Anywhere 3', 99.00, 110, '2024-06-18', 24, 'http://example.com/images/logitech_mx_anywhere3.jpg'),
(7, 'Razer Cynosa V2', 'Razer', 'Cynosa V2', 60.00, 125, '2024-07-22', 12, 'http://example.com/images/razer_cynosa_v2.jpg'),
(8, 'Apple Magic Mouse 2', 'Apple', 'Magic Mouse 2', 99.00, 55, '2024-08-18', 12, 'http://example.com/images/apple_magic_mouse2.jpg'),
(9, 'Bose SoundLink Revolve+', 'Bose', 'SoundLink Revolve+', 349.00, 50, '2024-09-15', 24, 'http://example.com/images/bose_soundlink_revolveplus.jpg'),
(10, 'Canon EOS Rebel SL3', 'Canon', 'EOS Rebel SL3', 649.00, 25, '2024-10-10', 24, 'http://example.com/images/canon_eos_rebel_sl3.jpg'),
(1, 'Dell XPS 15', 'Dell', 'XPS 15', 2000.00, 28, '2024-01-28', 24, 'http://example.com/images/dell_xps15.jpg'),
(2, 'Samsung Galaxy Z Flip3', 'Samsung', 'Galaxy Z Flip3', 1800.00, 58, '2024-02-18', 12, 'http://example.com/images/samsung_zflip3.jpg'),
(3, 'Apple MacBook Pro 14" M1 Pro', 'Apple', 'MacBook Pro 14" M1 Pro', 3000.00, 18, '2024-03-30', 12, 'http://example.com/images/apple_macbook_pro14_m1pro.jpg'),
(4, 'LG UltraFine OLED Pro', 'LG', 'UltraFine OLED Pro', 1800.00, 7, '2024-04-30', 12, 'http://example.com/images/lg_ultrafine_oledpro.jpg'),
(5, 'Sony WH-1000XM4', 'Sony', 'WH-1000XM4', 299.00, 90, '2024-05-28', 6, 'http://example.com/images/sony_wh1000xm4.jpg'),
(6, 'Logitech C930e Webcam', 'Logitech', 'C930e', 120.00, 70, '2024-06-20', 24, 'http://example.com/images/logitech_c930e.jpg'),
(7, 'Razer Seiren X', 'Razer', 'Seiren X', 90.00, 100, '2024-07-30', 12, 'http://example.com/images/razer_seiren_x.jpg'),
(8, 'Apple Magic Keyboard with Numeric Keypad', 'Apple', 'Magic Keyboard Numeric', 129.00, 60, '2024-08-25', 12, 'http://example.com/images/apple_magic_keyboard_numeric.jpg'),
(9, 'Bose SoundLink Mini II', 'Bose', 'SoundLink Mini II', 199.00, 40, '2024-09-10', 24, 'http://example.com/images/bose_soundlink_mini2.jpg'),
(10, 'Canon EOS Rebel T7i', 'Canon', 'EOS Rebel T7i', 749.00, 20, '2024-10-20', 24, 'http://example.com/images/canon_eos_rebel_t7i.jpg'),
(1, 'Dell Alienware Aurora R13', 'Dell', 'Alienware Aurora R13', 3000.00, 12, '2024-01-10', 24, 'http://example.com/images/dell_alienware_aurora_r13.jpg'),
(2, 'Samsung Galaxy S23 Ultra', 'Samsung', 'Galaxy S23 Ultra', 1200.00, 65, '2024-02-22', 12, 'http://example.com/images/samsung_galaxy_s23_ultra.jpg'),
(3, 'Apple iPad Mini 6', 'Apple', 'iPad Mini 6', 499.00, 40, '2024-03-18', 12, 'http://example.com/images/apple_ipad_mini6.jpg'),
(4, 'LG UltraGear 27GN950-B', 'LG', 'UltraGear 27GN950-B', 800.00, 17, '2024-04-28', 12, 'http://example.com/images/lg_ultragear27gn950b.jpg'),
(5, 'Sony PlayStation 5 Digital Edition', 'Sony', 'PS5 Digital', 400.00, 180, '2024-05-12', 24, 'http://example.com/images/sony_ps5_digital.jpg'),
(6, 'Logitech G213 Prodigy', 'Logitech', 'G213 Prodigy', 60.00, 115, '2024-06-25', 24, 'http://example.com/images/logitech_g213_prodigy.jpg'),
(7, 'Razer Nommo Pro', 'Razer', 'Nommo Pro', 300.00, 90, '2024-07-28', 12, 'http://example.com/images/razer_nommo_pro.jpg'),
(8, 'Apple AirPods Max', 'Apple', 'AirPods Max', 549.00, 35, '2024-08-18', 12, 'http://example.com/images/apple_airpods_max.jpg'),
(9, 'Bose Soundbar 700', 'Bose', 'Soundbar 700', 799.00, 25, '2024-09-15', 24, 'http://example.com/images/bose_soundbar700.jpg'),
(10, 'Canon EOS Rebel T7', 'Canon', 'EOS Rebel T7', 649.00, 22, '2024-10-10', 24, 'http://example.com/images/canon_eos_rebel_t7.jpg'),
(1, 'Dell XPS 13 Plus', 'Dell', 'XPS 13 Plus', 1800.00, 27, '2024-01-18', 24, 'http://example.com/images/dell_xps13plus.jpg'),
(2, 'Samsung Galaxy Note20 Ultra', 'Samsung', 'Galaxy Note20 Ultra', 1300.00, 58, '2024-02-18', 12, 'http://example.com/images/samsung_note20_ultra.jpg'),
(3, 'Apple MacBook Pro 16" M1 Pro', 'Apple', 'MacBook Pro 16" M1 Pro', 3200.00, 15, '2024-03-25', 12, 'http://example.com/images/apple_macbook_pro16_m1pro.jpg'),
(4, 'LG UltraFine OLED Pro 32"', 'LG', 'UltraFine OLED Pro 32"', 2000.00, 5, '2024-04-30', 12, 'http://example.com/images/lg_ultrafine_oledpro32.jpg'),
(5, 'Sony WH-1000XM3', 'Sony', 'WH-1000XM3', 299.00, 100, '2024-05-28', 6, 'http://example.com/images/sony_wh1000xm3.jpg'),
(6, 'Logitech G915 Lightspeed', 'Logitech', 'G915 Lightspeed', 250.00, 80, '2024-06-20', 24, 'http://example.com/images/logitech_g915_lightspeed.jpg'),
(7, 'Razer Seiren X G4', 'Razer', 'Seiren X G4', 100.00, 105, '2024-07-25', 12, 'http://example.com/images/razer_seiren_x_g4.jpg'),
(8, 'Apple Magic Trackpad 2', 'Apple', 'Magic Trackpad 2', 199.00, 50, '2024-08-22', 12, 'http://example.com/images/apple_magic_trackpad2.jpg'),
(9, 'Bose SoundLink Revolve+', 'Bose', 'SoundLink Revolve+', 349.00, 45, '2024-09-25', 24, 'http://example.com/images/bose_soundlink_revolveplus.jpg'),
(10, 'Canon EOS Rebel SL3', 'Canon', 'EOS Rebel SL3', 749.00, 20, '2024-10-18', 24, 'http://example.com/images/canon_eos_rebel_sl3.jpg'),
(1, 'Dell Alienware Aurora Ryzen Edition', 'Dell', 'Alienware Aurora Ryzen Edition', 3500.00, 10, '2024-01-22', 24, 'http://example.com/images/dell_alienware_aurora_ryzen.jpg'),
(2, 'Samsung Galaxy S23+', 'Samsung', 'Galaxy S23+', 999.00, 70, '2024-02-25', 12, 'http://example.com/images/samsung_galaxy_s23plus.jpg'),
(3, 'Apple iPad Pro 12.9"', 'Apple', 'iPad Pro 12.9"', 1099.00, 20, '2024-03-28', 12, 'http://example.com/images/apple_ipad_pro12.9.jpg'),
(4, 'LG UltraGear 27GN800-B', 'LG', 'UltraGear 27GN800-B', 500.00, 18, '2024-04-28', 12, 'http://example.com/images/lg_ultragear27gn800b.jpg'),
(5, 'Sony Xperia 5 IV', 'Sony', 'Xperia 5 IV', 899.00, 40, '2024-05-22', 24, 'http://example.com/images/sony_xperia5iv.jpg'),
(6, 'Logitech G Pro X Wireless', 'Logitech', 'G Pro X Wireless', 200.00, 90, '2024-06-25', 24, 'http://example.com/images/logitech_gprox_wireless.jpg'),
(7, 'Razer BlackWidow Elite', 'Razer', 'BlackWidow Elite', 170.00, 100, '2024-07-28', 12, 'http://example.com/images/razer_blackwidow_elite.jpg'),
(8, 'Apple AirPods Pro 2', 'Apple', 'AirPods Pro 2', 249.00, 80, '2024-08-25', 12, 'http://example.com/images/apple_airpods_pro2.jpg'),
(9, 'Bose SoundTouch 300', 'Bose', 'SoundTouch 300', 399.00, 30, '2024-09-20', 24, 'http://example.com/images/bose_soundtouch300.jpg'),
(10, 'Canon EOS M50 Mark II', 'Canon', 'EOS M50 Mark II', 799.00, 20, '2024-10-15', 24, 'http://example.com/images/canon_eos_m50_mark2.jpg'),
(1, 'Dell XPS 13 2-in-1', 'Dell', 'XPS 13 2-in-1', 1600.00, 22, '2024-01-25', 24, 'http://example.com/images/dell_xps132in1.jpg'),
(2, 'Samsung Galaxy A54 5G', 'Samsung', 'Galaxy A54 5G', 600.00, 115, '2024-02-20', 12, 'http://example.com/images/samsung_galaxy_a54_5g.jpg'),
(3, 'Apple MacBook Air M2', 'Apple', 'MacBook Air M2', 1199.00, 29, '2024-03-18', 12, 'http://example.com/images/apple_macbook_air_m2.jpg'),
(4, 'LG UltraGear 32GN600-B', 'LG', 'UltraGear 32GN600-B', 550.00, 12, '2024-04-28', 12, 'http://example.com/images/lg_ultragear32gn600b.jpg'),
(5, 'Sony PlayStation DualSense Wireless Controller', 'Sony', 'DualSense Controller', 69.99, 200, '2024-05-25', 24, 'http://example.com/images/sony_dualsense.jpg'),
(6, 'Logitech C920 HD Pro Webcam', 'Logitech', 'C920 HD Pro', 100.00, 105, '2024-06-30', 24, 'http://example.com/images/logitech_c920_hdpro.jpg'),
(7, 'Razer Seiren Go', 'Razer', 'Seiren Go', 80.00, 120, '2024-07-22', 12, 'http://example.com/images/razer_seiren_go.jpg'),
(8, 'Apple Magic Keyboard for iPad', 'Apple', 'Magic Keyboard for iPad', 299.00, 55, '2024-08-18', 12, 'http://example.com/images/apple_magic_keyboard_ipad.jpg'),
(9, 'Bose Portable Smart Speaker II', 'Bose', 'Portable Smart Speaker II', 499.00, 35, '2024-09-15', 24, 'http://example.com/images/bose_portable_speaker_ii.jpg'),
(10, 'Canon EOS Rebel SL3 Kit', 'Canon', 'EOS Rebel SL3 Kit', 899.00, 18, '2024-10-20', 24, 'http://example.com/images/canon_eos_rebel_sl3_kit.jpg'),
(1, 'Dell Inspiron 14 5000', 'Dell', 'Inspiron 14 5000', 1300.00, 30, '2024-01-15', 24, 'http://example.com/images/dell_inspiron145000.jpg'),
(2, 'Samsung Galaxy Watch 5 Pro', 'Samsung', 'Galaxy Watch 5 Pro', 450.00, 70, '2024-02-25', 12, 'http://example.com/images/samsung_galaxy_watch5_pro.jpg'),
(3, 'Apple iPad Pro 12.9" M2', 'Apple', 'iPad Pro 12.9" M2', 1099.00, 20, '2024-03-28', 12, 'http://example.com/images/apple_ipad_pro12.9_m2.jpg'),
(4, 'LG UltraGear 27GN850-B', 'LG', 'UltraGear 27GN850-B', 700.00, 15, '2024-04-25', 12, 'http://example.com/images/lg_ultragear27gn850b.jpg'),
(5, 'Sony WH-1000XM4 Wireless Headphones', 'Sony', 'WH-1000XM4', 299.00, 90, '2024-05-18', 6, 'http://example.com/images/sony_wh1000xm4_wireless.jpg'),
(6, 'Logitech G Pro X Superlight', 'Logitech', 'G Pro X Superlight', 250.00, 85, '2024-06-25', 24, 'http://example.com/images/logitech_gproxs.jpg'),
(7, 'Razer Seiren Mono', 'Razer', 'Seiren Mono', 120.00, 100, '2024-07-30', 12, 'http://example.com/images/razer_seiren_mono.jpg'),
(8, 'Apple Magic Keyboard Folio', 'Apple', 'Magic Keyboard Folio', 199.00, 65, '2024-08-20', 12, 'http://example.com/images/apple_magic_keyboard_folio.jpg'),
(9, 'Bose Home Speaker 500', 'Bose', 'Home Speaker 500', 399.00, 30, '2024-09-20', 24, 'http://example.com/images/bose_home_speaker500.jpg'),
(10, 'Canon EOS Rebel T8i Kit', 'Canon', 'EOS Rebel T8i Kit', 799.00, 20, '2024-10-15', 24, 'http://example.com/images/canon_eos_rebel_t8i_kit.jpg'),
(1, 'Dell XPS 17', 'Dell', 'XPS 17', 2000.00, 28, '2024-01-28', 24, 'http://example.com/images/dell_xps17.jpg'),
(2, 'Samsung Galaxy S23 Ultra', 'Samsung', 'Galaxy S23 Ultra', 1200.00, 65, '2024-02-22', 12, 'http://example.com/images/samsung_galaxy_s23_ultra.jpg'),
(3, 'Apple MacBook Pro 16" M1 Pro', 'Apple', 'MacBook Pro 16" M1 Pro', 3200.00, 15, '2024-03-30', 12, 'http://example.com/images/apple_macbook_pro16_m1pro.jpg'),
(4, 'LG UltraFine OLED Pro 32"', 'LG', 'UltraFine OLED Pro 32"', 1800.00, 7, '2024-04-30', 12, 'http://example.com/images/lg_ultrafine_oledpro32.jpg'),
(5, 'Sony WH-1000XM3 Wireless Headphones', 'Sony', 'WH-1000XM3', 299.00, 100, '2024-05-28', 6, 'http://example.com/images/sony_wh1000xm3_wireless.jpg'),
(6, 'Logitech G915 TKL Lightspeed', 'Logitech', 'G915 TKL Lightspeed', 250.00, 80, '2024-06-20', 24, 'http://example.com/images/logitech_g915tkl_lightspeed.jpg'),
(7, 'Razer BlackWidow V3 Pro', 'Razer', 'BlackWidow V3 Pro', 200.00, 95, '2024-07-25', 12, 'http://example.com/images/razer_blackwidow_v3_pro.jpg'),
(8, 'Apple Magic Trackpad 2 for Mac', 'Apple', 'Magic Trackpad 2 for Mac', 199.00, 50, '2024-08-18', 12, 'http://example.com/images/apple_magic_trackpad2_mac.jpg'),
(9, 'Bose SoundTouch 40', 'Bose', 'SoundTouch 40', 499.00, 35, '2024-09-20', 24, 'http://example.com/images/bose_soundtouch40.jpg'),
(10, 'Canon EOS Rebel T7i Kit', 'Canon', 'EOS Rebel T7i Kit', 799.00, 22, '2024-10-18', 24, 'http://example.com/images/canon_eos_rebel_t7i_kit.jpg'),
(1, 'Dell G7 17 Gaming Laptop', 'Dell', 'G7 17', 1600.00, 19, '2024-01-19', 24, 'http://example.com/images/dell_g717_gaming.jpg'),
(2, 'Samsung Galaxy A54 5G', 'Samsung', 'Galaxy A54 5G', 600.00, 115, '2024-02-20', 12, 'http://example.com/images/samsung_galaxy_a54_5g.jpg'),
(3, 'Apple iPad Pro 12.9" M2', 'Apple', 'iPad Pro 12.9" M2', 1099.00, 20, '2024-03-28', 12, 'http://example.com/images/apple_ipad_pro12.9_m2.jpg'),
(4, 'LG UltraGear 32GN600-B', 'LG', 'UltraGear 32GN600-B', 550.00, 12, '2024-04-28', 12, 'http://example.com/images/lg_ultragear32gn600b.jpg'),
(5, 'Sony PlayStation DualSense Controller', 'Sony', 'DualSense Controller', 69.99, 200, '2024-05-12', 24, 'http://example.com/images/sony_dualsense_controller.jpg'),
(6, 'Logitech G Pro X Superlight Wireless', 'Logitech', 'G Pro X Superlight Wireless', 250.00, 85, '2024-06-25', 24, 'http://example.com/images/logitech_gprox_superlight.jpg'),
(7, 'Razer Seiren X G4 Studio', 'Razer', 'Seiren X G4 Studio', 150.00, 100, '2024-07-28', 12, 'http://example.com/images/razer_seiren_x_g4_studio.jpg'),
(8, 'Apple Magic Keyboard Folio for iPad Pro', 'Apple', 'Magic Keyboard Folio for iPad Pro', 299.00, 55, '2024-08-18', 12, 'http://example.com/images/apple_magic_keyboard_folio_ipadpro.jpg'),
(9, 'Bose Portable Smart Speaker II', 'Bose', 'Portable Smart Speaker II', 399.00, 35, '2024-09-20', 24, 'http://example.com/images/bose_portable_speaker_ii.jpg'),
(10, 'Canon EOS Rebel SL3 Kit with Lens', 'Canon', 'EOS Rebel SL3 Kit with Lens', 899.00, 20, '2024-10-15', 24, 'http://example.com/images/canon_eos_rebel_sl3_kit.jpg'),
(1, 'Dell Precision 5550 Mobile Workstation', 'Dell', 'Precision 5550', 2200.00, 18, '2024-01-05', 24, 'http://example.com/images/dell_precision5550.jpg'),
(2, 'Samsung Galaxy S23+', 'Samsung', 'Galaxy S23+', 999.00, 75, '2024-02-18', 12, 'http://example.com/images/samsung_galaxy_s23plus.jpg'),
(3, 'Apple iPad Mini 6', 'Apple', 'iPad Mini 6', 499.00, 40, '2024-03-12', 12, 'http://example.com/images/apple_ipad_mini6.jpg'),
(4, 'LG 27GN850-B UltraGear Monitor', 'LG', '27GN850-B', 800.00, 16, '2024-04-22', 12, 'http://example.com/images/lg_27gn850b_ultragear.jpg'),
(5, 'Sony Xperia 5 IV', 'Sony', 'Xperia 5 IV', 899.00, 40, '2024-05-22', 24, 'http://example.com/images/sony_xperia5iv.jpg'),
(6, 'Logitech G Pro Wireless Gaming Mouse', 'Logitech', 'G Pro Wireless', 150.00, 90, '2024-06-25', 24, 'http://example.com/images/logitech_gpro_wireless.jpg'),
(7, 'Razer BlackWidow Elite Mechanical Keyboard', 'Razer', 'BlackWidow Elite', 170.00, 100, '2024-07-30', 12, 'http://example.com/images/razer_blackwidow_elite_mech.jpg'),
(8, 'Apple Magic Trackpad 2 for Mac', 'Apple', 'Magic Trackpad 2 for Mac', 199.00, 50, '2024-08-20', 12, 'http://example.com/images/apple_magic_trackpad2_mac.jpg'),
(9, 'Bose SoundTouch 300 Home Speaker', 'Bose', 'SoundTouch 300', 399.00, 30, '2024-09-20', 24, 'http://example.com/images/bose_soundtouch300_home.jpg'),
(10, 'Canon EOS Rebel T7 Kit', 'Canon', 'EOS Rebel T7 Kit', 799.00, 22, '2024-10-18', 24, 'http://example.com/images/canon_eos_rebel_t7_kit.jpg'),
(1, 'Dell XPS 13 2-in-1 Convertible Laptop', 'Dell', 'XPS 13 2-in-1', 1600.00, 22, '2024-01-25', 24, 'http://example.com/images/dell_xps132in1.jpg'),
(2, 'Samsung Galaxy A54 5G Smartphone', 'Samsung', 'Galaxy A54 5G', 600.00, 115, '2024-02-20', 12, 'http://example.com/images/samsung_galaxy_a54_5g.jpg'),
(3, 'Apple iPad Pro 12.9" M2', 'Apple', 'iPad Pro 12.9" M2', 1099.00, 20, '2024-03-28', 12, 'http://example.com/images/apple_ipad_pro12.9_m2.jpg'),
(4, 'LG UltraGear 32GN600-B Gaming Monitor', 'LG', 'UltraGear 32GN600-B', 550.00, 12, '2024-04-28', 12, 'http://example.com/images/lg_ultragear32gn600b.jpg'),
(5, 'Sony PlayStation DualSense Wireless Controller', 'Sony', 'DualSense Wireless Controller', 69.99, 200, '2024-05-12', 24, 'http://example.com/images/sony_dualsense_wireless_controller.jpg'),
(6, 'Logitech G Pro X Superlight Wireless Gaming Mouse', 'Logitech', 'G Pro X Superlight Wireless', 250.00, 85, '2024-06-25', 24, 'http://example.com/images/logitech_gprox_superlight_wireless.jpg'),
(7, 'Razer Seiren Go Streaming Microphone', 'Razer', 'Seiren Go', 80.00, 120, '2024-07-22', 12, 'http://example.com/images/razer_seiren_go_streaming.jpg'),
(8, 'Apple Magic Keyboard for iPad Pro 12.9"', 'Apple', 'Magic Keyboard for iPad Pro 12.9"', 299.00, 55, '2024-08-18', 12, 'http://example.com/images/apple_magic_keyboard_ipadpro12.9.jpg'),
(9, 'Bose Portable Smart Speaker II', 'Bose', 'Portable Smart Speaker II', 399.00, 35, '2024-09-20', 24, 'http://example.com/images/bose_portable_speaker_ii.jpg'),
(10, 'Canon EOS Rebel SL3 Kit with Lens', 'Canon', 'EOS Rebel SL3 Kit with Lens', 899.00, 20, '2024-10-15', 24, 'http://example.com/images/canon_eos_rebel_sl3_kit.jpg'),
(1, 'Dell Precision 5550 Mobile Workstation', 'Dell', 'Precision 5550', 2200.00, 18, '2024-01-05', 24, 'http://example.com/images/dell_precision5550.jpg'),
(2, 'Samsung Galaxy S23+', 'Samsung', 'Galaxy S23+', 999.00, 75, '2024-02-18', 12, 'http://example.com/images/samsung_galaxy_s23plus.jpg'),
(3, 'Apple iPad Mini 6', 'Apple', 'iPad Mini 6', 499.00, 40, '2024-03-12', 12, 'http://example.com/images/apple_ipad_mini6.jpg'),
(4, 'LG UltraGear 27GN800-B', 'LG', 'UltraGear 27GN800-B', 500.00, 16, '2024-04-22', 12, 'http://example.com/images/lg_ultragear27gn800b.jpg'),
(5, 'Sony PlayStation DualSense Wireless Controller', 'Sony', 'DualSense Wireless Controller', 69.99, 200, '2024-05-12', 24, 'http://example.com/images/sony_dualsense_wireless_controller.jpg'),
(6, 'Logitech G915 TKL Lightspeed Wireless Mechanical Keyboard', 'Logitech', 'G915 TKL Lightspeed', 250.00, 80, '2024-06-20', 24, 'http://example.com/images/logitech_g915tkl_lightspeed_wireless.jpg'),
(7, 'Razer BlackWidow V3 Pro Mechanical Keyboard', 'Razer', 'BlackWidow V3 Pro', 200.00, 95, '2024-07-28', 12, 'http://example.com/images/razer_blackwidow_v3_pro.jpg'),
(8, 'Apple Magic Trackpad 2 for MacBook Pro', 'Apple', 'Magic Trackpad 2 for MacBook Pro', 199.00, 50, '2024-08-20', 12, 'http://example.com/images/apple_magic_trackpad2_macbookpro.jpg'),
(9, 'Bose SoundTouch 300 Wireless Speaker', 'Bose', 'SoundTouch 300', 399.00, 30, '2024-09-20', 24, 'http://example.com/images/bose_soundtouch300_wireless.jpg'),
(10, 'Canon EOS Rebel T7 Kit with Lens', 'Canon', 'EOS Rebel T7 Kit with Lens', 799.00, 22, '2024-10-18', 24, 'http://example.com/images/canon_eos_rebel_t7_kit.jpg'),
(1, 'Dell XPS 17 2-in-1 Convertible Laptop', 'Dell', 'XPS 17 2-in-1', 2200.00, 20, '2024-01-30', 24, 'http://example.com/images/dell_xps172in1.jpg'),
(2, 'Samsung Galaxy Watch 5 Pro Edition', 'Samsung', 'Galaxy Watch 5 Pro Edition', 500.00, 70, '2024-02-25', 12, 'http://example.com/images/samsung_galaxy_watch5_pro_edition.jpg'),
(3, 'Apple MacBook Pro 16" M1 Max', 'Apple', 'MacBook Pro 16" M1 Max', 4000.00, 10, '2024-03-30', 12, 'http://example.com/images/apple_macbook_pro16_m1max.jpg'),
(4, 'LG UltraGear 32GN600-B Gaming Monitor', 'LG', 'UltraGear 32GN600-B', 550.00, 12, '2024-04-28', 12, 'http://example.com/images/lg_ultragear32gn600b_gaming.jpg'),
(5, 'Sony PlayStation DualSense Controller Pro', 'Sony', 'DualSense Controller Pro', 79.99, 200, '2024-05-12', 24, 'http://example.com/images/sony_dualsense_controller_pro.jpg'),
(6, 'Logitech G Pro X Superlight Wireless Gaming Mouse', 'Logitech', 'G Pro X Superlight Wireless', 250.00, 85, '2024-06-25', 24, 'http://example.com/images/logitech_gprox_superlight_wireless.jpg'),
(7, 'Razer Seiren Go Professional Microphone', 'Razer', 'Seiren Go Professional', 120.00, 100, '2024-07-22', 12, 'http://example.com/images/razer_seiren_go_professional.jpg'),
(8, 'Apple Magic Keyboard for iPad Pro 12.9"', 'Apple', 'Magic Keyboard for iPad Pro 12.9"', 299.00, 55, '2024-08-18', 12, 'http://example.com/images/apple_magic_keyboard_ipadpro12.9.jpg'),
(9, 'Bose SoundLink Revolve+', 'Bose', 'SoundLink Revolve+', 349.00, 45, '2024-09-20', 24, 'http://example.com/images/bose_soundlink_revolveplus.jpg'),
(10, 'Canon EOS Rebel SL3 Kit with Lens', 'Canon', 'EOS Rebel SL3 Kit with Lens', 899.00, 20, '2024-10-15', 24, 'http://example.com/images/canon_eos_rebel_sl3_kit.jpg'),
-- Dòng 51 đến 100
(1, 'Dell Latitude 7420 Mobile Workstation', 'Dell', 'Latitude 7420', 1800.00, 20, '2024-01-05', 24, 'http://example.com/images/dell_latitude7420_mobile.jpg'),
(2, 'Samsung Galaxy S23+', 'Samsung', 'Galaxy S23+', 999.00, 75, '2024-02-18', 12, 'http://example.com/images/samsung_galaxy_s23plus.jpg'),
(3, 'Apple iPad Mini 6', 'Apple', 'iPad Mini 6', 499.00, 40, '2024-03-12', 12, 'http://example.com/images/apple_ipad_mini6.jpg'),
(4, 'LG UltraGear 27GN800-B', 'LG', 'UltraGear 27GN800-B', 500.00, 16, '2024-04-22', 12, 'http://example.com/images/lg_ultragear27gn800b.jpg'),
(5, 'Sony PlayStation DualSense Wireless Controller', 'Sony', 'DualSense Wireless Controller', 69.99, 200, '2024-05-12', 24, 'http://example.com/images/sony_dualsense_wireless_controller.jpg'),
(6, 'Logitech G915 TKL Lightspeed Wireless Mechanical Keyboard', 'Logitech', 'G915 TKL Lightspeed Wireless', 250.00, 80, '2024-06-20', 24, 'http://example.com/images/logitech_g915tkl_lightspeed_wireless.jpg'),
(7, 'Razer BlackWidow V3 Pro Mechanical Keyboard', 'Razer', 'BlackWidow V3 Pro', 200.00, 95, '2024-07-28', 12, 'http://example.com/images/razer_blackwidow_v3_pro_mech.jpg'),
(8, 'Apple Magic Trackpad 2 for MacBook Pro', 'Apple', 'Magic Trackpad 2 for MacBook Pro', 199.00, 50, '2024-08-20', 12, 'http://example.com/images/apple_magic_trackpad2_macbookpro.jpg'),
(9, 'Bose SoundTouch 300 Wireless Speaker', 'Bose', 'SoundTouch 300', 399.00, 30, '2024-09-20', 24, 'http://example.com/images/bose_soundtouch300_wireless.jpg'),
(10, 'Canon EOS Rebel T7 Kit with Lens', 'Canon', 'EOS Rebel T7 Kit with Lens', 799.00, 22, '2024-10-18', 24, 'http://example.com/images/canon_eos_rebel_t7_kit.jpg'),
(1, 'Dell XPS 17 2-in-1 Convertible Laptop', 'Dell', 'XPS 17 2-in-1', 2200.00, 20, '2024-01-30', 24, 'http://example.com/images/dell_xps172in1_convertible.jpg'),
(2, 'Samsung Galaxy Watch 5 Pro Edition', 'Samsung', 'Galaxy Watch 5 Pro Edition', 500.00, 70, '2024-02-25', 12, 'http://example.com/images/samsung_galaxy_watch5_pro_edition.jpg'),
(3, 'Apple MacBook Pro 16" M1 Max', 'Apple', 'MacBook Pro 16" M1 Max', 4000.00, 10, '2024-03-30', 12, 'http://example.com/images/apple_macbook_pro16_m1max.jpg'),
(4, 'LG UltraGear 32GN600-B Gaming Monitor', 'LG', 'UltraGear 32GN600-B', 550.00, 12, '2024-04-28', 12, 'http://example.com/images/lg_ultragear32gn600b_gaming.jpg'),
(5, 'Sony PlayStation DualSense Wireless Controller Pro', 'Sony', 'DualSense Wireless Controller Pro', 79.99, 200, '2024-05-12', 24, 'http://example.com/images/sony_dualsense_wireless_controller_pro.jpg'),
(6, 'Logitech G Pro X Superlight Wireless Gaming Mouse', 'Logitech', 'G Pro X Superlight Wireless', 250.00, 85, '2024-06-25', 24, 'http://example.com/images/logitech_gprox_superlight_wireless.jpg'),
(7, 'Razer Seiren Go Professional Streaming Microphone', 'Razer', 'Seiren Go Professional', 120.00, 100, '2024-07-22', 12, 'http://example.com/images/razer_seiren_go_professional.jpg'),
(8, 'Apple Magic Keyboard Folio for iPad Pro 12.9"', 'Apple', 'Magic Keyboard Folio for iPad Pro 12.9"', 299.00, 55, '2024-08-18', 12, 'http://example.com/images/apple_magic_keyboard_folio_ipadpro12.9.jpg'),
(9, 'Bose Portable Smart Speaker II', 'Bose', 'Portable Smart Speaker II', 399.00, 35, '2024-09-20', 24, 'http://example.com/images/bose_portable_speaker_ii.jpg'),
(10, 'Canon EOS Rebel SL3 Kit with Lens', 'Canon', 'EOS Rebel SL3 Kit with Lens', 899.00, 20, '2024-10-15', 24, 'http://example.com/images/canon_eos_rebel_sl3_kit.jpg'),
(1, 'Dell Precision 5550 Mobile Workstation', 'Dell', 'Precision 5550 Mobile', 2200.00, 18, '2024-01-05', 24, 'http://example.com/images/dell_precision5550_mobile.jpg'),
(2, 'Samsung Galaxy S23 Ultra 5G', 'Samsung', 'Galaxy S23 Ultra 5G', 1250.00, 65, '2024-02-18', 12, 'http://example.com/images/samsung_galaxy_s23ultra5g.jpg'),
(3, 'Apple iPad Mini 6 with Accessories', 'Apple', 'iPad Mini 6 Accessories', 549.00, 30, '2024-03-18', 12, 'http://example.com/images/apple_ipad_mini6_accessories.jpg'),
(4, 'LG UltraGear 34GN850-B', 'LG', 'UltraGear 34GN850-B', 850.00, 10, '2024-04-28', 12, 'http://example.com/images/lg_ultragear34gn850b.jpg'),
(5, 'Sony WH-1000XM4 Wireless Headphones', 'Sony', 'WH-1000XM4 Wireless', 299.00, 90, '2024-05-28', 6, 'http://example.com/images/sony_wh1000xm4_wireless.jpg'),
(6, 'Logitech MX Master 3 Advanced', 'Logitech', 'MX Master 3 Advanced', 120.00, 75, '2024-06-20', 24, 'http://example.com/images/logitech_mxmaster3_advanced.jpg'),
(7, 'Razer BlackWidow V3 Pro Mechanical Gaming Keyboard', 'Razer', 'BlackWidow V3 Pro', 220.00, 95, '2024-07-28', 12, 'http://example.com/images/razer_blackwidow_v3_pro_mech_gaming.jpg'),
(8, 'Apple Magic Trackpad 2 for iMac', 'Apple', 'Magic Trackpad 2 for iMac', 199.00, 50, '2024-08-20', 12, 'http://example.com/images/apple_magic_trackpad2_imac.jpg'),
(9, 'Bose SoundTouch 300 Wireless Speaker', 'Bose', 'SoundTouch 300 Wireless', 399.00, 30, '2024-09-20', 24, 'http://example.com/images/bose_soundtouch300_wireless.jpg'),
(10, 'Canon EOS Rebel T7 Kit with 18-55mm Lens', 'Canon', 'EOS Rebel T7 Kit 18-55mm', 849.00, 20, '2024-10-15', 24, 'http://example.com/images/canon_eos_rebel_t7_kit_18-55mm.jpg'),
(1, 'Dell XPS 15 2-in-1 Convertible Laptop', 'Dell', 'XPS 15 2-in-1', 2200.00, 20, '2024-01-30', 24, 'http://example.com/images/dell_xps152in1_convertible.jpg'),
(2, 'Samsung Galaxy Watch 5 Pro Edition 5G', 'Samsung', 'Galaxy Watch 5 Pro Edition 5G', 550.00, 70, '2024-02-25', 12, 'http://example.com/images/samsung_galaxy_watch5_pro_edition5g.jpg'),
(3, 'Apple MacBook Pro 14" M1 Pro', 'Apple', 'MacBook Pro 14" M1 Pro', 3500.00, 12, '2024-03-30', 12, 'http://example.com/images/apple_macbook_pro14_m1pro.jpg'),
(4, 'LG UltraGear 34GN850-B', 'LG', 'UltraGear 34GN850-B', 900.00, 8, '2024-04-30', 12, 'http://example.com/images/lg_ultragear34gn850b.jpg'),
(5, 'Sony PlayStation DualSense Wireless Controller Elite', 'Sony', 'DualSense Wireless Controller Elite', 89.99, 200, '2024-05-12', 24, 'http://example.com/images/sony_dualsense_controller_elite.jpg'),
(6, 'Logitech G Pro X Superlight Wireless Gaming Mouse', 'Logitech', 'G Pro X Superlight Wireless', 250.00, 85, '2024-06-25', 24, 'http://example.com/images/logitech_gprox_superlight_wireless_gaming.jpg'),
(7, 'Razer Seiren Go Professional Streaming Microphone', 'Razer', 'Seiren Go Professional', 120.00, 100, '2024-07-22', 12, 'http://example.com/images/razer_seiren_go_professional_streaming.jpg'),
(8, 'Apple Magic Keyboard for iPad Pro 12.9"', 'Apple', 'Magic Keyboard for iPad Pro 12.9"', 299.00, 55, '2024-08-18', 12, 'http://example.com/images/apple_magic_keyboard_ipadpro12.9.jpg'),
(9, 'Bose SoundLink Revolve+', 'Bose', 'SoundLink Revolve+', 349.00, 45, '2024-09-20', 24, 'http://example.com/images/bose_soundlink_revolveplus.jpg'),
(10, 'Canon EOS Rebel SL3 Kit with 18-55mm Lens', 'Canon', 'EOS Rebel SL3 Kit 18-55mm', 899.00, 20, '2024-10-15', 24, 'http://example.com/images/canon_eos_rebel_sl3_kit_18-55mm.jpg');




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

INSERT INTO ProductDescription (
    ProductID, CPUcompany, CPUtechnology, CPUtype, MinimumCPUspeed, MaximunSpeed, Multiplier,
    ProcessorCache, BrandCardOboard, ModelCardOboard, FullNameCardOboard, VGABrand, VGAFullName,
    RAMcapacity, RAMType, RAMspeed, NumberOfRemovableSlots, NumberOfOnboardRAM, MaximumRAMSupport,
    HardDriveType, TotalSSDHDDSlots, NumberOfSSDHDDSlotsRemaining, MaximumHardDriveUpgradeCapacity,
    SSDType, Capacity, ScreenSize, DisplayTechnology, Resolution, ScreenType, ScanningFrequency,
    BasePlate, Brightness, ColorCoverage, ScreenRatio, CommunicationPort, Wifi, Bluetooth, Webcam,
    OS, Version, Security, KeyboardType, NumericKeypad, KeyboardLight, TouchPad, BatteryType,
    BatteryCapacity, PowerSupply, AccessoriesInTheBox, Size, ProductWeight, Material, PN, Origin,
    ReleaseDate, WarrantyPeriodMonths, StorageInstructions, UserManual, Color
)VALUES
-- Row 1

(
1, 'Intel', 'Intel Core i5', 'i5-11400', 3.6, 4.3, 40, '6 MB', 'Intel', 'Integrated Graphics', 'Intel UHD Graphics 630', 'Intel', 'Intel UHD Graphics 630', 4, 'DDR4', '2400 MHz', 2, 1, 32, 'SSD', 2, 1, 512, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Aluminum', 300, '85% sRGB', '16:9', 'USB, HDMI, Ethernet', 'Wi-Fi 5', 'Bluetooth 4.2', '720p HD', 'Windows 10', '10.0', 'Fingerprint Sensor', 'Backlit Keyboard', 'FALSE', 'Backlit', 'Precision Touchpad', 'Lithium-polymer', 4500, '65W', 'Charger, Cable, Earbuds', 14.0, 1.8, 'Aluminum', 'PN001', 'South Korea', '2024-02-18', 12, 'Store in a cool, dry place', 'User Manual', 'Blue'),
-- Row 2
(2, 'AMD', 'AMD Ryzen 7', 'Ryzen 7 5800H', 3.43, 4.99, 60, '16 MB', 'NVIDIA', 'GeForce RTX 3070', 'NVIDIA GeForce RTX 3070', 'NVIDIA', 'GeForce RTX 3070', 32, 'DDR4', '2400 MHz', 1, 2, 128, 'SSD', 2, 1, 128, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 326, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 11', '11.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN002', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 3
(3, 'Intel', 'Intel Core i7', 'i7-11700K', 3.8, 5.0, 50, '12 MB', 'Intel', 'Integrated Graphics', 'Intel UHD Graphics 750', 'Intel', 'Intel UHD Graphics 750', 8, 'DDR4', '3200 MHz', 2, 2, 64, 'HDD', 1, 1, 1024, 'SATA', 512, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 300, '90% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '1080p', 'Windows 10', '10.0', 'Fingerprint Sensor', 'Backlit Keyboard', 'FALSE', 'Backlit', 'Precision Touchpad', 'Lithium-polymer', 5000, '65W', 'Charger, Cable, Earbuds', 15.0, 1.8, 'Metal', 'PN003', 'USA', '2024-03-12', 12, 'Store in a cool, dry place', 'User Manual', 'White'),
-- Row 4
(4, 'Intel', 'Intel Core i5', 'i5-11400F', 3.5, 4.5, 42, '12 MB', 'NVIDIA', 'GeForce GTX 1650', 'NVIDIA GeForce GTX 1650', 'NVIDIA', 'GeForce GTX 1650', 8, 'DDR4', '3200 MHz', 1, 2, 64, 'HDD', 2, 1, 1024, 'SATA', 256, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Plastic', 280, '80% NTSC', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 5', 'Bluetooth 4.2', '720p HD', 'Windows 10', '10.0', 'Fingerprint Sensor', 'Standard Keyboard', 'TRUE', 'None', 'Precision Touchpad', 'Lithium-ion', 5000, '65W', 'Charger, Cable, Earbuds', 15.0, 1.8, 'Plastic', 'PN004', 'USA', '2024-02-18', 12, 'Store in a dry place', 'User Manual', 'Blue'),
-- Row 5
(5, 'Intel', 'Intel Core i3', 'i3-10100', 3.6, 4.2, 38, '6 MB', 'Intel', 'Integrated Graphics', 'Intel UHD Graphics 630', 'Intel', 'Intel UHD Graphics 630', 4, 'DDR4', '2400 MHz', 1, 1, 32, 'SSD', 1, 1, 256, 'NVMe', 128, '15.6', 'TN', '1366x768', 'LCD', 60, 'Plastic', 250, '70% NTSC', '16:9', 'USB, VGA, Ethernet', 'Wi-Fi 5', 'Bluetooth 4.2', '720p HD', 'Windows 10', '10.0', 'None', 'Standard Keyboard', 'FALSE', 'None', 'Basic Touchpad', 'Lithium-ion', 4000, '50W', 'Charger, Cable', 13.0, 1.5, 'Plastic', 'PN005', 'Japan', '2024-05-12', 6, 'Store in a dry place', 'User Manual', 'White'),
-- Row 6
(6, 'AMD', 'AMD Ryzen 7', 'Ryzen 7 5800H', 3.43, 4.99, 60, '16 MB', 'NVIDIA', 'GeForce RTX 3070', 'NVIDIA GeForce RTX 3070', 'NVIDIA', 'GeForce RTX 3070', 8, 'DDR4', '3600 MHz', 0, 1, 32, 'SSD', 2, 1, 256, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Plastic', 260, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN006', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 7
(7, 'Intel', 'Intel Core i5', 'i5-12400', 3.3, 4.81, 51, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 8, 'DDR4', '3200 MHz', 0, 2, 32, 'SSD', 4, 1, 1024, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 309, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN007', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 8
(8, 'Intel', 'Intel Core i7', 'i7-12700K', 3.2, 5.2, 55, '12 MB', 'AMD', 'GeForce RTX 3080', 'AMD GeForce RTX 3080', 'AMD', 'GeForce RTX 3080', 16, 'DDR4', '2400 MHz', 1, 2, 64, 'SSD', 4, 0, 512, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 322, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN008', 'China', '2024-06-30', 24, 'Store in a dry place', 'User Manual', 'Silver'),
-- Row 9

(
9, 'Intel', 'Intel Core i5', 'i5-12400', 2.98, 5.2, 57, '8 MB', 'AMD', 'GeForce RTX 3080', 'AMD GeForce RTX 3080', 'AMD', 'GeForce RTX 3080', 8, 'DDR4', '3200 MHz', 1, 1, 32, 'SSD', 1, 1, 512, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 322, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN009', 'Japan', '2024-05-12', 6, 'Store in a dry place', 'User Manual', 'White'),
-- Row 10
(10, 'Intel', 'Intel Core i5', 'i5-12400', 3.33, 4.7, 55, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 8, 'DDR4', '2400 MHz', 1, 2, 32, 'HDD', 3, 2, 32, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 285, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN010', 'Japan', '2024-05-12', 6, 'Store in a dry place', 'User Manual', 'White'),
-- Row 11
(11, 'Intel', 'Intel Core i7', 'i7-12700K', 2.92, 4.8, 47, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR4', '2400 MHz', 1, 2, 64, 'SSD', 4, 0, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 302, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN011', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 12
(12, 'Intel', 'Intel Core i5', 'i5-12400', 3.33, 4.7, 55, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 8, 'DDR4', '2400 MHz', 1, 2, 32, 'HDD', 3, 2, 32, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 285, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN012', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 13
(13, 'AMD', 'Intel Core i7', 'Ryzen 5 5600H', 3.44, 5.32, 42, '12 MB', 'NVIDIA', 'Radeon RX 6700M', 'NVIDIA Radeon RX 6700M', 'NVIDIA', 'Radeon RX 6700M', 32, 'DDR4', '3600 MHz', 2, 1, 128, 'HDD', 3, 1, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 250, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN013', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 14
(14, 'Intel', 'Intel Core i5', 'i5-12400', 3.37, 5.19, 44, '16 MB', 'NVIDIA', 'Radeon RX 6800M', 'NVIDIA Radeon RX 6800M', 'NVIDIA', 'Radeon RX 6800M', 8, 'DDR5', '3600 MHz', 1, 1, 32, 'SSD', 4, 1, 256, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 262, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN014', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 15
(15, 'Intel', 'Intel Core i7', 'i7-12700K', 2.92, 4.8, 47, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR4', '2400 MHz', 1, 2, 64, 'SSD', 4, 0, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 302, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN015', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 16
(16, 'Intel', 'Intel Core i5', 'i5-12400', 3.35, 5.15, 58, '12 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 8, 'DDR4', '3200 MHz', 1, 1, 32, 'HDD', 4, 0, 32, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 305, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN016', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 17
(17, 'Intel', 'Intel Core i7', 'i7-12700K', 3.08, 4.82, 57, '12 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '2400 MHz', 1, 1, 64, 'SSD', 2, 0, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN017', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 18
(18, 'Intel', 'Intel Core i7', 'i7-12700K', 3.35, 5.42, 49, '12 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 16, 'DDR4', '2400 MHz', 1, 2, 64, 'HDD', 2, 1, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 268, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 11', '11.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN018', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 19
(19, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.42, 4.85, 50, '16 MB', 'NVIDIA', 'Radeon RX 6800M', 'NVIDIA Radeon RX 6800M', 'NVIDIA', 'Radeon RX 6800M', 16, 'DDR5', '2400 MHz', 2, 1, 64, 'SSD', 2, 2, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 317, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN019', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 20
(20, 'Intel', 'Intel Core i5', 'i5-12400', 3.33, 4.7, 55, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '3200 MHz', 1, 2, 64, 'SSD', 2, 0, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 330, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN020', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 21

(21, 'AMD', 'Intel Core i5', 'i7-12700K', 2.6, 4.66, 46, '16 MB', 'NVIDIA', 'GeForce RTX 3070', 'NVIDIA GeForce RTX 3070', 'NVIDIA', 'GeForce RTX 3070', 16, 'DDR5', '3200 MHz', 0, 2, 64, 'HDD', 2, 1, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 330, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN021', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 22
(22, 'Intel', 'Intel Core i5', 'i5-12400', 3.5, 4.3, 40, '6 MB', 'Intel', 'Integrated Graphics', 'Intel UHD Graphics 630', 'Intel', 'Intel UHD Graphics 630', 4, 'DDR4', '2400 MHz', 2, 1, 32, 'SSD', 2, 1, 512, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Aluminum', 300, '85% sRGB', '16:9', 'USB, HDMI, Ethernet', 'Wi-Fi 5', 'Bluetooth 4.2', '720p HD', 'Windows 10', '10.0', 'Fingerprint Sensor', 'Backlit Keyboard', 'FALSE', 'Backlit', 'Precision Touchpad', 'Lithium-polymer', 5000, '65W', 'Charger, Cable, Earbuds', 14.0, 1.8, 'Aluminum', 'PN022', 'South Korea', '2024-02-18', 12, 'Store in a cool, dry place', 'User Manual', 'Blue'),
-- Row 23
(23, 'Intel', 'AMD Ryzen 7', 'Ryzen 7 5800H', 3.41, 4.97, 46, '12 MB', 'NVIDIA', 'GeForce RTX 3080', 'NVIDIA GeForce RTX 3080', 'NVIDIA', 'GeForce RTX 3080', 16, 'DDR5', '3200 MHz', 1, 1, 128, 'HDD', 4, 3, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 271, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN023', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 24
(24, 'Intel', 'AMD Ryzen 5', 'Ryzen 7 5800H', 3.37, 5.19, 44, '16 MB', 'NVIDIA', 'Radeon RX 6800M', 'NVIDIA Radeon RX 6800M', 'NVIDIA', 'Radeon RX 6800M', 8, 'DDR5', '3600 MHz', 1, 1, 32, 'SSD', 4, 1, 256, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 262, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN024', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 25
(25, 'Intel', 'AMD Ryzen 5', 'Ryzen 7 5800H', 2.76, 5.06, 51, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR4', '3600 MHz', 2, 2, 64, 'HDD', 4, 4, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 258, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN025', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 26
(26, 'Intel', 'Intel Core i5', 'i5-12400', 3.35, 5.15, 58, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 16, 'DDR4', '3200 MHz', 1, 2, 64, 'HDD', 3, 2, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 305, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN026', 'Japan', '2024-05-12', 6, 'Store in a dry place', 'User Manual', 'White'),
-- Row 27
(27, 'AMD', 'Intel Core i7', 'Ryzen 7 5800H', 3.07, 4.75, 52, '8 MB', 'NVIDIA', 'Radeon RX 6800M', 'NVIDIA Radeon RX 6800M', 'NVIDIA', 'Radeon RX 6800M', 8, 'DDR4', '2400 MHz', 0, 1, 32, 'SSD', 3, 2, 32, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 268, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN027', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 28
(28, 'Intel', 'Intel Core i7', 'i7-12700K', 2.75, 4.7, 41, '16 MB', 'NVIDIA', 'GeForce RTX 3080', 'NVIDIA GeForce RTX 3080', 'NVIDIA', 'GeForce RTX 3080', 8, 'DDR5', '3200 MHz', 1, 1, 64, 'SSD', 2, 1, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 341, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 11', '11.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN028', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 29
(29, 'AMD', 'Intel Core i7', 'Ryzen 7 5800H', 3.23, 5.19, 42, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3200 MHz', 0, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 328, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN029', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 30
(30, 'Intel', 'Intel Core i5', 'Ryzen 7 5800H', 3.24, 5.27, 53, '16 MB', 'NVIDIA', 'Radeon RX 6800M', 'NVIDIA Radeon RX 6800M', 'NVIDIA', 'Radeon RX 6800M', 16, 'DDR5', '2400 MHz', 2, 1, 64, 'HDD', 1, 1, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 268, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 11', '11.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN030', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 31
(31, 'AMD', 'Intel Core i7', 'Ryzen 7 5800H', 3.23, 5.19, 42, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR4', '3600 MHz', 0, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 341, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN031', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 32
(32, 'Intel', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.3, 5.24, 46, '8 MB', 'NVIDIA', 'GeForce RTX 3070', 'NVIDIA GeForce RTX 3070', 'NVIDIA', 'GeForce RTX 3070', 16, 'DDR4', '3200 MHz', 1, 1, 64, 'HDD', 3, 2, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 317, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN032', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 33
(33, 'Intel', 'Intel Core i7', 'i5-12400', 3.28, 5.15, 56, '12 MB', 'NVIDIA', 'Radeon RX 6800M', 'NVIDIA Radeon RX 6800M', 'NVIDIA', 'Radeon RX 6800M', 32, 'DDR5', '3200 MHz', 1, 1, 128, 'HDD', 2, 1, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 271, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN033', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 34
(34, 'Intel', 'AMD Ryzen 5', 'Ryzen 7 5800H', 3.17, 4.53, 45, '8 MB', 'NVIDIA', 'Radeon RX 6800M', 'NVIDIA Radeon RX 6800M', 'NVIDIA', 'Radeon RX 6800M', 16, 'DDR5', '3200 MHz', 1, 1, 64, 'HDD', 2, 1, 64, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 273, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN034', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 35
(35, 'Intel', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.05, 5.02, 52, '8 MB', 'NVIDIA', 'GeForce RTX 3080', 'NVIDIA GeForce RTX 3080', 'NVIDIA', 'GeForce RTX 3080', 16, 'DDR5', '3200 MHz', 2, 1, 64, 'HDD', 1, 1, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 250, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN035', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 36
(36, 'Intel', 'Intel Core i7', 'i7-12700K', 2.75, 5.38, 58, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 16, 'DDR5', '3200 MHz', 0, 1, 64, 'SSD', 2, 2, 64, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 330, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN036', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 37
(37, 'AMD', 'Intel Core i7', 'Ryzen 7 5800H', 3.23, 5.19, 42, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3200 MHz', 0, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 328, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN037', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 38
(38, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.42, 4.85, 50, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 317, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN038', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 39
(39, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.34, 4.62, 57, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'HDD', 2, 1, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN039', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 40
(40, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.08, 4.82, 58, '12 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3200 MHz', 1, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN040', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 41
(41, 'Intel', 'AMD Ryzen 5', 'Ryzen 7 5800H', 2.85, 4.87, 44, '16 MB', 'NVIDIA', 'GeForce RTX 3080', 'NVIDIA GeForce RTX 3080', 'NVIDIA', 'GeForce RTX 3080', 16, 'DDR4', '3200 MHz', 1, 2, 64, 'HDD', 2, 2, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN041', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 42
(42, 'Intel', 'Intel Core i5', 'i5-12400', 3.35, 5.15, 58, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 16, 'DDR4', '3200 MHz', 1, 2, 64, 'HDD', 2, 1, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 305, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN042', 'Japan', '2024-05-12', 6, 'Store in a dry place', 'User Manual', 'White'),
-- Row 43
(43, 'Intel', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.07, 4.75, 59, '12 MB', 'AMD', 'Radeon RX 6700M', 'AMD Radeon RX 6700M', 'AMD', 'Radeon RX 6700M', 32, 'DDR4', '2400 MHz', 1, 1, 128, 'HDD', 3, 1, 128, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 256, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN043', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 44
(44, 'AMD', 'AMD Ryzen 5', 'Ryzen 7 5800H', 3.17, 4.53, 45, '8 MB', 'NVIDIA', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '3200 MHz', 1, 1, 64, 'HDD', 2, 1, 64, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 273, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN044', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 45
(45, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.35, 4.62, 57, '12 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '3200 MHz', 0, 1, 64, 'HDD', 4, 0, 64, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN045', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 46
(46, 'AMD', 'AMD Ryzen 5', 'Ryzen 7 5800H', 2.73, 4.7, 44, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 32, 'DDR4', '3200 MHz', 1, 2, 128, 'HDD', 3, 0, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 324, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN046', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 47
(47, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.34, 4.62, 59, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '3200 MHz', 1, 1, 64, 'SSD', 2, 0, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN047', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 48
(48, 'Intel', 'AMD Ryzen 5', 'Ryzen 7 5800H', 3.17, 4.53, 45, '8 MB', 'NVIDIA', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '3200 MHz', 1, 1, 64, 'HDD', 2, 1, 64, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 273, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN048', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 49
(49, 'Intel', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.05, 5.02, 52, '8 MB', 'NVIDIA', 'GeForce RTX 3080', 'NVIDIA GeForce RTX 3080', 'NVIDIA', 'GeForce RTX 3080', 16, 'DDR5', '3200 MHz', 2, 1, 64, 'HDD', 1, 1, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 250, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN049', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 50
(50, 'Intel', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.16, 4.91, 45, '16 MB', 'NVIDIA', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'NVIDIA', 'Radeon RX 6800M', 16, 'DDR5', '2400 MHz', 2, 1, 64, 'HDD', 1, 1, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 268, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 11', '11.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN050', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 51
(51, 'Intel', 'Intel Core i5', 'i5-12400', 3.35, 5.15, 58, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 16, 'DDR4', '3200 MHz', 1, 2, 64, 'HDD', 3, 2, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 317, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN051', 'Japan', '2024-05-12', 6, 'Store in a dry place', 'User Manual', 'White'),
-- Row 52
(52, 'Intel', 'Intel Core i5', 'i5-12400', 3.35, 5.15, 58, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 16, 'DDR4', '3200 MHz', 1, 2, 64, 'HDD', 3, 2, 64, 'NVMe', 256, '15.6', 'IPS', '2560x1440', 'IPS', 144, 'Metal', 300, '99% sRGB', '16:9', 'USB, HDMI, DisplayPort', 'Wi-Fi N/A', 'Bluetooth N/A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35.0, 2.5, 'Plastic', 'PN052', 'South Korea', '2024-04-22', 12, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 53
(53, 'Intel', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.07, 4.75, 59, '12 MB', 'AMD', 'Radeon RX 6700M', 'AMD Radeon RX 6700M', 'AMD', 'Radeon RX 6700M', 32, 'DDR4', '2400 MHz', 1, 1, 128, 'HDD', 3, 1, 128, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 256, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN053', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 54
(54, 'Intel', 'Intel Core i5', 'i5-12400', 3.08, 4.82, 58, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 16, 'DDR5', '3200 MHz', 1, 1, 64, 'SSD', 3, 0, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN054', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 55
(55, 'Intel', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.41, 4.69, 57, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 32, 'DDR4', '3200 MHz', 1, 2, 128, 'HDD', 3, 0, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 341, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN055', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 56
(56, 'Intel', 'Intel Core i5', 'i5-12400', 3.35, 5.15, 58, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 16, 'DDR4', '3200 MHz', 1, 2, 64, 'HDD', 3, 2, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 60, 'Metal', 305, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN056', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 57
(57, 'Intel', 'AMD Ryzen 7', 'Ryzen 7 5800H', 3.23, 5.19, 42, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3200 MHz', 0, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 328, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN057', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 58
(58, 'Intel', 'Intel Core i7', 'i7-12700K', 2.66, 5.33, 58, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 16, 'DDR5', '3200 MHz', 1, 1, 64, 'SSD', 2, 2, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 330, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN058', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 59
(59, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.42, 4.85, 50, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '2400 MHz', 2, 1, 64, 'SSD', 2, 1, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 317, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN059', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 60
(60, 'Intel', 'AMD Ryzen 7', 'i7-12700K', 2.75, 5.38, 58, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 16, 'DDR5', '3200 MHz', 0, 1, 64, 'SSD', 2, 2, 64, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 330, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN060', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 61
(61, 'Intel', 'Intel Core i5', 'i5-12400', 3.35, 5.15, 58, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 16, 'DDR4', '3200 MHz', 1, 2, 64, 'HDD', 3, 2, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 317, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN061', 'Japan', '2024-05-12', 6, 'Store in a dry place', 'User Manual', 'White'),
-- Row 62
(62, 'Intel', 'AMD Ryzen 5', 'Ryzen 7 5800H', 3.47, 4.89, 45, '16 MB', 'AMD', 'Radeon RX 6700M', 'AMD Radeon RX 6700M', 'AMD', 'Radeon RX 6700M', 32, 'DDR4', '3600 MHz', 0, 1, 128, 'HDD', 3, 0, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 319, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN062', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 63
(63, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.08, 4.82, 58, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '3200 MHz', 1, 1, 64, 'SSD', 3, 0, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN063', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 64
(64, 'Intel', 'Intel Core i7', 'i5-12400', 2.66, 5.33, 58, '12 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '3600 MHz', 1, 1, 64, 'SSD', 2, 2, 64, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 330, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN064', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 65
(65, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.35, 4.62, 59, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN065', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 66
(66, 'Intel', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.3, 5.24, 46, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR4', '3200 MHz', 1, 2, 64, 'HDD', 4, 2, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 317, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN066', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 67
(67, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.23, 5.19, 42, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3200 MHz', 0, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 328, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN067', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 68
(68, 'Intel', 'AMD Ryzen 7', 'i5-12400', 2.66, 5.33, 58, '12 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '3600 MHz', 1, 1, 64, 'SSD', 2, 2, 64, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 330, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN068', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 69
(69, 'AMD', 'AMD Ryzen 7', 'Ryzen 5 5600H', 3.23, 5.19, 42, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 0, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 328, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN069', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 70
(70, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.34, 4.62, 59, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'SSD', 2, 2, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN070', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 71
(71, 'AMD', 'AMD Ryzen 5', 'Ryzen 7 5800H', 3.0, 4.75, 52, '8 MB', 'NVIDIA', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'NVIDIA', 'Radeon RX 6800M', 8, 'DDR4', '2400 MHz', 0, 2, 32, 'SSD', 3, 2, 32, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 268, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN071', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 72
(72, 'AMD', 'AMD Ryzen 5', 'Ryzen 7 5800H', 2.73, 4.7, 44, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 32, 'DDR4', '3200 MHz', 1, 2, 128, 'HDD', 3, 0, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 324, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN072', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 73
(73, 'AMD', 'AMD Ryzen 5', 'Ryzen 7 5800H', 3.07, 4.75, 52, '8 MB', 'NVIDIA', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR4', '3600 MHz', 1, 1, 128, 'HDD', 3, 0, 128, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 256, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN073', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 74
(74, 'Intel', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.23, 5.19, 42, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR4', '3600 MHz', 0, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 273, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN074', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 75
(75, 'Intel', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.41, 4.75, 57, '8 MB', 'NVIDIA', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR4', '3200 MHz', 2, 1, 128, 'HDD', 2, 2, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 341, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN075', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 76
(76, 'Intel', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.41, 4.69, 57, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '3600 MHz', 0, 1, 64, 'HDD', 3, 0, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 341, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN076', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 77
(77, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.23, 5.19, 42, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 0, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 328, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN077', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 78
(78, 'AMD', 'AMD Ryzen 5', 'Ryzen 7 5800H', 2.73, 4.7, 44, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 32, 'DDR4', '3600 MHz', 1, 2, 128, 'HDD', 3, 0, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 324, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN078', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 79
(79, 'AMD', 'AMD Ryzen 5', 'Ryzen 7 5800H', 3.0, 4.75, 52, '8 MB', 'NVIDIA', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR4', '3600 MHz', 1, 1, 128, 'HDD', 3, 0, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 324, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN079', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 80
(80, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.35, 4.62, 57, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'SSD', 2, 2, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN080', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 81
(81, 'AMD', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.3, 5.24, 46, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR4', '3200 MHz', 1, 2, 128, 'HDD', 4, 1, 128, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 317, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN081', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 82
(82, 'Intel', 'AMD Ryzen 5', 'Ryzen 5 5600H', 3.3, 5.24, 46, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR4', '3200 MHz', 1, 2, 128, 'HDD', 4, 1, 128, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 317, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN082', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 83
(83, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.08, 4.82, 58, '12 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 16, 'DDR5', '3200 MHz', 1, 1, 64, 'SSD', 3, 0, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN083', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 84
(84, 'AMD', 'AMD Ryzen 5', 'Ryzen 7 5800H', 3.17, 4.53, 45, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '3600 MHz', 1, 1, 64, 'HDD', 2, 1, 64, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 273, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN084', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 85
(85, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.05, 5.02, 52, '8 MB', 'AMD', 'GeForce RTX 3080', 'AMD GeForce RTX 3080', 'AMD', 'GeForce RTX 3080', 16, 'DDR5', '3200 MHz', 2, 1, 64, 'HDD', 1, 1, 64, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 250, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN085', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 86
(86, 'AMD', 'AMD Ryzen 5', 'Ryzen 7 5800H', 2.73, 4.7, 44, '8 MB', 'AMD', 'GeForce RTX 3070', 'AMD GeForce RTX 3070', 'AMD', 'GeForce RTX 3070', 32, 'DDR4', '3200 MHz', 1, 2, 128, 'HDD', 3, 0, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 324, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN086', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 87
(87, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.34, 4.62, 59, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'SSD', 2, 2, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN087', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 88
(88, 'Intel', 'AMD Ryzen 7', 'i5-12400', 2.66, 5.33, 58, '12 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '3600 MHz', 1, 1, 64, 'SSD', 2, 2, 64, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN088', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 89
(89, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.34, 4.62, 59, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'SSD', 2, 2, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN089', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 90
(90, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.34, 4.62, 59, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'SSD', 2, 2, 128, 'NVMe', 512, '15.6', 'IPS', '2560x1440', 'IPS', 144, 'Metal', 300, '99% sRGB', '16:9', 'USB, HDMI, DisplayPort', 'Wi-Fi N/A', 'Bluetooth N/A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35.0, 2.5, 'Plastic', 'PN090', 'South Korea', '2024-04-22', 12, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 91
(91, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.23, 5.19, 42, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3200 MHz', 0, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 328, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN091', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 92
(92, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.35, 5.15, 58, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'SSD', 2, 2, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN092', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 93
(93, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.34, 4.62, 59, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'SSD', 2, 2, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN093', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 94
(94, 'Intel', 'AMD Ryzen 7', 'i5-12400', 2.66, 5.33, 58, '12 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 16, 'DDR5', '3600 MHz', 1, 1, 64, 'SSD', 2, 2, 64, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 330, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN094', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 95
(95, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.34, 4.62, 59, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'SSD', 2, 2, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN095', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 96
(96, 'AMD', 'AMD Ryzen 5', 'Ryzen 7 5800H', 3.41, 4.69, 57, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'HDD', 3, 0, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 341, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN096', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 97
(97, 'AMD', 'AMD Ryzen 7', 'i5-12400', 3.23, 5.19, 42, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 0, 1, 128, 'SSD', 2, 1, 128, 'NVMe', 1024, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 328, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN097', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 98
(98, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.08, 4.82, 58, '8 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'SSD', 2, 2, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Windows 10', '10.0', 'Windows Hello', 'Mechanical Keyboard', 'TRUE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN098', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 99
(99, 'Intel', 'AMD Ryzen 7', 'i7-12700K', 2.98, 4.89, 53, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 2, 128, 'SSD', 2, 2, 128, 'NVMe', 256, '15.6', 'IPS', '1920x1080', 'LCD', 120, 'Metal', 317, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'Ubuntu 20.04', '20.04', 'N/A', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN099', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black'),
-- Row 100
(100, 'Intel', 'AMD Ryzen 7', 'i5-12400', 3.34, 4.62, 59, '16 MB', 'AMD', 'Radeon RX 6800M', 'AMD Radeon RX 6800M', 'AMD', 'Radeon RX 6800M', 32, 'DDR5', '3600 MHz', 1, 1, 128, 'SSD', 2, 2, 128, 'NVMe', 512, '15.6', 'IPS', '1920x1080', 'LCD', 144, 'Metal', 348, '99% sRGB', '16:9', 'USB, HDMI, LAN', 'Wi-Fi 6', 'Bluetooth 5.0', '720p', 'macOS Monterey', '15.0', 'Touch ID', 'Mechanical Keyboard', 'FALSE', 'RGB', 'Precision Touchpad', 'Lithium-ion', 6000, '450W', 'Charger, Cable, Headphones', 35.0, 2.5, 'Plastic', 'PN100', 'USA', '2024-01-15', 24, 'Store in a dry place', 'User Manual', 'Black' ) ;


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

-- INSERT DATA INTO Users
INSERT INTO Users (UserID, FullName, Email, Password, PhoneNumber, UserType, RegistrationDate) VALUES
(51, 'Nhật Mai', 'nguyenthia51@example.com', 'hashed_password51', '0912345651', 'customer', '2024-10-28'),
(52, 'Kim Trí Trần', 'nguyenthia52@example.com', 'hashed_password52', '0912345652', 'customer', '2024-05-18'),
(53, 'Nhật Trần', 'nguyenthia53@example.com', 'hashed_password53', '0912345653', 'customer', '2024-08-18'),
(54, 'Vi Vũ', 'nguyenthia54@example.com', 'hashed_password54', '0912345654', 'customer', '2024-10-12'),
(55, 'Hương Bùi', 'nguyenthia55@example.com', 'hashed_password55', '0912345655', 'customer', '2024-07-04'),
(56, 'Nhiên Dương', 'nguyenthia56@example.com', 'hashed_password56', '0912345656', 'customer', '2024-08-28'),
(57, 'Bà Kim Vũ', 'nguyenthia57@example.com', 'hashed_password57', '0912345657', 'customer', '2024-02-02'),
(58, 'Hải Bảo Bùi', 'nguyenthia58@example.com', 'hashed_password58', '0912345658', 'customer', '2024-08-06'),
(59, 'Chị An Bùi', 'nguyenthia59@example.com', 'hashed_password59', '0912345659', 'customer', '2024-11-04'),
(60, 'Hà Trí Hoàng', 'nguyenthia60@example.com', 'hashed_password60', '0912345660', 'customer', '2024-03-18'),
(61, 'Vân Phạm', 'nguyenthia61@example.com', 'hashed_password61', '0912345661', 'customer', '2024-10-21'),
(62, 'Nam Văn Lê', 'nguyenthia62@example.com', 'hashed_password62', '0912345662', 'customer', '2024-06-19'),
(63, 'Bà Khoa Trần', 'nguyenthia63@example.com', 'hashed_password63', '0912345663', 'customer', '2024-12-29'),
(64, 'Nam Hoàng', 'nguyenthia64@example.com', 'hashed_password64', '0912345664', 'customer', '2024-03-10'),
(65, 'Ngọc Đặng', 'nguyenthia65@example.com', 'hashed_password65', '0912345665', 'customer', '2024-08-07'),
(66, 'Minh Bùi', 'nguyenthia66@example.com', 'hashed_password66', '0912345666', 'customer', '2024-02-03'),
(67, 'Chị Yến Hoàng', 'nguyenthia67@example.com', 'hashed_password67', '0912345667', 'customer', '2024-11-09'),
(68, 'Duyên Mai', 'nguyenthia68@example.com', 'hashed_password68', '0912345668', 'customer', '2024-05-31'),
(69, 'Minh Hoàng', 'nguyenthia69@example.com', 'hashed_password69', '0912345669', 'customer', '2024-09-03'),
(70, 'Vi Hoàng', 'nguyenthia70@example.com', 'hashed_password70', '0912345670', 'customer', '2024-05-11'),
(71, 'Kim Đặng', 'nguyenthia71@example.com', 'hashed_password71', '0912345671', 'customer', '2024-02-13'),
(72, 'Nam Phạm', 'nguyenthia72@example.com', 'hashed_password72', '0912345672', 'customer', '2024-12-21'),
(73, 'Phương Mai Bùi', 'nguyenthia73@example.com', 'hashed_password73', '0912345673', 'customer', '2024-02-24'),
(74, 'Quý ông Tú Vũ', 'nguyenthia74@example.com', 'hashed_password74', '0912345674', 'customer', '2024-12-09'),
(75, 'Cô Linh Mai', 'nguyenthia75@example.com', 'hashed_password75', '0912345675', 'customer', '2024-01-20'),
(76, 'Anh Vũ Nguyễn', 'nguyenthia76@example.com', 'hashed_password76', '0912345676', 'customer', '2024-05-18'),
(77, 'Chị Bảo Hoàng', 'nguyenthia77@example.com', 'hashed_password77', '0912345677', 'customer', '2024-04-10'),
(78, 'Vi Phạm', 'nguyenthia78@example.com', 'hashed_password78', '0912345678', 'customer', '2024-02-18'),
(79, 'Bác Vũ Nguyễn', 'nguyenthia79@example.com', 'hashed_password79', '0912345679', 'customer', '2024-09-29'),
(80, 'Hải Dương', 'nguyenthia80@example.com', 'hashed_password80', '0912345680', 'customer', '2024-07-24'),
(81, 'Cô Khoa Hoàng', 'nguyenthia81@example.com', 'hashed_password81', '0912345681', 'customer', '2024-06-22'),
(82, 'Nam Phạm', 'nguyenthia82@example.com', 'hashed_password82', '0912345682', 'customer', '2024-06-09'),
(83, 'Khoa Xuân Nguyễn', 'nguyenthia83@example.com', 'hashed_password83', '0912345683', 'customer', '2024-10-18'),
(84, 'Quý cô Linh Phạm', 'nguyenthia84@example.com', 'hashed_password84', '0912345684', 'customer', '2024-11-16'),
(85, 'Hồng Nguyễn', 'nguyenthia85@example.com', 'hashed_password85', '0912345685', 'customer', '2024-10-26'),
(86, 'Dũng Đặng', 'nguyenthia86@example.com', 'hashed_password86', '0912345686', 'customer', '2024-09-27'),
(87, 'An Bùi', 'nguyenthia87@example.com', 'hashed_password87', '0912345687', 'customer', '2024-01-18'),
(88, 'Hưng Mai Bảo Vũ', 'nguyenthia88@example.com', 'hashed_password88', '0912345688', 'customer', '2024-08-05'),
(89, 'Khoa Lê', 'nguyenthia89@example.com', 'hashed_password89', '0912345689', 'customer', '2024-05-12'),
(90, 'Trọng Trần', 'nguyenthia90@example.com', 'hashed_password90', '0912345690', 'customer', '2024-07-15'),
(91, 'Trọng Nguyễn', 'nguyenthia91@example.com', 'hashed_password91', '0912345691', 'customer', '2024-07-22'),
(92, 'Châu Đức Nguyễn', 'nguyenthia92@example.com', 'hashed_password92', '0912345692', 'customer', '2024-07-06'),
(93, 'Bảo Hoàng', 'nguyenthia93@example.com', 'hashed_password93', '0912345693', 'customer', '2024-01-09'),
(94, 'Bảo Dương', 'nguyenthia94@example.com', 'hashed_password94', '0912345694', 'customer', '2024-08-01'),
(95, 'Châu Dương', 'nguyenthia95@example.com', 'hashed_password95', '0912345695', 'customer', '2024-03-10'),
(96, 'Cô Lâm Lê', 'nguyenthia96@example.com', 'hashed_password96', '0912345696', 'customer', '2024-03-26'),
(97, 'Dũng Hoàng', 'nguyenthia97@example.com', 'hashed_password97', '0912345697', 'customer', '2024-10-13'),
(98, 'Châu Trần', 'nguyenthia98@example.com', 'hashed_password98', '0912345698', 'customer', '2024-03-27'),
(99, 'Bà Hồng Nguyễn', 'nguyenthia99@example.com', 'hashed_password99', '0912345699', 'customer', '2024-01-27'),
(100, 'Nhiên Bảo Phạm', 'nguyenthia100@example.com', 'hashed_password100', '09123456100', 'customer', '2024-01-26'),
(101, 'Vi Hoàng', 'nguyenthia101@example.com', 'hashed_password101', '09123456101', 'customer', '2024-10-15'),
(102, 'Hoàng Đức Bùi', 'nguyenthia102@example.com', 'hashed_password102', '09123456102', 'customer', '2024-12-26'),
(103, 'Hạnh Quang Lê', 'nguyenthia103@example.com', 'hashed_password103', '09123456103', 'customer', '2024-02-20'),
(104, 'Vũ Thế Vũ', 'nguyenthia104@example.com', 'hashed_password104', '09123456104', 'customer', '2024-03-29'),
(105, 'Hà Quang Mai', 'nguyenthia105@example.com', 'hashed_password105', '09123456105', 'customer', '2024-11-25'),
(106, 'Phúc Hải Vũ', 'nguyenthia106@example.com', 'hashed_password106', '09123456106', 'customer', '2024-01-21'),
(107, 'Linh Vũ', 'nguyenthia107@example.com', 'hashed_password107', '09123456107', 'customer', '2024-12-08'),
(108, 'Trung Đức Nguyễn', 'nguyenthia108@example.com', 'hashed_password108', '09123456108', 'customer', '2024-03-16'),
(109, 'Duyên Lê', 'nguyenthia109@example.com', 'hashed_password109', '09123456109', 'customer', '2024-06-24'),
(110, 'Chị Thành Trần', 'nguyenthia110@example.com', 'hashed_password110', '09123456110', 'customer', '2024-09-18'),
(111, 'Hương Dương', 'nguyenthia111@example.com', 'hashed_password111', '09123456111', 'customer', '2024-02-14'),
(112, 'Hải Thế Vũ', 'nguyenthia112@example.com', 'hashed_password112', '09123456112', 'customer', '2024-01-29'),
(113, 'Ánh Trần', 'nguyenthia113@example.com', 'hashed_password113', '09123456113', 'customer', '2024-11-06'),
(114, 'Dũng Dương', 'nguyenthia114@example.com', 'hashed_password114', '09123456114', 'customer', '2024-08-25'),
(115, 'Hải Vũ', 'nguyenthia115@example.com', 'hashed_password115', '09123456115', 'customer', '2024-09-14'),
(116, 'An Nguyễn', 'nguyenthia116@example.com', 'hashed_password116', '09123456116', 'customer', '2024-12-13'),
(117, 'Dũng Dương', 'nguyenthia117@example.com', 'hashed_password117', '09123456117', 'customer', '2024-01-12'),
(118, 'Hưng Hữu Mai', 'nguyenthia118@example.com', 'hashed_password118', '09123456118', 'customer', '2024-10-01'),
(119, 'Quý cô Phương Lê', 'nguyenthia119@example.com', 'hashed_password119', '09123456119', 'customer', '2024-08-08'),
(120, 'Bà Phương Mai', 'nguyenthia120@example.com', 'hashed_password120', '09123456120', 'customer', '2024-03-20'),
(121, 'Vân Lê', 'nguyenthia121@example.com', 'hashed_password121', '09123456121', 'customer', '2024-01-15'),
(122, 'Quang Mai Bùi', 'nguyenthia122@example.com', 'hashed_password122', '09123456122', 'customer', '2024-11-11'),
(123, 'Ông Hoàng Hoàng', 'nguyenthia123@example.com', 'hashed_password123', '09123456123', 'customer', '2024-02-22'),
(124, 'Hoàng Trần', 'nguyenthia124@example.com', 'hashed_password124', '09123456124', 'customer', '2024-01-01'),
(125, 'Nhật Xuân Bùi', 'nguyenthia125@example.com', 'hashed_password125', '09123456125', 'customer', '2024-04-27'),
(126, 'Hồng Bùi', 'nguyenthia126@example.com', 'hashed_password126', '09123456126', 'customer', '2024-06-18'),
(127, 'Phúc Tấn Bùi', 'nguyenthia127@example.com', 'hashed_password127', '09123456127', 'customer', '2024-11-18'),
(128, 'Bảo Dương', 'nguyenthia128@example.com', 'hashed_password128', '09123456128', 'customer', '2024-10-29'),
(129, 'Yến Vũ', 'nguyenthia129@example.com', 'hashed_password129', '09123456129', 'customer', '2024-04-26'),
(130, 'Quý cô Nhật Dương', 'nguyenthia130@example.com', 'hashed_password130', '09123456130', 'customer', '2024-02-26'),
(131, 'Chị Xuân Trần', 'nguyenthia131@example.com', 'hashed_password131', '09123456131', 'customer', '2024-10-31'),
(132, 'Hưng Phạm', 'nguyenthia132@example.com', 'hashed_password132', '09123456132', 'customer', '2024-06-15'),
(133, 'Quang Hoàng', 'nguyenthia133@example.com', 'hashed_password133', '09123456133', 'customer', '2024-04-01'),
(134, 'Bảo Vũ', 'nguyenthia134@example.com', 'hashed_password134', '09123456134', 'customer', '2024-09-21'),
(135, 'Cô Lâm Nguyễn', 'nguyenthia135@example.com', 'hashed_password135', '09123456135', 'customer', '2024-03-15'),
(136, 'Thành Nguyễn', 'nguyenthia136@example.com', 'hashed_password136', '09123456136', 'customer', '2024-02-01'),
(137, 'Hạnh Đức Dương', 'nguyenthia137@example.com', 'hashed_password137', '09123456137', 'customer', '2024-06-14'),
(138, 'Nam Mai', 'nguyenthia138@example.com', 'hashed_password138', '09123456138', 'customer', '2024-01-05'),
(139, 'Chị Ánh Nguyễn', 'nguyenthia139@example.com', 'hashed_password139', '09123456139', 'customer', '2024-05-20'),
(140, 'Vũ Thế Bùi', 'nguyenthia140@example.com', 'hashed_password140', '09123456140', 'customer', '2024-12-28'),
(141, 'Nam Đặng', 'nguyenthia141@example.com', 'hashed_password141', '09123456141', 'customer', '2024-11-19'),
(142, 'Kim Mai', 'nguyenthia142@example.com', 'hashed_password142', '09123456142', 'customer', '2024-05-12'),
(143, 'Anh Dũng Trần', 'nguyenthia143@example.com', 'hashed_password143', '09123456143', 'customer', '2024-08-15'),
(144, 'Cô Ánh Trần', 'nguyenthia144@example.com', 'hashed_password144', '09123456144', 'customer', '2024-11-15'),
(145, 'Quý ông Bảo Nguyễn', 'nguyenthia145@example.com', 'hashed_password145', '09123456145', 'customer', '2024-05-23'),
(146, 'Bảo Phạm', 'nguyenthia146@example.com', 'hashed_password146', '09123456146', 'customer', '2024-08-21'),
(147, 'Quý ông Nam Trần', 'nguyenthia147@example.com', 'hashed_password147', '09123456147', 'customer', '2024-03-12'),
(148, 'Hải Văn Vũ', 'nguyenthia148@example.com', 'hashed_password148', '09123456148', 'customer', '2024-12-14'),
(149, 'Vũ Trần', 'nguyenthia149@example.com', 'hashed_password149', '09123456149', 'customer', '2024-04-18'),
(150, 'Anh Châu Hoàng', 'nguyenthia150@example.com', 'hashed_password150', '09123456150', 'customer', '2024-09-20');

-- INSERT DATA INTO Customers
INSERT INTO Customers (UserID, RegistrationDate, Status) VALUES
(51, '2024-04-13', 'active'),
(52, '2024-07-28', 'active'),
(53, '2024-02-28', 'active'),
(54, '2024-08-05', 'active'),
(55, '2024-10-10', 'active'),
(56, '2024-05-24', 'active'),
(57, '2024-12-08', 'active'),
(58, '2024-04-12', 'active'),
(59, '2024-06-11', 'active'),
(60, '2024-05-14', 'active'),
(61, '2024-04-17', 'active'),
(62, '2024-04-02', 'active'),
(63, '2024-11-18', 'active'),
(64, '2024-05-26', 'active'),
(65, '2024-05-26', 'active'),
(66, '2024-04-04', 'active'),
(67, '2024-05-15', 'active'),
(68, '2024-08-17', 'active'),
(69, '2024-06-03', 'active'),
(70, '2024-11-24', 'active'),
(71, '2024-02-19', 'active'),
(72, '2024-05-02', 'active'),
(73, '2024-12-02', 'active'),
(74, '2024-08-22', 'active'),
(75, '2024-10-23', 'active'),
(76, '2024-11-28', 'active'),
(77, '2024-03-20', 'active'),
(78, '2024-11-24', 'active'),
(79, '2024-07-16', 'active'),
(80, '2024-06-18', 'active'),
(81, '2024-12-18', 'active'),
(82, '2024-09-29', 'active'),
(83, '2024-06-28', 'active'),
(84, '2024-01-01', 'active'),
(85, '2024-03-30', 'active'),
(86, '2024-07-08', 'active'),
(87, '2024-08-31', 'active'),
(88, '2024-03-26', 'active'),
(89, '2024-12-09', 'active'),
(90, '2024-03-08', 'active'),
(91, '2024-02-20', 'active'),
(92, '2024-06-11', 'active'),
(93, '2024-10-28', 'active'),
(94, '2024-09-15', 'active'),
(95, '2024-07-20', 'active'),
(96, '2024-09-07', 'active'),
(97, '2024-12-30', 'active'),
(98, '2024-10-02', 'active'),
(99, '2024-12-25', 'active'),
(100, '2024-04-01', 'active'),
(101, '2024-06-13', 'active'),
(102, '2024-12-14', 'active'),
(103, '2024-10-07', 'active'),
(104, '2024-01-17', 'active'),
(105, '2024-07-26', 'active'),
(106, '2024-05-01', 'active'),
(107, '2024-08-15', 'active'),
(108, '2024-06-04', 'active'),
(109, '2024-07-09', 'active'),
(110, '2024-02-13', 'active'),
(111, '2024-05-28', 'active'),
(112, '2024-06-01', 'active'),
(113, '2024-03-15', 'active'),
(114, '2024-08-09', 'active'),
(115, '2024-11-09', 'active'),
(116, '2024-01-14', 'active'),
(117, '2024-12-30', 'active'),
(118, '2024-05-08', 'active'),
(119, '2024-04-18', 'active'),
(120, '2024-07-10', 'active'),
(121, '2024-07-13', 'active'),
(122, '2024-11-24', 'active'),
(123, '2024-10-13', 'active'),
(124, '2024-09-26', 'active'),
(125, '2024-01-11', 'active'),
(126, '2024-02-28', 'active'),
(127, '2024-09-12', 'active'),
(128, '2024-12-22', 'active'),
(129, '2024-01-09', 'active'),
(130, '2024-12-01', 'active'),
(131, '2024-06-28', 'active'),
(132, '2024-05-30', 'active'),
(133, '2024-09-04', 'active'),
(134, '2024-09-21', 'active'),
(135, '2024-01-29', 'active'),
(136, '2024-05-04', 'active'),
(137, '2024-06-24', 'active'),
(138, '2024-10-15', 'active'),
(139, '2024-10-23', 'active'),
(140, '2024-05-25', 'active'),
(141, '2024-09-07', 'active'),
(142, '2024-01-28', 'active'),
(143, '2024-12-11', 'active'),
(144, '2024-05-19', 'active'),
(145, '2024-03-18', 'active'),
(146, '2024-12-17', 'active'),
(147, '2024-01-03', 'active'),
(148, '2024-09-06', 'active'),
(149, '2024-12-20', 'active'),
(150, '2024-11-11', 'active');

-- INSERT DATA INTO ShippingAddresses
INSERT INTO ShippingAddresses (CustomerID, Address, City, District, Ward, StreetAddress) VALUES
 (11, 'Số 12, Đường Lê Lợi, Phường 3, Quận Tân Bình', 'Thành phố Hồ Chí Minh', 'Quận Tân Bình', 'Phường 3', 'Số 12, Đường Lê Lợi'),
    (12, 'Số 45, Đường Nguyễn Trãi, Phường 5, Quận 1', 'Thành phố Hồ Chí Minh', 'Quận 1', 'Phường 5', 'Số 45, Đường Nguyễn Trãi'),
    (13, 'Số 78, Đường Trần Hưng Đạo, Phường 7, Quận 10', 'Thành phố Hồ Chí Minh', 'Quận 10', 'Phường 7', 'Số 78, Đường Trần Hưng Đạo'),
    (14, 'Số 34, Đường Võ Văn Kiệt, Phường 2, Quận Gò Vấp', 'Thành phố Hồ Chí Minh', 'Quận Gò Vấp', 'Phường 2', 'Số 34, Đường Võ Văn Kiệt'),
    (15, 'Số 56, Đường Phạm Ngọc Thạch, Phường 4, Quận Phú Nhuận', 'Thành phố Hồ Chí Minh', 'Quận Phú Nhuận', 'Phường 4', 'Số 56, Đường Phạm Ngọc Thạch'),
    (16, 'Số 89, Đường Nguyễn Văn Cừ, Phường 6, Quận 3', 'Thành phố Hồ Chí Minh', 'Quận 3', 'Phường 6', 'Số 89, Đường Nguyễn Văn Cừ'),
    (17, 'Số 23, Đường Lý Chính Thắng, Phường 8, Quận Bình Thạnh', 'Thành phố Hồ Chí Minh', 'Quận Bình Thạnh', 'Phường 8', 'Số 23, Đường Lý Chính Thắng'),
    (18, 'Số 67, Đường Lê Văn Sỹ, Phường 9, Quận 11', 'Thành phố Hồ Chí Minh', 'Quận 11', 'Phường 9', 'Số 67, Đường Lê Văn Sỹ'),
    (19, 'Số 10, Đường Hùng Vương, Phường 1, Quận Tân Phú', 'Thành phố Hồ Chí Minh', 'Quận Tân Phú', 'Phường 1', 'Số 10, Đường Hùng Vương'),
    (20, 'Số 54, Đường Phan Đình Phùng, Phường 2, Quận 7', 'Thành phố Hồ Chí Minh', 'Quận 7', 'Phường 2', 'Số 54, Đường Phan Đình Phùng'),
    (21, 'Số 36, Đường Trương Định, Phường 4, Quận Bình Tân', 'Thành phố Hồ Chí Minh', 'Quận Bình Tân', 'Phường 4', 'Số 36, Đường Trương Định'),
    (22, 'Số 81, Đường Võ Thị Sáu, Phường 5, Quận Thủ Đức', 'Thành phố Hồ Chí Minh', 'Quận Thủ Đức', 'Phường 5', 'Số 81, Đường Võ Thị Sáu'),
    (23, 'Số 29, Đường Nguyễn Thị Minh Khai, Phường 3, Quận 9', 'Thành phố Hồ Chí Minh', 'Quận 9', 'Phường 3', 'Số 29, Đường Nguyễn Thị Minh Khai'),
    (24, 'Số 62, Đường Lê Lai, Phường 6, Quận 4', 'Thành phố Hồ Chí Minh', 'Quận 4', 'Phường 6', 'Số 62, Đường Lê Lai'),
    (25, 'Số 14, Đường Hà Nội, Phường 7, Quận Gò Vấp', 'Thành phố Hồ Chí Minh', 'Quận Gò Vấp', 'Phường 7', 'Số 14, Đường Hà Nội'),
    (26, 'Số 77, Đường Cách Mạng Tháng 8, Phường 8, Quận Phú Nhuận', 'Thành phố Hồ Chí Minh', 'Quận Phú Nhuận', 'Phường 8', 'Số 77, Đường Cách Mạng Tháng 8'),
    (27, 'Số 39, Đường Cách Mạng Tháng 8, Phường 9, Quận 5', 'Thành phố Hồ Chí Minh', 'Quận 5', 'Phường 9', 'Số 39, Đường Cách Mạng Tháng 8'),
    (28, 'Số 95, Đường Hồng Bàng, Phường 10, Quận 6', 'Thành phố Hồ Chí Minh', 'Quận 6', 'Phường 10', 'Số 95, Đường Hồng Bàng'),
    (29, 'Số 48, Đường Bạch Đằng, Phường 11, Quận 8', 'Thành phố Hồ Chí Minh', 'Quận 8', 'Phường 11', 'Số 48, Đường Bạch Đằng'),
    (30, 'Số 5, Đường Lê Duẩn, Phường 12, Quận 2', 'Thành phố Hồ Chí Minh', 'Quận 2', 'Phường 12', 'Số 5, Đường Lê Duẩn'),
    (31, 'Số 88, Đường Nguyễn Văn Linh, Phường 13, Quận 12', 'Thành phố Hồ Chí Minh', 'Quận 12', 'Phường 13', 'Số 88, Đường Nguyễn Văn Linh'),
    (32, 'Số 19, Đường Hàm Nghi, Phường 14, Quận 10', 'Thành phố Hồ Chí Minh', 'Quận 10', 'Phường 14', 'Số 19, Đường Hàm Nghi'),
    (33, 'Số 73, Đường Lý Thường Kiệt, Phường 15, Quận 3', 'Thành phố Hồ Chí Minh', 'Quận 3', 'Phường 15', 'Số 73, Đường Lý Thường Kiệt'),
    (34, 'Số 27, Đường Võ Văn Kiệt, Phường 16, Quận Phú Nhuận', 'Thành phố Hồ Chí Minh', 'Quận Phú Nhuận', 'Phường 16', 'Số 27, Đường Võ Văn Kiệt'),
    (35, 'Số 64, Đường Nguyễn Văn Cừ, Phường 17, Quận 4', 'Thành phố Hồ Chí Minh', 'Quận 4', 'Phường 17', 'Số 64, Đường Nguyễn Văn Cừ'),
    (36, 'Số 51, Đường Trần Phú, Phường 18, Quận 5', 'Thành phố Hồ Chí Minh', 'Quận 5', 'Phường 18', 'Số 51, Đường Trần Phú'),
    (37, 'Số 85, Đường Nguyễn Thị Minh Khai, Phường 19, Quận 7', 'Thành phố Hồ Chí Minh', 'Quận 7', 'Phường 19', 'Số 85, Đường Nguyễn Thị Minh Khai'),
    (38, 'Số 30, Đường Phạm Văn Đồng, Phường 20, Quận 1', 'Thành phố Hồ Chí Minh', 'Quận 1', 'Phường 20', 'Số 30, Đường Phạm Văn Đồng'),
    (39, 'Số 60, Đường Nguyễn Văn Lượng, Phường 21, Quận 6', 'Thành phố Hồ Chí Minh', 'Quận 6', 'Phường 21', 'Số 60, Đường Nguyễn Văn Lượng'),
    (40, 'Số 42, Đường Tôn Đức Thắng, Phường 22, Quận Thủ Đức', 'Thành phố Hồ Chí Minh', 'Quận Thủ Đức', 'Phường 22', 'Số 42, Đường Tôn Đức Thắng'),
    (41, 'Số 17, Đường Nguyễn Trãi, Phường 23, Quận 2', 'Thành phố Hồ Chí Minh', 'Quận 2', 'Phường 23', 'Số 17, Đường Nguyễn Trãi'),
    (42, 'Số 93, Đường Võ Văn Kiệt, Phường 24, Quận Bình Thạnh', 'Thành phố Hồ Chí Minh', 'Quận Bình Thạnh', 'Phường 24', 'Số 93, Đường Võ Văn Kiệt'),
    (43, 'Số 8, Đường Lê Lai, Phường 25, Quận 3', 'Thành phố Hồ Chí Minh', 'Quận 3', 'Phường 25', 'Số 8, Đường Lê Lai'),
    (44, 'Số 76, Đường Nguyễn Du, Phường 26, Quận 10', 'Thành phố Hồ Chí Minh', 'Quận 10', 'Phường 26', 'Số 76, Đường Nguyễn Du'),
    (45, 'Số 22, Đường Trần Hưng Đạo, Phường 27, Quận Gò Vấp', 'Thành phố Hồ Chí Minh', 'Quận Gò Vấp', 'Phường 27', 'Số 22, Đường Trần Hưng Đạo'),
    (46, 'Số 99, Đường Phan Văn Trị, Phường 28, Quận Phú Nhuận', 'Thành phố Hồ Chí Minh', 'Quận Phú Nhuận', 'Phường 28', 'Số 99, Đường Phan Văn Trị'),
    (47, 'Số 37, Đường Lê Văn Sỹ, Phường 29, Quận 4', 'Thành phố Hồ Chí Minh', 'Quận 4', 'Phường 29', 'Số 37, Đường Lê Văn Sỹ'),
    (48, 'Số 58, Đường Cách Mạng Tháng 8, Phường 30, Quận 5', 'Thành phố Hồ Chí Minh', 'Quận 5', 'Phường 30', 'Số 58, Đường Cách Mạng Tháng 8'),
    (49, 'Số 44, Đường Hàm Nghi, Phường 31, Quận 7', 'Thành phố Hồ Chí Minh', 'Quận 7', 'Phường 31', 'Số 44, Đường Hàm Nghi'),
    (50, 'Số 66, Đường Lý Thường Kiệt, Phường 32, Quận 9', 'Thành phố Hồ Chí Minh', 'Quận 9', 'Phường 32', 'Số 66, Đường Lý Thường Kiệt'),
(51, 'Số 1, Đường TỪ46, Phường 1, JohnHuyện', 'Quận JohnHuyện', 'Khu', 'Mai Làng', 'Số 1, Đường MÀ85'),
(52, 'Số 2, Đường VÀ12, Phường 9, JohnQuận', 'JohnThành phố', 'Khu', 'Trần Tổ', 'Số 2, Đường SẼ19'),
(53, 'Số 3, Đường VỀ12, Phường 16, JaneThị xã', 'Huyện JaneThị xã', 'Hẻm', 'Trần Ngõ', 'Số 3, Đường KHI70'),
(54, 'Số 4, Đường SẼ30, Phường 17, JohnThành phố', 'Thành phố JohnThành phố', 'Dãy', 'Bùi Ngõ', 'Số 4, Đường CÁCH74'),
(55, 'Số 5, Đường SAU50, Phường 15, JohnThị xã', 'JohnHuyện', 'Dãy', 'Jane Khu', 'Số 5, Đường THAY20'),
(56, 'Số 6, Đường TỪNG78, Phường 17, JaneThị xã', 'Thành phố JohnHuyện', 'Khu', 'John Ngõ', 'Số 6, Đường BẠN51'),
(57, 'Số 7, Đường CŨNG28, Phường 9, Thị xã JohnThành phố', 'JaneXã', 'Hẻm', 'John Hẻm', 'Số 7, Đường ĐƯỢC54'),
(58, 'Số 8, Đường TẠI96, Phường 15, Thị xã JanePhường', 'Huyện JohnQuận', 'Dãy', 'Vũ Dãy', 'Số 8, Đường GIỮA21'),
(59, 'Số 9, Đường CỦA76, Phường 15, Quận JohnPhường', 'JohnThị xã', 'Khu', 'John Làng', 'Số 9, Đường ĐỂ76'),
(60, 'Số 10, Đường VỚI92, Phường 17, JaneHuyện', 'JaneThị xã', 'Tổ', 'John Ngõ', 'Số 10, Đường KHIẾN92'),
(61, 'Số 11, Đường ĐÚNG51, Phường 2, Huyện JanePhường', 'JaneQuận', 'Khu', 'Mai Ngõ', 'Số 11, Đường TỪ41'),
(62, 'Số 12, Đường HOẶC31, Phường 7, JohnXã', 'JohnHuyện', 'Làng', 'John Tổ', 'Số 12, Đường NHƯ53'),
(63, 'Số 13, Đường MÀ4, Phường 18, Thành phố JohnQuận', 'JohnThành phố', 'Tổ', 'John Làng', 'Số 13, Đường CHỈ73'),
(64, 'Số 14, Đường NẾU57, Phường 20, Thị xã JaneXã', 'Thị xã JohnThành phố', 'Hẻm', 'Jane Đường', 'Số 14, Đường VỚI29'),
(65, 'Số 15, Đường NÀY40, Phường 7, JaneXã', 'Thị xã JohnXã', 'Dãy', 'John Đường', 'Số 15, Đường SẼ14'),
(66, 'Số 16, Đường CŨNG65, Phường 19, Huyện JohnHuyện', 'Huyện JohnPhường', 'Hẻm', 'John Số', 'Số 16, Đường BẠN8'),
(67, 'Số 17, Đường ĐÚNG3, Phường 17, Quận JaneHuyện', 'JohnHuyện', 'Số', 'Vũ Tổ', 'Số 17, Đường ĐỂ67'),
(68, 'Số 18, Đường ĐÃ1, Phường 5, Quận JaneThành phố', 'JohnQuận', 'Khu', 'Vũ Đường', 'Số 18, Đường VỚI48'),
(69, 'Số 19, Đường BÊN23, Phường 2, JohnHuyện', 'JanePhường', 'Đường', 'Jane Làng', 'Số 19, Đường VÀI21'),
(70, 'Số 20, Đường ĐIỀU61, Phường 20, JaneHuyện', 'JohnThành phố', 'Tổ', 'Lê Dãy', 'Số 20, Đường LÀ30'),
(71, 'Số 21, Đường CHỈ28, Phường 20, JohnXã', 'JaneQuận', 'Số', 'John Tổ', 'Số 21, Đường ĐỂ7'),
(72, 'Số 22, Đường NHƯ34, Phường 4, JaneHuyện', 'JaneThành phố', 'Dãy', 'John Khu', 'Số 22, Đường LÀM89'),
(73, 'Số 23, Đường TỪ90, Phường 18, JanePhường', 'JaneThành phố', 'Khu', 'John Tổ', 'Số 23, Đường VÀ3'),
(74, 'Số 24, Đường CŨNG55, Phường 10, JohnXã', 'Huyện JohnXã', 'Đường', 'John Đường', 'Số 24, Đường ĐIỀU60'),
(75, 'Số 25, Đường VẪN26, Phường 2, JohnThị xã', 'JaneXã', 'Số', 'Bùi Số', 'Số 25, Đường VẪN18'),
(76, 'Số 26, Đường HƠN79, Phường 12, Quận JaneXã', 'Quận JanePhường', 'Số', 'Phạm Ngõ', 'Số 26, Đường ĐỂ12'),
(77, 'Số 27, Đường TẠI41, Phường 1, JaneThành phố', 'Thị xã JaneHuyện', 'Tổ', 'Jane Tổ', 'Số 27, Đường ĐÃ47'),
(78, 'Số 28, Đường CỦA60, Phường 16, Thành phố JaneQuận', 'JohnXã', 'Ngõ', 'Phạm Làng', 'Số 28, Đường MỘT18'),
(79, 'Số 29, Đường KHIẾN74, Phường 11, Thành phố JanePhường', 'JaneThị xã', 'Tổ', 'Jane Đường', 'Số 29, Đường ĐƯỢC38'),
(80, 'Số 30, Đường VẬY15, Phường 3, JanePhường', 'JohnThành phố', 'Số', 'Mai Số', 'Số 30, Đường VÀ13'),
(81, 'Số 31, Đường VẬY64, Phường 7, JohnXã', 'JohnPhường', 'Đường', 'Phạm Khu', 'Số 31, Đường VỚI43'),
(82, 'Số 32, Đường TỰ3, Phường 17, JaneThị xã', 'JaneThành phố', 'Ngõ', 'Jane Hẻm', 'Số 32, Đường KHÔNG32'),
(83, 'Số 33, Đường VẬY40, Phường 13, Huyện JohnPhường', 'Quận JaneThị xã', 'Tổ', 'Đặng Dãy', 'Số 33, Đường NÀY2'),
(84, 'Số 34, Đường CHO39, Phường 2, JaneQuận', 'Thành phố JaneThành phố', 'Tổ', 'John Làng', 'Số 34, Đường VẪN77'),
(85, 'Số 35, Đường LÀM21, Phường 12, JaneXã', 'Quận JaneHuyện', 'Dãy', 'Trần Khu', 'Số 35, Đường KHÔNG82'),
(86, 'Số 36, Đường CHƯA68, Phường 8, JaneQuận', 'Thành phố JohnHuyện', 'Ngõ', 'John Đường', 'Số 36, Đường NẾU97'),
(87, 'Số 37, Đường VÀI41, Phường 8, JaneXã', 'Thành phố JohnPhường', 'Khu', 'Nguyễn Ngõ', 'Số 37, Đường THẾ96'),
(88, 'Số 38, Đường CÓ54, Phường 4, Quận JaneThị xã', 'Quận JaneXã', 'Hẻm', 'Jane Ngõ', 'Số 38, Đường VÌ54'),
(89, 'Số 39, Đường CÓ24, Phường 18, JaneQuận', 'JohnPhường', 'Ngõ', 'Dương Số', 'Số 39, Đường CỦA57'),
(90, 'Số 40, Đường KHÔNG8, Phường 8, JohnThị xã', 'Thành phố JaneHuyện', 'Dãy', 'John Tổ', 'Số 40, Đường CÁI37'),
(91, 'Số 41, Đường TỰ82, Phường 15, JaneThị xã', 'Quận JohnThành phố', 'Làng', 'John Số', 'Số 41, Đường VÌ6'),
(92, 'Số 42, Đường NƠI54, Phường 1, JaneQuận', 'JohnThành phố', 'Dãy', 'John Hẻm', 'Số 42, Đường GIỐNG66'),
(93, 'Số 43, Đường ĐẾN54, Phường 19, JohnThị xã', 'JaneThị xã', 'Tổ', 'Nguyễn Hẻm', 'Số 43, Đường TẠI22'),
(94, 'Số 44, Đường TỪ69, Phường 18, Thị xã JohnPhường', 'JaneHuyện', 'Đường', 'Jane Tổ', 'Số 44, Đường THAY85'),
(95, 'Số 45, Đường VẪN68, Phường 13, JaneQuận', 'Thị xã JaneXã', 'Ngõ', 'Dương Ngõ', 'Số 45, Đường CÁI73'),
(96, 'Số 46, Đường CÁI70, Phường 3, Thành phố JohnXã', 'Thành phố JohnXã', 'Ngõ', 'Lê Khu', 'Số 46, Đường LÀM39'),
(97, 'Số 47, Đường CÁI35, Phường 19, Thị xã JohnQuận', 'Huyện JaneHuyện', 'Hẻm', 'John Khu', 'Số 47, Đường VÀI31'),
(98, 'Số 48, Đường ĐÃ20, Phường 10, Huyện JohnQuận', 'JohnThị xã', 'Hẻm', 'Mai Hẻm', 'Số 48, Đường NHƯ26'),
(99, 'Số 49, Đường SẼ85, Phường 14, JanePhường', 'Thành phố JohnXã', 'Dãy', 'John Dãy', 'Số 49, Đường NGƯỜI23'),
(100, 'Số 50, Đường MÀ98, Phường 6, JaneHuyện', 'Quận JaneQuận', 'Làng', 'John Dãy', 'Số 50, Đường BÊN16'),
(101, 'Số 51, Đường VỚI52, Phường 4, Thị xã JohnThành phố', 'JohnThị xã', 'Khu', 'John Làng', 'Số 51, Đường THẾ93'),
(102, 'Số 52, Đường CHƯA19, Phường 18, JohnThành phố', 'Thị xã JaneHuyện', 'Dãy', 'John Hẻm', 'Số 52, Đường VỀ64'),
(103, 'Số 53, Đường ĐÓ45, Phường 12, JohnXã', 'JaneHuyện', 'Ngõ', 'Dương Khu', 'Số 53, Đường KHÔNG90'),
(104, 'Số 54, Đường CỦA74, Phường 14, Huyện JohnXã', 'Quận JohnPhường', 'Khu', 'Jane Đường', 'Số 54, Đường TỪNG48'),
(105, 'Số 55, Đường NHƯ49, Phường 13, JohnThành phố', 'Huyện JohnHuyện', 'Ngõ', 'Trần Đường', 'Số 55, Đường KHIẾN28'),
(106, 'Số 56, Đường KHÔNG5, Phường 17, Huyện JohnQuận', 'Huyện JaneQuận', 'Khu', 'Dương Làng', 'Số 56, Đường ĐỂ77'),
(107, 'Số 57, Đường CỦA63, Phường 3, Huyện JohnThành phố', 'JaneHuyện', 'Khu', 'Lê Làng', 'Số 57, Đường NẾU5'),
(108, 'Số 58, Đường LÀ93, Phường 19, JohnThành phố', 'Thị xã JohnThị xã', 'Tổ', 'Đặng Khu', 'Số 58, Đường KHI76'),
(109, 'Số 59, Đường THEO18, Phường 3, JaneXã', 'JohnXã', 'Dãy', 'John Khu', 'Số 59, Đường MỖI71'),
(110, 'Số 60, Đường TỪ9, Phường 12, JaneHuyện', 'JohnThị xã', 'Hẻm', 'John Số', 'Số 60, Đường CÁCH78');


INSERT INTO Cart (CustomerID, Status, CreatedDate, TotalPrice) VALUES
    (11, 'active', '2024-11-15', 1500.00),
    (12, 'checked_out', '2024-12-16', 1700.00),
    (13, 'active', '2024-01-17', 1600.00),
    (14, 'checked_out', '2024-02-18', 1800.00),
    (15, 'active', '2024-03-19', 1550.00),
    (16, 'checked_out', '2024-04-20', 1400.00),
    (17, 'active', '2024-05-21', 1450.00),
    (18, 'checked_out', '2024-06-22', 1650.00),
    (19, 'active', '2024-07-23', 1500.00),
    (20, 'checked_out', '2024-08-24', 1700.00),
    (21, 'active', '2024-09-15', 1600.00),
    (22, 'checked_out', '2024-10-16', 1800.00),
    (23, 'active', '2024-11-17', 1550.00),
    (24, 'checked_out', '2024-12-18', 1400.00),
    (25, 'active', '2024-01-19', 1450.00),
    (26, 'checked_out', '2024-02-20', 1650.00),
    (27, 'active', '2024-03-21', 1500.00),
    (28, 'checked_out', '2024-04-22', 1700.00),
    (29, 'active', '2024-05-23', 1600.00),
    (30, 'checked_out', '2024-06-24', 1800.00),
    (31, 'active', '2024-07-15', 1550.00),
    (32, 'checked_out', '2024-08-16', 1400.00),
    (33, 'active', '2024-09-17', 1450.00),
    (34, 'checked_out', '2024-10-18', 1650.00),
    (35, 'active', '2024-11-19', 1500.00),
    (36, 'checked_out', '2024-12-20', 1700.00),
    (37, 'active', '2024-01-21', 1600.00),
    (38, 'checked_out', '2024-02-22', 1800.00),
    (39, 'active', '2024-03-23', 1550.00),
    (40, 'checked_out', '2024-04-24', 1400.00),
    (41, 'active', '2024-05-15', 1450.00),
    (42, 'checked_out', '2024-06-16', 1650.00),
    (43, 'active', '2024-07-17', 1500.00),
    (44, 'checked_out', '2024-08-18', 1700.00),
    (45, 'active', '2024-09-19', 1600.00),
    (46, 'checked_out', '2024-10-20', 1800.00),
    (47, 'active', '2024-11-21', 1550.00),
    (48, 'checked_out', '2024-12-22', 1400.00),
    (49, 'active', '2024-01-23', 1450.00),
    (50, 'checked_out', '2024-02-24', 1650.00),
    (51, 'active', '2024-03-15', 1500.00),
    (52, 'checked_out', '2024-04-16', 1700.00),
    (53, 'active', '2024-05-17', 1600.00),
    (54, 'checked_out', '2024-06-18', 1800.00),
    (55, 'active', '2024-07-19', 1550.00),
    (56, 'checked_out', '2024-08-20', 1400.00),
    (57, 'active', '2024-09-21', 1450.00),
    (58, 'checked_out', '2024-10-22', 1650.00),
    (59, 'active', '2024-11-23', 1500.00),
    (60, 'checked_out', '2024-12-24', 1700.00),
    (61, 'active', '2024-01-25', 1600.00),
    (62, 'checked_out', '2024-02-26', 1800.00),
    (63, 'active', '2024-03-27', 1550.00),
    (64, 'checked_out', '2024-04-28', 1400.00),
    (65, 'active', '2024-05-29', 1450.00),
    (66, 'checked_out', '2024-06-30', 1650.00),
    (67, 'active', '2024-07-25', 1500.00),
    (68, 'checked_out', '2024-08-26', 1700.00),
    (69, 'active', '2024-09-27', 1600.00),
    (70, 'checked_out', '2024-10-28', 1800.00),
    (71, 'active', '2024-11-29', 1550.00),
    (72, 'checked_out', '2024-12-30', 1400.00),
    (73, 'active', '2024-01-31', 1450.00),
    (74, 'checked_out', '2024-02-15', 1650.00),
    (75, 'active', '2024-03-16', 1500.00),
    (76, 'checked_out', '2024-04-17', 1700.00),
    (77, 'active', '2024-05-18', 1600.00),
    (78, 'checked_out', '2024-06-19', 1800.00),
    (79, 'active', '2024-07-20', 1550.00),
    (80, 'checked_out', '2024-08-21', 1400.00),
    (81, 'active', '2024-09-22', 1450.00),
    (82, 'checked_out', '2024-10-23', 1650.00),
    (83, 'active', '2024-11-24', 1500.00),
    (84, 'checked_out', '2024-12-25', 1700.00),
    (85, 'active', '2024-01-26', 1600.00),
    (86, 'checked_out', '2024-02-27', 1800.00),
    (87, 'active', '2024-03-28', 1550.00),
    (88, 'checked_out', '2024-04-29', 1400.00),
    (89, 'active', '2024-05-30', 1450.00),
    (90, 'checked_out', '2024-06-15', 1650.00),
    (91, 'active', '2024-07-16', 1500.00),
    (92, 'checked_out', '2024-08-17', 1700.00),
    (93, 'active', '2024-09-18', 1600.00),
    (94, 'checked_out', '2024-10-19', 1800.00),
    (95, 'active', '2024-11-20', 1550.00),
    (96, 'checked_out', '2024-12-21', 1400.00),
    (97, 'active', '2024-01-22', 1450.00),
    (98, 'checked_out', '2024-02-23', 1650.00),
    (99, 'active', '2024-03-24', 1500.00),
    (100, 'checked_out', '2024-04-25', 1700.00),
    (101, 'active', '2024-05-26', 1600.00),
    (102, 'checked_out', '2024-06-27', 1800.00),
    (103, 'active', '2024-07-28', 1550.00),
    (104, 'checked_out', '2024-08-29', 1400.00),
    (105, 'active', '2024-09-30', 1450.00),
    (106, 'checked_out', '2024-10-15', 1650.00),
    (107, 'active', '2024-11-16', 1500.00),
    (108, 'checked_out', '2024-12-17', 1700.00),
    (109, 'active', '2024-01-18', 1600.00),
    (110, 'checked_out', '2024-02-19', 1800.00);

INSERT INTO CartDetails (CartID, ProductID, Quantity, Price) VALUES

    (11, 21, 3, 425.00),
    (12, 5, 2, 390.25),
    (13, 14, 1, 720.00),
    (14, 22, 3, 510.60),
    (15, 31, 2, 380.00),
    (16, 4, 1, 640.50),
    (17, 18, 3, 295.80),
    (18, 27, 2, 530.40),
    (19, 9, 1, 660.00),
    (20, 30, 3, 700.20),
    (21, 11, 2, 480.90),
    (22, 23, 1, 515.75),
    (23, 35, 3, 605.10),
    (24, 2, 2, 310.80),
    (25, 39, 1, 780.00),
    (26, 17, 3, 620.55),
    (27, 13, 2, 400.00),
    (28, 41, 1, 850.35),
    (29, 34, 3, 290.60),
    (30, 10, 2, 465.40),
    (31, 26, 1, 550.00),
    (32, 3, 3, 720.80),
    (33, 24, 2, 330.10),
    (34, 38, 1, 500.00),
    (35, 45, 3, 630.25),
    (36, 6, 2, 275.00),
    (37, 20, 1, 490.75),
    (38, 19, 3, 360.50),
    (39, 28, 2, 700.90),
    (40, 32, 1, 410.30),
    (41, 36, 3, 209.67),
    (42, 48, 3, 289.09),
    (43, 42, 3, 995.97),
    (44, 13, 3, 518.80),
    (45, 4, 2, 482.19),
    (46, 20, 1, 970.19),
    (47, 26, 3, 815.87),
    (48, 6, 2, 375.51),
    (49, 6, 1, 766.40),
    (50, 43, 3, 296.74),
    (51, 15, 2, 540.00),
    (52, 49, 1, 890.50),
    (53, 7, 3, 610.30),
    (54, 14, 2, 780.25),
    (55, 21, 1, 720.00),
    (56, 18, 3, 620.60),
    (57, 22, 2, 390.00),
    (58, 30, 1, 650.35),
    (59, 5, 3, 295.40),
    (60, 9, 2, 480.90),
    (61, 34, 1, 515.75),
    (62, 12, 3, 605.10),
    (63, 24, 2, 310.80),
    (64, 39, 1, 780.00),
    (65, 17, 3, 620.55),
    (66, 37, 2, 400.00),
    (67, 8, 1, 850.35),
    (68, 28, 3, 290.60),
    (69, 10, 2, 465.40),
    (70, 11, 1, 550.00),
    (71, 35, 3, 720.80),
    (72, 3, 2, 330.10),
    (73, 38, 1, 500.00),
    (74, 45, 3, 630.25),
    (75, 6, 2, 275.00),
    (76, 20, 1, 490.75),
    (77, 19, 3, 360.50),
    (78, 28, 2, 700.90),
    (79, 32, 1, 410.30),
    (80, 36, 3, 209.67),
    (81, 48, 3, 289.09),
    (82, 42, 3, 995.97),
    (83, 13, 3, 518.80),
    (84, 4, 2, 482.19),
    (85, 20, 1, 970.19),
    (86, 26, 3, 815.87),
    (87, 6, 2, 375.51),
    (88, 6, 1, 766.40),
    (89, 43, 3, 296.74),
    (90, 15, 2, 540.00),
    (91, 49, 1, 890.50),
    (92, 7, 3, 610.30),
    (93, 14, 2, 780.25),
    (94, 21, 1, 720.00),
    (95, 18, 3, 620.60),
    (96, 22, 2, 390.00),
    (97, 30, 1, 650.35),
    (98, 5, 3, 295.40),
    (99, 9, 2, 480.90),
    (100, 34, 1, 515.75),
    (101, 12, 3, 605.10),
    (102, 24, 2, 310.80),
    (103, 39, 1, 780.00),
    (104, 17, 3, 620.55),
    (105, 37, 2, 400.00),
    (106, 8, 1, 850.35),
    (107, 28, 3, 290.60),
    (108, 10, 2, 465.40),
    (109, 11, 1, 550.00),
    (110, 35, 3, 720.80);



-- INSERT DATA INTO Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, ShippingFee, PaymentMethodID, OrderStatus, EstimatedDeliveryDate, ActualDeliveryDate, PromotionID, AddressID) VALUES
    (11, 11, '2024-01-11', 6500.00, 18.00, 1, 'Shipped', '2024-01-16', NULL, 2, 11),
    (12, 12, '2024-01-12', 8200.75, 22.00, 1, 'Delivered', '2024-01-17', '2024-01-19', 3, 12),
    (13, 13, '2024-01-13', 9300.50, 30.00, 1, 'Canceled', '2024-01-18', NULL, 1, 13),
    (14, 14, '2024-01-14', 5400.25, 15.00, 1, 'Pending', '2024-01-19', NULL, 3, 14),
    (15, 15, '2024-01-15', 7600.00, 20.00, 1, 'Confirmed', '2024-01-20', NULL, NULL, 15),
    (16, 16, '2024-01-16', 8800.50, 25.00, 1, 'Shipped', '2024-01-21', NULL, 2, 16),
    (17, 17, '2024-01-17', 6700.75, 18.00, 1, 'Delivered', '2024-01-22', '2024-01-24', 3, 17),
    (18, 18, '2024-01-18', 7300.00, 22.00, 1, 'Confirmed', '2024-01-23', NULL, 1, 18),
    (19, 19, '2024-01-19', 5900.25, 15.00, 1, 'Canceled', '2024-01-24', NULL, NULL, 19),
    (20, 20, '2024-01-20', 8400.50, 20.00, 1, 'Pending', '2024-01-25', NULL, 2, 20),
    (21, 21, '2024-01-21', 9100.00, 25.00, 1, 'Confirmed', '2024-01-26', NULL, NULL, 21),
    (22, 22, '2024-01-22', 10200.75, 30.00, 1, 'Shipped', '2024-01-27', '2024-01-29', 3, 22),
    (23, 23, '2024-01-23', 4700.50, 18.00, 1, 'Delivered', '2024-01-28', NULL, 2, 23),
    (24, 24, '2024-01-24', 6300.25, 22.00, 1, 'Canceled', '2024-01-29', NULL, NULL, 24),
    (25, 25, '2024-01-25', 7900.00, 15.00, 1, 'Pending', '2024-01-30', NULL, 3, 25),
    (26, 26, '2024-01-26', 5600.50, 20.00, 1, 'Confirmed', '2024-01-31', NULL, NULL, 26),
    (27, 27, '2024-01-27', 6800.75, 25.00, 1, 'Shipped', '2024-02-01', NULL, 1, 27),
    (28, 28, '2024-01-28', 7200.00, 18.00, 1, 'Delivered', '2024-02-02', '2024-02-04', 2, 28),
    (29, 29, '2024-01-29', 8100.25, 22.00, 1, 'Confirmed', '2024-02-03', NULL, 3, 29),
    (30, 30, '2024-01-30', 5400.50, 15.00, 1, 'Canceled', '2024-02-04', NULL, 1, 30),
    (31, 31, '2024-01-31', 6700.00, 20.00, 1, 'Pending', '2024-02-06', NULL, NULL, 31),
    (32, 32, '2024-02-01', 9200.75, 25.00, 1, 'Confirmed', '2024-02-07', NULL, 2, 32),
    (33, 33, '2024-02-02', 8300.50, 18.00, 1, 'Shipped', '2024-02-08', NULL, NULL, 33),
    (34, 34, '2024-02-03', 6100.25, 22.00, 1, 'Delivered', '2024-02-09', '2024-02-11', 3, 34),
    (35, 35, '2024-02-04', 7500.00, 15.00, 1, 'Confirmed', '2024-02-10', NULL, 1, 35),
    (36, 36, '2024-02-05', 8800.50, 20.00, 1, 'Canceled', '2024-02-11', NULL, NULL, 36),
    (37, 37, '2024-02-06', 9400.75, 25.00, 1, 'Pending', '2024-02-12', NULL, 2, 37),
    (38, 38, '2024-02-07', 5900.00, 18.00, 1, 'Confirmed', '2024-02-13', NULL, NULL, 38),
    (39, 39, '2024-02-08', 7600.25, 22.00, 1, 'Shipped', '2024-02-14', NULL, 3, 39),
    (40, 40, '2024-02-09', 8400.50, 15.00, 1, 'Delivered', '2024-02-15', '2024-02-17', NULL, 40),
    (41, 41, '2024-02-10', 9334.09, 12.94, 1, 'Delivered', '2024-02-16', '2024-02-20', 2, 41),
    (42, 42, '2024-02-11', 6881.74, 66.74, 1, 'Confirmed', '2024-02-17', NULL, NULL, 42),
    (43, 43, '2024-02-12', 2935.15, 15.22, 1, 'Canceled', '2024-02-22', NULL, 3, 43),
    (44, 44, '2024-02-13', 9166.29, 40.93, 1, 'Delivered', '2024-02-19', '2024-02-19', NULL, 44),
    (45, 45, '2024-02-14', 7343.42, 14.30, 1, 'Shipped', '2024-02-24', NULL, NULL, 45),
    (46, 46, '2024-02-15', 2476.61, 32.07, 1, 'Delivered', '2024-02-20', '2024-02-22', 3, 46),
    (47, 47, '2024-02-16', 4571.85, 45.91, 1, 'Shipped', '2024-02-23', NULL, 1, 47),
    (48, 48, '2024-02-17', 1320.35, 72.37, 1, 'Pending', '2024-02-22', NULL, NULL, 48),
    (49, 49, '2024-02-18', 3751.98, 24.22, 1, 'Shipped', '2024-02-23', NULL, NULL, 49),
    (50, 50, '2024-02-19', 7200.72, 24.09, 1, 'Confirmed', '2024-02-24', NULL, NULL, 50),
    (51, 51, '2024-02-20', 4552.30, 91.43, 1, 'Confirmed', '2024-02-25', NULL, 2, 51),
    (52, 52, '2024-02-21', 1876.17, 83.38, 1, 'Delivered', '2024-02-26', '2024-02-27', NULL, 52),
    (53, 53, '2024-02-22', 5961.33, 65.58, 1, 'Delivered', '2024-02-28', '2024-03-01', 3, 53),
    (54, 54, '2024-02-23', 5979.82, 88.75, 1, 'Pending', '2024-03-01', NULL, NULL, 54),
    (55, 55, '2024-02-24', 3007.46, 64.36, 1, 'Confirmed', '2024-02-29', NULL, NULL, 55),
    (56, 56, '2024-02-25', 8059.94, 71.93, 1, 'Pending', '2024-03-04', NULL, NULL, 56),
    (57, 57, '2024-02-26', 1576.37, 74.71, 1, 'Canceled', '2024-03-03', NULL, 3, 57),
    (58, 58, '2024-02-27', 9895.76, 52.94, 1, 'Canceled', '2024-03-07', NULL, NULL, 58),
    (59, 59, '2024-02-28', 6469.40, 78.32, 1, 'Pending', '2024-03-07', NULL, NULL, 59),
    (60, 60, '2024-02-29', 9389.14, 61.47, 1, 'Shipped', '2024-03-04', NULL, NULL, 60),
    (61, 61, '2024-03-01', 4068.92, 76.36, 1, 'Canceled', '2024-03-06', NULL, 2, 61),
    (62, 62, '2024-03-02', 6766.07, 92.12, 1, 'Pending', '2024-03-07', NULL, 3, 62),
    (63, 63, '2024-03-03', 4908.84, 38.93, 1, 'Shipped', '2024-03-09', NULL, 1, 63),
    (64, 64, '2024-03-04', 7837.55, 38.16, 1, 'Confirmed', '2024-03-09', NULL, 2, 64),
    (65, 65, '2024-03-05', 5885.20, 14.52, 1, 'Canceled', '2024-03-08', NULL, 3, 65),
    (66, 66, '2024-03-06', 5988.70, 82.01, 1, 'Confirmed', '2024-03-10', NULL, 3, 66),
    (67, 67, '2024-03-07', 8045.87, 92.84, 1, 'Delivered', '2024-03-12', '2024-03-14', 2, 67),
    (68, 68, '2024-03-08', 7391.56, 75.75, 1, 'Pending', '2024-03-13', NULL, 3, 68),
    (69, 69, '2024-03-09', 6932.33, 72.28, 1, 'Shipped', '2024-03-14', NULL, NULL, 69),
    (70, 70, '2024-03-10', 3958.00, 78.48, 1, 'Confirmed', '2024-03-15', NULL, NULL, 70),
    (71, 71, '2024-03-11', 4096.74, 12.72, 1, 'Shipped', '2024-03-16', NULL, 2, 71),
    (72, 72, '2024-03-12', 5826.78, 42.16, 1, 'Confirmed', '2024-03-17', NULL, 3, 72),
    (73, 73, '2024-03-13', 5853.60, 46.45, 1, 'Delivered', '2024-03-18', '2024-03-22', 3, 73),
    (74, 74, '2024-03-14', 8128.23, 78.40, 1, 'Shipped', '2024-03-19', NULL, NULL, 74),
    (75, 75, '2024-03-15', 5400.01, 37.47, 1, 'Pending', '2024-03-20', NULL, 3, 75),
    (76, 76, '2024-03-16', 4282.18, 64.71, 1, 'Canceled', '2024-03-21', NULL, NULL, 76),
    (77, 77, '2024-03-17', 9480.19, 70.77, 1, 'Delivered', '2024-03-22', '2024-03-23', 2, 77),
    (78, 78, '2024-03-18', 7796.43, 52.15, 1, 'Delivered', '2024-03-23', '2024-03-28', NULL, 78),
    (79, 79, '2024-03-19', 1245.17, 67.49, 1, 'Confirmed', '2024-03-24', NULL, 3, 79),
    (80, 80, '2024-03-20', 4065.82, 37.36, 1, 'Shipped', '2024-03-25', NULL, 1, 80),
    (81, 81, '2024-03-21', 2895.39, 91.00, 1, 'Delivered', '2024-03-26', '2024-03-29', 3, 81),
    (82, 82, '2024-03-22', 4766.08, 39.57, 1, 'Pending', '2024-03-27', NULL, NULL, 82),
    (83, 83, '2024-03-23', 8795.79, 81.66, 1, 'Pending', '2024-03-28', NULL, 3, 83),
    (84, 84, '2024-03-24', 4173.71, 89.54, 1, 'Pending', '2024-03-29', NULL, NULL, 84),
    (85, 85, '2024-03-25', 4985.17, 42.61, 1, 'Delivered', '2024-03-30', '2024-03-31', 3, 85),
    (86, 86, '2024-03-26', 1382.50, 68.46, 1, 'Confirmed', '2024-03-31', NULL, NULL, 86),
    (87, 87, '2024-03-27', 3726.49, 63.25, 1, 'Shipped', '2024-04-01', NULL, 2, 87),
    (88, 88, '2024-03-28', 1577.09, 28.91, 1, 'Canceled', '2024-04-02', NULL, NULL, 88),
    (89, 89, '2024-03-29', 8403.24, 42.13, 1, 'Pending', '2024-04-13', NULL, 3, 89),
    (90, 90, '2024-03-30', 3951.64, 78.49, 1, 'Confirmed', '2024-04-15', NULL, 3, 90),
    (91, 91, '2024-03-31', 3457.40, 29.32, 1, 'Shipped', '2024-04-05', NULL, NULL, 91),
    (92, 92, '2024-04-01', 7047.95, 89.76, 1, 'Shipped', '2024-04-06', NULL, 3, 92),
    (93, 93, '2024-04-02', 2942.24, 74.80, 1, 'Confirmed', '2024-04-07', NULL, 3, 93),
    (94, 94, '2024-04-03', 1056.33, 71.99, 1, 'Canceled', '2024-04-08', NULL, NULL, 94),
    (95, 95, '2024-04-04', 1455.28, 30.54, 1, 'Confirmed', '2024-04-09', NULL, NULL, 95),
    (96, 96, '2024-04-05', 9154.44, 39.50, 1, 'Canceled', '2024-04-10', NULL, NULL, 96),
    (97, 97, '2024-04-06', 5329.32, 85.83, 1, 'Pending', '2024-04-11', NULL, 3, 97),
    (98, 98, '2024-04-07', 1353.48, 88.42, 1, 'Canceled', '2024-04-11', NULL, 3, 98),
    (99, 99, '2024-04-08', 3384.98, 71.34, 1, 'Pending', '2024-04-13', NULL, NULL, 99),
    (100, 100, '2024-04-09', 1349.42, 74.48, 1, 'Delivered', '2024-04-15', '2024-04-17', NULL, 100),
    (101, 101, '2024-04-10', 5600.00, 25.00, 1, 'Confirmed', '2024-04-15', NULL, NULL, 101),
    (102, 102, '2024-04-11', 6300.50, 30.00, 1, 'Shipped', '2024-04-16', NULL, 3, 102),
    (103, 103, '2024-04-12', 7900.75, 35.00, 1, 'Delivered', '2024-04-17', '2024-04-19', NULL, 103),
    (104, 104, '2024-04-13', 7200.00, 20.00, 1, 'Canceled', '2024-04-18', NULL, NULL, 104),
    (105, 105, '2024-04-14', 8500.25, 15.00, 1, 'Pending', '2024-04-19', NULL, 2, 105),
    (106, 106, '2024-04-15', 9100.50, 22.00, 1, 'Confirmed', '2024-04-20', NULL, NULL, 106),
    (107, 107, '2024-04-16', 6700.75, 18.00, 1, 'Shipped', '2024-04-21', NULL, 4, 107),
    (108, 108, '2024-04-17', 8200.00, 22.00, 1, 'Delivered', '2024-04-22', '2024-04-24', NULL, 108),
    (109, 109, '2024-04-18', 6900.25, 15.00, 1, 'Confirmed', '2024-04-23', NULL, 3, 109),
    (110, 110, '2024-04-19', 9400.50, 20.00, 1, 'Canceled', '2024-04-24', NULL, NULL, 110);

-- INSERT DATA INTO OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
    (11, 21, 2, 3250.00),
    (11, 22, 1, 3250.00),
    (12, 23, 3, 1950.00),
    (12, 24, 2, 1950.00),
    (13, 25, 4, 1200.00),
    (13, 26, 1, 1200.00),
    (14, 27, 5, 1200.00),
    (14, 28, 1, 1200.00),
    (15, 29, 2, 1500.00),
    (15, 30, 3, 1500.00),
    (16, 31, 2, 3750.00),
    (16, 32, 1, 3750.00),
    (17, 33, 3, 983.00),
    (17, 34, 2, 983.00),
    (18, 35, 4, 2625.00),
    (18, 36, 1, 2625.00),
    (19, 37, 3, 3500.00),
    (19, 38, 1, 3500.00),
    (20, 39, 2, 2000.00),
    (20, 40, 3, 2000.00),
    (21, 41, 2, 4550.00),
    (21, 42, 1, 4550.00),
    (22, 43, 3, 4250.00),
    (22, 44, 2, 4250.00),
    (23, 45, 4, 1200.00),
    (23, 46, 1, 1200.00),
    (24, 47, 5, 975.00),
    (24, 48, 1, 975.00),
    (25, 49, 2, 1000.00),
    (25, 50, 3, 1000.00),
    (26, 51, 2, 2125.00),
    (26, 52, 1, 2125.00),
    (27, 53, 3, 1750.00),
    (27, 54, 2, 1750.00),
    (28, 55, 4, 4250.00),
    (28, 56, 1, 4250.00),
    (29, 57, 3, 1500.00),
    (29, 58, 2, 1500.00),
    (30, 59, 5, 2000.00),
    (30, 60, 1, 2000.00),
    (31, 61, 4, 1417.50),
    (31, 62, 1, 1417.50),
    (32, 63, 2, 975.00),
    (32, 64, 1, 975.00),
    (33, 65, 4, 830.00),
    (33, 66, 1, 830.00),
    (34, 67, 3, 1200.00),
    (34, 68, 2, 1200.00),
    (35, 69, 2, 1500.00),
    (35, 70, 3, 1500.00),
    (36, 71, 3, 2250.00),
    (36, 72, 1, 2250.00),
    (37, 73, 3, 3150.00),
    (37, 74, 2, 3150.00),
    (38, 75, 4, 1750.00),
    (38, 76, 1, 1750.00),
    (39, 77, 3, 5250.00),
    (39, 78, 2, 5250.00),
    (40, 79, 2, 4000.00),
    (40, 80, 3, 4000.00),
    (41, 81, 1, 899.27),
    (41, 82, 2, 899.27),
    (42, 83, 1, 194.69),
    (42, 84, 2, 194.69),
    (43, 85, 1, 907.69),
    (43, 86, 2, 907.69),
    (44, 87, 5, 854.75),
    (44, 88, 1, 854.75),
    (45, 89, 1, 813.54),
    (45, 90, 2, 813.54),
    (46, 91, 2, 322.51),
    (46, 92, 1, 322.51),
    (47, 93, 3, 999.33),
    (47, 94, 1, 999.33),
    (48, 95, 4, 638.40),
    (48, 96, 1, 638.40),
    (49, 97, 5, 791.53),
    (49, 98, 1, 791.53),
    (50, 99, 5, 882.10),
    (50, 100, 1, 882.10),
    (51, 101, 2, 268.92),
    (51, 102, 1, 268.92),
    (52, 103, 3, 408.61),
    (52, 104, 2, 408.61),
    (53, 105, 2, 948.91),
    (53, 106, 1, 948.91),
    (54, 107, 3, 824.21),
    (54, 108, 1, 824.21),
    (55, 109, 5, 894.10),
    (55, 110, 1, 894.10),
    (56, 111, 4, 719.02),
    (56, 112, 1, 719.02),
    (57, 113, 2, 299.56),
    (57, 114, 1, 299.56),
    (58, 115, 1, 981.43),
    (58, 116, 1, 981.43),
    (59, 117, 2, 320.55),
    (59, 118, 1, 320.55),
    (60, 119, 5, 417.42),
    (60, 120, 1, 417.42),
    (61, 121, 4, 709.23),
    (61, 122, 1, 709.23),
    (62, 123, 2, 501.89),
    (62, 124, 1, 501.89),
    (63, 125, 4, 481.22),
    (63, 126, 1, 481.22),
    (64, 127, 5, 438.14),
    (64, 128, 1, 438.14),
    (65, 129, 4, 351.08),
    (65, 130, 1, 351.08),
    (66, 131, 2, 383.01),
    (66, 132, 1, 383.01),
    (67, 133, 3, 907.50),
    (67, 134, 1, 907.50),
    (68, 135, 2, 494.16),
    (68, 136, 1, 494.16),
    (69, 137, 5, 807.47),
    (69, 138, 1, 807.47),
    (70, 139, 5, 452.26),
    (70, 140, 1, 452.26),
    (71, 141, 4, 141.75),
    (71, 142, 1, 141.75),
    (72, 143, 5, 772.01),
    (72, 144, 1, 772.01),
    (73, 145, 2, 519.56),
    (73, 146, 1, 519.56),
    (74, 147, 4, 295.54),
    (74, 148, 1, 295.54),
    (75, 149, 3, 677.88),
    (75, 150, 1, 677.88),
    (76, 151, 5, 887.18),
    (76, 152, 1, 887.18),
    (77, 153, 1, 265.66),
    (77, 154, 1, 265.66),
    (78, 155, 1, 566.05),
    (78, 156, 1, 566.05),
    (79, 157, 1, 486.93),
    (79, 158, 1, 486.93),
    (80, 159, 5, 303.22),
    (80, 160, 1, 303.22),
    (81, 161, 2, 828.22),
    (81, 162, 1, 828.22),
    (82, 163, 2, 722.77),
    (82, 164, 1, 722.77),
    (83, 165, 3, 117.95),
    (83, 166, 1, 117.95),
    (84, 167, 2, 983.27),
    (84, 168, 1, 983.27),
    (85, 169, 1, 350.31),
    (85, 170, 1, 350.31),
    (86, 171, 3, 259.29),
    (86, 172, 1, 259.29),
    (87, 173, 4, 882.63),
    (87, 174, 1, 882.63),
    (88, 175, 2, 631.46),
    (88, 176, 1, 631.46),
    (89, 177, 3, 956.15),
    (89, 178, 1, 956.15),
    (90, 179, 2, 785.23),
    (90, 180, 1, 785.23),
    (91, 181, 1, 849.54),
    (91, 182, 1, 849.54),
    (92, 183, 2, 293.34),
    (92, 184, 1, 293.34),
    (93, 185, 2, 891.61),
    (93, 186, 1, 891.61),
    (94, 187, 1, 467.18),
    (94, 188, 1, 467.18),
    (95, 189, 1, 870.98),
    (95, 190, 1, 870.98),
    (96, 191, 1, 938.42),
    (96, 192, 1, 938.42),
    (97, 193, 4, 446.05),
    (97, 194, 1, 446.05),
    (98, 195, 3, 626.15),
    (98, 196, 1, 626.15),
    (99, 197, 3, 585.47),
    (99, 198, 1, 585.47),
    (100, 199, 2, 268.04),
    (100, 200, 1, 268.04),
    (101, 201, 4, 780.51),
    (101, 202, 1, 780.51),
    (102, 203, 4, 896.42),
    (102, 204, 1, 896.42),
    (103, 205, 3, 471.90),
    (103, 206, 1, 471.90),
    (104, 207, 1, 232.96),
    (104, 208, 1, 232.96),
    (105, 209, 1, 242.52),
    (105, 210, 1, 242.52),
    (106, 211, 2, 782.08),
    (106, 212, 1, 782.08),
    (107, 213, 5, 562.01),
    (107, 214, 1, 562.01),
    (108, 215, 4, 932.66),
    (108, 216, 1, 932.66),
    (109, 217, 4, 405.14),
    (109, 218, 1, 405.14),
    (110, 219, 1, 128.68),
    (110, 220, 1, 128.68);
