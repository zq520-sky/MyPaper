<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <!-- 页面事件 -->
    <title>九江学院宿舍管理系统</title>
    <link href="${pageContext.request.contextPath}/static/css/login.css" rel="stylesheet" rev="stylesheet" type="text/css" media="all" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jQuery1.7.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery1.42.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.SuperSlide.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){

            $(".changeCode").click(function () {
                var date = new Date().getTime();
                var img = document.getElementsByClassName("changeCode");
                for(i=0;i<img.length;i++){
                    img[i].src = "${pageContext.request.contextPath }/getCode?"+date;
                }
            });
            var $tab_li = $('#tab ul li');
            $tab_li.hover(function(){
                $(this).addClass('selected').siblings().removeClass('selected');
                var index = $tab_li.index(this);
                $('div.tab_box > div').eq(index).show().siblings().hide();
            });
        });
    </script>
    <script type="text/javascript">
        //var img = document.getElementById("changcode");

        function valForm(user_login) {
            if(valUserName(user_login)==false){
                alert("用户名必须为6-12位字母或数字!");
                return false;
            }
            if(valPwd(user_login)==false){
                alert("密码必须为6-12位字母或数字!");
                return false;
            }
            if(valImg(user_login)==false){
                alert("校验码不能为空!");
                return false;
            }
            return true;
        }
        function valImg(user_login){
            if(user_login == "ad_login") {
                var iptVal = $("#sec_code_hide").val();
            }
            if(user_login == "tea_login"){
                var iptVal = $("#tea_code_hide").val();
            }
            if(user_login == "stu_login"){
                var iptVal = $("#stu_code_hide").val();
            }
            if(iptVal==null||iptVal==""){
                return false;
            }
            return true;
        }
        function valUserName(user_login){

            if(user_login == "ad_login") {
                var iptName = $("#sec_username_hide").val();
            }
            if(user_login == "tea_login"){
                var iptName = $("#tea_username_hide").val();
            }
            if(user_login == "stu_login"){
                var iptName = $("#stu_username_hide").val();
            }
            var p=/^\w\w{5,11}$/;//用户名必须为8-12为字母或数字
            var r=p.test(iptName);//校验
            if(!r){
                return false;
            }
            return true;
        }
        function valPwd(pwd_login){

            if(pwd_login == "ad_login") {
                var iptName = $("#sec_password_hide").val();
            }
            if(pwd_login == "tea_login"){
                var iptName = $("#tea_password_hide").val();
            }
            if(pwd_login == "stu_login"){
                var iptName = $("#stu_password_hide").val();
            }
            var p=/^\w\w{5,11}$/;//用户名必须为6-12为字母或数字
            var r=p.test(iptName);//校验
            if(r){
                return true;
            }
            return false;
        }



        $(function(){
            /*学生登录信息验证*/
            $("#stu_username_hide").focus(function(){
                var username = $(this).val();
                if(username=='输入学号'){
                    $(this).val('');
                }
            });
            $("#stu_username_hide").focusout(function(){
                var username = $(this).val();
                if(username==''){
                    $(this).val('输入学号');
                }
            });
            $("#stu_password_hide").focus(function(){
                var username = $(this).val();
                if(username=='输入密码'){
                    $(this).val('');
                }
            });
            $("#stu_password_hide").focusout(function(){
                var username = $(this).val();
                if(username==''){
                    $(this).val('输入密码');
                }
            });
            $("#stu_code_hide").focus(function(){
                var username = $(this).val();
                if(username=='输入验证码'){
                    $(this).val('');
                }
            });
            $("#stu_code_hide").focusout(function(){
                var username = $(this).val();
                if(username==''){
                    $(this).val('输入验证码');
                }
            });
            /*导师登录信息验证*/
            $("#tea_username_hide").focus(function(){
                var username = $(this).val();
                if(username=='输入教工号'){
                    $(this).val('');
                }
            });
            $("#tea_username_hide").focusout(function(){
                var username = $(this).val();
                if(username==''){
                    $(this).val('输入教工号');
                }
            });
            $("#tea_password_hide").focus(function(){
                var username = $(this).val();
                if(username=='输入密码'){
                    $(this).val('');
                }
            });
            $("#tea_password_hide").focusout(function(){
                var username = $(this).val();
                if(username==''){
                    $(this).val('输入密码');
                }
            });
            $("#tea_code_hide").focus(function(){
                var username = $(this).val();
                if(username=='输入验证码'){
                    $(this).val('');
                }
            });
            $("#tea_code_hide").focusout(function(){
                var username = $(this).val();
                if(username==''){
                    $(this).val('输入验证码');
                }
            });

            /*教务登录信息验证*/
            $("#sec_username_hide").focus(function(){
                var username = $(this).val();
                if(username=='输入教务号'){
                    $(this).val('');
                }
            });
            $("#sec_username_hide").focusout(function(){
                var username = $(this).val();
                if(username==''){
                    $(this).val('输入教务号');
                }
            });
            $("#sec_password_hide").focus(function(){
                var username = $(this).val();
                if(username=='输入密码'){
                    $(this).val('');
                }
            });
            $("#sec_password_hide").focusout(function(){
                var username = $(this).val();
                if(username==''){
                    $(this).val('输入密码');
                }
            });
            $("#sec_code_hide").focus(function(){
                var username = $(this).val();
                if(username=='输入验证码'){
                    $(this).val('');
                }
            });
            $("#sec_code_hide").focusout(function(){
                var username = $(this).val();
                if(username==''){
                    $(this).val('输入验证码');
                }
            });
        });
    </script>
    <script type="text/javascript">
        $(function(){
            $(".screenbg ul li").each(function(){
                $(this).css("opacity","0.8");
            });
            $(".screenbg ul li:first").css("opacity","1");
            var index = 0;
            var t;
            var li = $(".screenbg ul li");
            var number = li.size();
            function change(index){
                li.css("visibility","visible");
                li.eq(index).siblings().animate({opacity:0},3000);
                li.eq(index).animate({opacity:1},3000);
            }
            function show(){
                index = index + 1;
                if(index<=number-1){
                    change(index);
                }else{
                    index = 0;
                    change(index);
                }
            }
            t = setInterval(show,8000);
            //根据窗口宽度生成图片宽度
            var width = $(window).width();
            $(".screenbg ul img").css("width",width+"px");
        });
    </script>
