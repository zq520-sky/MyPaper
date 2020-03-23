package com.service;

import com.pojo.Admin;
import com.pojo.Student;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class StudentService {


        @Resource(name="studentServiceImpl")
        private StudentServiceImpl studentServiceImpl;

        public Student login(String sno,String password){
        	return (Student) studentServiceImpl.query(sno, password);
        }
        public List query(String condition,List ls) throws Exception {
            return studentServiceImpl.query(condition,ls);
        }
        public void add(Student stu){
            studentServiceImpl.save(stu);
        }
        public void update(Student stu){
            studentServiceImpl.update(stu);
        }

        public void updateByCondition(String condition,List list){
            studentServiceImpl.updateByCondition(condition,list);
        }
        public void deleteById(int id){
           studentServiceImpl.deleteById(id);
        }

        public Student queryById(int id){
            return studentServiceImpl.get(id);
        }

        public Student queryByOne(String condition,String pwd) throws Exception {
            return studentServiceImpl.query(condition, pwd);
        }
        public void updateByArray(String condition, List list, List ids){
            studentServiceImpl.updateByArray(condition,list,ids);
        }

        public List<Student> queryByCondition(String condition,List list)throws Exception{
            return studentServiceImpl.queryByCondition(condition,list);
        }
}
