package com.service;

import com.pojo.Admin;
import com.pojo.RoomTeacher;
import com.pojo.Student;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class TeacherService {

    @Resource(name="teacherServiceImpl")
    private TeacherServiceImpl teacherServiceImpl;

    public RoomTeacher login(String sno,String password){
    	return (RoomTeacher) teacherServiceImpl.query(sno, password);
    }
    public List query() throws Exception {
        List list = new ArrayList();
        return teacherServiceImpl.query(null,list);
    }

    public void updateByCondition(String condition,List list){
        teacherServiceImpl.updateByCondition(condition,list);
    }
    public void add(RoomTeacher tea){
        teacherServiceImpl.save(tea);
    }
    public void deleteById(int id){
        teacherServiceImpl.deleteById(id);
    }
    public RoomTeacher queryById(int id){
        return (RoomTeacher) teacherServiceImpl.query(id);
    }
    public RoomTeacher query(String sno,String password){
        return teacherServiceImpl.query(sno,password);
    }

    public RoomTeacher get(int id){
        return teacherServiceImpl.get(id);
    }

    public void update(RoomTeacher roomTeacher){
        teacherServiceImpl.update(roomTeacher);
    }
    public List<RoomTeacher> queryByCondition(String condition,List ls)throws Exception{
        return teacherServiceImpl.query(condition,ls);
    }
}
