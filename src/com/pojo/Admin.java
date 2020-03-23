package com.pojo;

import org.springframework.stereotype.Component;

import java.util.Set;

//实体类用将实体放入component容器中
@Component
public class Admin {//管理员

    private Integer id;
    private String username;
    private String password;
    private String sno;//工号唯一
    private String gender;//所属年级
    private String email;
    private String telephone;
    private Integer status;
    private int address;//所管理宿舍
    private Set<RoomTeacher> roomTeachers;//管理员管理多个宿管

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public Set<RoomTeacher> getRoomTeachers() {
        return roomTeachers;
    }

    public void setRoomTeachers(Set<RoomTeacher> roomTeachers) {
        this.roomTeachers = roomTeachers;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public int getAddress() {
        return address;
    }

    public void setAddress(int address) {
        this.address = address;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", gender='" + gender + '\'' +
                ", email='" + email + '\'' +
                ", telephone='" + telephone + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
