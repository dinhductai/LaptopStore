package com.example.ProjectLaptopStore.Repository.Custom.Impl;

import com.example.ProjectLaptopStore.Convert.ContentConverter;
import com.example.ProjectLaptopStore.DTO.ProductDetailDTO;
import com.example.ProjectLaptopStore.DTO.Product_FindTopPurchasedProductsDTO;
import com.example.ProjectLaptopStore.DTO.Product_GetReceiptDTO;
import com.example.ProjectLaptopStore.DTO.Product_ProductSearchCheckBoxDTO;
import com.example.ProjectLaptopStore.Entity.ContentEntity;
import com.example.ProjectLaptopStore.Entity.Enum.ProDescription_FindByUserDemand_Enum;
import com.example.ProjectLaptopStore.Entity.Enum.Product_FindProductsByPriceRange_Enum;
import com.example.ProjectLaptopStore.Entity.ProductDescriptionEntity;
import com.example.ProjectLaptopStore.Entity.ProductsEntity;
import com.example.ProjectLaptopStore.Entity.SuppliersEntity;
import com.example.ProjectLaptopStore.Repository.Custom.ProductRepositoryCustom;
import com.example.ProjectLaptopStore.Repository.ProductRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityNotFoundException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;
//import org.springframework.security.core.parameters.P;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import static java.util.regex.Pattern.matches;
import static org.apache.el.lang.ELArithmetic.isNumber;

//sử dụng JDBC để lấy dữ liệu
@Repository
@Transactional
public class ProductRepositoryCustomImpl implements ProductRepositoryCustom {
    @Autowired
    private ContentConverter contentConverter;
    @PersistenceContext
    private EntityManager entityManager;

    //hàm lấy list sản phẩm theo số lượng được đặt hàng
    @Override
    public List<ProductDetailDTO> findAllProductsWithTotalQuantityOrdered() {
        String addCount = " , COUNT(DISTINCT od.ProductID) AS totalProduct, SUM(od.Quantity) AS totalQuantitySold  ";
        String addJoin = " JOIN OrderDetails od ON od.ProductID = p.ProductID Join Orders o on o.OrderID = od.OrderID ";
        StringBuilder query = setQuery(addCount,addJoin);
        query.append(" and MONTH(o.OrderDate) = MONTH(CURDATE())  AND YEAR(o.OrderDate) = YEAR(CURDATE()) " +
                "    and o.OrderStatus = 'Confirmed' ");
        query.append(setQueryGroupBy());
        Query nativeQuery = entityManager.createNativeQuery(query.toString());
        List<Object[]> resultQuery = nativeQuery.getResultList();
        List<ProductDetailDTO> listProductDetailDTO = new ArrayList<>();
        for (Object[] rowOfResult : resultQuery) {
            ProductDetailDTO dto = setConstructor(rowOfResult);
            listProductDetailDTO.add(dto);
        }
        return listProductDetailDTO;
    }
    //hàm tạo sản phẩm
    @Override
    public void createProduct(ProductDetailDTO productNew, ProductsEntity productsEntity, ProductDescriptionEntity productDescriptionEntity, ContentEntity contentEntity) {
        setDataProduct(productNew,productsEntity,productDescriptionEntity,contentEntity,1);
    }
    //hàm cập nhật sản phẩm
    @Override
    public void updateProduct(ProductDetailDTO productUpdate, ProductsEntity productsEntityById,ProductDescriptionEntity productDescriptionEntity,ContentEntity contentEntity) {
       setDataProduct(productUpdate,productsEntityById,productDescriptionEntity,contentEntity,2);
    }

    //Hàm tìm kiếm sản phẩm bằng key trên searchbar
    @Override
    public List<ProductDetailDTO> findAllProductsByKey(String key) {
        Integer keyTransfered=null;
        if(isNumberInteger(key)){
             keyTransfered = Integer.parseInt(key);
        }else{
            System.out.println("key khong phai so");;
        }
        StringBuilder queryCheck = checkKey(key,keyTransfered);
        if(queryCheck == null) {
        return findByKeyWord(key);
        }
        Query nativeQuery = entityManager.createNativeQuery(queryCheck.toString());
        if(queryCheck.toString().contains(":keyInt")){
            Integer keyInt = Integer.parseInt((String) key);
            nativeQuery.setParameter("keyInt", keyInt);
        }
        List<Object[]> resultQuery = nativeQuery.getResultList();
        List<ProductDetailDTO> listProductDetailDTO = new ArrayList<>();
        for (Object[] rowOfResult : resultQuery) {
            ProductDetailDTO dto = setConstructor(rowOfResult);
            listProductDetailDTO.add(dto);
        }
        return listProductDetailDTO;
    }

