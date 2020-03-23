package com.Control;

import com.google.gson.Gson;
import com.page.page;
import com.pojo.*;
import com.service.StudentService;
import com.util.UserOperate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("student")
public class StudentControl {
    @Resource
    StudentService studentService;
    @UserOperate(describe = "获取违规记录",type = "查询")
    @RequestMapping("/getRecordList")
    @ResponseBody
    public String recordList(@RequestParam(value = "stu_id",required = true)String stu_id,
                             page page)throws Exception{//获取该宿舍楼管理的学生列表
        List<Map<String, Object>> listMaps = new ArrayList<>();//初始化一个容器

        Map<String,Object> result = null;
        //模糊查询
        //querymap.put("name","%" + name + "%");
        //分页
        //querymap.put("offset",page.getOffset());//表示从第几页开始
        //querymap.put("pageSize",page.getRows());//得到一行的数据
        //将查出的数据和分页信息封装传入前端
        int id = Integer.parseInt(stu_id);
        Student su = studentService.queryById(id);//查询到该宿管
        Set<Record> records = su.getRecords();
            if(records!=null&&records.size()>0&&!records.isEmpty()) {
                for(Record record:records){
                    result = new HashMap();
                    result.put("data", record.getDate());
                    result.put("id", record.getId());//id是记录的Id,不是学生id
                    result.put("sno", su.getSno());
                    result.put("profess", su.getClazz().getProfess());
                    result.put("username", su.getUsername());
                    result.put("roomlevel", su.getRoom().getName());
                    result.put("roomname", su.getDoom().getName());
                    result.put("note", record.getNote());
                    listMaps.add(result);
                }
            }
        Gson gson = new Gson();

        String rs = gson.toJson(listMaps);
        return rs;
    }

    @UserOperate(describe = "修改用户密码",type = "修改")
    @RequestMapping(value = "/changePassword",method = RequestMethod.POST)
    @ResponseBody
    public String ChangePassword(@RequestParam(value = "sno",required = true)String sno, @RequestParam(value = "valid_password",required = true)String valid_password, @RequestParam(value = "new_password",required = true)String new_password, HttpServletRequest request) throws Exception {
        Student student = studentService.queryByOne(sno,valid_password);
        if(student==null){
            return "旧密码错误";
        }else {
            String condition = " set password=? where sno=?";
            List list = new ArrayList();
            list.add(new_password);
            list.add(sno);
            studentService.updateByCondition(condition, list);
            return "修改成功";
        }
    }
    @UserOperate(describe = "用户注销",type = "其他")
    @RequestMapping(value = "/loginout",method = RequestMethod.GET)
    public String LoginOut(HttpServletRequest request) {
        return "redirect:../../MyPaper/index.jsp";
    }
    @UserOperate(describe = "获取维修记录",type = "查询")
    @RequestMapping("/getRepairList")
    @ResponseBody
    public String repairList(@RequestParam(value = "stu_id",required = true)String stu_id,
                             page page)throws Exception{//获取该宿舍楼管理的学生列表
        List<Map<String, Object>> listMaps = new ArrayList<>();//初始化一个容器

        Map<String,Object> result = null;
        //模糊查询
        //querymap.put("name","%" + name + "%");
        //分页
        //querymap.put("offset",page.getOffset());//表示从第几页开始
        //querymap.put("pageSize",page.getRows());//得到一行的数据
        //将查出的数据和分页信息封装传入前端
        int id = Integer.parseInt(stu_id);
        Student su = studentService.queryById(id);//查询到该宿管
        Doom doom = su.getDoom();
        Set<RepairRecord> records = doom.getRepairRecords();
        if(records!=null&&records.size()>0&&!records.isEmpty()) {
            for(RepairRecord record:records){
                result = new HashMap();
                result.put("createDate", record.getCreateDate());
                result.put("id", record.getId());//id是记录的Id,不是学生id
                result.put("roomname",su.getRoom().getName());
                result.put("doomname", su.getDoom().getName());
                result.put("record",record.getRecord());
                listMaps.add(result);
            }
        }
        Gson gson = new Gson();

        String rs = gson.toJson(listMaps);
        return rs;
    }

    @UserOperate(describe = "获取维修记录",type = "查询")
    @RequestMapping("/addRepairRecord")
    @ResponseBody
    public Map<String,String> addRepairRecord(@RequestParam(value = "stu_id",required = true)String stu_id,
                             @RequestParam(value="text",required = true)String text,
                             page page)throws Exception{//获取该宿舍楼管理的学生列表
        Map<String,String> rt = new HashMap<>(0);

        int id = Integer.parseInt(stu_id);
        try {
            Student su = studentService.queryById(id);//查询到该学生
            Doom doom = su.getDoom();
            Set<RepairRecord> records = new HashSet<>();
            RepairRecord repairRecord = new RepairRecord();
            repairRecord.setCreateDate(new Date());
            repairRecord.setRecord(text);
            records.add(repairRecord);
            doom.setRepairRecords(records);
            rt.put("type","success");
            rt.put("message","添加成功！");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
            rt.put("message","添加失败！");
        }
        return rt;
    }
}
