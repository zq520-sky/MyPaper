package com.service;

import com.pojo.Record;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Repository("recordService")
public class RecordService {
    @Resource(name = "recordServiceImpl")
    RecordServiceImpl recordImpl;
    public List query(String condition,List list) throws Exception {
       // List list = new ArrayList();
        return recordImpl.query(condition,list);
    }
    public void addRecord(Record record){
        recordImpl.save(record);
    }
    public Record queryById(int id){
        return recordImpl.query(id);
    }
    public void update(Record record){
        recordImpl.update(record);
    }
    public void updateByCondition(String condition,List values){
        recordImpl.updateByCondition(condition,values);
    }
    public void deleteById(int id){
        recordImpl.deleteById(id);
    }
}
