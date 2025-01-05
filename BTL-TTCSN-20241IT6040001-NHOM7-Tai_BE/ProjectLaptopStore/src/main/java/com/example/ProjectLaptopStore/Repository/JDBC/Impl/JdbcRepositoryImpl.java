package com.example.ProjectLaptopStore.Repository.JDBC.Impl;

import com.example.ProjectLaptopStore.AnnotationCustom.ColumnCustom;
import com.example.ProjectLaptopStore.AnnotationCustom.OneToManyCustom;
import com.example.ProjectLaptopStore.AnnotationCustom.TableCustom;
import com.example.ProjectLaptopStore.Mapper.ResultSetMapper;
import com.example.ProjectLaptopStore.Repository.JDBC.JdbcRepository;
import com.example.ProjectLaptopStore.Util.ConnectionUtil;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.sql.*;
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

    private String createSqlInsert(){
        Class<T> tClass = (Class<T>) ((ParameterizedType)getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        String tableName = "";
        if(tClass.isAnnotationPresent(TableCustom.class)){
            TableCustom tableCustom = tClass.getAnnotation(TableCustom.class);
            tableName = tableCustom.name();
        }
        //tạo các dấu , ? để map dl
        StringBuilder fields = new StringBuilder("");
        StringBuilder params = new StringBuilder("");
        for(Field field : tClass.getDeclaredFields()){
            if(fields.length() > 0 && !field.isAnnotationPresent(OneToManyCustom.class)){
                fields.append(",");
                params.append(",");
            }
            if(field.isAnnotationPresent(ColumnCustom.class)){
                ColumnCustom columnCustom = field.getAnnotation(ColumnCustom.class);
                fields.append(columnCustom.name());
                params.append("?");
            }
        }
        String sql = " Insert into "+ tableName +" ( "+fields+" ) values ( "+params+" ) ";
        return sql;
    }

    @Override
    public void saveCustom(T tClass) {
        try(Connection conn = ConnectionUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(createSqlInsert())){
            Field[] fields = tClass.getClass().getDeclaredFields();
            int index = 1;
            for(Field field : fields){
                field.setAccessible(true);
                if(!field.isAnnotationPresent(ColumnCustom.class)){
                    continue;
                }
                try {
                    Object value = field.get(tClass);

                    // Kiểm tra nếu là kiểu enum
                    if (field.getType().isEnum()) {
                        value = value != null ? value.toString() : null; // Chuyển enum thành chuỗi
                        ps.setObject(index, value);
                        index++;
                        continue;
                    }
                    ps.setObject(index, field.get(tClass));

                }catch (Exception e){
                    e.printStackTrace();
                    System.out.println("PreparedStatement has error");
                }
                index++;
            }
            ps.executeUpdate();
        }catch (Exception ex){
            ex.printStackTrace();
            System.out.println("Connect database error");
        }
    }
}
