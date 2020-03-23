<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/1/8 0008
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jQuery1.7.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery1.42.min.js"></script>
    <script>
        self.setInterval("ReturnPage()",5000)//5秒后跳转回原页面
        function ReturnPage() {
            window.location.href="index.jsp"
        }
    </script>
</head>
<body>
<center>
    <h2 style="margin-top: 200px" id="ms">
        登录失败!请检查验证码及用户密码是否正确,5秒后自动跳转回原页面!<a href="index.jsp">立即跳转</a>
    </h2>
</center>
</body>
</html>
