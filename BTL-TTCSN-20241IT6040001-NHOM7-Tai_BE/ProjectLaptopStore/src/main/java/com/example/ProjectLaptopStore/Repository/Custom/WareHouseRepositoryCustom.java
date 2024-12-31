package com.example.ProjectLaptopStore.Repository.Custom;

import com.example.ProjectLaptopStore.Entity.WareHouseEntity;

public interface WareHouseRepositoryCustom {
    void createWareHouse(WareHouseEntity newWareHouse,WareHouseEntity wareHouseEntity);
    void updateWareHouse(WareHouseEntity newWareHouse,WareHouseEntity wareHouseEntity);
    void deleteWareHouse(WareHouseEntity wareHouseEntity);
}
