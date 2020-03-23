package com.Control;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.page.page;
import com.pojo.*;
import com.service.*;
import com.util.UserOperate;
import jdk.nashorn.internal.runtime.GlobalConstants;
import org.hibernate.annotations.Parameter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.portlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
@RequestMapping("/admin")
public class AdminControl {

    @Resource(name = "adminService")
    AdminService adminService;
    @Resource(name = "studentService")
    StudentService studentService;
    @Resource(name = "teacherService")
    TeacherService teacherService;
    @Resource(name="roomService")
    RoomService roomService;
    @Resource(name="recordService")
    RecordService recordService;
    @Resource(name="doomService")
    DoomService doomService;
    @Resource(name = "clazzService")
    ClazzService clazzService;
    @Resource
    UserOperateLogService userOperateLogService;
    private String room_id;
    private String doom_id;
    private String admin_id;
    private String clazz_id;
    private String gender;
    private String password;
    private String telephone;
    private String sno;
    private String username;

    @UserOperate(describe = "获取宿管列表",type = "查询")
    @RequestMapping(value = "/getRoomTeacherList",method = RequestMethod.POST)
    @ResponseBody
    public String getRoomTeacher(@RequestParam(value = "name",required = false,defaultValue = "")String name,
                                 page page)throws Exception {

        List<Map<String, Object>> listMaps = new ArrayList<>();//初始化一个容器

        Map<String,Object> result = null;
        //模糊查询
        //querymap.put("name","%" + name + "%");
        //分页
        //querymap.put("offset",page.getOffset());//表示从第几页开始
        //querymap.put("pageSize",page.getRows());//得到一行的数据
        //将查出的数据和分页信息封装传入前端
        List<RoomTeacher> list = teacherService.query();
        for(RoomTeacher su:list){
            result = new HashMap<>();
            result.put("id",su.getId());
            result.put("sno",su.getSno());
            result.put("username",su.getUsername());
            result.put("email",su.getEmail());
            result.put("telephone",su.getTelephone());
            result.put("roomname",su.getRoom().getName());//楼栋名字
            if(su.getStatus()==1){
                result.put("status","正常登陆");
            }else{
                result.put("status","禁止登陆");
            }
            listMaps.add(result);
        }

        Gson gson = new Gson();

        String rs = gson.toJson(listMaps);

        return rs;
    }

