package com.example.ProjectLaptopStore.Convert;

import com.example.ProjectLaptopStore.DTO.Product_ProductSearchCheckBoxDTO;
import com.example.ProjectLaptopStore.Util.MapUtil;
import org.springframework.stereotype.Component;
import org.springframework.util.MultiValueMap;

import java.util.List;
import java.util.Map;

@Component
public class ProductCheckboxConverter {
    public Product_ProductSearchCheckBoxDTO toProductCheckboxBuilder(MultiValueMap<String,Object> params){
        Product_ProductSearchCheckBoxDTO productProductSearchCheckBoxDTO = Product_ProductSearchCheckBoxDTO.builder()
                .idBrand(MapUtil.getObject(params,"idBrand", List.class))
                .price(MapUtil.getObject(params,"price",List.class))
                .cpu(MapUtil.getObject(params,"cpu", List.class))
                .ram(MapUtil.getObject(params,"ram",List.class))
                .hardDrive(MapUtil.getObject(params,"hardDrive", List.class))
                .demand(MapUtil.getObject(params,"demand", List.class))
                .screenSize(MapUtil.getObject(params,"screenSize",List.class))
                .build();
        return productProductSearchCheckBoxDTO;
    }
}
