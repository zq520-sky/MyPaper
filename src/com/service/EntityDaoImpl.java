package com.service;

import java.lang.reflect.ParameterizedType;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import org.joda.time.DateTime;
import com.pojo.Doom;
import com.pojo.UserOperateLog;
import com.util.Hibernate_cfg;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dao.entityDao;
import org.springframework.transaction.annotation.Transactional;


public class EntityDaoImpl<T> implements entityDao<T> {

    Class clasz;

    //锟斤拷梅锟斤拷偷锟绞碉拷锟斤拷锟斤拷锟�

    public EntityDaoImpl() {
        super();
        ParameterizedType clazz = (ParameterizedType)this.getClass().getGenericSuperclass();
        this.clasz = (Class<T>) clazz.getActualTypeArguments()[0];

    }

    @Override
    public T save(T entity) {//淇濆瓨
        // TODO Auto-generated method stub

        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        Transaction transaction = session.getTransaction();
        transaction.begin();
        session.merge(entity);
        session.flush();
        session.clear();
        transaction.commit();
        return entity;
    }

    @Override
    public T delete(T entity) {//鍒犻櫎
        // TODO Auto-generated method stub
        Session session = Hibernate_cfg.getCurrentSession();
        Transaction transaction = session.getTransaction();
        transaction.begin();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        session.delete(entity);
        session.flush();
        transaction.commit();
        return entity;
    }

  //  @Transactional(readOnly = false)
    @Override
    public T update(T entity) {//鏇存柊
        // TODO Auto-generated method stub
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        session.beginTransaction();
        session.update(entity);
        session.flush();
        session.clear();
        session.getTransaction().commit();
        return entity;
    }

    @Override
    public T get(int id) {//鏌ヨ
        // TODO Auto-generated method stub

        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        T t = (T) session.get(clasz, id);
        return t;
    }

    //锟斤拷锟斤拷锟斤拷询
    @Override
    public List<T> query(String condition,List<Object> values) throws Exception {
        // TODO Auto-generated method stub

        //from user as user where
        String hql = "from "+clasz.getName()+" as "+clasz.getSimpleName();//from file as file where file.user.id
        if(condition!=null&&!"".equals(condition)){
            hql = hql+" where "+condition;
        }
        System.out.print("hql");
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        Query query = session.createQuery(hql);
        if(values!=null&&values.size()>0){
            for(int index=0;index<values.size();index++){
                query.setParameter(index, values.get(index));
            }
        }
        return query.list();
    }

    //锟斤拷锟斤拷锟矫伙拷ID锟斤拷锟侥硷拷锟斤拷
    public T query(int userid) {
        // TODO Auto-generated method stub
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        String hql = "from "+clasz.getName()+" as "+clasz.getSimpleName()+" where "+clasz.getSimpleName()+".id=?";
        T t = (T) session.createQuery(hql).setParameter(0, userid).uniqueResult();
        return t;
    }
    //rows锟斤拷一页锟斤拷嗉革拷校锟絧ages锟角第硷拷页
    @Override
    public List<T> query(int pages, int rows,int id) {
        // TODO Auto-generated method stub
        String hql = "from Student file where file.id=?";
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        Query query = session.createQuery(hql).setParameter(0, id);
        query.setMaxResults(rows);
        query.setFirstResult((pages-1)*rows);
        List<T> t =  query.list();
        return t;
    }

    @Override
    public T query(String username, String password) {
        // TODO Auto-generated method stub
        //String name = clasz.getName();
        String hql = "from "+clasz.getName()+" as " +clasz.getSimpleName()+" where "+clasz.getSimpleName()+".sno=? and "+clasz.getSimpleName()+".password=? and "+clasz.getSimpleName()+".status=1";
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        Query query = session.createQuery(hql);
        query.setParameter(0, username);
        query.setParameter(1, password);
        T t = (T) query.uniqueResult();
        return t;
    }

    @Override
    public int getTotal(int id) {
        return 0;
    }

    public List<T> QueryByFilename(String condition) {
        // TODO Auto-generated method stub
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
       String hql="from Admin Student where Student.username like :name";
        Query query = session.createQuery(hql);
        query.setString("name", "%"+condition+"%");
        List<T> t = query.list();
        return t;
    }

    @Override
    public void save(int id, String FileName, String path, Long i, Date date) {

    }

    public void updateByCondition(String condition,List values) {
        String hql = "update " + clasz.getSimpleName();
        if (condition != null && !"".equals(condition)) {
            hql = hql + condition;
        }
        System.out.print(hql);
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        Transaction transaction = session.getTransaction();
        transaction.begin();
        Query query = session.createQuery(hql);
        if (values != null && values.size() > 0) {
            for (int index = 0; index < values.size(); index++) {
                query.setParameter(index, values.get(index));
            }
            query.executeUpdate();
            transaction.commit();
        }
    }
    public void deleteById(int id){
        String hql = "delete "+clasz.getSimpleName()+" where id="+id;
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        Transaction transaction = session.getTransaction();
        transaction.begin();
        Query query = session.createQuery(hql);
        query.executeUpdate();
        transaction.commit();
    }
    public T queryDoom(int d_id){
        String hql = "from "+clasz.getSimpleName()+" where id="+d_id;
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        Query query = session.createQuery(hql);
        T t = (T) query.uniqueResult();
        return t;
    }

    public void updateByArray(String condition,List list,List ids){
        String hql = "update " + clasz.getSimpleName();
        if (condition != null && !"".equals(condition)) {
            hql = hql + condition;
        }
        System.out.print("---------"+hql+"--------------");
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        Transaction transaction = session.getTransaction();
        transaction.begin();
        Query query = session.createQuery(hql);
        query.setParameter(0,list.get(0));
        query.setParameter(1,list.get(1));

        query.setParameterList("ids",ids);
        query.executeUpdate();
        transaction.commit();
        }
    public List<T> queryByCondition(String condition,List<Object> values) throws Exception {
        // TODO Auto-generated method stub

        //from user as user where
        String hql = "from "+clasz.getSimpleName();//from file as file where file.user.id
        if(condition!=null&&!"".equals(condition)){
            hql = hql+" where "+condition;
        }
        System.out.print("hql");
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        Query query = session.createQuery(hql);
        if(values!=null&&values.size()>0){
            for(int index=0;index<values.size();index++){
                query.setParameter("sno", "%"+values.get(index)+"%");
            }
        }
        return query.list();
    }

    public void savaLog(UserOperateLog user){
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        Transaction transaction = session.getTransaction();
        transaction.begin();
        session.merge(user);
        session.flush();
        session.clear();
        transaction.commit();
    }

    public List<T> dataRange(String start,String end){
        Date beginDate = DateTime.parse(start).toDate();
        Date endDate = DateTime.parse(end).toDate();
        String hql = "from "+clasz.getSimpleName()+ " where createTime<:endDate and createTime>:beginDate";
        System.out.println(endDate);
        Session session = Hibernate_cfg.getCurrentSession();
        if (session.isOpen()){
            session = Hibernate_cfg.openSession();
        }
        Transaction transaction = session.getTransaction();
        transaction.begin();
        Query query = session.createQuery(hql);
        query.setParameter("beginDate",endDate);
        query.setParameter("endDate",beginDate);
        return query.list();
    }
}

