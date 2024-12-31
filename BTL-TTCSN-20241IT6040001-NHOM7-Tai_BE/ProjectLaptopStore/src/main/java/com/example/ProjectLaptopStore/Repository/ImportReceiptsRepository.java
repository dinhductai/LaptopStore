package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.ImportReceiptEntity;
import com.example.ProjectLaptopStore.Repository.Custom.ImportReceiptsRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImportReceiptsRepository extends JpaRepository<ImportReceiptEntity,Integer>, ImportReceiptsRepositoryCustom {
}
