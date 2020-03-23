package com.service;

import com.dao.TeacherDao;
import com.pojo.RoomTeacher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("teacherServiceImpl")
public class TeacherServiceImpl extends EntityDaoImpl<RoomTeacher>{


}