</head>

<body>
<div id="tab">
    <ul class="tab_menu">
        <li class="selected">学生登录</li>
        <li>宿管登录</li>
        <li>管理员登录</li>
    </ul>
    <div class="tab_box">
        <!-- 学生登录开始 -->
        <div>
            <div class="stu_error_box"></div>
            <form action="student_login" method="post" class="stu_login_error">
                <div id="stu_username">
                    <label>学&nbsp;&nbsp;&nbsp;号：</label>
                    <input type="text" id="stu_username_hide" name="username" value="输入学号"/>
                    <!--ajaxurl="demo/valid.jsp"-->
                </div>
                <div id="stu_password">
                    <label>密&nbsp;&nbsp;&nbsp;码：</label>
                    <input type="password" id="stu_password_hide" name="password" value="输入密码" />
                </div>

                <div id="code1">
                    <label>验证码：</label>
                    <input type="text" id="stu_code_hide" name="code"  value="输入验证码" nullmsg="验证码不能为空！" datatype="*4-4" errormsg="验证码有4位数！" sucmsg="验证码验证通过！"/>
                    <img class="changeCode" src="${pageContext.request.contextPath }/getCode" title="点击更换" alt="验证码占位图" /> </div>
                <!--
              <div id="remember">
                <input type="checkbox" name="remember">
                <label>记住密码</label>
              </div>
              -->
                <div id="stu_login">
                    <input type="submit" id="stu_code_img" style="font-size:20px;width:370px;height: 30px;color: orangered;background-color: darkred" onclick="return valForm('stu_login')">
                </div>
            </form>
        </div>
        <!-- 学生登录结束-->
        <!-- 导师登录开始-->
        <div class="hide">
            <div class="tea_error_box"></div>
            <form action="teacher_login" method="post" class="tea_login_error">
                <div id="tea_username">
                    <label>教工号：</label>
                    <input type="text" id="tea_username_hide" name="username" value="输入教工号" />
                    <!--ajaxurl="demo/valid.jsp"-->
                </div>
                <div id="tea_password">
                    <label>密&nbsp;&nbsp;&nbsp;码：</label>
                    <input type="password" id="tea_password_hide" name="password" value="输入密码" />
                </div>

                <div id="code2">
                    <label>验证码：</label>
                    <input type="text" id="tea_code_hide" name="code"  value="输入验证码" nullmsg="验证码不能为空！" datatype="*4-4" errormsg="验证码有4位数！" sucmsg="验证码验证通过！"/>
                    <img class="changeCode" src="${pageContext.request.contextPath }/getCode" title="点击更换" alt="验证码占位图" /> </div>
                <!-- <div id="tea_remember">
                   <input type="checkbox" name="remember">
                   <label>记住密码</label>
                 </div>
                 -->
                <div id="tea_login">
                    <input  type="submit" id="tea_code_img" style="font-size:20px;width:370px;height: 30px;color: orangered;background-color: darkred" onclick="return valForm('tea_login')">
                </div>
            </form>
        </div>
        <!-- 导师登录结束-->
        <!-- 教务登录开始-->
        <div class="hide">
            <div class="sec_error_box"></div>
            <form action="admin_login" method="post" class="sec_login_error">
                <div id="ad_username">
                    <label>教务号：</label>
                    <input type="text" id="sec_username_hide" name="username" value="输入教务号">
                    <!--ajaxurl="demo/valid.jsp"-->
                </div>
                <div id="ad_password">
                    <label>密&nbsp;&nbsp;&nbsp;码：</label>
                    <input type="password" id="sec_password_hide" name="password" value="输入密码"/>
                </div>

                <div id="code">
                    <label>验证码：</label>
                    <input type="text" id="sec_code_hide" name="code"  value="输入验证码" nullmsg="验证码不能为空！" datatype="*4-4" errormsg="验证码有4位数！" sucmsg="验证码验证通过！"/>
                    <img class="changeCode" src="${pageContext.request.contextPath }/getCode" title="点击更换" alt="验证码占位图"  id="imgcode"/> </div>
                <!--<div id="remember">
                  <input type="checkbox" name="remember">
                  <label>记住密码</label>
                </div>
                -->
                <div id="ad_login">
                    <input type="submit" value="提交" id="ad_code_img" style="font-size:20px;width:370px;height: 30px;color: orangered;background-color: darkred" onclick="return valForm('ad_login')">
                </div>
            </form>
        </div>
        <!-- 教务登录结束-->
    </div>
</div>
<div class="bottom">©2020 Leting <a href="javascript:;" target="_blank">关于</a> <span>赣ICP证030173号</span><img width="13" height="16" src="images/copy_rignt_24.png" /></div>
<div class="screenbg">
    <ul>
        <li><a href="javascript:;"><img src="${pageContext.request.contextPath}/images/0.jpg"></a></li>
        <li><a href="javascript:;"><img src="${pageContext.request.contextPath}/images/1.jpg"></a></li>
        <li><a href="javascript:;"><img src="${pageContext.request.contextPath}/images/2.jpg"></a></li>
    </ul>
</div>
</body>
</html>
