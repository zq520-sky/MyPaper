package com.pojo;

public class Room {
    private int id;
    private String name;//哪一栋
    private Clazz clazz;//属于哪个班级
    private RoomTeacher roomTeacher;

    public int getId() {
        return id;
    }

    public RoomTeacher getRoomTeacher() {
        return roomTeacher;
    }

    public void setRoomTeacher(RoomTeacher roomTeacher) {
        this.roomTeacher = roomTeacher;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Clazz getClazz() {
        return clazz;
    }

    public void setClazz(Clazz clazz) {
        this.clazz = clazz;
    }
}
