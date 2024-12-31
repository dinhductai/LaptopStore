package com.example.ProjectLaptopStore.Convert;

import com.example.ProjectLaptopStore.DTO.ProductDetailDTO;
import com.example.ProjectLaptopStore.Entity.ContentEntity;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.swing.text.html.parser.ContentModel;
import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.List;

@Component
public class ContentConverter {
    @Autowired
    private ModelMapper modelMapper;
    public ContentEntity toContentEntity(ProductDetailDTO productNew, ContentEntity contentEntity) {
        StringBuilder contentBuilder = new StringBuilder();

//        // Danh sách các trường cần loại trừ
//        List<String> excludedFields = Arrays.asList("productId", "supplierId", "productDescriptionId");
//        //Sử dụng Reflection
//        // Lặp qua các trường trong ProductDetailDTO
//        Field[] fields = ProductDetailDTO.class.getDeclaredFields();
//        for (Field field : fields) {
//            if (excludedFields.contains(field.getName())) {
//                continue; // Bỏ qua các trường trong danh sách loại trừ
//            }
//            field.setAccessible(true); // Đảm bảo có thể truy cập
//            try {
//                Object value = field.get(productNew);
//                if (value != null) {
//                    contentBuilder.append(value.toString());
//                }
//            } catch (IllegalAccessException e) {
//                e.printStackTrace(); // Xử lý lỗi nếu không truy cập được trường
//            }
//        }
        // Thêm dữ liệu từ ProductDetailDTO
        contentBuilder.append("Laptop ").append(productNew.getProductName()).append(", ");
        contentBuilder.append("Brand ").append(productNew.getProductBrand()).append(", ");
        contentBuilder.append("Model ").append(productNew.getModel()).append(", ");
        contentBuilder.append("Price ").append(productNew.getPrice()).append(", ");
        contentBuilder.append("Stock Quantity ").append(productNew.getStockQuantity()).append(", ");
        contentBuilder.append("Release Date").append(productNew.getReleaseDate()).append(", ");
        contentBuilder.append("Warranty Period ").append(productNew.getWarrantyPeriod()).append(", ");
        contentBuilder.append("CPU ").append(productNew.getCpuCompany()).append(" ")
                .append(productNew.getCpuTechnology()).append(" ")
                .append(productNew.getCpuType()).append(", ");
        contentBuilder.append("RAM ").append(productNew.getRamCapacity()).append("GB, ")
                .append("Type ").append(productNew.getRamType()).append(", ");
        contentBuilder.append("Screen ").append(productNew.getScreenSize()).append(", ")
                .append("Resolution ").append(productNew.getResolution()).append(", ");
        contentBuilder.append("Storage ").append(productNew.getHardDriveType()).append(", ")
                .append("Capacity ").append(productNew.getCapacity()).append("GB, ");
        contentBuilder.append("Graphics Card ").append(productNew.getVgaBrand()).append(" ")
                .append(productNew.getVgaFullName()).append(", ");
        contentBuilder.append("OS ").append(productNew.getOs()).append(" Version ").append(productNew.getVersion()).append(", ");
        contentBuilder.append("Battery ").append(productNew.getBatteryType()).append(" Capacity ")
                .append(productNew.getBatteryCapacity()).append("mAh, ");
        contentBuilder.append("Weight ").append(productNew.getProductWeight()).append("kg, ");
        contentBuilder.append("Material ").append(productNew.getMaterial()).append(", ");
        contentBuilder.append("Origin ").append(productNew.getOrigin()).append(", ");
        contentBuilder.append("Color ").append(productNew.getColor());
        contentEntity.setContent(contentBuilder.toString());
        return contentEntity;
    }
}