    //thấy thông tin chi tiết danh sách các sản phẩm
    @Override
    public List<ProductDetailDTO> listProductDetail() {
        StringBuilder query = setQuery("","");
        query.append(" ORDER BY p.productId desc ");
        Query nativeQuery = entityManager.createNativeQuery(query.toString());
        List<Object[]> resultQuery = nativeQuery.getResultList();
        List<ProductDetailDTO> listProductDetailDTO = new ArrayList<>();
        for (Object[] rowOfResult : resultQuery) {
            ProductDetailDTO dto = setConstructor(rowOfResult);
            listProductDetailDTO.add(dto);
        }
        return listProductDetailDTO;
    }

    @Override
    public List<ProductDetailDTO> getOneProductDetail(List<Integer> idProducts) {
        StringBuilder query = setQuery("","");
        query.append(" AND p.productId in (:idProducts) ");

        Query nativeQuery = entityManager.createNativeQuery(query.toString());
        nativeQuery.setParameter("idProducts", idProducts);

        List<Object[]> resultQuery = nativeQuery.getResultList();
        List<ProductDetailDTO> productDetai = new ArrayList<>();

        for (Object[] rowOfResult : resultQuery) {
            ProductDetailDTO product = setConstructor(rowOfResult);
            productDetai.add(product);
        }
        return productDetai;
    }

    @Override
    public List<ProductDetailDTO> getProductDetailByCheckbox(Product_ProductSearchCheckBoxDTO productSearchCheckBoxDTO) {
        StringBuilder query = setQuery("","");
        query.append(setQueryCheckbox(productSearchCheckBoxDTO));
        Query nativeQuery = entityManager.createNativeQuery(query.toString());
        List<Object[]> resultQuery = nativeQuery.getResultList();
        List<ProductDetailDTO> listProductDetailDTO = new ArrayList<>();
        for (Object[] rowOfResult : resultQuery) {
            ProductDetailDTO dto = setConstructor(rowOfResult);
            listProductDetailDTO.add(dto);
        }
        return listProductDetailDTO;
    }

    @Override
    public List<Product_GetReceiptDTO> listProductForReceipt() {
        String query = "select p.productId , p.productName ,p.imageUrl from Products p JOIN Suppliers s on s.SupplierID = p.SupplierID " +
                " WHERE s.Status = 'active' ";
        Query nativeQuery = entityManager.createNativeQuery(query);
        List<Object[]> resultQuery = nativeQuery.getResultList();
        List<Product_GetReceiptDTO> listProductGetReceiptDTO = new ArrayList<>();
        for (Object[] rowOfResult : resultQuery) {
            Product_GetReceiptDTO dto = new Product_GetReceiptDTO(
                    (Integer) rowOfResult[0],
                    (String) rowOfResult[1],
                    (String) rowOfResult[2]
            );
            listProductGetReceiptDTO.add(dto);
        }
        return listProductGetReceiptDTO;
    }

    public StringBuilder checkKey(Object key,Integer keyTransfered){
        if(keyTransfered!=null){
            StringBuilder query = setQuery("","");
            query.append(" and p.brand in (SELECT p2.brand FROM Products p2 WHERE p2.productId = :keyInt) ");
            return query;
        }
        for(String item : ProDescription_FindByUserDemand_Enum.toList()){
            StringBuilder query = setQuery("","");
            if(item.equals(key)){
                if(key.equals("GAMING_DOHOA")) {
                    query.append(" AND pd.vgaBrand like '%NVIDIA%'  ");
                    return query;
                }
                if(key.equals("SINHVIEN_VANPHONG")) {
                    query.append(" AND p.price <= 15000000  ");
                    return query;
                }
                if(key.equals("MONGNHE")) {
                    query.append(" AND pd.productWeight < 1.50  ");
                    return query;
                }
                if(key.equals("DOANHNHAN")) {
                    query.append(" AND p.price > 15000000 ");
                    return query;
                }
            }
        }
        return null;
    }

