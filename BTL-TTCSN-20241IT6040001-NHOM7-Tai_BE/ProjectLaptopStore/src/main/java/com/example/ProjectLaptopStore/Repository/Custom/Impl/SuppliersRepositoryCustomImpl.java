package com.example.ProjectLaptopStore.Repository.Custom.Impl;

import com.example.ProjectLaptopStore.DTO.Supplier_FindTopSupplierDTO;
import com.example.ProjectLaptopStore.DTO.SupplierDTO;
import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.example.ProjectLaptopStore.Entity.SuppliersEntity;
import com.example.ProjectLaptopStore.Repository.Custom.SuppliersRepositoryCustom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Transactional
@Repository
public class SuppliersRepositoryCustomImpl implements SuppliersRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Supplier_FindTopSupplierDTO> listTopSuppliers() {
        String query = "SELECT s.SupplierName, s.Address, s.PhoneNumber, s.Email, s.TaxCode, s.Website, s.Representative, s.PartnershipStartDate " +
                "FROM Suppliers s";
        Query queryNative = entityManager.createNativeQuery(query);
        List<Supplier_FindTopSupplierDTO> list = new ArrayList<>();
        List<Object[]> resultQuery = queryNative.getResultList();
        for (Object[] rowOfResult : resultQuery) {
            Supplier_FindTopSupplierDTO dto = new Supplier_FindTopSupplierDTO(
                    (String) rowOfResult[0],
                    (String) rowOfResult[1],
                    (String) rowOfResult[2],
                    (String) rowOfResult[3],
                    (String) rowOfResult[4],
                    (String) rowOfResult[5],
                    (String) rowOfResult[6],
                    (Date) rowOfResult[7]
            );
            list.add(dto);
        }
        return list;
    }

    @Override
    public void createSupplier(SupplierDTO supplierNew,SuppliersEntity suppliersEntity) {
        setData(supplierNew,suppliersEntity,1);
    }

    @Override
    public void updateSupplier(SupplierDTO supplierUpdate, SuppliersEntity suppliersEntity) {
        setData(supplierUpdate,suppliersEntity,2);
    }

    @Override
    public void deleteSupplier(SuppliersEntity suppliersEntity) {
        suppliersEntity.setStatus(Status_Enum.inactive);
        entityManager.merge(suppliersEntity);
        entityManager.flush();
    }

    public void setData(SupplierDTO supplierNew, SuppliersEntity suppliersEntity,Integer task){
        suppliersEntity.setSupplierName(supplierNew.getSupplierName());
        suppliersEntity.setAddress(supplierNew.getAddress());
        suppliersEntity.setPhoneNumber(supplierNew.getPhoneNumber());
        suppliersEntity.setEmail(supplierNew.getEmail());
        suppliersEntity.setTaxCode(supplierNew.getTaxcode());
        suppliersEntity.setWebsite(supplierNew.getWebsite());
        suppliersEntity.setRepresentative(supplierNew.getRepresentative());
        suppliersEntity.setPartnershipStartDate(supplierNew.getPartnershipStartDate());
        if(task==1){
            entityManager.persist(suppliersEntity);
        }
        else{
            entityManager.merge(suppliersEntity);
            entityManager.flush();
        }
    }
}
