package com.pojo;

import com.Enum.OperationType;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.stereotype.Component;

import javax.persistence.*;
import java.util.Date;

@Component
public class UserOperateLog{
    /** 版本号 */
    private static final long serialVersionUID = 3322584679786620277L;

    /**  */
    private Integer id;


    /** 用户名 */
    private String userName;

    private String sno;

    /** 操作时间 */
    private Date createTime;

    /** 操作类型 */
    private String operationType;

    /** 操作描述 */
    private String operateDesc;

    /** 操作IP */
    private String ipAddress;



    /**
     * 获取
     *
     * @return
     */
    public Integer getId() {
        return this.id;
    }

    /**
     * 设置
     *
     * @param id
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 获取用户id
     *
     * @return 用户id
     */


    /**
     * 获取操作描述
     *
     * @return 操作描述
     */
    public String getOperateDesc() {
        return this.operateDesc;
    }

    /**
     * 设置操作描述
     *
     * @param operateDesc
     *          操作描述
     */
    public void setOperateDesc(String operateDesc) {
        this.operateDesc = operateDesc;
    }

    /**
     * 获取操作IP
     *
     * @return 操作IP
     */
    public String getIpAddress() {
        return this.ipAddress;
    }

    /**
     * 设置操作IP
     *
     * @param ipAddress
     *          操作IP
     */
    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    /**
     * 获取操作时间
     *
     * @return 操作时间
     */
    public Date getCreateTime() {
        return this.createTime;
    }

    /**
     * 设置操作时间
     *
     * @param createTime
     *          操作时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public String getOperationType() {
        return operationType;
    }

    public void setOperationType(String operationType) {
        this.operationType = operationType;
    }
}

