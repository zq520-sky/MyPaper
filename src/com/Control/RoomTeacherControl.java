package com.Control;

import com.google.gson.Gson;
import com.page.page;
import com.pojo.*;
import com.service.AdminService;
import com.service.RecordService;
import com.service.StudentService;
import com.service.TeacherService;
import com.util.UserOperate;
import org.springframework.jca.cci.RecordTypeNotSupportedException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("/teacher")
public class RoomTeacherControl
{
    @Resource
    private StudentService studentService;

    @Resource
    private TeacherService teacherService;
    @Resource
    private RecordService recordService;
    @UserOperate(describe = "获取学生信息",type = "查询")
    @RequestMapping("/getStudentList")
    @ResponseBody
    public String studentList(@RequestParam(value = "tea_id",required = true)String tea_id,
                              page page)throws Exception{//获取该宿舍楼管理的学生列表
        List<Map<String, Object>> listMaps = new ArrayList<>();//初始化一个容器

        Map<String,Object> result = null;
        //模糊查询
        //querymap.put("name","%" + name + "%");
        //分页
        //querymap.put("offset",page.getOffset());//表示从第几页开始
        //querymap.put("pageSize",page.getRows());//得到一行的数据
        //将查出的数据和分页信息封装传入前端
        int id = Integer.parseInt(tea_id);
        List<Object> ls = new ArrayList();
        RoomTeacher roomTeacher = teacherService.queryById(id);//查询到该宿管
        Set<Student> studentSet = new HashSet<>();
        studentSet = roomTeacher.getStudents();//通过宿管得到这些学生
        if(studentSet.size()>0&&studentSet!=null){
            for(Student su:studentSet){
                result = new HashMap();
                result.put("id", su.getId());
                result.put("username", su.getUsername());
                result.put("sno", su.getSno());
                result.put("clazzId", su.getClazz().getNumber());
                result.put("profess", su.getClazz().getProfess());
                result.put("gender", su.getGender());
                result.put("roomlevel", su.getRoom().getName());
                result.put("telephone", su.getTelephone());
                result.put("adnumber", su.getDoom().getName());
                listMaps.add(result);
            }

        }

        Gson gson = new Gson();

        String rs = gson.toJson(listMaps);
        return rs;
    }

    @UserOperate(describe = "获得违规记录信息",type = "查询")
    @RequestMapping("/getRecordList")
    @ResponseBody
    public String recordList(@RequestParam(value = "tea_id",required = true)String tea_id,
                             page page)throws Exception{//获取该宿舍楼管理的学生列表
        List<Map<String, Object>> listMaps = new ArrayList<>();//初始化一个容器

        Map<String,Object> result = null;
        //模糊查询
        //querymap.put("name","%" + name + "%");
        //分页
        //querymap.put("offset",page.getOffset());//表示从第几页开始
        //querymap.put("pageSize",page.getRows());//得到一行的数据
        //将查出的数据和分页信息封装传入前端
        //List ls = new ArrayList();
        String condition = "room.id=?";
        int id = Integer.parseInt(tea_id);
        List<Object> ls = new ArrayList();
        RoomTeacher roomTeacher = teacherService.queryById(id);//查询到该宿管
        Set<Student> studentSet = roomTeacher.getStudents();
        Set<Record> hashSet;
        for(Student su:studentSet){//一个学生可能有多条记录
            hashSet =  su.getRecords();
            if(hashSet!=null&&hashSet.size()>0&&!hashSet.isEmpty()) {
                for(Record record:hashSet){
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

        }

        Gson gson = new Gson();

        String rs = gson.toJson(listMaps);
        return rs;
    }
    @UserOperate(describe = "修改用户密码",type = "修改")
    @RequestMapping(value = "/changePassword",method = RequestMethod.POST)
    @ResponseBody
    public String ChangePassword(@RequestParam(value = "sno",required = true)String sno, @RequestParam(value = "valid_password",required = true)String valid_password, @RequestParam(value = "new_password",required = true)String new_password, HttpServletRequest request){
        RoomTeacher roomTeacher = teacherService.query(sno,valid_password);
        if(roomTeacher==null){
            return "旧密码错误";
        }else {
            String condition = " set password=? where sno=?";
            List list = new ArrayList();
            list.add(new_password);
            list.add(sno);
            teacherService.updateByCondition(condition, list);
            return "修改成功";
        }
    }
    @UserOperate(describe = "用户注销",type = "其他")
    @RequestMapping(value = "/loginout",method = RequestMethod.GET)
    public String LoginOut(HttpServletRequest request) {
        return "redirect:../../MyPaper/index.jsp";

    }
    @UserOperate(describe = "获得违规记录",type = "查询")
    @RequestMapping(value = "/addStudentRecord",method = RequestMethod.POST)
    @ResponseBody
    public Map addStudentRecord(@RequestParam(value = "stu_id",required = true)int stu_id,
                                               @RequestParam(value = "record",required = true)String record){
        Map<String,String> rt = new HashMap<>(0);
        try {
            Student student = studentService.queryById(stu_id);//找到改学生
            HashSet<Record> records = new HashSet<>();
            Record record1 = new Record();
            record1.setStudent(student);
            record1.setNote(record);
            record1.setDate(new Date());
            records.add(record1);
            //student.setRecords(records);
            recordService.addRecord(record1);
            //studentService.update(student);
            rt.put("type","success");
            rt.put("message","修改成功！");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
            rt.put("message","修改失败！");
        }
        return rt;
    }

    @UserOperate(describe = "修改学生违规记录",type = "修改")
    @RequestMapping(value = "/editStudentRecord")
    @ResponseBody
    public Map editStudentRecord(@RequestParam(value = "record_id",required = true)int record_id,
                                 @RequestParam(value = "record",required = true)String record){

        Map<String,String> rt = new HashMap<>(0);
        try {
            Record record1 = recordService.queryById(record_id);//找到该条记录
            record1.setNote(record);
            String conditon = " set 记录=? where id=?";
            List list = new ArrayList();
            list.add(record);
            list.add(record_id);
            recordService.updateByCondition(conditon,list);
            rt.put("type","success");
            rt.put("message","修改成功！");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
            rt.put("message","修改失败！");
        }

        return rt;
    }

    @UserOperate(describe = "删除学生违规记录",type = "删除")
    @RequestMapping("/deleteStudentRecord")
    @ResponseBody
    public Map deleteStudent(@RequestParam(value = "ids",required = true) int[] ids){
        Map<String,String> rt = new HashMap<>(0);
        try {
            for(int i:ids)
            recordService.deleteById(i);
            rt.put("type","success");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
        }
        return rt;
    }
}
