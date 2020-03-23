package com.util;

import com.pojo.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class Hibernate_cfg {
    private SessionFactory sessionFactory;
    private Session session;
    private Transaction transaction;
    public static final Configuration cfg;
    public static final SessionFactory sf;
    static{

        cfg = new Configuration();
        cfg.configure();
        cfg.addClass(Doom.class);
        cfg.addClass(RoomTeacher.class);
        cfg.addClass(Student.class);

        cfg.addClass(Admin.class);
        cfg.addClass(Room.class);
        cfg.addClass(Record.class);
        cfg.addClass(Clazz.class);
        cfg.addClass(UserOperateLog.class);
        cfg.addClass(Post.class);
        cfg.addClass(RepairRecord.class);
        sf = cfg.buildSessionFactory();
    }
    public static Session openSession(){
        return sf.openSession();
    }
    public void destorySession(){
        transaction.commit();
        session.close();
        sessionFactory.close();
    }
    public static Session getCurrentSession(){
        return sf.getCurrentSession();
    }

}
