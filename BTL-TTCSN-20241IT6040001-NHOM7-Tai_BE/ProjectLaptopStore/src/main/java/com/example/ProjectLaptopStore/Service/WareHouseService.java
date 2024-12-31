package com.example.ProjectLaptopStore.Service;

import com.example.ProjectLaptopStore.Entity.WareHouseEntity;

import java.util.List;

public interface WareHouseService {
    List<WareHouseEntity> getListWareHouse();
    void createWareHouse(WareHouseEntity wareHouse);
    void updateWareHouse(WareHouseEntity wareHouse);
    void deleteWareHouse(Integer id);
    WareHouseEntity getWareHouseById(Integer id);
}
