package com.service;

import com.pojo.Clazz;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository("clazzService")
public class ClazzService {
    @Resource(name="clazzServiceImpl")
    ClazzServiceImpl clazzServiceImpl;
    public List<Clazz> query(String conditon, List list) throws Exception {
        return clazzServiceImpl.query(conditon,list);
    }
    public Clazz queryById(int id){
        return clazzServiceImpl.get(id);
    }
}
