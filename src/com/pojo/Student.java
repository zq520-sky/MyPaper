package com.pojo;

import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Set;

@Component
public class Student implements Serializable {//学生

    private Integer id;
    private Integer status;//状态
    private String username;//用户名
    private String clazzId;//班级号
    private String sno;//学号唯一
    private String password;//密码
    private String gender;//性别
    private String telephone;//电话
    private Clazz clazz;//一个学生对应一个班级


    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }

    private Admin admin;
    public Doom getDoom() {
        return doom;
    }

    public void setDoom(Doom doom) {
        this.doom = doom;
    }

    private Room room;//所属寝室栋数

    private Doom doom;

    public Set<Record> getRecords() {
        return records;
    }

    public void setRecords(Set<Record> records) {
        this.records = records;
    }

    private Set<Record> records;//一个学生对应对个记录



    public Clazz getClazz() {
        return clazz;
    }

    public void setClazz(Clazz clazz) {
        this.clazz = clazz;
    }

    private RoomTeacher roomTeachers;//多个学生对应一个宿管

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }





    public Student() {
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getClazzId() {
        return clazzId;
    }

    public void setClazzId(String clazzId) {
        this.clazzId = clazzId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }


    public String getTelephone() {
        return telephone;
    }



    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public RoomTeacher getRoomTeachers() {
        return roomTeachers;
    }

    public void setRoomTeachers(RoomTeacher roomTeachers) {
        this.roomTeachers = roomTeachers;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}