<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>宿舍管理系统</title>

    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.easyui.min.js"></script>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/icon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/demo.css">

    <script type="text/javascript">

        function check(){

            $valid_password = document.getElementById("valid_password").value;
            $new_password = document.getElementById("new_password").value;
            $renew_password = document.getElementById("renew_password").value;


            if($valid_password == ''){
                alert("旧密码不能空");
                return false;
            }
            if($new_password==''||$renew_password==''){
                alert("新密码不能为空");
                return false;
            }
            if($new_password!=$renew_password){
                alert("输入密码不一致，请重新输入");
                return false;
            }
            return true;
        }

        $(function () {
            var table;
            var tea_id = ${requestScope.get("tea_id")};
            //初始化datagrid
            $('#postList').datagrid({iconCls: 'icon-more',//图标
                border: true,
                collapsible: false,//是否可折叠
                fit: true,//自动大小
                method: "post",
                url: "${pageContext.request.contextPath }/post/getPostList",
                idField: 'id',
                fitColumns:true,
                singleSelect: false,//是否单选
                rownumbers: true,//行号
                pagination: true,//分页控件
                sortOrder: 'DESC',
                remoteSort: false,
                columns: [[
                    {field: 'chk', checkbox: true, width: 150,editor:{type:'text',required:true}},
                    {field: 'text', title: '公告内容', width: 150,editor:{type:'text',required:true}},
                    {field: 'createDate', title: '发布时间', width: 150,editor:{type:'text',required:true},formatter : function(value){
                            var date = new Date(value);
                            var y = date.getFullYear();
                            var m = date.getMonth() + 1;
                            var d = date.getDate();
                            var h = date.getHours();
                            var min = date.getMinutes();
                            var sec = date.getSeconds();
                            return y + '-' +m + '-' + d +  '  '+ h+':'+min+':'+sec;
                        }}
                ]]
            });
            $('#dataList').datagrid({
                iconCls: 'icon-more',//图标
                border: true,
                collapsible: false,//是否可折叠
                fit: true,//自动大小
                method: "post",
                url: "${pageContext.request.contextPath }/teacher/getStudentList?tea_id="+tea_id,
                idField: 'id',
                fitColumns:true,
                singleSelect: false,//是否单选
                rownumbers: true,//行号
                pagination: true,//分页控件
                sortName: 'id',
                sortOrder: 'DESC',
                remoteSort: false,
                columns: [[
                    {field: 'chk', checkbox: true, width: 150,editor:{type:'text',required:true}},
                    {field: 'id', title: 'ID', width: 150, sortable: true,editor:{type:'text',required:true}},
                    {field: 'username', title: '姓名', width: 150,editor:{type:'text',required:true}},
                    {field: 'clazzId', title: '班级', width: 150,editor:{type:'text',required:true}},
                    {field: 'sno', title: '学号', width: 150,editor:{type:'text',required:true}},
                    {field:'profess',title:'专业',width:150,editor:{type:'text',required:true}},
                    {field: 'gender', title: '性别', width: 150,editor:{type:'text',required:true}},
                    {field: 'telephone', title: '电话', width: 150,editor:{type:'text',required:true}},
                    {field: 'roomlevel', title: '栋数', width: 150,editor:{type:'text',required:true}},
                    {field: 'adnumber', title: '宿舍号', width: 150,editor:{type:'text',required:true}}
                ]],
                toolbar: "#studentbar"//工具栏
            });


            $('#recordList').datagrid({
                iconCls: 'icon-more',//图标
                border: true,
                collapsible: false,//是否可折叠
                fit: true,//自动大小
                method: "post",
                url: "${pageContext.request.contextPath }/teacher/getRecordList?tea_id="+${requestScope.get("tea_id")},
                idField: 'id',
                fitColumns:true,
                singleSelect: false,//是否单选
                rownumbers: true,//行号
                pagination: true,//分页控件
                sortName: 'id',
                sortOrder: 'DESC',
                remoteSort: false,
                columns: [[
                    {field: 'chk', checkbox: true, width: 150,editor:{type:'text',required:true}},
                    {field: 'id', title: 'ID', width: 150, sortable: true,editor:{type:'text',required:true}},
                    {field: 'data', title: '日期', width: 150,formatter : function(value){
                            var date = new Date(value);
                            var y = date.getFullYear();
                            var m = date.getMonth() + 1;
                            var d = date.getDate();
                            var h = date.getHours();
                            var min = date.getMinutes();
                            var sec = date.getSeconds();
                            return y + '-' +m + '-' + d +  '  '+ h+':'+min+':'+sec;}},
                    {field: 'sno', title: '学号', width: 150,editor:{type:'text',required:true}},
                    {field: 'username', title: '用户名', width: 150},
                    {field: 'roomlevel', title: '宿舍楼', width: 150, sortable: true,editor:{type:'text',required:true}},
                    {field: 'roomname', title: '寝室', width: 150, sortable: true,editor:{type:'text',required:true}},
                    {field: 'note', title: '记录', width: 150, sortable: true,editor:{type:'text',required:true}}
                ]],
                toolbar: "#recordbar"//工具栏
            });
            $('#allocateRoom').datagrid({
                iconCls: 'icon-more',//图标
                border: true,
                collapsible: false,//是否可折叠
                fit: true,//自动大小
                method: "post",
                url: "${pageContext.request.contextPath }/admin/allocateRoomToStudent",
                idField: 'id',
                fitColumns:true,
                singleSelect: false,//是否单选
                rownumbers: true,//行号
                pagination: true,//分页控件
                sortName: 'id',
                sortOrder: 'DESC',
                remoteSort: false,
                columns: [[
                    {field: 'chk', checkbox: true, width: 150,editor:{type:'text',required:true}},
                    {field: 'id', title: 'ID', width: 150, sortable: true,editor:{type:'text',required:true}},
                    {field: 'sno', title: '学号', width: 150,editor:{type:'text',required:true}},
                    {field: 'username', title: '用户名', width: 150},
                    {field: 'clazzId', title: '班级', width: 150},
                    {field: 'profess', title: '专业', width: 150, sortable: true,editor:{type:'text',required:true}},
                    {field: 'gender', title: '性别', width: 150, sortable: true,editor:{type:'text',required:true}}
                ]],
                toolbar: "#allocatebar"//工具栏
            });

            $("#add_record").click(function () {
                table = $("#editTable");
                var selectRows = $("#dataList").datagrid("getSelections");
                if (selectRows.length !== 1) {
                    $.messager.alert("消息提醒", "请单条选择想要给学生添加的记录!", "warning");
                } else {
                    $("#addDialog").dialog("open");
                }
            });
            $("#edit_record").click(function () {
                table = $("#editTable");
                    var selectRows = $("#recordList").datagrid("getSelections");
                    if (selectRows.length !== 1) {
                    $.messager.alert("消息提醒", "请单条选择想要修改的数据哟!", "warning");
                } else {
                    $("#editDialog").dialog("open");
                }
            });
            $("#delete_record").click(function () {
                var selectRows = $("#recordList").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                var selectLength = selectRows.length;
                if (selectLength === 0) {
                    $.messager.alert("消息提醒", "请选择想要删除的数据!", "warning");
                } else {
                    var ids = [];
                    $(selectRows).each(function (i, row) {
                        ids[i] = row.id;//将预删除行的id存储到数组中
                    });
                    $.messager.confirm("消息提醒", "删除后将无法恢复该记录! 确定继续?", function (r) {
                        if (r) {
                            $.ajax({
                                type: "post",
                                url: "${pageContext.request.contextPath }/teacher/deleteStudentRecord?ids="+ids,
                                dataType: 'json',
                                success: function (data) {
                                    if (data.type="success") {
                                        $.messager.alert("消息提醒", "删除成功啦!", "info");
                                        $("#recordList").datagrid("reload");//刷新表格
                                        $("#recordList").datagrid("uncheckAll");//取消勾选当前页所有的行
                                    } else {
                                        $.messager.alert("消息提醒", "服务器端发生异常! 删除失败!", "warning");
                                    }
                                }
                            });
                        }
                    });
                }
            });
            $("#addDialog").dialog({
                title: "添加记录窗口",
                width: 430,
                height: 300,
                iconCls: "icon-house",
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                buttons: [
                    {
                        text: '添加',
                        plain: true,
                        iconCls: 'icon-add',
                        handler: function () {
                            var validate = $("#addForm").form("validate");
                            var row = $("#dataList").datagrid('getSelected');
                            var stu_id=row.id;

                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
                            } else {
                                var data = $("#addForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "${pageContext.request.contextPath }/teacher/addStudentRecord?stu_id="+stu_id,
                                    dataType: 'json',
                                    data:data,
                                    success: function (data) {
                                        if (data.type="success") {
                                            //关闭窗口
                                            $("#addDialog").dialog("close");
                                            //重新刷新页面数据
                                            $('#recordList').datagrid("reload");
                                            $('#recordList').datagrid("uncheckAll");
                                            $.messager.alert('Info', data.message, 'info');
                                        } else {
                                            $.messager.alert("消息提醒", data.message, "warning");
                                        }
                                    }
                                });
                            }
                        }
                    },
                    {
                        text: '重置',
                        plain: true,
                        iconCls: 'icon-reload',
                        handler: function () {
                            $("#add_sno").textbox('setValue', selectRow.sno);
                            $("#add_name").textbox('setValue', selectRow.username);
                        }
                    }
                ],
                onBeforeOpen: function () {
                    var selectRow = $("#dataList").datagrid("getSelected");
                    $("#add_sno").textbox('setValue', selectRow.sno);
                    $("#add_name").textbox('setValue', selectRow.username);
                }
            });
            $("#editDialog").dialog({
                title: "修改记录窗口",
                width: 430,
                height: 300,
                iconCls: "icon-house",
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                buttons: [
                    {
                        text: '提交',
                        plain: true,
                        iconCls: 'icon-edit',
                        handler: function () {
                            var validate = $("#editForm").form("validate");
                            var row = $("#recordList").datagrid('getSelected');
                            if(row){
                                var record_id = row.id;
                            };
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
                            } else {
                                var data = $("#editForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "${pageContext.request.contextPath }/teacher/editStudentRecord?record_id="+record_id,
                                    dataType: 'json',
                                    data:data,
                                    success: function (data) {
                                        if (data.type="success") {
                                            //关闭窗口
                                            $("#editDialog").dialog("close");
                                            //重新刷新页面数据
                                            $('#recordList').datagrid("reload");
                                            $('#recordList').datagrid("uncheckAll");
                                            //用户提示
                                            $.messager.alert('Info', data.message, 'info');
                                        } else {
                                            $.messager.alert("消息提醒", data.message, "warning");
                                        }
                                    }
                                });
                            }
                        }
                    },
                    {
                        text: '重置',
                        plain: true,
                        iconCls: 'icon-reload',
                        handler: function () {
                            $("#edit_sno").textbox('setValue', selectRow.sno);
                            $("#edit_name").textbox('setValue', selectRow.username);
                        }
                    }
                ],
                //打开窗口前先初始化表单数据(表单回显)
                onBeforeOpen: function () {
                    var selectRow = $("#recordList").datagrid("getSelected");
                    $("#edit_id").val(selectRow.id);//初始化id值,需根据id更新教师信息
                    $("#edit_sno").textbox('setValue', selectRow.sno);
                    $("#edit_name").textbox('setValue', selectRow.username);
                }
            });

            $("#all_all_edit").click(function () {//一键分配
                var selectRows = $("#allocateRoom").datagrid("getSelections");
                if (selectRows.length ==0) {
                    $.messager.alert("消息提醒", "请选择想要分配宿舍的学生!", "warning");
                } else if(selectRows.length>6){
                    $.messager.alert("消息提醒", "一次最多分配六名学生!", "warning");
                }else {
                    $("#all_all_editDialog").dialog("open");
                }
            });
            $("#all_all_editDialog").dialog({
                title: "分配学生宿舍信息窗口",
                width: 660,
                height: 430,
                iconCls: "icon-house",
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                buttons: [
                    {
                        text: '提交',
                        plain: true,
                        iconCls: 'icon-edit',
                        handler: function () {

                            var validate = $("#all_all_editForm").form("validate");
                            var selectRows = $("#allocateRoom").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                            var selectLength = selectRows.length;
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据!", "warning");
                            } else {
                                var ids=[];
                                $(selectRows).each(function (i, row) {
                                    ids[i] = row.id;//将预删除行的id存储到数组中
                                });
                                var data = $("#all_all_editForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "${pageContext.request.contextPath }/admin/editAllocateRooms?ids="+ids,
                                    dataType: 'json',
                                    data:data,
                                    success: function (data) {
                                        if (data.type="success") {
                                            //关闭窗口
                                            $("#all_all_editDialog").dialog("close");
                                            //重新刷新页面数据
                                            $('#allocateRoom').datagrid("reload");
                                            $('#allocateRoom').datagrid("uncheckAll");
                                            //用户提示
                                            $.messager.alert('Info', data.message, 'info');
                                        } else {
                                            $.messager.alert("消息提醒", data.message, "warning");
                                        }
                                    }
                                });
                            }
                        }
                    }
                ]
            });
            $('#repassword').form({
                success:function(data){
                    $.messager.alert('Info', data, 'info');
                }
            });
        });
        $("#ma_search-btn").click(function () {
            $('#dataList').datagrid('load', {
                clazzname: $('#ma_search-clazzname').val(),//获取学生名称
                usersno:$('#ma_search_studentsno').val(),
                clazzId: $('#ma_search-clazzname').combobox('getValue')//获取年级名称
            });
        });
        $("#date_record_search-btn").click(function(){
            $('#userOperateList').datagrid('load',{
                beginDate:$("#record_begin_date").val(),
                endDate:$("#record_end_data").val()
            });
        });
        $("#re_search-roomname").change(function(){
            $.get("getDoomForRoom",{},function(){

            });
        });


    </script>

    <style type="text/css">

    </style>
