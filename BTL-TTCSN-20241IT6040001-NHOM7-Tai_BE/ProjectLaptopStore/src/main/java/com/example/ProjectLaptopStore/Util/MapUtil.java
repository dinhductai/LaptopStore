package com.example.ProjectLaptopStore.Util;

import org.springframework.util.MultiValueMap;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import static org.apache.tomcat.util.http.FastHttpDateFormat.parseDate;

//lớp này dùng để lấy các phần tử trong map (được lấy từ giao diện) và chuyển đổi kiểu dữ liệu
public class MapUtil {
    //xử lý đơn và đa giá trị
    public static <T> T getObject(MultiValueMap<String, Object> params, String key, Class<T> tClass) {
        List<Object> values = params.get(key);  // Lấy danh sách giá trị theo key
        if (values == null || values.isEmpty()) {
            return null;
        }

        if (tClass.equals(List.class)) {
            return tClass.cast(values);  // Trả về danh sách nếu kiểu là List
        }

        Object value = values.get(0);  // Lấy giá trị đầu tiên nếu không phải danh sách

        if (value != null) {
            if (tClass.equals(Long.class)) {
                return tClass.cast(Long.valueOf(value.toString()));
            } else if (tClass.equals(Integer.class)) {
                return tClass.cast(Integer.valueOf(value.toString()));
            } else if (tClass.equals(Double.class)) {
                return tClass.cast(Double.valueOf(value.toString()));
            } else if (tClass.equals(Date.class)) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    return tClass.cast(sdf.parse(value.toString()));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            } else if (tClass.equals(BigDecimal.class)) {
                return tClass.cast(new BigDecimal(value.toString()));
            } else if (tClass.equals(String.class)) {
                return tClass.cast(value.toString());
            }
        }
        return null;
    }

//chỉ có thể sử lý map với đơn giá trị
//        Object obj = params.getOrDefault(key,null);
//        if(obj!=null){
//            if(tClass.getTypeName().equals("java.lang.Long")){
//                obj = obj != ""? Long.valueOf(obj.toString()) :null;
//            }
//            else if(tClass.getTypeName().equals("java.lang.Integer")){
//                obj =obj != ""? Integer.valueOf(obj.toString()) : null;
//            }
//            else if(tClass.getTypeName().equals("java.lang.Double")){
//                obj =obj != ""? Double.valueOf(obj.toString()) : null;
//            }
//            //dính lỗi Cannot cast java.lang.String to java.util.Date
////            else if(tClass.getTypeName().equals("java.lang.Date")){
////                obj =obj != ""? parseDate(obj.toString()) : null;
////            }
//            else if(tClass.getTypeName().equals("java.util.Date")){
//                // Chuyển đổi chuỗi thành Date (ví dụ 2024-10-06)
//                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Định dạng ngày phù hợp với chuỗi đầu vào
//                try {
//                    obj = obj != ""? sdf.parse(obj.toString()) : null;
//                } catch (ParseException e) {
//                    e.printStackTrace();
//                    obj = null; // Hoặc xử lý lỗi theo cách bạn muốn
//                }
//            }
//            else if(tClass.getTypeName().equals("java.lang.String")){
//                obj = obj.toString();
//            }
//            else if (tClass.getTypeName().equals("java.math.BigDecimal")) {
//                obj = new BigDecimal(obj.toString());
//            }
//            return tClass.cast(obj);
//        }
//        return null;

}
