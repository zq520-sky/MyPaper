package com.dao;


import com.pojo.RoomTeacher;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

public interface TeacherDao {

    public List<RoomTeacher> get_Teacher_List(Map<String, Object> querymap);
    public Integer getCount(Map<String, Object> querymap);
    public int insertTeacher(RoomTeacher teacher);
    public int updateTeacher(RoomTeacher teacher);
    public RoomTeacher findTeacherByName(String name);
    public List<RoomTeacher> findAll();
    public int deleteTeacher(String ids);
    public int updatePassword(RoomTeacher teacher);

}
