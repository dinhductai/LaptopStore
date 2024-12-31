package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.example.ProjectLaptopStore.Entity.SuppliersEntity;
import com.example.ProjectLaptopStore.Repository.Custom.SuppliersRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface SuppliersRepository extends JpaRepository<SuppliersEntity,Integer> , SuppliersRepositoryCustom {
//    List<SuppliersEntity> findAll();
    //phương thuc tim nha cung cap theo ID
    List<SuppliersEntity> findBySupplierIDIn(Long[] ids);
//    void deleteBySupplierIDIn(Long[] ids);
    //phuong thuc tim nha cung cap theo status
    List<SuppliersEntity> findByStatus(Status_Enum status);
}
