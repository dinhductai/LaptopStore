package com.example.ProjectLaptopStore.Repository.Custom.Impl;

import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.example.ProjectLaptopStore.Entity.WareHouseEntity;
import com.example.ProjectLaptopStore.Repository.Custom.WareHouseRepositoryCustom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Repository
public class WareHouseRepositoryCustomImpl implements WareHouseRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;
    @Override
    public void createWareHouse(WareHouseEntity newWareHouse, WareHouseEntity wareHouseEntity) {
        setData(newWareHouse,wareHouseEntity,1);
    }

    @Override
    public void updateWareHouse(WareHouseEntity newWareHouse, WareHouseEntity wareHouseEntity) {
        setData(newWareHouse,wareHouseEntity,2);
    }

    @Override
    public void deleteWareHouse(WareHouseEntity wareHouseEntity) {
        wareHouseEntity.setStatus(Status_Enum.inactive);
    }



    void setData(WareHouseEntity newWareHouse,WareHouseEntity wareHouseEntity,Integer task) {
        wareHouseEntity.setWarehouseName(newWareHouse.getWarehouseName());
        wareHouseEntity.setAddress(newWareHouse.getAddress());
        wareHouseEntity.setWarehouseType(newWareHouse.getWarehouseType());
        wareHouseEntity.setStatus(Status_Enum.active);
        if(task==1) {
            entityManager.persist(wareHouseEntity);
        }
        else{
            entityManager.merge(wareHouseEntity);
            entityManager.flush();
        }
    }
}
