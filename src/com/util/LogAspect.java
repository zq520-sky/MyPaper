package com.util;


import com.Control.LoginControl;
import com.Enum.OperationType;
import com.pojo.Student;
import com.pojo.UserOperateLog;
import com.service.AdminService;
import com.service.StudentService;
import com.service.TeacherService;
import com.service.UserOperateLogService;
import com.sun.org.apache.xerces.internal.util.SynchronizedSymbolTable;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 处理用户操作日志切面类
 * @author HuYa
 *
 */
@Aspect
@Component
public class LogAspect {

    private static final Logger logger = LoggerFactory.getLogger(LoginControl.class);

    @Resource
    UserOperateLogService userOperateLogService;

    @Resource
    StudentService studentService;
    @Resource
    TeacherService teacherService;
    @Resource
    AdminService adminService;
    @Pointcut("@annotation(com.util.UserOperate)")
    public void controllerAspecta(){

    }

    @AfterReturning(pointcut = "controllerAspecta()",returning = "result")
    public void interceptorApplogicA(JoinPoint joinPoint, Object result) throws Exception{
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String classType = joinPoint.getTarget().getClass().getName();
        Class<?> clazz = Class.forName(classType);
        String clazzName = clazz.getName();
         // 拦截的方法名称。当前正在执行的方法
        String methodName = joinPoint.getSignature().getName();
        // 获取方法的参数
        Object[] args = joinPoint.getArgs();
        Object[] arguments = new Object[args.length];
        for(int i=0;i<args.length;i++){
            if(args[i] instanceof ServletRequest || args[i] instanceof ServletResponse){
                continue;
            }
            arguments[i] = args[i];
        }
        for(Object v:arguments){
        }
        String params = null;
        Map<String,String> map = LogUtil.getMthodRemark(joinPoint);
        String type = map.get("type");
        String describe = map.get("describe");
        try{
            //if(result.toString()!="loginfaile"||!request.equals("loginfaile")){//代表登录成功
                //String sno = (String) arguments[1];//登录成功，获得学号
                //String role = (String) arguments[4];//获取角色
                //String sno = (String) request.getAttribute("user_sno");
                //String condition="sno=?";
                //List list = new ArrayList();
                //list.add(sno);
                //Student student = (Student) studentService.query(condition,list).get(0);
                HttpSession session = request.getSession();
                String sno = (String) session.getAttribute("sy_user_sno");
                String userName = (String) session.getAttribute("sy_user_userName");
                if(describe.equals("用户注销")) {
                    request.getSession().removeAttribute("sy_user_userName");
                    request.getSession().removeAttribute("sy_user_sno");
                    request.getSession().invalidate();
                }
                UserOperateLog userLog = new UserOperateLog();
                userLog.setCreateTime(new Date());
                String ip = this.getIpAddr(request);
                userLog.setIpAddress(ip);
                userLog.setUserName(userName);
                userLog.setSno(sno);
                userLog.setOperateDesc(describe);
                userLog.setOperationType(type);
                this.userOperateLogService.addLog(userLog);
                //System.out.println("添加成功");
           // }
        }catch (Exception e){
            e.printStackTrace();

        }


    }

    /**
     * 获取IP地址
     * @param request
     * @return
     */
    private  String getIpAddr(HttpServletRequest request) {
        System.out.println(request.getRequestURI());
        String ip = request.getHeader("x-forwarded-for");
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

}