    @UserOperate(describe = "获取学生列表",type = "查询")
    @RequestMapping(value = "/getStudentList",method = RequestMethod.POST)
    @ResponseBody
    public String getStudentList(@RequestParam(value = "usersno",required = true,defaultValue = "null")String usersno,
                                 @RequestParam(value = "clazzId",required = true,defaultValue = "null")String clazzId,
                                  page page)throws Exception {

        List<Map<String, Object>> listMaps = new ArrayList<>();//初始化一个容器

        Map<String,Object> result = null;
        List<Student> list = null;
        if(usersno.equals("null")&&clazzId.equals("null")) {
            list = studentService.query(null, null);
            for (int i = 0; i < list.size(); i++) {
                if (list.get(i).getDoom() == null || list.get(i).getRoom() == null) {
                    list.remove(i);
                    i--;
                }
            }

        }
        else{
            if(!usersno.equals("null")&&clazzId.equals("null")){//如果学号不空
                String hql = "sno like :sno";
                List ls = new ArrayList();
                ls.add(sno);
                list = studentService.queryByCondition(hql,ls);
            }else if(usersno.equals("null")&&!clazzId.equals("null")){//如果学号空班级不空
                String hql = "class_id=?";
                List ls = new ArrayList();
                //ls.add(username);
                //ls.add(usersno);
                ls.add(clazzId);
                list = studentService.query(hql,ls);
            }else{//如果学号和班级都不空
                String hql = "sno like %"+sno+"% and class_id=?";
                List ls = new ArrayList();
                ls.add(clazzId);
                list = studentService.query(hql,ls);
            }


            for (int i = 0; i < list.size(); i++) {
                if (list.get(i).getDoom() == null || list.get(i).getRoom() == null) {
                    list.remove(i);
                    i--;
                }
            }
        }


        for(Student su:list){
            result = new HashMap<>();
            result.put("id",su.getId());
            result.put("username",su.getUsername());
            result.put("sno",su.getSno());
            result.put("clazzId",su.getClazz().getNumber());
            result.put("profess",su.getClazz().getProfess());
            result.put("gender",su.getGender());
            result.put("roomlevel",su.getRoom().getName());
            result.put("telephone",su.getTelephone());
            result.put("adnumber",su.getDoom().getName());
            if(su.getStatus()==1){
                result.put("status","正常登陆");
            }else{
                result.put("status","禁止登陆");
            }

            listMaps.add(result);
        }

        Gson gson = new Gson();

        String rs = gson.toJson(listMaps);
        return rs;
    }
    @UserOperate(describe = "获取楼栋列表",type = "查询")
    @RequestMapping(value = "/getRoomList",method = RequestMethod.POST)
    @ResponseBody
    public String getRoom(@RequestParam(value = "name",required = false,defaultValue = "")String name,
                                 page page,HttpServletRequest request)throws Exception {

        List<Map<String, Object>> listMaps = new ArrayList<>();//初始化一个容器

        Map<String,Object> result = null;
        //模糊查询
        //querymap.put("name","%" + name + "%");
        //分页
        //querymap.put("offset",page.getOffset());//表示从第几页开始
        //querymap.put("pageSize",page.getRows());//得到一行的数据
        //将查出的数据和分页信息封装传入前端
        List<Room> list = roomService.query();
        request.setAttribute("roomList",list);
        for(Room su:list){
            result = new HashMap<>();
            result.put("id",su.getId());
            result.put("name",su.getName());
            result.put("profess",su.getClazz().getProfess());
            listMaps.add(result);
        }

        Gson gson = new Gson();
        String rs = gson.toJson(listMaps);
        return rs;
    }
    @UserOperate(describe = "获取违规记录",type = "查询")
    @RequestMapping(value = "/getRecordList",method = RequestMethod.POST)
    @ResponseBody
    public String getRecord(@RequestParam(value = "name",required = false,defaultValue = "")String name,
                          page page)throws Exception {

        List<Map<String, Object>> listMaps = new ArrayList<>();//初始化一个容器

        Map<String,Object> result = null;
        //模糊查询
        //querymap.put("name","%" + name + "%");
        //分页
        //querymap.put("offset",page.getOffset());//表示从第几页开始
        //querymap.put("pageSize",page.getRows());//得到一行的数据
        //将查出的数据和分页信息封装传入前端
        List<Record> list = recordService.query(null,null);
        for(Record su:list){
            result = new HashMap<>();
            result.put("id",su.getId());
            result.put("data",su.getDate());
            result.put("sno",su.getStudent().getSno());
            result.put("profess",su.getStudent().getClazz().getProfess());
            result.put("username",su.getStudent().getUsername());
            if(su.getStudent().getRoom()==null){
                result.put("roomlevel","未分配");
                result.put("roomname","未分配");
            }else {
                result.put("roomlevel", su.getStudent().getRoom().getName());
                result.put("roomname", su.getStudent().getDoom().getName());
            }
            result.put("note",su.getNote());
            listMaps.add(result);
        }
        Gson gson = new Gson();
        String rs = gson.toJson(listMaps);
        return rs;
    }

