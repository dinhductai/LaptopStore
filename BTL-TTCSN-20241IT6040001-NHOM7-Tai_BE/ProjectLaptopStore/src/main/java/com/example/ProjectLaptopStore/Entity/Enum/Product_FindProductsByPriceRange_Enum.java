package com.example.ProjectLaptopStore.Entity.Enum;

import java.util.*;

public enum Product_FindProductsByPriceRange_Enum {
    BELOW_10("Dưới 10 triệu"),
    BETWEEN_10_AND_15( "Từ 10 - 15 triệu"),
    BETWEEN_15_AND_20("Từ 15 - 20 triệu"),
    BETWEEN_20_AND_25( "Từ 20 - 25 triệu"),
    BETWEEN_25_AND_30("Từ 25 - 30 triệu"),
    ABOVE_30("Trên 30 triệu");// null có nghĩa là ko còn giới hạn ở trên

//    private final List<Integer> priceRange; // sử dụng list bởi vì mảng thì bị lỗi khi chuyển đổi qua json
    private final String description;

    Product_FindProductsByPriceRange_Enum( String description) {

        this.description = description;
    }



    public String getDescription() {
        return description;
    }

    public static Map<String, String> getPriceRanges() {
        Map<String,String> priceRanges = new HashMap<>();
        for (Product_FindProductsByPriceRange_Enum range : Product_FindProductsByPriceRange_Enum.values()) {
            priceRanges.put(range.toString(), range.getDescription());
        }
        return priceRanges;
    }


}
