package com.example.ProjectLaptopStore.Repository.Custom;

import com.example.ProjectLaptopStore.DTO.OrderDetail_CountQuantityProductPerMonthDTO;

import java.util.List;

public interface OrderDetailRepositoryCustom {
    List<OrderDetail_CountQuantityProductPerMonthDTO> listCountQuantityProductPerMonth();
}
