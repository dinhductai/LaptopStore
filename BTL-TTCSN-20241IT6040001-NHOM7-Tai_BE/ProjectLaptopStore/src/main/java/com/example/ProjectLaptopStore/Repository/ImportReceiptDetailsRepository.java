package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.ImportReceiptDetailEntity;
import com.example.ProjectLaptopStore.Entity.ImportReceiptEntity;
import com.example.ProjectLaptopStore.Repository.Custom.ImportReceiptDetailsRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImportReceiptDetailsRepository extends JpaRepository<ImportReceiptDetailEntity,Integer>, ImportReceiptDetailsRepositoryCustom {
}
