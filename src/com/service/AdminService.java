package com.service;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.pojo.Admin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.portlet.bind.annotation.RenderMapping;

import javax.annotation.Resource;
import java.util.List;

@Repository("adminService")
public class AdminService {

    @Resource(name="adminServiceImpl")
    private AdminServiceImpl adminImpl;

    public Admin login(String username,String password) {
        return adminImpl.query(username, password);
    }
    public Admin register(){
        Admin admin = new Admin();
        adminImpl.save(admin);
        return null;
    }
    public void updateByConditon(String condition1, List condition2){
        adminImpl.updateByCondition(condition1,condition2);
    }
    public Admin query(String sno,String password){
        return adminImpl.query(sno,password);
    }
    public Admin queryById(int id){
        return adminImpl.get(id);
    }
    public List<Admin> queryByCondition(String condition,List list)throws Exception{
        return adminImpl.query(condition,list);
    }
}
