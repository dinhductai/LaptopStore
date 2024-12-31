package com.example.ProjectLaptopStore.Util;

import java.util.List;

public class NullUtill {
    public Boolean checkListNull(List<Object> listInput){
        if(listInput == null || listInput.size() == 0 || listInput.isEmpty()){
            return false;
        }
        else return true;
    }

    public Boolean checkItemNull(Object itemInput){
        if(itemInput == null || itemInput.toString().isEmpty()){
            return false;
        }
        else return true;
    }
}
