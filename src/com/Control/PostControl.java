package com.Control;

import com.google.gson.Gson;
import com.page.page;
import com.pojo.*;
import com.service.PostService;
import com.util.UserOperate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.*;

@Controller
@RequestMapping("/post")
public class PostControl {
    @Resource(name="postService")
    private PostService postService;
    @UserOperate(describe = "获取通知列表",type = "查询")
    @RequestMapping(value = "/getPostList",method = RequestMethod.POST)
    @ResponseBody
    public String getRoomTeacher(@RequestParam(value = "name",required = false,defaultValue = "")String name,
                                 page page)throws Exception {

        List<Map<String, Object>> listMaps = new ArrayList<>();//初始化一个容器

        Map<String, Object> result = null;
        //模糊查询
        //querymap.put("name","%" + name + "%");
        //分页
        //querymap.put("offset",page.getOffset());//表示从第几页开始
        //querymap.put("pageSize",page.getRows());//得到一行的数据
        //将查出的数据和分页信息封装传入前端
        List<Post> list = postService.query();
        for (Post su : list) {
            result = new HashMap<>();
            result.put("id", su.getId());
            result.put("text", su.getText());
            result.put("createDate", su.getCreateDate());
            listMaps.add(result);
        }
        Gson gson = new Gson();
        String rs = gson.toJson(listMaps);
        return rs;
    }
    @UserOperate(describe = "添加通知信息",type = "添加")
    @RequestMapping("/addPost")
    @ResponseBody
    public Map<String,String> addStudent(@RequestParam(value = "text",required = true)String text){

        //System.out.print(sno);

        Map<String,String> rt = new HashMap<>(0);
        try {

            Post post = new Post();
            post.setText(text);
            post.setCreateDate(new Date());
            this.postService.add(post);
            rt.put("type","success");
            rt.put("message","添加成功！");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
            rt.put("message","添加失败！");
        }

        return rt;

    }

    @UserOperate(describe = "修改通知信息",type = "修改")
    @RequestMapping("/editPost")
    @ResponseBody
    public Map editStudent(@RequestParam(value = "id",required = true)int id,
                           @RequestParam(value = "text",required = true)String text){

        Map<String,String> rt = new HashMap<>(0);
        try {
                String condition = " set text=? where id =?";
                List list = new ArrayList<>();
                list.add(text);
                list.add(id);
                this.postService.updateByCondition(condition, list);
                rt.put("type", "success");
                rt.put("message", "修改成功！");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
            rt.put("message","修改失败！");
        }
        return rt;
    }
    @UserOperate(describe = "删除通知信息",type = "删除")
    @RequestMapping("/deletePost")
    @ResponseBody
    public Map deleteTeacher(@RequestParam(value = "ids",required = true) int ids){
        Map<String,String> rt = new HashMap<>(0);
        try {
            postService.deleteById(ids);
            rt.put("type","success");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
        }
        return rt;
    }
}
