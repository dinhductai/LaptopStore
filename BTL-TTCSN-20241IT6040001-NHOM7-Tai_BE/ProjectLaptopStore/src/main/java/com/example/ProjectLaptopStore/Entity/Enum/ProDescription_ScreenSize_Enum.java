package com.example.ProjectLaptopStore.Entity.Enum;

import java.util.HashMap;
import java.util.Map;

public enum ProDescription_ScreenSize_Enum {
    BELOW_14("Dưới 14 inch"),
    BETWEEN_1415( "Từ 14-15 inch "),
    BETWEEN_1517("Từ 15-17 inch");

    private final String description;

    ProDescription_ScreenSize_Enum(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
    public static Map<String,String> getScreenSize() {
        Map<String,String> screenSize = new HashMap<>();
        for(ProDescription_ScreenSize_Enum screenSizeEnum: ProDescription_ScreenSize_Enum.values()) {
            screenSize.put(screenSizeEnum.toString(),screenSizeEnum.getDescription());
        }
        return screenSize;
    }
}