</head>
<body class="easyui-layout">
<div data-options="region:'south',title:'South Title',split:true" style="height:100px;"></div>
<div data-options="region:'center',title:'操作模块'" style="padding:5px;background:#eee;height:1250px ">
    <div id="tt" class="easyui-tabs" style="height: 550px;">
        <div title="首页" style="padding:20px;display:none; width: 20%" >
            <div>
                <div class=blank align="right">
                    <font color="#8b0000" size="20">欢迎${requestScope.get("username")},宿舍管理员!</font>
                </div>
            </div>
            <table id="postList" cellspacing="0" cellpadding="0"></table>
        </div>
        <div title="学生管理" id="studentManage" style="padding:20px;display:none;width: 20%">
            <div id="studentbar">
                <div style="float: left;"><a id="add_record" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-add',plain:true">添加记录</a></div>
                <div style="float: left;" class="datagrid-btn-separator"></div>
                <div style="margin-left: 10px;">
                    <div style="float: left;" class="datagrid-btn-separator"></div>
                    <!-- 班级名称下拉框 -->

                    <a href="javascript:" class="easyui-linkbutton"
                       data-options="iconCls:'icon-class',plain:true">班级名称</a>
                    <select id="ma_search-clazzname" style="width: 155px;" class="easyui-combobox" name="clazzId">
                        <!-- 通过JSTL遍历显示年级信息,clazzList:为Contrller传递的来的,存储着Clazz的List对象 -->
                        <option value="">未选择班级</option>
                        <c:forEach items="${clazzList}" var="clazz">
                            <option value="${clazz.id}">${clazz.number}</option>
                        </c:forEach>
                    </select>

                    <a href="javascript:" class="easyui-linkbutton"
                       data-options="iconCls:'icon-user-teacher',plain:true">学生学号</a>

                    <input id="ma_search_studentsno" class="easyui-textbox" name="se_stu_sno"/>
                    <!-- 搜索按钮 -->
                    <a id="ma_search-btn" href="javascript:" class="easyui-linkbutton"
                       data-options="iconCls:'icon-search',plain:true">搜索</a>
                </div>
            </div>

            <table id="dataList" cellspacing="0" cellpadding="0"></table>

        </div>
        <div title="宿舍分配"  style="padding:20px;display:none;width: 20%">
            <div id="allocatebar">
                <div style="float: left;"><a id="all_all_edit" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-edit',plain:true">一键分配</a></div>
                <div style="float: left;" class="datagrid-btn-separator"></div>
                <div style="float: left;"><a id="all_delete" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-remove',plain:true">删除</a></div>
            </div>
            <table id="allocateRoom" cellspacing="0" cellpadding="0">

            </table>
        </div>
        <div title="缺勤记录"  style="padding:20px;display:none;width: 20%">
            <div id="recordbar">
                <div style="float: left;"><a id="edit_record" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-edit',plain:true">记录更改</a></div>
                <div style="float: left;"><a id="delete_record" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-remove',plain:true">记录删除</a></div>
                <div style="margin-left: 10px;">
                    <div style="float: left;" class="datagrid-btn-separator"></div>
                    <!-- 班级名称下拉框 -->
                    <a href="javascript:" class="easyui-linkbutton"
                       data-options="iconCls:'icon-class',plain:true">班级名称</a>
                    <select id="re_search-clazzname" style="width: 155px;" class="easyui-combobox" name="clazzId">
                        <!-- 通过JSTL遍历显示年级信息,clazzList:为Contrller传递的来的,存储着Clazz的List对象 -->
                        <option value="">未选择班级</option>
                        <c:forEach items="${clazzList}" var="clazz">
                            <option value="${clazz.id}">${clazz.number}</option>
                        </c:forEach>
                    </select>

                    <a href="javascript:" class="easyui-linkbutton"
                       data-options="iconCls:'icon-user-teacher',plain:true">学生学号</a>

                    <input id="re_search-studentsno" class="easyui-textbox" name="se_stu_sno"/>
                    <!-- 搜索按钮 -->
                    <a id="re_search-btn" href="javascript:" class="easyui-linkbutton"
                       data-options="iconCls:'icon-search',plain:true">搜索</a>
                </div>
            </div>

            <table id="recordList" cellspacing="0" cellpadding="0"></table>
        </div>
        <div title="密码修改"  style="padding:20px;display:none;width: 20%">
            <div align="center">
                <form id="repassword" action="${pageContext.request.contextPath }/teacher/changePassword?sno=${requestScope.get("user_sno")}" method="post">
                    旧密码:&nbsp;&nbsp;<input name="valid_password" id="valid_password" class="easyui-textbox"  style="width:200px;">
                    <br/>
                    新密码:&nbsp;&nbsp;<input name="new_password" id="new_password" class="easyui-textbox"  style="width:200px;">
                    <br/>
                    确认密码:<input class="easyui-textbox" id="renew_password"  style=" width:200px;">
                    <br/>
                    <input type="submit"  value="提交" onclick="return check()" >
                </form>
            </div>

        </div>
        <div title="退出系统"  style="padding:20px;display:none;width: 20%" align="center">
            <form action="${pageContext.request.contextPath }/teacher/loginout" method="get">
                <input type="submit" value="安全退出">
            </form>
        </div>
    </div>
