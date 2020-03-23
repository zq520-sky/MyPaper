﻿<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>账户注册</title>
    <style type="text/css">
        body,input{
            margin: 0;
            padding: 0;
            background: pink;
        }
        input{
            display: inline-block;
            background: #fff;
        }
        .xiao-container{
            width: 100%;
        }
        .xiao-register-box{
            position: relative;
            height: 800px;
            width: 800px;
            top: 50px;
            margin: 0 auto;
            z-index: 99999;
            background:#ffffff;
            border: 7px solid #ccc;
        }
        .xiao-title-box{
            position: absolute;
            width: 300px;
            height: 50px;
            margin-left: 250px;
            margin-top: 5px;
            text-align: center;
            font-size: 28px;
            font-weight: 800;
            color: #ff5000;
            line-height: 50px;
        }
        .xiao-username-box{
            position: absolute;
            width: 420px;
            height: 40px;
            line-height: 40px;
            margin-top:100px;
            margin-left:80px;
            font-weight: 700;
        }
        .xiao-username-input{
            display: inline-block;
            margin-left: 45px;
            /*background: green;*/
        }
        #username{
            height: 35px;
            width: 290px;
            border: 2px solid #ccc;
            border-radius: 5px;
        }
        .xiao-userPassword-box{
            position: absolute;
            width: 420px;
            height: 40px;
            line-height: 40px;
            margin-top:180px;
            margin-left:80px;
            font-weight: 700;
        }
        .xiao-userPassword-input{
            display: inline-block;
            margin-left: 61px;
        }
        #userPassword{
            height: 35px;
            width: 290px;
            border: 2px solid #ccc;
            border-radius: 5px;
        }
        .xiao-userRePassword-box{
            position: absolute;
            width: 420px;
            height: 40px;
            line-height: 40px;
            margin-top:260px;
            margin-left:80px;
            font-weight: 700;
        }
        .xiao-userRePassword-input{
            display: inline-block;
            margin-left: 28px;
        }
        #userRePassword{
            height: 35px;
            width: 290px;
            border: 2px solid #ccc;
            border-radius: 5px;
        }
        .xiao-userPhone-box{
            position: absolute;
            width: 420px;
            height: 40px;
            line-height: 40px;
            margin-top:340px;
            margin-left:80px;
            font-weight: 700;
        }
        .xiao-userPhone-input{
            display: inline-block;
            margin-left: 28px;
        }
        #userPhone{
            height: 35px;
            width: 290px;
            border: 2px solid #ccc;
            border-radius: 5px;
        }
        .xiao-userEmail-box{
            position: absolute;
            width: 420px;
            height: 40px;
            line-height: 40px;
            margin-top:420px;
            margin-left:80px;
            font-weight: 700;
        }
        .xiao-userEmail-input{
            display: inline-block;
            margin-left: 28px;
        }
        #userEmail{
            height: 35px;
            width: 290px;
            border: 2px solid #ccc;
            border-radius: 5px;
        }

        .xiao-userGender-box{
            position: absolute;
            width: 420px;
            height: 40px;
            line-height: 40px;
            margin-top:500px;
            margin-left:82px;
            font-weight: 700;
        }
        .xiao-userGender-input{
            display: inline-block;
            margin-left: 62px;
        }
        .xiao-require{
            color: red;
        }
        .xiao-submit-box{
            position:absolute;
            width: 80px;
            height: 40px;
            line-height: 40px;
            margin-top: 580px;
            margin-left:200px;
            border-radius: 5px;
            background: grey;
        }
        #xiao-submit-button{
            display: inline-block;
            width: 80px;
            height: 40px;
            border-radius: 5px;
            background: red;
        }
        .xiao-goLogin-box{
            position:absolute;
            width: 150px;
            height: 20px;
            margin-top: 600px;
            margin-left:320px;

        }

        .xiao-cl-box{
            position: absolute;
            width: 420px;
            height: 40px;
            line-height: 40px;
            margin-top:180px;
            margin-left:80px;
            font-weight: 700;
        }
        .xiao-class-input{
            display: inline-block;
            margin-left: 61px;
        }
        #class{
            height: 35px;
            width: 290px;
            border: 2px solid #ccc;
            border-radius: 5px;
        }

    </style>
</head>
<body>
<div class="xiao-container">
    <div class="xiao-register-box">
        <div class="xiao-title-box">
            <span>管理员注册</span>
        </div>
        <form action="#" method="post">
            <div class="xiao-username-box">
                <span class="xiao-require">*</span>
                <label for="username">用户名</label>
                <div class="xiao-username-input">
                    <input type="text" id="username" name="username" placeholder="请输入用户名 长度:6-12个字符" />
                </div>
            </div>

            <div class="xiao-userPassword-box">
                <span class="xiao-require">*</span>
                <label for="userPassword">密码</label>
                <div class="xiao-userPassword-input">
                    <input type="password" id="userPassword" name="userPassword" placeholder="请输入密码 长度:6-12个字符" />
                </div>
            </div>

            <div class="xiao-userRePassword-box">
                <span class="xiao-require">*</span>
                <label for="userRePassword">确认密码</label>
                <div class="xiao-userRePassword-input">
                    <input type="password" id="userRePassword" name="userRePassword" placeholder="请重复输入密码" />
                </div>
            </div>

            <div class="xiao-userPhone-box">
                <span class="xiao-require">*</span>
                <label for="userPhone">手机号码</label>
                <div class="xiao-userPhone-input">
                    <input type="text" id="userPhone" name="userPhone" placeholder="请输入您的手机号码，11位有效数字" />
                </div>
            </div>

            <div class="xiao-userEmail-box">
                <span class="xiao-require">*</span>
                <label for="userEmail">电子邮箱</label>
                <div class="xiao-userEmail-input">
                    <input type="text" id="userEmail" name="userEmail" placeholder="请输入您的邮箱地址，如：123@qq.com" />
                </div>
            </div>

            <div class="xiao-userGender-box">
                <span class="xiao-require">*</span>
                <label for="userGender">性别</label>
                <div class="xiao-userGender-input">
                    <input type="radio" id="userGender_01" name="userGender" value="0" checked="checked" />男   
                    <input type="radio" id="userGender_02" name="userGender" value="1" />女
                </div>
            </div>

            <div class="xiao-submit-box">
                <input id = "xiao-submit-button" type="submit" value="注册">
            </div>

            <div class="xiao-goLogin-box">
                <a href="${pageContext.request.contextPath } " style="text-decoration: none;">已有账号？去登录</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
