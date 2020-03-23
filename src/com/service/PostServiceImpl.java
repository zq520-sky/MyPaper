package com.service;

import com.pojo.Post;
import org.springframework.stereotype.Service;

import javax.swing.text.html.parser.Entity;

@Service("postServiceImpl")
public class PostServiceImpl extends EntityDaoImpl<Post> {

}