</div>


<!--     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx         -->

<!-- 添加信息窗口 -->
<div id="addDialog" style="padding: 15px 0 0 55px;">
    <form id="addForm" method="post" action="#">
        <table id="addTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">

            <tr>
                <td>姓名</td>
                <td colspan="1">
                    <input id="add_name" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="username" data-options="editable: false,required:true, missingMessage:'姓名不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>学号</td>
                <td colspan="1">
                    <input id="add_sno" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="sno" data-options="editable: false,required:true, missingMessage:'学号不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>原因</td>
                <td>
                    <select id="add_record_text" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="record" data-options="editable: false,required:true, missingMessage:'记录不能为空'">
                        <option value="晚归">晚归</option>
                        <option value="夜不归宿">夜不归宿</option>
                        <option value="宿舍脏乱差">宿舍脏乱差</option>
                        <option value="其他违规行为">其他违规行为</option>
                    </select>
                </td>
            </tr>
        </table>
    </form>
</div>

<!--  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -->
<div id="editDialog" style="padding: 15px 0 0 55px;">

    <!-- 教师信息表单 -->
    <form id="editForm" method="post" action="#">
        <table id="editTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">

            <tr>
                <td>姓名</td>
                <td colspan="1">
                    <input id="edit_name" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="username" data-options="editable: false,required:true, missingMessage:'姓名不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>学号</td>
                <td colspan="1">
                    <input id="edit_sno" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="sno" data-options="editable: false,required:true, missingMessage:'学号不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>原因</td>
                <td>
                    <select id="edit_record_text" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="record" data-options="editable: false,required:true, missingMessage:'记录不能为空'">
                        <option value="晚归">晚归</option>
                        <option value="夜不归宿">夜不归宿</option>
                        <option value="宿舍脏乱差">宿舍脏乱差</option>
                        <option value="其他违规行为">其他违规行为</option>
                    </select>
                </td>
            </tr>
        </table>
    </form>
