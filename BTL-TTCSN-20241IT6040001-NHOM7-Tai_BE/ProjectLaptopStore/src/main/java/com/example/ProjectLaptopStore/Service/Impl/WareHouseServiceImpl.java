package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.example.ProjectLaptopStore.Entity.WareHouseEntity;
import com.example.ProjectLaptopStore.Repository.WareHouseRepository;
import com.example.ProjectLaptopStore.Service.WareHouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class WareHouseServiceImpl implements WareHouseService {

    @Autowired
    private WareHouseRepository wareHouseRepository;
    @Override
    public List<WareHouseEntity> getListWareHouse() {
        List<WareHouseEntity> listWareHouse = wareHouseRepository.findByStatus(Status_Enum.active);
        return listWareHouse;
    }

    @Override
    public void createWareHouse(WareHouseEntity wareHouseNew) {
        WareHouseEntity wareHouseEntity = new WareHouseEntity();
        wareHouseRepository.createWareHouse(wareHouseNew, wareHouseEntity);
    }

    @Override
    public void updateWareHouse(WareHouseEntity wareHouseNew) {
        WareHouseEntity wareHouseEntity = wareHouseRepository.findById(wareHouseNew.getWarehouseID()).get();
        wareHouseRepository.updateWareHouse(wareHouseNew, wareHouseEntity);
    }

    @Override
    public void deleteWareHouse(Integer id) {
        WareHouseEntity wareHouseEntity = wareHouseRepository.findById(id).get();
        wareHouseRepository.deleteWareHouse(wareHouseEntity);
    }

    @Override
    public WareHouseEntity getWareHouseById(Integer id) {
        return wareHouseRepository.findById(id).get();
    }


}