    public boolean isNumberInteger(String key) {
        return key != null && key.matches("\\d+");  // Kiểm tra chuỗi chỉ chứa các ký tự số
    }

    //hàm set dữ liệu cho các biến
    public void setDataProduct(ProductDetailDTO productNew, ProductsEntity productsEntity,ProductDescriptionEntity productDescriptionEntity,ContentEntity contentEntity,Integer task){
        // Kiểm tra nếu nhà cung cấp (Supplier) đã tồn tại trong cơ sở dữ liệu
        SuppliersEntity suppliersEntity = entityManager.find(SuppliersEntity.class, productNew.getSupplierId());
        // Nếu Supplier không tồn tại, có thể ném ra ngoại lệ hoặc xử lý khác
        if (suppliersEntity == null) {
            throw new EntityNotFoundException("Supplier with ID " + productNew.getSupplierId() + " not found");
        }
//        SuppliersEntity suppliersEntity = new SuppliersEntity();
        // Tạo đối tượng sản phẩm
        productsEntity.setSupplier(suppliersEntity); // Liên kết sản phẩm với nhà cung cấp đã tồn tại
        productsEntity.setProductName(productNew.getProductName());
        productsEntity.setBrand(productNew.getProductBrand());
        productsEntity.setModel(productNew.getModel());
        productsEntity.setPrice(productNew.getPrice());
        productsEntity.setStockQuantity(productNew.getStockQuantity());
        productsEntity.setWarrantyPeriod(productNew.getWarrantyPeriod());
        productsEntity.setReleaseDate(productNew.getReleaseDate());
        productsEntity.setImageURL(productNew.getImageUrl());
        // Tạo đối tượng mô tả sản phẩm
        productDescriptionEntity.setProduct(productsEntity); // Liên kết mô tả sản phẩm với sản phẩm đã tồn tại
        productDescriptionEntity.setCpuCompany(productNew.getCpuCompany());
        productDescriptionEntity.setCpuTechnology(productNew.getCpuTechnology());
        productDescriptionEntity.setCpuType(productNew.getCpuType());
        productDescriptionEntity.setMinimumCPUspeed(productNew.getMinimumCPUspeed());
        productDescriptionEntity.setMaximunSpeed(productNew.getMaximunSpeed());
        productDescriptionEntity.setMultiplier(productNew.getMultiplier());
        productDescriptionEntity.setProcessorCache(productNew.getProcessorCache());
        productDescriptionEntity.setBrandCardOboard(productNew.getBrandCardOboard());
        productDescriptionEntity.setModelCardOboard(productNew.getModelCardOboard());
        productDescriptionEntity.setFullNameCardOboard(productNew.getFullNameCardOboard());
        productDescriptionEntity.setVgaBrand(productNew.getVgaBrand());
        productDescriptionEntity.setVgaFullName(productNew.getVgaFullName());
        productDescriptionEntity.setRamCapacity(productNew.getRamCapacity());
        productDescriptionEntity.setRamType(productNew.getRamType());
        productDescriptionEntity.setRamSpeed(productNew.getRamSpeed());
        productDescriptionEntity.setNumberOfRemovableSlots(productNew.getNumberOfRemovableSlots());
        productDescriptionEntity.setNumberOfOnboardRAM(productNew.getNumberOfOnboardRAM());
        productDescriptionEntity.setMaximumRAMSupport(productNew.getMaximumRAMSupport());
        productDescriptionEntity.setHardDriveType(productNew.getHardDriveType());
        productDescriptionEntity.setTotalSSDHDDSlots(productNew.getTotalSSDHDDSlots());
        productDescriptionEntity.setNumberOfSSDHDDSlotsRemaining(productNew.getNumberOfSSDHDDSlotsRemaining());
        productDescriptionEntity.setMaximumHardDriveUpgradeCapacity(productNew.getMaximumHardDriveUpgradeCapacity());
        productDescriptionEntity.setSsdType(productNew.getSsdType());
        productDescriptionEntity.setCapacity(productNew.getCapacity());
        productDescriptionEntity.setScreenSize(productNew.getScreenSize());
        productDescriptionEntity.setDisplayTechnology(productNew.getDisplayTechnology());
        productDescriptionEntity.setResolution(productNew.getResolution());
        productDescriptionEntity.setScreenType(productNew.getScreenType());
        productDescriptionEntity.setScanningFrequency(productNew.getScanningFrequency());
        productDescriptionEntity.setBasePlate(productNew.getBasePlate());
        productDescriptionEntity.setBrightness(productNew.getBrightness());
        productDescriptionEntity.setColorCoverage(productNew.getColorCoverage());
        productDescriptionEntity.setScreenRatio(productNew.getScreenRatio());
        productDescriptionEntity.setCommunicationPort(productNew.getCommunicationPort());
        productDescriptionEntity.setWifi(productNew.getWifi());
        productDescriptionEntity.setBluetooth(productNew.getBluetooth());
        productDescriptionEntity.setWebcam(productNew.getWebcam());
        productDescriptionEntity.setOs(productNew.getOs());
        productDescriptionEntity.setVersion(productNew.getVersion());
        productDescriptionEntity.setSecurity(productNew.getSecurity());
        productDescriptionEntity.setKeyboardType(productNew.getKeyboardType());
        productDescriptionEntity.setNumericKeypad(productNew.getNumericKeypad());
        productDescriptionEntity.setKeyboardLight(productNew.getKeyboardLight());
        productDescriptionEntity.setTouchPad(productNew.getTouchPad());
        productDescriptionEntity.setBatteryType(productNew.getBatteryType());
        productDescriptionEntity.setBatteryCapacity(productNew.getBatteryCapacity());
        productDescriptionEntity.setPowerSupply(productNew.getPowerSupply());
        productDescriptionEntity.setAccessoriesInTheBox(productNew.getAccessoriesInTheBox());
        productDescriptionEntity.setSize(productNew.getSize());
        productDescriptionEntity.setProductWeight(productNew.getProductWeight());
        productDescriptionEntity.setMaterial(productNew.getMaterial());
        productDescriptionEntity.setPn(productNew.getPnProductCode());
        productDescriptionEntity.setOrigin(productNew.getOrigin());
        productDescriptionEntity.setWarrantyPeriodMonths(productNew.getWarrantyPeriodMonths());
        productDescriptionEntity.setStorageInstructions(productNew.getStorageInstructions());
        productDescriptionEntity.setUserManual(productNew.getUserManual());
        productDescriptionEntity.setColor(productNew.getColor());

        ContentEntity contentNew = contentConverter.toContentEntity(productNew,contentEntity);
        contentNew.setProduct(productsEntity);
        //thêm mới
        if(task == 1){
            // Lưu cả sản phẩm và mô tả sản phẩm
            entityManager.persist(productsEntity);
            entityManager.persist(productDescriptionEntity);
            entityManager.persist(contentNew);
        }
        //cập nhật
        else {
            // Lưu cả sản phẩm và mô tả sản phẩm
            entityManager.merge(productsEntity);
            entityManager.merge(productDescriptionEntity);
            entityManager.merge(contentNew);
            // Flush để đảm bảo các thay đổi được đẩy vào cơ sở dữ liệu ngay lập tức
            entityManager.flush();
        }
    }
    //hàm tạo query lấy thông tin bảng product productdes
    public StringBuilder setQuery(String addCount,String addJoin){
        StringBuilder query = new StringBuilder("SELECT \n" +
                "    p.supplierId,\n" +
                "    p.productId,\n" +
                "    p.productName,\n" +
                "    p.brand AS productBrand,\n" +
                "    p.model,\n" +
                "    p.price,\n" +
                "    p.stockQuantity,\n" +
                "    p.releaseDate,\n" +
                "    p.warrantyPeriod,\n" +
                "    p.imageUrl,\n" +
                "    pd.productDescriptionId,\n" +
                "    pd.cpuCompany,\n" +
                "    pd.cpuTechnology,\n" +
                "    pd.cpuType,\n" +
                "    pd.minimumCPUspeed,\n" +
                "    pd.maximunSpeed,\n" +
                "    pd.multiplier,\n" +
                "    pd.processorCache,\n" +
                "    pd.brandCardOboard,\n" +
                "    pd.modelCardOboard,\n" +
                "    pd.fullNameCardOboard,\n" +
                "    pd.vgaBrand,\n" +
                "    pd.vgaFullName,\n" +
                "    pd.ramCapacity,\n" +
                "    pd.ramType,\n" +
                "    pd.ramSpeed,\n" +
                "    pd.numberOfRemovableSlots,\n" +
                "    pd.numberOfOnboardRAM,\n" +
                "    pd.maximumRAMSupport,\n" +
                "    pd.hardDriveType,\n" +
                "    pd.totalSSDHDDSlots,\n" +
                "    pd.numberOfSSDHDDSlotsRemaining,\n" +
                "    pd.maximumHardDriveUpgradeCapacity,\n" +
                "    pd.ssdType,\n" +
                "    pd.capacity,\n" +
                "    pd.screenSize,\n" +
                "    pd.displayTechnology,\n" +
                "    pd.resolution,\n" +
                "    pd.screenType,\n" +
                "    pd.scanningFrequency,\n" +
                "    pd.basePlate,\n" +
                "    pd.brightness,\n" +
                "    pd.colorCoverage,\n" +
                "    pd.screenRatio,\n" +
                "    pd.communicationPort,\n" +
                "    pd.wifi,\n" +
                "    pd.bluetooth,\n" +
                "    pd.webcam,\n" +
                "    pd.os,\n" +
                "    pd.version,\n" +
                "    pd.security,\n" +
                "    pd.keyboardType,\n" +
                "    pd.numericKeypad,\n" +
                "    pd.keyboardLight,\n" +
                "    pd.touchPad,\n" +
                "    pd.batteryType,\n" +
                "    pd.batteryCapacity,\n" +
                "    pd.powerSupply,\n" +
                "    pd.accessoriesInTheBox,\n" +
                "    pd.size,\n" +
                "    pd.productWeight,\n" +
                "    pd.material,\n" +
                "    pd.pn AS pnProductCode,\n" +
                "    pd.origin,\n" +
                "    pd.warrantyPeriodMonths,\n" +
                "    pd.storageInstructions,\n" +
                "    pd.userManual,\n" +
                "    pd.color\n" +
                addCount+
                " FROM Products p\n" +
                " JOIN ProductDescription pd ON p.productId = pd.productId " +
                " JOIN Suppliers s on s.SupplierID = p.SupplierID " +
                addJoin+
                " WHERE s.Status = 'active'" +
                " ");
        return query;
    }
    //hàm set dữ liệu cho constructor
    public ProductDetailDTO setConstructor(Object[] rowOfResult){
        ProductDetailDTO dto = new ProductDetailDTO(
        (Integer) rowOfResult[1], // productId
                (Integer) rowOfResult[0], // supplierId
                (String) rowOfResult[2],  // productName
                (String) rowOfResult[3],  // productBrand
                (String) rowOfResult[4],  // model
                (Float) rowOfResult[5],   // price
                (Integer) rowOfResult[6], // stockQuantity
                (Date) rowOfResult[7],    // releaseDate
                (Integer) rowOfResult[8], // warrantyPeriod
                (String) rowOfResult[9],  // imageUrl
                (Integer) rowOfResult[10],// productDescriptionId
                (String) rowOfResult[11], // cpuCompany
                (String) rowOfResult[12], // cpuTechnology
                (String) rowOfResult[13], // cpuType
                (BigDecimal) rowOfResult[14], // minimumCPUspeed
                (BigDecimal) rowOfResult[15], // maximunSpeed
                (Integer) rowOfResult[16],  // multiplier
                (String) rowOfResult[17], // processorCache
                (String) rowOfResult[18], // brandCardOboard
                (String) rowOfResult[19], // modelCardOboard
                (String) rowOfResult[20], // fullNameCardOboard
                (String) rowOfResult[21], // vgaBrand
                (String) rowOfResult[22], // vgaFullName
                (Integer) rowOfResult[23],  // ramCapacity
                (String) rowOfResult[24], // ramType
                (String) rowOfResult[25], // ramSpeed
                (Integer) rowOfResult[26],  // numberOfRemovableSlots
                (Integer) rowOfResult[27],  // numberOfOnboardRAM
                (Integer) rowOfResult[28],  // maximumRAMSupport
                (String) rowOfResult[29], // hardDriveType
                (Integer) rowOfResult[30],  // totalSSDHDDSlots
                (Integer) rowOfResult[31],  // numberOfSSDHDDSlotsRemaining
                (Integer) rowOfResult[32],  // maximumHardDriveUpgradeCapacity
                (String) rowOfResult[33], // ssdType
                (Integer) rowOfResult[34],  // capacity
                (String) rowOfResult[35], // screenSize
                (String) rowOfResult[36], // displayTechnology
                (String) rowOfResult[37], // resolution
                (String) rowOfResult[38], // screenType
                (String) rowOfResult[39], // scanningFrequency
                (String) rowOfResult[40], // basePlate
                (Integer) rowOfResult[41],  // brightness
                (String) rowOfResult[42], // colorCoverage
                (BigDecimal) rowOfResult[43], // screenRatio
                (String) rowOfResult[44], // communicationPort
                (String) rowOfResult[45], // wifi
                (String) rowOfResult[46], // bluetooth
                (String) rowOfResult[47], // webcam
                (String) rowOfResult[48], // os
                (String) rowOfResult[49], // version
                (String) rowOfResult[50], // security
                (String) rowOfResult[51], // keyboardType
                (Boolean) rowOfResult[52], // numericKeypad =============================
                (String) rowOfResult[53], // keyboardLight
                (String) rowOfResult[54], // touchPad
                (String) rowOfResult[55], // batteryType
                (Integer) rowOfResult[56],  // batteryCapacity
                (String) rowOfResult[57], // powerSupply
                (String) rowOfResult[58], // accessoriesInTheBox
                (Float)  rowOfResult[59], // size
                (BigDecimal) rowOfResult[60], // productWeight
                (String) rowOfResult[61], // material
                (String) rowOfResult[62], // pnProductCode
                (String) rowOfResult[63], // origin
                (Integer) rowOfResult[64],  // warrantyPeriodMonths
                (String) rowOfResult[65], // storageInstructions
                (String) rowOfResult[66], // userManual
                (String) rowOfResult[67] // color
        );
        return dto;
    }
    //hàm tìm kiếm bằng keyword ở searchbar
    public List<ProductDetailDTO> findByKeyWord(Object key){
        StringBuilder query = new StringBuilder("SELECT ProductID " +
                " FROM Contens " +
                "WHERE Content LIKE :key ");
        Query queryNative = entityManager.createNativeQuery(query.toString());
        queryNative.setParameter("key", "%"+key+"%");
        List<Integer> listIdProductSearch = queryNative.getResultList();
        StringBuilder queryProduct = setQuery("","");
        queryProduct.append(" AND p.productId in :listIdProductSearch ");
        Query nativeQuery2 = entityManager.createNativeQuery(queryProduct.toString());
        nativeQuery2.setParameter("listIdProductSearch", listIdProductSearch);
        List<Object[]> resultQuery = nativeQuery2.getResultList();
        List<ProductDetailDTO> listProductDetai = new ArrayList<>();
        for (Object[] rowOfResult : resultQuery) {
            ProductDetailDTO dto = setConstructor(rowOfResult);
            listProductDetai.add(dto);
        }
        return listProductDetai;
    }
    //hàm set group by
    public StringBuilder setQueryGroupBy(){
        StringBuilder query = new StringBuilder(" GROUP BY " +
                "    p.supplierId, p.productId, pd.productDescriptionId, p.productName, p.brand, p.model, p.price, \n" +
                "    p.stockQuantity, p.releaseDate, p.warrantyPeriod, p.imageUrl, pd.cpuCompany, pd.cpuTechnology, \n" +
                "    pd.cpuType, pd.minimumCPUspeed, pd.maximunSpeed, pd.multiplier, pd.processorCache, pd.brandCardOboard,\n" +
                "    pd.modelCardOboard, pd.fullNameCardOboard, pd.vgaBrand, pd.vgaFullName, pd.ramCapacity, pd.ramType, \n" +
                "    pd.ramSpeed, pd.numberOfRemovableSlots, pd.numberOfOnboardRAM, pd.maximumRAMSupport, pd.hardDriveType, \n" +
                "    pd.totalSSDHDDSlots, pd.numberOfSSDHDDSlotsRemaining, pd.maximumHardDriveUpgradeCapacity, pd.ssdType,\n" +
                "    pd.capacity, pd.screenSize, pd.displayTechnology, pd.resolution, pd.screenType, pd.scanningFrequency, \n" +
                "    pd.basePlate, pd.brightness, pd.colorCoverage, pd.screenRatio, pd.communicationPort, pd.wifi, pd.bluetooth, \n" +
                "    pd.webcam, pd.os, pd.version, pd.security, pd.keyboardType, pd.numericKeypad, pd.keyboardLight, pd.touchPad, \n" +
                "    pd.batteryType, pd.batteryCapacity, pd.powerSupply, pd.accessoriesInTheBox, pd.size, pd.productWeight, \n" +
                "    pd.material, pd.pn, pd.origin, pd.warrantyPeriodMonths, pd.storageInstructions, pd.userManual, pd.color\n" +
                " Order by totalProduct DESC,  totalQuantitySold DESC " +
                " LIMIT 10 ;");
        return query;
    }
    //hàm nối query tìm bằng checkbox
//    public StringBuilder setQueryCheckbox(Product_ProductSearchCheckBoxDTO productSearchCheckBoxDTO){
//        StringBuilder query = new StringBuilder(" ");
//        try {
//            Field[] fields = Product_ProductSearchCheckBoxDTO.class.getDeclaredFields();
//            for (Field item : fields){
//                item.setAccessible(true);
//                String fieldName = item.getName();
//                Object value = item.get(productSearchCheckBoxDTO);
//                //tìm kiếm bằng giá
//                if(fieldName.equals("price") && value != null){
//                    switch (value.toString()) {
//                        case "BETWEEN_15_AND_20":
//                            query.append(" AND p.price BETWEEN 15000000 AND 20000000 ");
//                            break;
//                        case "BETWEEN_10_AND_15":
//                            query.append(" AND p.price BETWEEN 10000000 AND 15000000 ");
//                            break;
//                        case "BELOW_10":
//                            query.append(" AND p.price < 10000000 ");
//                            break;
//                        case "BETWEEN_25_AND_30":
//                            query.append(" AND p.price BETWEEN 25000000 AND 30000000 ");
//                            break;
//                        case "ABOVE_30":
//                            query.append(" AND p.price > 30000000 ");
//                            break;
//                        case "BETWEEN_20_AND_25":
//                            query.append(" AND p.price BETWEEN 20000000 AND 25000000 ");
//                            break;
//                        default:
//                            // Trường hợp không có giá trị phù hợp
//                            query.append(" ");
//                            break;
//                    }
//                }
//                //tìm kiếm bằng brand
//                if(fieldName.equals("idBrand") && value != null){
//                    query.append(" and p.brand in (SELECT p2.brand FROM Products p2 WHERE p2.productId = ").append(value).append(" ) ");
//                }
//                //tìm kiếm bằng CPU
//                if(fieldName.equals("cpu") && value != null){
//                    query.append(" and pd.cpuTechnology like '%").append(value).append("%' ");
//                }
//                //tìm kiếm bằng
//                if(fieldName.equals("ram") && value != null){
//                    query.append(" and pd.ramCapacity = ").append(value).append(" ");
//                }
//                //tìm kiếm bằng harddrive
//                if(fieldName.equals("hardDrive") && value != null){
//                    query.append(" and pd.hardDriveType like '%").append(value).append("%' ");
//                }
//                //tìm kiếm bằng screensize
//                if(fieldName.equals("screenSize") && value != null){
//                    switch (value.toString()) {
//                        case "BETWEEN_1517":
//                            query.append(" AND pd.screenSize BETWEEN 15 AND 17 ");
//                            break;
//                        case "BETWEEN_1415":
//                            query.append(" AND pd.screenSize BETWEEN 14 AND 15 ");
//                            break;
//                        case "BELOW_14":
//                            query.append(" AND pd.screenSize < 14 ");
//                            break;
//                        default:
//                            // Trường hợp không có giá trị phù hợp
//                            query.append(" ");
//                            break;
//                    }
//                }
//            }
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//        return query;
//    }

