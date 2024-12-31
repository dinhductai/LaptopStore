package com.example.ProjectLaptopStore.Service;

import com.example.ProjectLaptopStore.DTO.OrderDetail_CountQuantityProductPerMonthDTO;
import com.example.ProjectLaptopStore.DTO.OrderDetail_displayForStatusDTO;

import java.util.List;

public interface OrderDetailService {
    List<OrderDetail_CountQuantityProductPerMonthDTO> listCountQuantityProductPerMonth();
    Integer getQuantityProductCurrentMonthAtService();

}