    @UserOperate(describe = "用户注销",type = "其他")
    @RequestMapping(value = "/loginout",method = RequestMethod.GET)
    public String LoginOut(HttpServletRequest request) {
        return "redirect:../../MyPaper/index.jsp";

    }
    @UserOperate(describe = "修改密码",type = "修改")
    @RequestMapping(value = "/changePassword",method = RequestMethod.POST)
    @ResponseBody
    public String ChangePassword(@RequestParam(value = "sno",required = true)String sno,@RequestParam(value = "valid_password",required = true)String valid_password,@RequestParam(value = "new_password",required = true)String new_password,HttpServletRequest request){
        Admin admin = adminService.query(sno,valid_password);
        if(admin==null){
            return "旧密码错误";
        }else {
            String condition = " set password=? where sno=?";
            List list = new ArrayList();
            list.add(new_password);
            list.add(sno);
            adminService.updateByConditon(condition, list);
            return "修改成功";
        }
    }
    @UserOperate(describe = "获取待分配宿舍学生信息",type = "查询")
    @RequestMapping(value = "/allocateRoomToStudent",method = RequestMethod.POST)
    @ResponseBody
    public String getAllocateStudent(page page)throws Exception {

        List<Map<String, Object>> listMaps = new ArrayList<>();//初始化一个容器

        Map<String,Object> result = null;
        //模糊查询
        //querymap.put("name","%" + name + "%");
        //分页
        //querymap.put("offset",page.getOffset());//表示从第几页开始
        //querymap.put("pageSize",page.getRows());//得到一行的数据
        //将查出的数据和分页信息封装传入前端
        List<Student> list = studentService.query(null,null);
        /*
        System.out.println("----------------------"+list.size());
        for(int i =0;i<list.size();i++){
            if(list.get(i).getRoom()!=null||list.get(i).getDoom()!=null){
                list.remove(i);//未分配宿舍
                i--;
            }
        }*/
        for(Student su:list){
            result = new HashMap<>();
            result.put("id",su.getId());
            result.put("username",su.getUsername());
            result.put("sno",su.getSno());
            result.put("profess",su.getClazz().getProfess());
            result.put("gender",su.getGender());
            result.put("clazzId",su.getClazz().getNumber());
            //result.put("roomlevel",su.getRoom().getName());
            //result.put("telephone",su.getTelephone());
            //result.put("adnumber",su.getDoom().getName());
            listMaps.add(result);
        }
        Gson gson = new Gson();
        String rs = gson.toJson(listMaps);
        return rs;
    }
    @UserOperate(describe = "添加学生信息",type = "添加")
    @RequestMapping("/addStudent")
    @ResponseBody
    public Map<String,String> addStudent(@RequestParam(value = "room_id",defaultValue = "",required = false)String room_id,
                             @RequestParam(value = "doom_id",defaultValue = "",required = false)String doom_id,
                             @RequestParam(value = "admin_id",required =true)String admin_id,
                             @RequestParam(value = "clazz_id",required = true)String clazz_id,
                             @RequestParam(value = "gender",required =true)String gender,
                             @RequestParam(value = "password",required =true)String password,
                             @RequestParam(value = "telephone",required =true)String telephone,
                             @RequestParam(value = "sno",required = true)String sno,
                             @RequestParam(value = "username",required = true)String username){

        //System.out.print(sno);

        Map<String,String> rt = new HashMap<>(0);
        String condition="sno=?";
        List list = new ArrayList();
        list.add(sno);

        Student student = new Student();
        try {
            if(!room_id.equals("")&&!doom_id.equals("")) {
                int r_id = Integer.parseInt(room_id);
                int d_id = Integer.parseInt(doom_id);
                int c_id = Integer.parseInt(clazz_id);
                int a_id = Integer.parseInt(admin_id);
                Admin admin = adminService.queryById(a_id);
                Doom doom = doomService.queryById(d_id);
                Room room = roomService.queryById(r_id);
                Clazz clazz = clazzService.queryById(c_id);
                List<RoomTeacher> ls = teacherService.query();

                student.setAdmin(admin);
                student.setClazz(clazz);
                for (RoomTeacher roomTeacher : ls) {
                    if (roomTeacher.getRoom().getId() != r_id) {
                        student.setRoomTeachers(null);
                    } else {
                        student.setRoomTeachers(roomTeacher);
                        break;
                    }
                }
                student.setDoom(doom);
                student.setGender(gender);
                student.setPassword(password);
                student.setRoom(room);
                student.setTelephone(telephone);
                student.setUsername(username);
                student.setRecords(null);
                student.setSno(sno);
                student.setStatus(1);//默认允许登录
            }else{
                student.setGender(gender);
                student.setPassword(password);
                //student.setRoom(room);
                student.setTelephone(telephone);
                student.setUsername(username);
                student.setRecords(null);
                student.setSno(sno);
                student.setStatus(1);//默认允许登录
            }

            this.studentService.add(student);
            rt.put("type","success");
            rt.put("message","添加成功！");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
            rt.put("message","添加失败！");
        }

        return rt;

    }

