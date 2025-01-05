package com.example.ProjectLaptopStore.Repository.JDBC;


import java.util.List;

//repository custom
public interface JdbcRepository<T,ID> {
    List<T> findAllCustom();
    T findByIdCustom(ID id);
    void saveCustom(T tClass);

}
