package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.DTO.OrderDetail_CountQuantityProductPerMonthDTO;
import com.example.ProjectLaptopStore.DTO.OrderDetail_displayForStatusDTO;
import com.example.ProjectLaptopStore.Repository.OrderDetailRepository;
import com.example.ProjectLaptopStore.Service.OrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
@Service
public class OrderDetailServiceImpl implements OrderDetailService {

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Override
    public List<OrderDetail_CountQuantityProductPerMonthDTO> listCountQuantityProductPerMonth() {
        List<OrderDetail_CountQuantityProductPerMonthDTO> result = orderDetailRepository.listCountQuantityProductPerMonth();
        return result;
    }

    @Override
    public Integer getQuantityProductCurrentMonthAtService() {
        Integer result = orderDetailRepository.getTotalQuantityProductCurrentMonth();
        return result;
    }

}
