package com.pojo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Doom {
    private int id;
    private int name;//宿舍名
    private Room room;//这个寝室属于哪一栋
    private Set<RepairRecord> repairRecords = new HashSet<>();

    private Set<Student> studentList = new HashSet<>();//所住学生

    public Set<Student> getStudentList() {
        return studentList;
    }

    public void setStudentList(Set<Student> studentList) {
        this.studentList = studentList;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getName() {
        return name;
    }

    public void setName(int name) {
        this.name = name;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public Set<RepairRecord> getRepairRecords() {
        return repairRecords;
    }

    public void setRepairRecords(Set<RepairRecord> repairRecords) {
        this.repairRecords = repairRecords;
    }
}
