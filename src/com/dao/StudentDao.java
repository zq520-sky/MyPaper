package com.dao;

import com.pojo.Student;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 数据访问层-操控学生信息
 */

public interface StudentDao {

    public List<Student> get_Student_List(Map<String, Object> querymap);
    public Integer getCount(Map<String, Object> querymap);
    public int insertStudent(Student student);
    public int updateStudent(Student student);
    public Student findStudentByName(String name);
    public List<Student> findAll();
    public int deleteStudent(String ids);
    public int updatePassword(Student student);
    public int getAddress(Student student);
    public int getAdNumber(Student student);
    public int getLevel(Student student);
}