    @UserOperate(describe = "修改学生信息",type = "修改")
    @RequestMapping("/editStudent")
    @ResponseBody
    public Map editStudent(@RequestParam(value = "stu_id",required = true)int stu_id,
                           @RequestParam(value = "room",required = true)String room_id,
                           @RequestParam(value = "doom",required = true)String doom_id,
                           @RequestParam(value = "admin_id",required =true)String admin_id,
                           @RequestParam(value = "clazzId",required = true)String clazz_id,
                           @RequestParam(value = "gender",required =true)String gender,
                           @RequestParam(value = "password",required =false,defaultValue = "null")String password,
                           @RequestParam(value = "telephone",required =true)String telephone,
                           @RequestParam(value = "sno",required = true)String sno,
                           @RequestParam(value = "username",required = true)String username){

        Map<String,String> rt = new HashMap<>(0);
        try {
            if(!password.equals("null")) {//如果密码不为空，说明需要修改密码
                String condition = " set username=?,sno=?,password=?,gender=?,telephone=?,admin_id=?,class_id=?,doom_id=?,room_id=? where id =?";
                int r_id = Integer.parseInt(room_id);
                int d_id = Integer.parseInt(doom_id);
                int c_id = Integer.parseInt(clazz_id);
                int a_id = Integer.parseInt(admin_id);
                List list = new ArrayList<>();
                list.add(username);
                list.add(sno);
                list.add(password);
                list.add(gender);
                list.add(telephone);
                list.add(admin_id);
                list.add(clazz_id);
                list.add(doom_id);
                list.add(room_id);
                list.add(stu_id);
                this.studentService.updateByCondition(condition, list);
                rt.put("type", "success");
                rt.put("message", "修改成功！");
            }else{
                String condition = " set username=?,sno=?,gender=?,telephone=?,admin_id=?,class_id=?,doom_id=?,room_id=? where id =?";
                int r_id = Integer.parseInt(room_id);
                int d_id = Integer.parseInt(doom_id);
                int c_id = Integer.parseInt(clazz_id);
                int a_id = Integer.parseInt(admin_id);
                List list = new ArrayList<>();
                list.add(username);
                list.add(sno);
                list.add(gender);
                list.add(telephone);
                list.add(admin_id);
                list.add(clazz_id);
                list.add(doom_id);
                list.add(room_id);
                list.add(stu_id);
                this.studentService.updateByCondition(condition, list);
                rt.put("type", "success");
                rt.put("message", "修改成功！");
            }
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
            rt.put("message","修改失败！");
        }

        return rt;
    }
    @UserOperate(describe = "学生权限控制",type = "更改")
    @RequestMapping("/stuAccLogin")
    @ResponseBody
    public Map stuAccLogin(@RequestParam(value = "ids",required = true) int ids,
                           @RequestParam(value = "type",required = true) String type){
        Map<String,String> rt = new HashMap<>(0);
        try {
            List<Integer> ls = new ArrayList();
            if(type.equals("0")) {
                ls.add(0);
            }else{
                ls.add(1);
            }
            ls.add(ids);
            String condition = " set status=? where id=?";
            studentService.updateByCondition(condition,ls);
            rt.put("type","success");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
        }
        return rt;
    }
    @UserOperate(describe = "删除学生信息",type = "删除")
    @RequestMapping("/deleteStudent")
    @ResponseBody
    public Map deleteStudent(@RequestParam(value = "ids",required = true) int ids){
        Map<String,String> rt = new HashMap<>(0);
        try {
            Student student = studentService.queryById(ids);
            Set<Record> recordSet = student.getRecords();
            for(Record record:recordSet){
                recordService.deleteById(record.getId());
            }
            studentService.deleteById(ids);
            rt.put("type","success");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
        }
        return rt;
    }
    @UserOperate(describe = "添加宿管信息",type = "添加")
    @RequestMapping("/addTeacher")
    @ResponseBody
    public Map addTeacher(@RequestParam(value = "room",required = true)String room_id,
                             @RequestParam(value = "admin_id",required =true)String admin_id,
                             @RequestParam(value = "password",required =true)String password,
                             @RequestParam(value = "telephone",required =true)String telephone,
                             @RequestParam(value = "sno",required = true)String sno,
                             @RequestParam(value = "mail",required = true)String mail,
                             @RequestParam(value = "username",required = true)String username){

        Map<String,String> rt = new HashMap<>(0);

        try {
            int r_id = Integer.parseInt(room_id);
            int a_id = Integer.parseInt(admin_id);
            RoomTeacher teacher = new RoomTeacher();
            Admin admin = adminService.queryById(a_id);
            HashSet hashSet = new HashSet();
            hashSet.add(admin);
            Room room = roomService.queryById(r_id);
            teacher.setPassword(password);
            teacher.setRoom(room);
            teacher.setTelephone(telephone);
            teacher.setUsername(username);
            teacher.setSno(sno);
            teacher.setEmail(mail);
            teacher.setAdmins(hashSet);
            teacher.setStatus(1);//默认允许登录
            this.teacherService.add(teacher);
            rt.put("type","success");
            rt.put("message","添加成功！");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
            rt.put("message","添加失败！");
        }

        return rt;
    }
    @UserOperate(describe = "修改宿管信息",type = "修改")
    @RequestMapping("/editTeacher")
    @ResponseBody
    public Map editTeacher(@RequestParam(value = "stu_id",required = true)int stu_id,
                             @RequestParam(value = "room",required = true)String room_id,
                             @RequestParam(value = "admin_id",required =true)String admin_id,
                             @RequestParam(value = "password",required =false,defaultValue = "null")String password,
                             @RequestParam(value = "telephone",required =true)String telephone,
                             @RequestParam(value = "sno",required = true)String sno,
                             @RequestParam(value = "mail",required = true)String mail,
                             @RequestParam(value = "username",required = true)String username){
        Map<String,String> rt = new HashMap<>(0);
        try {
            if (!password.equals("null")) {//如果密码不为空，代表需要修改密码
                String condition = " set username=?,sno=?,password=?,telephone=?,room_id=?,email=? where id =?";
                List list = new ArrayList<>();
                list.add(username);
                list.add(sno);
                list.add(password);
                list.add(telephone);
                list.add(room_id);
                list.add(mail);
                list.add(stu_id);

                this.teacherService.updateByCondition(condition, list);
                rt.put("type", "success");
                rt.put("message", "修改成功！");
            }else{//如果密码为空，说明不需要修改密码
                String condition = " set username=?,sno=?,telephone=?,room_id=?,email=? where id =?";
                List list = new ArrayList<>();
                list.add(username);
                list.add(sno);
                list.add(telephone);
                list.add(room_id);
                list.add(mail);
                list.add(stu_id);
                this.teacherService.updateByCondition(condition, list);
                rt.put("type", "success");
                rt.put("message", "修改成功！");
            }
            }catch(Exception e){
                e.printStackTrace();
                rt.put("type", "faile");
                rt.put("message", "修改失败！");
            }


        return rt;
    }
    @UserOperate(describe = "宿管权限控制",type = "更改")
    @RequestMapping("/teaAccLogin")
    @ResponseBody
    public Map teaAccLogin(@RequestParam(value = "ids",required = true) int ids,
                           @RequestParam(value = "type",required = true) String type){
        Map<String,String> rt = new HashMap<>(0);
        try {
            List<Integer> ls = new ArrayList();
            if(type.equals("0")) {
                ls.add(0);
            }else{
                ls.add(1);
            }
            ls.add(ids);
            String condition = " set status=? where id=?";
            teacherService.updateByCondition(condition,ls);
            rt.put("type","success");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
        }
        return rt;
    }
    @UserOperate(describe = "删除宿管信息",type = "删除")
    @RequestMapping("/deleteTeacher")
    @ResponseBody
    public Map deleteTeacher(@RequestParam(value = "ids",required = true) int ids){
        Map<String,String> rt = new HashMap<>(0);
        try {
            RoomTeacher roomTeacher = teacherService.queryById(ids);
            roomTeacher.setStudents(null);
            roomTeacher.setAdmins(null);
            teacherService.update(roomTeacher);
            teacherService.deleteById(ids);
            rt.put("type","success");
        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
        }
        return rt;
    }
    @UserOperate(describe = "分配宿舍",type = "添加")
    @RequestMapping("/editAllocateRooms")//分配房间
    @ResponseBody
    public Map editAllocateRoom(@RequestParam(value="ids",required = true)int ids[],
                           @RequestParam(value = "room",required = true)String room_id,
                           @RequestParam(value="doom",required = true)String doom_id){
        Map<String,String> rt = new HashMap<>(0);
        try {
            int r_id = Integer.parseInt(room_id);
            int d_id = Integer.parseInt(doom_id);
            List list = new ArrayList<>();
            list.add(room_id);
            list.add(doom_id);
            List arrayList = new ArrayList();
            for(int i:ids){
                arrayList.add(i);
            }
            //Doom doom = doomService.queryDoom(d_id);
            //Room room = roomService.queryById(r_id);
            //if(6-doom.getStudentList().size()<ids.length){
            //    rt.put("type","faile");
            //    rt.put("message","待分配人数大于宿舍空余床位数");
            //}else {
            String hql = " set doom_id=?,room_id=? where id in (:ids)";
            /**
                HashSet<Student> studentHashSet = new HashSet<>();
                for(int i=0;i<ids.length;i++){
                    Student student = studentService.queryById(ids[i]);
                    student.setDoom(doom);
                    //student.setRoom(room);
                    studentService.update(student);
                }
                doom.setStudentList(studentHashSet);

             **/
            studentService.updateByArray(hql,list,arrayList);
            rt.put("type", "success");
            rt.put("message", "分配成功！");

        }catch (Exception e){
            e.printStackTrace();
            rt.put("type","faile");
            rt.put("message","分配失败！");
        }

        return rt;
    }

