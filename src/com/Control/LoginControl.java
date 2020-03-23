package com.Control;


import com.pojo.*;
import com.service.*;
import com.util.CpachaUtil;
import com.util.UserOperate;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;

import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LoginControl {

	@Resource(name = "adminService")
	AdminService adminService;
	@Resource(name = "studentService")
	StudentService studentService;
	@Resource(name = "teacherService")
	TeacherService teacherService;
	@Resource(name="roomService")
    RoomService roomService;
    @Resource(name="doomService")
    DoomService doomService;
    @Resource(name = "clazzService")
    ClazzService clazzService;
    private static final Log log = LogFactory.getLog(LoginControl.class);
    @UserOperate(describe = "学生登录",type = "查询")
    @RequestMapping("/student_login")
    public String studentLogin(Model model, @RequestParam(value = "username", required = true) String username,
                               @RequestParam(value = "password", required = true) String password,
                               @RequestParam(value="code",required = true)String iptCode,//验证码校验
                               HttpServletResponse hsr, HttpServletRequest request) {

        HttpSession session = request.getSession();
        String code = (String) session.getAttribute("loginImgVal");
        code = code.toLowerCase();//把大写字符换成小写，不区分大小写
        iptCode = iptCode.toLowerCase();
        if(!code.equals(iptCode)){
            session.setAttribute("message","验证码错误!");
        }
        Student student = studentService.login(username,password);
        if(student!=null){
           try {
               List<Room> lists = roomService.query();
               model.addAttribute("roomList",lists);
               model.addAttribute("doomList",doomService.query());
               model.addAttribute("clazzList",clazzService.query(null,null));
           }catch (Exception e){
               e.printStackTrace();
           }
           request.setAttribute("username",student.getUsername());
           request.setAttribute("user_sno",student.getSno());
           request.setAttribute("stu_id",student.getId());
           session.setAttribute("sy_user_userName",student.getUsername());
           session.setAttribute("sy_user_sno",student.getSno());
           return "mainStudent";
       }
       return "loginfaile";
    }
    @UserOperate(describe = "管理员登录",type = "查询")
    @RequestMapping("/admin_login")
    public String adminLogin(Model model, @RequestParam(value = "username", required = true) String username,
                             @RequestParam(value = "password", required = true) String password,
                             @RequestParam(value="code",required = true)String iptCode,//验证码校验
                             HttpServletResponse hsr, HttpServletRequest request) {


        HttpSession session = request.getSession();
        String code = (String) session.getAttribute("loginImgVal");
        code = code.toLowerCase();//把大写字符换成小写，不区分大小写
        iptCode = iptCode.toLowerCase();
        if(!code.equals(iptCode)){
            session.setAttribute("message","验证码错误!");
        }
        Admin admin = adminService.login(username, password);
        if(admin!=null){
            try {
                List<Room> lists = roomService.query();
                model.addAttribute("roomList",lists);
                model.addAttribute("doomList",doomService.query());
                model.addAttribute("clazzList",clazzService.query(null,null));
            }catch (Exception e){
                e.printStackTrace();
            }
            session.removeAttribute("message");
            request.setAttribute("username",admin.getUsername());
            request.setAttribute("admin_id",admin.getId());
            request.setAttribute("user_sno",admin.getSno());
            session.setAttribute("sy_user_userName",admin.getUsername());
            session.setAttribute("sy_user_sno",admin.getSno());
            return "mainAdmin";
        }
        session.setAttribute("message","用户名或密码错误!");
        return "loginfaile";
    }
    @UserOperate(describe = "宿管登录",type = "查询")
    @RequestMapping("/teacher_login")
    public String teacherLogin(Model model, @RequestParam(value = "username", required = true) String username,
                               @RequestParam(value = "password", required = true) String password,
                               @RequestParam(value="code",required = true)String iptCode,//验证码校验
                               HttpServletResponse hsr, HttpServletRequest request) {


        HttpSession session = request.getSession();
        String code = (String) session.getAttribute("loginImgVal");
        code = code.toLowerCase();
        iptCode = iptCode.toLowerCase();
        if(!code.equals(iptCode)){
            session.setAttribute("message","验证码错误!");
        }

        RoomTeacher teacher = teacherService.login(username,password);
        if (teacher!=null){
            try {

                List<Room> lists = roomService.query();
                model.addAttribute("roomList",lists);
                model.addAttribute("doomList",doomService.query());
                model.addAttribute("clazzList",clazzService.query(null,null));
            }catch (Exception e){
                e.printStackTrace();
            }
            session.removeAttribute("message");
            request.setAttribute("username",teacher.getUsername());
            request.setAttribute("sno",teacher.getSno());
            request.setAttribute("tea_id",teacher.getId());
            session.setAttribute("sy_user_userName",teacher.getUsername());
            session.setAttribute("sy_user_sno",teacher.getSno());
            return "mainTeacher";
        }
        session.setAttribute("message","用户名或密码错误!");
        return "loginfaile";
    }

    @RequestMapping(value="/getCode")
    @ResponseBody
    public String getCodeCha(HttpServletRequest request,
                           //设置自定义的字母个数，宽度和高度。
                           @RequestParam(value = "vl",defaultValue = "4",required = false)Integer vl,
                           @RequestParam(value = "width",defaultValue = "98",required = false)Integer width,
                           @RequestParam(value = "height",defaultValue = "33",required = false)Integer height,
                           @RequestParam(value = "abc",defaultValue = "",required = false)String abc,
                           HttpServletResponse response) {
        //System.out.println("获取验证码！");

        //Map<String,String> rt = new HashMap<>(0);
        CpachaUtil cpachaUtil = new CpachaUtil(vl,width,height);
        String  StringGeneratorVCode= cpachaUtil.generatorVCode();
        //把验证码存入会话中
        request.getSession().setAttribute("loginImgVal",StringGeneratorVCode);
        //干扰线
        BufferedImage bufferedImage = cpachaUtil.generatorRotateVCodeImage(StringGeneratorVCode, true);
        try {
            //把图片写入gif流中
            ImageIO.write(bufferedImage, "gif", response.getOutputStream());
            //rt.put("strCode", StringGeneratorVCode);
        }catch (Exception e){
            e.printStackTrace();
        }
        return StringGeneratorVCode;
    }


}
