package com.example.ProjectLaptopStore.Config;

import com.example.ProjectLaptopStore.Convert.EnumConverter;
import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import org.apache.commons.beanutils.ConvertUtils;

public class BeanUtilsConfig {
    public static void registerEnumConverter() {
        ConvertUtils.register(new EnumConverter(Status_Enum.class), Status_Enum.class);
    }
}
