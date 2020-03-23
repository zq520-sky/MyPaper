package com.pojo;

import org.springframework.stereotype.Component;

import java.util.Set;

@Component
public class Clazz {
    private int id;//主键
    private int number;//班级号
    private String profess;//专业






    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getProfess() {
        return profess;
    }

    public void setProfess(String profess) {
        this.profess = profess;
    }
}
