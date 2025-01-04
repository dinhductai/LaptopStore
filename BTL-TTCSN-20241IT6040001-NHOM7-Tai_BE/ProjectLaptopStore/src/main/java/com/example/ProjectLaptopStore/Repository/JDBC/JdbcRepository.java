package com.example.ProjectLaptopStore.Repository.JDBC;


import java.util.List;

//repository custom
public interface JdbcRepository<T> {
    List<T> findAllCustom();
}
