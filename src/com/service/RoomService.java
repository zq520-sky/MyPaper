package com.service;

import com.pojo.Room;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Repository("roomService")
public class RoomService {
    @Resource
    RoomServiceImpl roomImpl;
    public List query() throws Exception {
        List list = new ArrayList();
        return roomImpl.query(null,list);
    }
    public Room queryById(int id){
        return roomImpl.get(id);
    }

}
