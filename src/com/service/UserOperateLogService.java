package com.service;

import com.pojo.UserOperateLog;
import com.util.UserOperate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserOperateLogService {
    @Resource
    UserOperateLogImpl userOperateLogImpl;
    public void addLog(UserOperateLog userOperateLog){
        userOperateLogImpl.save(userOperateLog);
    }
    public List<UserOperateLog> queryAllLog(String condition,List ls)throws Exception{
        return userOperateLogImpl.query(condition,ls);
    }
    public List<UserOperateLog> queryByDate(String beginDate,String endDate){
        return userOperateLogImpl.dataRange(beginDate,endDate);
    }
}
