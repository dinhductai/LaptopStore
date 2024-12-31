package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.ContentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface ContentRepository extends JpaRepository<ContentEntity, Integer> {
    ContentEntity findByProduct_ProductID(Integer productID);
}