    public StringBuilder setQueryCheckbox(Product_ProductSearchCheckBoxDTO productSearchCheckBoxDTO) {
        StringBuilder query = new StringBuilder(" ");
        try {
            Field[] fields = Product_ProductSearchCheckBoxDTO.class.getDeclaredFields();
            for (Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();
                Object value = item.get(productSearchCheckBoxDTO);

                // Kiểm tra nếu value là List và không rỗng
                if (value instanceof List<?> values && !values.isEmpty()) {
                    query.append(" AND (");

                    for (int i = 0; i < values.size(); i++) {
                        Object singleValue = values.get(i);

                        if (fieldName.equals("price") && singleValue != null) {
                            switch (singleValue.toString()) {
                                case "BETWEEN_15_AND_20":
                                    query.append(" p.price BETWEEN 15000000 AND 20000000 ");
                                    break;
                                case "BETWEEN_10_AND_15":
                                    query.append(" p.price BETWEEN 10000000 AND 15000000 ");
                                    break;
                                case "BELOW_10":
                                    query.append(" p.price < 10000000 ");
                                    break;
                                case "BETWEEN_25_AND_30":
                                    query.append(" p.price BETWEEN 25000000 AND 30000000 ");
                                    break;
                                case "ABOVE_30":
                                    query.append(" p.price > 30000000 ");
                                    break;
                                case "BETWEEN_20_AND_25":
                                    query.append(" p.price BETWEEN 20000000 AND 25000000 ");
                                    break;
                                default:
                                    break;
                            }
                        }

                        if (fieldName.equals("idBrand") && singleValue != null) {
                            query.append(" p.brand in (SELECT p2.brand FROM Products p2 WHERE p2.productId = ").append(singleValue).append(" ) ");
                        }

                        if (fieldName.equals("cpu") && singleValue != null) {
                            query.append(" pd.cpuTechnology LIKE '%").append(singleValue).append("%' ");
                        }

                        if (fieldName.equals("ram") && singleValue != null) {
                            query.append(" pd.ramCapacity = ").append(singleValue).append(" ");
                        }

                        if (fieldName.equals("hardDrive") && singleValue != null) {
                            query.append(" pd.hardDriveType LIKE '%").append(singleValue).append("%' ");
                        }

                        if (fieldName.equals("screenSize") && singleValue != null) {
                            switch (singleValue.toString()) {
                                case "BETWEEN_1517":
                                    query.append(" pd.screenSize BETWEEN 15 AND 17 ");
                                    break;
                                case "BETWEEN_1415":
                                    query.append(" pd.screenSize BETWEEN 14 AND 15 ");
                                    break;
                                case "BELOW_14":
                                    query.append(" pd.screenSize < 14 ");
                                    break;
                                default:
                                    break;
                            }
                        }

                        if (i < values.size() - 1) {
                            query.append(" OR ");
                        }
                    }

                    query.append(")");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return query;
    }


// phan trang product
//    @Override
//    public Page<Product_DisplayForHomePageDTO> findAllProductsByPage(int pageNo, int pageSize) {
//        Pageable pageable = PageRequest.of(pageNo,pageSize);
//        List<ProductsEntity> productsEntities = productRepository.getAllProducts(pageable);
//        List<Product_DisplayForHomePageDTO> rs = new ArrayList<>();
//        for (ProductsEntity productsEntity : productsEntities) {
//            Product_DisplayForHomePageDTO dto = modelMapper.map(productsEntity, Product_DisplayForHomePageDTO.class);
//            rs.add(dto);
//        }
//        Page<Product_DisplayForHomePageDTO> page = new PageImpl<>(rs);
//        return page;
//    }


}
