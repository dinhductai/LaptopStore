package com.example.ProjectLaptopStore.Repository;

import com.example.ProjectLaptopStore.Entity.ExportReceiptEntity;
import com.example.ProjectLaptopStore.Repository.Custom.ExportReceiptsRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExportReceiptsRepository extends JpaRepository<ExportReceiptEntity,Integer>, ExportReceiptsRepositoryCustom {
}
