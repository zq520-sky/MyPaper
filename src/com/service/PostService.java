package com.service;

import com.pojo.Post;
import com.pojo.Student;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Repository("postService")
public class PostService {
    @Resource(name="postServiceImpl")
    private PostServiceImpl postServiceImpl;
    public List query() throws Exception {
        List list = new ArrayList();
        return postServiceImpl.query(null,list);
    }
    public void add(Post post){
        postServiceImpl.save(post);
    }
    public void updateByCondition(String condition,List list){
        postServiceImpl.updateByCondition(condition,list);
    }
    public void deleteById(int id){
        postServiceImpl.deleteById(id);
    }
}
