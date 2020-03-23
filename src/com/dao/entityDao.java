package com.dao;

import java.util.Date;
import java.util.List;

public interface entityDao<T>{

        public T save(T entity);
        public T delete(T entity);
        public T update(T entity);
        public void updateByCondition(String condition,List<Object> lists);
        public T get(int id);
        public List<T> query(String condition, List<Object> values)throws Exception;
        public List<T> query(int pages,int rows,int id);
        public T query(String username,String password);
        public int getTotal(int id);
        public List<T> QueryByFilename(String condition);
        public void save(int id, String FileName, String path, Long i, Date date);

}