</div>
<div id="all_all_editDialog" style="padding: 15px 0 0 55px;">

    <!-- 教师信息表单 -->
    <form id="all_all_editForm" method="post" action="#">
        <table id="all_all_editTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">
            <!-- 存储所上传的头像路径 -->
            <%--<input id="add_portrait-path" type="hidden" name="portrait_path"/>--%>


            <tr hidden="true">
                <td>管理员_id</td>
                <td name="admin_id" id="all_all_edit_admin">${requestScope.get("admin_id")}</td>
            </tr>
            <tr hidden="true">
                <td>学生_id</td>
                <td name="stu_id" id="all_all_edit_stuId">${requestScope.get("stu_id")}</td>
            </tr>

            <tr>
                <td>班级</td>
                <td colspan="1">
                    <select id="add_all_clazz_name" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="clazzId" data-options="required:true, missingMessage:'班级不能为空'">
                        <c:forEach items="${clazzList}" var="clazz">
                            <option value="${clazz.id}">${clazz.number}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <td>楼栋</td>
            <td colspan="1">
                <select id="all_all_edit_room" style="width: 200px; height: 30px;"class="easyui-combobox" data-options="editable: false,required:true, missingMessage:'楼栋不能为空'" name="room">
                    <c:forEach items="${roomList}" var="room">
                        <option value="${room.id}">${room.name}</option>
                    </c:forEach>
                </select>
            </td>
            </tr>
            <tr>
                <td>宿舍</td>
                <td colspan="1">
                    <select id="all_all_doom" style="width: 200px; height: 30px;"class="easyui-combobox" data-options="editable: false,required:true, missingMessage:'宿舍不能为空'" name="doom">
                        <c:forEach items="${doomList}" var="doom">
                            <option value="${doom.id}">${doom.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>