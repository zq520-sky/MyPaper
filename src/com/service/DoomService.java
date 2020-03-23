package com.service;

import com.pojo.Doom;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Repository("doomService")
public class DoomService {
    @Resource(name="doomServiceImpl")
    DoomServiceImpl doomServiceImpl;
    public List<Doom> query()throws Exception{
        List list = new ArrayList();
       return doomServiceImpl.query(null,list);
    }
    public Doom queryById(int id){
        return doomServiceImpl.get(id);
    }

    public Doom queryDoom(int d_id)throws Exception{
        return doomServiceImpl.queryDoom(d_id);
    }
}