    @RequestMapping("/getUserOperateRecord")
    @ResponseBody
    public String gerUserOperateRecord(@RequestParam(required = false,defaultValue = "null")String beginDate,@RequestParam(required = false,defaultValue = "null")String endDate, page page)throws Exception{


        List<Map<String, Object>> listMaps = new ArrayList<>();//初始化一个容器
        Map<String,Object> result = null;
        //模糊查询
        //querymap.put("name","%" + name + "%");
        //分页
        //querymap.put("offset",page.getOffset());//表示从第几页开始
        //querymap.put("pageSize",page.getRows());//得到一行的数据
        //将查出的数据和分页信息封装传入前端
        List<UserOperateLog> list = null;
        if(beginDate.equals("null")&&endDate.equals("null")) {
             list = userOperateLogService.queryAllLog(null, null);
            for (UserOperateLog su : list) {
                result = new HashMap<>();
                result.put("id", su.getId());
                result.put("username", su.getUserName());
                result.put("usersno", su.getSno());
                result.put("creatDate", su.getCreateTime());
                result.put("ipAddress", su.getIpAddress());
                result.put("describe", su.getOperateDesc());
                result.put("type", su.getOperationType());
                listMaps.add(result);
            }

        }else{
            System.out.println("运行了日期查询"+beginDate);
            list = userOperateLogService.queryByDate(beginDate,endDate);
            for (UserOperateLog su : list) {
                result = new HashMap<>();
                result.put("id", su.getId());
                result.put("username", su.getUserName());
                result.put("usersno", su.getSno());
                result.put("creatDate", su.getCreateTime());
                result.put("ipAddress", su.getIpAddress());
                result.put("describe", su.getOperateDesc());
                result.put("type", su.getOperationType());
                listMaps.add(result);
            }
        }
        Gson gson = new Gson();

        String rs = gson.toJson(listMaps);

        return rs;
    }
}
