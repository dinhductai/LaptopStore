package com.example.ProjectLaptopStore.Config;

import com.example.ProjectLaptopStore.AnnotationCustom.EnumeratedCustom;
import com.example.ProjectLaptopStore.Convert.EnumConverter;
import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import org.apache.commons.beanutils.ConvertUtils;

import java.lang.reflect.Field;

public class BeanUtilsConfig {
    public static void registerEnumConverter(Class<?> tClass) {
        for(Field field : tClass.getDeclaredFields()) {
            field.setAccessible(true);
            if(field.isAnnotationPresent(EnumeratedCustom.class)) {
                Class<?> type = field.getType();
                if(type.isEnum()){
                    Class<? extends Enum<?>> enumClass = (Class<? extends Enum<?>>) type;
                    ConvertUtils.register(new EnumConverter(enumClass), enumClass);
                }
            }
        }

    }
}
