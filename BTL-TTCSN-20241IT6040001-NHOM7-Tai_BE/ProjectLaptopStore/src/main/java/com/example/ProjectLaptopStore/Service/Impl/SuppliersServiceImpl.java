package com.example.ProjectLaptopStore.Service.Impl;

import com.example.ProjectLaptopStore.DTO.Supplier_FindTopSupplierDTO;
import com.example.ProjectLaptopStore.DTO.SupplierDTO;
import com.example.ProjectLaptopStore.Entity.Enum.Status_Enum;
import com.example.ProjectLaptopStore.Entity.JDBC.SuppliersJDBCEntity;
import com.example.ProjectLaptopStore.Entity.SuppliersEntity;
import com.example.ProjectLaptopStore.Repository.Custom.Impl.SuppliersJDBCRepositoryImpl;
import com.example.ProjectLaptopStore.Repository.SuppliersJDBCRepository;
import com.example.ProjectLaptopStore.Repository.SuppliersRepository;
import com.example.ProjectLaptopStore.Service.SuppliersService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class SuppliersServiceImpl implements SuppliersService {
    @Autowired
    private SuppliersRepository suppliersRepository;

    private SuppliersJDBCRepositoryImpl suppliersJDBCRepositoryImpl = new SuppliersJDBCRepositoryImpl();
    @Autowired
    private ModelMapper modelMapper;

    @Override
    public List<Supplier_FindTopSupplierDTO> listTopSupplier() {
        List<Supplier_FindTopSupplierDTO> result = suppliersRepository.listTopSuppliers();
        return result;
    }

    @Override
    public void createSupplier(SupplierDTO supplierNew) {
        SuppliersEntity suppliersEntity = new SuppliersEntity();
        suppliersRepository.createSupplier(supplierNew,suppliersEntity);
    }

    @Override
    public void deleteSupplier(Long[] ids) {
        List<SuppliersEntity> listSupplierDel = suppliersRepository.findBySupplierIDIn(ids);
        for(SuppliersEntity suppliersDel : listSupplierDel){
            suppliersRepository.deleteSupplier(suppliersDel);
        }
    }

    @Override
    public void updateSupplier(SupplierDTO supplierUpdate) {
        SuppliersEntity suppliersEntity = suppliersRepository.findById(supplierUpdate.getSupplierId()).get();
        suppliersRepository.updateSupplier(supplierUpdate, suppliersEntity);
    }



    @Override
    //kien thuc spring data
    public List<SuppliersEntity> getListSupplier() {
        return suppliersRepository.findByStatus(Status_Enum.active);
    }

    @Override
    public SuppliersEntity getSupplierByID(Integer supplierId) {
        return suppliersRepository.findById(supplierId).get();
    }

    @Override
    public List<SuppliersJDBCEntity> getAllSuppliersJDBC() {
        return suppliersJDBCRepositoryImpl.findAllCustom();
    }

    @Override
    public void createSupplierJDBC(SupplierDTO supplierNew) {
        SuppliersJDBCEntity suppliersJDBCEntity = modelMapper.map(supplierNew, SuppliersJDBCEntity.class);
        suppliersJDBCRepositoryImpl.saveCustom(suppliersJDBCEntity);
    }
}
