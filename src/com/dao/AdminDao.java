package com.dao;

import com.pojo.Admin;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


public interface AdminDao {

    public Admin findUserByUserName(String username);
    public int addUser(Admin user);
    public int delete(String ids);
    public List<Admin> get_User_List(Map<String, Object> querymap);
    public Integer getCount(Map<String, Object> querymap);
    public int updateUser(Admin user);
    public int updatePassword(Admin user);

}
