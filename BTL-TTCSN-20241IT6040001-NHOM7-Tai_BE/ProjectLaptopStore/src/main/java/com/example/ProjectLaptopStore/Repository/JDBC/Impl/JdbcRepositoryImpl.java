package com.example.ProjectLaptopStore.Repository.JDBC.Impl;

import com.example.ProjectLaptopStore.AnnotationCustom.TableCustom;
import com.example.ProjectLaptopStore.Mapper.ResultSetMapper;
import com.example.ProjectLaptopStore.Repository.JDBC.JdbcRepository;
import com.example.ProjectLaptopStore.Util.ConnectionUtil;

import java.lang.reflect.ParameterizedType;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class JdbcRepositoryImpl<T> implements JdbcRepository<T> {
    @Override
    public List<T> findAllCustom() {
        Class<T> tClass = (Class<T>) ((ParameterizedType)getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        List<T> result = new ArrayList<T>();
        String tableName="";
        //kiểm tra xem entity có đc đánh dấu @table không
        if(tClass.isAnnotationPresent(TableCustom.class)) {
            //lấy tên bảng và set vào biến
            TableCustom tableCustom = tClass.getAnnotation(TableCustom.class);
            tableName = tableCustom.name();
        }
        String sql = "select * from " + tableName;
        ResultSetMapper<T> resultSetMapper = new ResultSetMapper<T>();
        try(Connection conn = ConnectionUtil.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)){
            result = resultSetMapper.mapRow(rs,tClass);
            if(result != null){
                return result;
            }else return new ArrayList<>();
        }catch (Exception ex){
            System.out.println("Connect database error");
            return null;
        }
    }
}
