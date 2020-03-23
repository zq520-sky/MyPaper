package com.service;

import com.dao.StudentDao;
import com.pojo.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("studentServiceImpl")
public class StudentServiceImpl extends EntityDaoImpl<Student>{

}
