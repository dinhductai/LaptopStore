package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.example.ProjectLaptopStore.Entity.WareHouseEntity;
import com.example.ProjectLaptopStore.Repository.Custom.WareHouseRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


public interface WareHouseRepository extends JpaRepository<WareHouseEntity,Integer> , WareHouseRepositoryCustom {
    WareHouseEntity findByWarehouseIDAndStatus(Integer warehouseID,Status_Enum status);
    List<WareHouseEntity> findByStatus(Status_Enum status);
}
