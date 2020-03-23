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
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/easyui-lang-zh_CN.js"></script>

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
                sortName: 'id',
                sortOrder: 'DESC',
                remoteSort: false,
                columns: [[
                    {field: 'chk', checkbox: true, width: 150,editor:{type:'text',required:true}},
                    {field: 'id', title: 'ID', width: 150, sortable: true,editor:{type:'text',required:true}},
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
                ]],
                toolbar: "#postBar"
            });
			$('#dataList').datagrid({
				iconCls: 'icon-more',//图标
				border: true,
				collapsible: false,//是否可折叠
				fit: true,//自动大小
				method: "post",
				url: "${pageContext.request.contextPath }/admin/getStudentList",
				saveUrl: 'save_user.php',
				updateUrl: 'update_user.php',
				destroyUrl: 'destroy_user.php',
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
					{field: 'adnumber', title: '宿舍号', width: 150,editor:{type:'text',required:true}},
                    {field: 'status', title: '状态', width: 150,editor:{type:'text',required:true}}
				]],
				toolbar: "#studentbar"//工具栏
			});
			$('#roomTeacherList').datagrid({
				iconCls: 'icon-more',//图标
				border: true,
				collapsible: false,//是否可折叠
				fit: true,//自动大小
				method: "post",
				url: "${pageContext.request.contextPath }/admin/getRoomTeacherList",
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
					{field: 'id',  title: 'ID', width: 150, sortable: true,editor:{type:'text',required:true}},
					{field: 'username', title: '姓名', width: 150,editor:{type:'text',required:true}},
					{field: 'sno', title: '工号', width: 150,editor:{type:'text',required:true}},
					{field: 'telephone', title: '电话', width: 150,editor:{type:'text',required:true}},
					{field: 'email', title: '邮箱', width: 150,editor:{type:'text',required:true}},
					{field:'roomname',title:'楼栋',width: 150},
                    {field: 'status', title: '状态', width: 150,editor:{type:'text',required:true}}
				]],
				toolbar: "#teacherbar"//工具栏
			});

			$('#roomList').datagrid({
				iconCls: 'icon-more',//图标
				border: true,
				collapsible: false,//是否可折叠
				fit: true,//自动大小
				method: "post",
				url: "${pageContext.request.contextPath }/admin/getRoomList",
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
					{field: 'name', title: '名称', width: 150,editor:{type:'text',required:true}},
					{field: 'profess', title: '专业', width: 150,editor:{type:'text',required:true}}
				]],
				toolbar: "#roombar"//工具栏
			});

			$('#recordList').datagrid({
				iconCls: 'icon-more',//图标
				border: true,
				collapsible: false,//是否可折叠
				fit: true,//自动大小
				method: "post",
				url: "${pageContext.request.contextPath }/admin/getRecordList",
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

            $('#userOperateList').datagrid({
                iconCls: 'icon-more',//图标
                border: true,
                collapsible: false,//是否可折叠
                fit: true,//自动大小
                method: "post",
                url: "${pageContext.request.contextPath }/admin/getUserOperateRecord",
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
                    {field: 'username', title: '用户名', width: 150,editor:{type:'text',required:true}},
                    {field: 'usersno', title: '学号', width: 150,editor:{type:'text',required:true}},
                    {field: 'creatDate', title: '操作时间', width: 150,formatter : function(value){
                            var date = new Date(value);
                            var y = date.getFullYear();
                            var m = date.getMonth() + 1;
                            var d = date.getDate();
                            var h = date.getHours();
                            var min = date.getMinutes();
                            var sec = date.getSeconds();
                            return y + '-' +m + '-' + d +  '  '+ h+':'+min+':'+sec;
                        }},
                    {field: 'ipAddress', title: 'ip地址', width: 150,editor:{type:'text',required:true}},
                    {field: 'describe', title: '操作描述', width: 150,editor:{type:'text',required:true}},
                    {field: 'type', title: '操作类型', width: 150,editor:{type:'text',required:true}}
                ]],
                toolbar: "#userOperatebar"//工具栏
            });
            $("#post_add").click(function(){
                table = $("#post_AddTable");
                $("#post_AddTable").form("clear");//清空表单数据
                $("#post_AddDialog").dialog("open");//打开添加窗口
            });
            $("#post_edit").click(function () {
                table = $("#post_EditTable");
                var selectRows = $("#postList").datagrid("getSelections");
                if (selectRows.length !== 1) {
                    $.messager.alert("消息提醒", "请单条选择想要修改的数据哟!", "warning");
                } else {
                    $("#post_EditDialog").dialog("open");
                }
            });
            $("#post_delete").click(function () {
                var selectRows = $("#postList").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                var selectLength = selectRows.length;
                if (selectLength === 0) {
                    $.messager.alert("消息提醒", "请选择想要删除的数据!", "warning");
                } else {
                    var ids;
                    $(selectRows).each(function (i, row) {
                        ids = row.id;//将预删除行的id存储到数组中
                    });
                    $.messager.confirm("消息提醒", "删除后将无法恢复该学生信息! 确定继续?", function (r) {
                        if (r) {
                            $.ajax({
                                type: "post",
                                url: "${pageContext.request.contextPath }/post/deletePost",
                                data: {ids: ids},
                                dataType: 'json',
                                success: function (data) {
                                    if (data.type="success") {
                                        $.messager.alert('Info', "删除成功!", 'info');
                                        $('#postList').datagrid("reload");
                                        $('#postList').datagrid("uncheckAll");

                                    } else {
                                        $.messager.alert("消息提醒", "服务器端发生异常! 删除失败!", "warning");
                                    }
                                }
                            });
                        }
                    });
                }
            });
			$("#add").click(function () {
				table = $("#addTable");
				$("#addTable").form("clear");//清空表单数据
				$("#addDialog").dialog("open");//打开添加窗口
			});
			$("#edit").click(function () {
				table = $("#editTable");
				var selectRows = $("#dataList").datagrid("getSelections");
				if (selectRows.length !== 1) {
					$.messager.alert("消息提醒", "请单条选择想要修改的数据哟!", "warning");
				} else {
					$("#editDialog").dialog("open");
				}
			});
            $("#stu_fib_login").click(function () {
                var selectRows = $("#dataList").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                var selectLength = selectRows.length;
                if (selectLength === 0) {
                    $.messager.alert("消息提醒", "请选择想要删除的数据!", "warning");
                } else {
                    var ids;
                    $(selectRows).each(function (i, row) {
                        ids = row.id;//将预删除行的id存储到数组中
                    });
                    $.messager.confirm("消息提醒", "学生将被禁止登陆! 确定继续?", function (r) {
                        if (r) {
                            $.ajax({
                                type: "post",
                                url: "${pageContext.request.contextPath }/admin/stuAccLogin?type=0",
                                data: {ids: ids},
                                dataType: 'json',
                                success: function (data) {
                                    if (data.type="success") {
                                        $.messager.alert('Info', "操作成功!", 'info');
                                        $('#dataList').datagrid("reload");
                                        $('#dataList').datagrid("uncheckAll");

                                    } else {
                                        $.messager.alert("消息提醒", "服务器端发生异常! 操作失败!", "warning");
                                    }
                                }
                            });
                        }
                    });
                }
            });
            $("#stu_acc_login").click(function () {
                var selectRows = $("#dataList").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                var selectLength = selectRows.length;
                if (selectLength === 0) {
                    $.messager.alert("消息提醒", "请选择想要删除的数据!", "warning");
                } else {
                    var ids;
                    $(selectRows).each(function (i, row) {
                        ids = row.id;//将预删除行的id存储到数组中
                    });
                    $.messager.confirm("消息提醒", "学生将被允许登陆! 确定继续?", function (r) {
                        if (r) {
                            $.ajax({
                                type: "post",
                                url: "${pageContext.request.contextPath }/admin/stuAccLogin?type=1",
                                data: {ids: ids},
                                dataType: 'json',
                                success: function (data) {
                                    if (data.type="success") {
                                        $.messager.alert('Info', "操作成功!", 'info');
                                        $('#dataList').datagrid("reload");
                                        $('#dataList').datagrid("uncheckAll");

                                    } else {
                                        $.messager.alert("消息提醒", "服务器端发生异常! 操作失败!", "warning");
                                    }
                                }
                            });
                        }
                    });
                }
            });
			$("#delete").click(function () {
				var selectRows = $("#dataList").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
				var selectLength = selectRows.length;
				if (selectLength === 0) {
					$.messager.alert("消息提醒", "请选择想要删除的数据!", "warning");
				} else {
					var ids;
					$(selectRows).each(function (i, row) {
						ids = row.id;//将预删除行的id存储到数组中
					});
					$.messager.confirm("消息提醒", "删除后将无法恢复该学生信息! 确定继续?", function (r) {
						if (r) {
							$.ajax({
								type: "post",
								url: "${pageContext.request.contextPath }/admin/deleteStudent",
								data: {ids: ids},
								dataType: 'json',
								success: function (data) {
									if (data.type="success") {
                                        $.messager.alert('Info', "删除成功!", 'info');
                                        $('#dataList').datagrid("reload");
                                        $('#dataList').datagrid("uncheckAll");

									} else {
										$.messager.alert("消息提醒", "服务器端发生异常! 删除失败!", "warning");
									}
								}
							});
						}
					});
				}
			});
            $("#post_AddDialog").dialog({
                title: "添加通知信息窗口",
                width: 660,
                height: 470,
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
                                //var text=$("#add_text").combobox("getValue");
                                var data = $("#post_AddForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "${pageContext.request.contextPath }/post/addPost",
                                    dataType: 'json',
                                    data:data,
                                    success: function (data) {
                                        if (data.type="success") {
                                            //关闭窗口
                                            $("#post_AddDialog").dialog("close");
                                            //重新刷新页面数据
                                            $('#postList').datagrid("reload");
                                            $('#postList').datagrid("uncheckAll");
                                            $.messager.alert('Info', data.message, 'info');
                                        } else {
                                            $.messager.alert("消息提醒", data.message, "warning");
                                        }
                                    }
                                });

                        }
                    },
                    {
                        text: '重置',
                        plain: true,
                        iconCls: 'icon-reload',
                        handler: function () {

                        }
                    }
                ]
            });
            $("#post_EditDialog").dialog({
                title: "修改学生信息窗口",
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
                            var data = $("#post_EditForm").serialize();//序列化表单信息
                            var row = $("#postList").datagrid('getSelected');
                            if(row){
                                var id = row.id;
                            };
                                $.ajax({
                                    type: "post",
                                    url: "${pageContext.request.contextPath }/post/editPost?id="+id,
                                    dataType: 'json',
                                    data:data,
                                    success: function (data) {
                                        if (data.type="success") {
                                            //关闭窗口
                                            $("#post_EditDialog").dialog("close");
                                            //重新刷新页面数据
                                            $('#postList').datagrid("reload");
                                            $('#postList').datagrid("uncheckAll");
                                            //用户提示
                                            $.messager.alert('Info', data.message, 'info');
                                        } else {
                                            $.messager.alert("消息提醒", data.message, "warning");
                                        }
                                    }
                                });

                        }
                    },
                    {
                        text: '重置',
                        plain: true,
                        iconCls: 'icon-reload',
                        handler: function () {
                        }
                    }
                ],
                //打开窗口前先初始化表单数据(表单回显)
                onBeforeOpen: function () {

                    var selectRow = $("#postList").datagrid("getSelected");
                    $("#edit_text").textbox('setValue', selectRow.text);//初始化id值,需根据id更新教师信息
                }
            });
			$("#addDialog").dialog({
				title: "添加学生信息窗口",
				width: 660,
				height: 470,
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
							var room_id=$("#add_room").combobox("getValue");
							var doom_id=$("#add_doom").combobox("getValue");
							var clazz_id=$("#add_clazz_name").combobox("getValue");
                            var admin_id=$("#add_admin").text();


							if (!validate) {
								$.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
							} else {
								var data = $("#addForm").serialize();//序列化表单信息
								$.ajax({
									type: "post",
									url: "${pageContext.request.contextPath }/admin/addStudent?"+"room_id="+room_id+"&&doom_id="+doom_id+"&&admin_id="+admin_id+"&&clazz_id="+clazz_id,
									dataType: 'json',
                                    data:data,
									success: function (data) {
                                        if (data.type="success") {
                                            //关闭窗口
                                            $("#addDialog").dialog("close");
                                            //重新刷新页面数据
                                            $('#dataList').datagrid("reload");
                                            $('#dataList').datagrid("uncheckAll");
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
							$("#add_sno").textbox('setValue', "");
							$("#add_name").textbox('setValue', "");
							$("#add_gender").textbox('setValue', "男");
							$("#add_password").textbox('setValue', "");
							$("#add_profess").textbox('setvalue',"");
							$("#add_clazz_name").textbox('setvalue',"");
							$("#add_doom").textbox('setvalue',"");
							$("#add_room").textbox('setvalue',"");
						}
					}
				]
			});
			$("#editDialog").dialog({
				title: "修改学生信息窗口",
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

							var validate = $("#editForm").form("validate");
							var admin_id=$("#edit_admin").text();
                            var row = $("#dataList").datagrid('getSelected');
                            if(row){
                                var stu_id = row.id;
                            };
							if (!validate) {
								$.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
							} else {
								var data = $("#editForm").serialize();//序列化表单信息
								$.ajax({
									type: "post",
									url: "${pageContext.request.contextPath }/admin/editStudent?admin_id="+admin_id+"&&stu_id="+stu_id,
									dataType: 'json',
                                    data:data,
									success: function (data) {
										if (data.type="success") {
											//关闭窗口
											$("#editDialog").dialog("close");
											//重新刷新页面数据
											$('#dataList').datagrid("reload");
											$('#dataList').datagrid("uncheckAll");
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
							$("#edit_name").textbox('setValue', "");
							$("#edit_gender").textbox('setValue', "男");
							$("#edit_password").textbox('setValue', "");
						}
					}
				],
				//打开窗口前先初始化表单数据(表单回显)
				onBeforeOpen: function () {
					var selectRow = $("#dataList").datagrid("getSelected");
					$("#edit_id").val(selectRow.id);//初始化id值,需根据id更新教师信息
					$("#edit_sno").textbox('setValue', selectRow.sno);
					$("#edit_name").textbox('setValue', selectRow.username);
                    $("#edit_password").textbox('setValue', selectRow.password);
					$("#edit_gender").textbox('setValue', selectRow.gender);
                    $("#edit_telephone").textbox('setValue', selectRow.telephone);
				}
			});



            $("#t_add").click(function () {
                table = $("#addTable");
                $("#t_addTable").form("clear");//清空表单数据
                $("#t_addDialog").dialog("open");//打开添加窗口
            });
            $("#t_edit").click(function () {
                table = $("#t_editTable");
                var selectRows = $("#roomTeacherList").datagrid("getSelections");
                if (selectRows.length !== 1) {
                    $.messager.alert("消息提醒", "请单条选择想要修改的数据哟!", "warning");
                } else {
                    $("#t_editDialog").dialog("open");
                }
            });
            $("#tea_fib_login").click(function () {
                var selectRows = $("#roomTeacherList").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                var selectLength = selectRows.length;
                if (selectLength === 0) {
                    $.messager.alert("消息提醒", "请选择想要修改的数据!", "warning");
                } else {
                    var ids;
                    $(selectRows).each(function (i, row) {
                        ids = row.id;//将预删除行的id存储到数组中
                    });
                    $.messager.confirm("消息提醒", "学生将被禁止登陆! 确定继续?", function (r) {
                        if (r) {
                            $.ajax({
                                type: "post",
                                url: "${pageContext.request.contextPath }/admin/teaAccLogin?type=0",
                                data: {ids: ids},
                                dataType: 'json',
                                success: function (data) {
                                    if (data.type="success") {
                                        $.messager.alert('Info', "操作成功!", 'info');
                                        $('#roomTeacherList').datagrid("reload");
                                        $('#roomTeacherList').datagrid("uncheckAll");

                                    } else {
                                        $.messager.alert("消息提醒", "服务器端发生异常! 操作失败!", "warning");
                                    }
                                }
                            });
                        }
                    });
                }
            });
            $("#tea_acc_login").click(function () {
                var selectRows = $("#roomTeacherList").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                var selectLength = selectRows.length;
                if (selectLength === 0) {
                    $.messager.alert("消息提醒", "请选择想要修改的数据!", "warning");
                } else {
                    var ids;
                    $(selectRows).each(function (i, row) {
                        ids = row.id;//将预删除行的id存储到数组中
                    });
                    $.messager.confirm("消息提醒", "学生将被允许登陆! 确定继续?", function (r) {
                        if (r) {
                            $.ajax({
                                type: "post",
                                url: "${pageContext.request.contextPath }/admin/teaAccLogin?type=1",
                                data: {ids: ids},
                                dataType: 'json',
                                success: function (data) {
                                    if (data.type="success") {
                                        $.messager.alert('Info', "操作成功!", 'info');
                                        $('#roomTeacherList').datagrid("reload");
                                        $('#roomTeacherList').datagrid("uncheckAll");
                                    } else {
                                        $.messager.alert("消息提醒", "服务器端发生异常! 操作失败!", "warning");
                                    }
                                }
                            });
                        }
                    });
                }
            });

            $("#t_delete").click(function () {
                var selectRows = $("#roomTeacherList").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                var selectLength = selectRows.length;
                if (selectLength === 0) {
                    $.messager.alert("消息提醒", "请选择想要删除的数据!", "warning");
                } else {
                    var ids;
                    $(selectRows).each(function (i, row) {
                        ids = row.id;//将预删除行的id存储到数组中
                    });
                    $.messager.confirm("消息提醒", "删除后将无法恢复该学生信息! 确定继续?", function (r) {
                        if (r) {
                            $.ajax({
                                type: "post",
                                url: "${pageContext.request.contextPath }/admin/deleteTeacher",
                                data: {ids: ids},
                                dataType: 'json',
                                success: function (data) {
                                    if (data.type="success") {
                                        $.messager.alert('Info', "删除成功", 'info');
                                        $('#roomTeacherList').datagrid("reload");
                                        $('#roomTeacherList').datagrid("uncheckAll");
                                        //取消勾选当前页所有的行
                                    } else {
                                        $.messager.alert("消息提醒", "服务器端发生异常! 删除失败!", "warning");
                                    }
                                }
                            });
                        }
                    });
                }
            });
            $("#t_addDialog").dialog({
                title: "添加教师信息窗口",
                width: 660,
                height: 470,
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
                            var row = $("#roomTeacherList").datagrid('getSelected');
                            var validate = $("#t_addForm").form("validate");
                            var admin_id=$("#add_admin").text();
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
                            } else {
                                var data = $("#t_addForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "${pageContext.request.contextPath }/admin/addTeacher?admin_id="+admin_id,
                                    dataType: 'json',
                                    data:data,
                                    success: function (data) {
                                        if (data.type="success") {
                                            //关闭窗口
                                            $("#t_addDialog").dialog("close");
                                            //重新刷新页面数据
                                            $('#roomTeacherList').datagrid("reload");
                                            $('#roomTeacherList').datagrid("uncheckAll");
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
                            $("#t_add_sno").textbox('setValue', "");
                            $("#t_add_name").textbox('setValue', "");
                            $("#t_add_gender").textbox('setValue', "男");
                            $("#t_add_password").textbox('setValue', "");
                        }
                    }
                ]
            });


            $("#t_editDialog").dialog({
                title: "修改学生信息窗口",
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

                            var validate = $("#t_editForm").form("validate");
                            var admin_id=$("#t_edit_admin").text();
                            var row = $("#roomTeacherList").datagrid('getSelected');
                            if(row){
                                var tea_id = row.id;
                            };
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
                            } else {
                                var data = $("#t_editForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "${pageContext.request.contextPath }/admin/editTeacher?admin_id="+admin_id+"&&stu_id="+tea_id,
                                    dataType: 'json',
                                    data:data,
                                    success: function (data) {
                                        if (data.type="success") {
                                            //关闭窗口
                                            $("#t_editDialog").dialog("close");
                                            //重新刷新页面数据
                                            $('#roomTeacherList').datagrid("reload");
                                            $('#roomTeacherList').datagrid("uncheckAll");
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
                            $("#t_edit_name").textbox('setValue', "");
                            $("#t_edit_gender").textbox('setValue', "男");
                            $("#t_edit_password").textbox('setValue', "");
                        }
                    }
                ],
                //打开窗口前先初始化表单数据(表单回显)
                onBeforeOpen: function () {
                    var selectRow = $("#roomTeacherList").datagrid("getSelected");
                    $("#t_edit_id").val(selectRow.id);//初始化id值,需根据id更新教师信息
                    $("#t_edit_sno").textbox('setValue', selectRow.sno);
                    $("#t_edit_name").textbox('setValue', selectRow.username);
                    $("#t_edit_password").textbox('setValue', selectRow.password);
                    $("#t_edit_telephone").textbox('setValue', selectRow.telephone);
                    $("#t_edit_mail").textbox('setValue', selectRow.email);
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
            $("#all_delete").click(function () {
                var selectRows = $("#allocateRoom").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                var selectLength = selectRows.length;
                if (selectLength === 0) {
                    $.messager.alert("消息提醒", "请选择想要删除的数据!", "warning");
                } else {
                    var ids;
                    $(selectRows).each(function (i, row) {
                        ids = row.id;//将预删除行的id存储到数组中
                    });
                    $.messager.confirm("消息提醒", "删除后将无法恢复该学生信息! 确定继续?", function (r) {
                        if (r) {
                            $.ajax({
                                type: "post",
                                url: "${pageContext.request.contextPath }/admin/deleteAllocateRoom",
                                data: {ids: ids},
                                dataType: 'json',
                                success: function (data) {
                                    if (data.type="success") {
                                        $.messager.alert("消息提醒", "删除成功啦!", "info");
                                        $("#allocateRoom").datagrid("reload");//刷新表格
                                        $("#allocateRoom").datagrid("uncheckAll");//取消勾选当前页所有的行
                                    } else {
                                        $.messager.alert("消息提醒", "服务器端发生异常! 删除失败!", "warning");
                                    }
                                }
                            });
                        }
                    });
                }
            });
            $("#all_editDialog").dialog({
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

                            var validate = $("#all_editForm").form("validate");
                            var row = $("#allocateRoom").datagrid('getSelected');
                            if(row){
                                var stu_id = row.id;
                            };
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据!", "warning");
                            } else {
                                var data = $("#all_editForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "${pageContext.request.contextPath }/admin/editAllocateRoom?stu_id="+stu_id,
                                    dataType: 'json',
                                    data:data,
                                    success: function (data) {
                                        if (data.type="success") {
                                            //关闭窗口
                                            $("#all_editDialog").dialog("close");
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
                    },
                    {
                        text: '重置',
                        plain: true,
                        iconCls: 'icon-reload',
                        handler: function () {
                        }
                    }
                ],
                //打开窗口前先初始化表单数据(表单回显)
                onBeforeOpen: function () {
                    var selectRow = $("#roomTeacherList").datagrid("getSelected");
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
                    },
                    {
                        text: '重置',
                        plain: true,
                        iconCls: 'icon-reload',
                        handler: function () {
                        }
                    }
                ],
                //打开窗口前先初始化表单数据(表单回显)
                onBeforeOpen: function () {
                    var selectRow = $("#roomTeacherList").datagrid("getSelected");
                }
            });

            $("#search-btn").click(function () {
                $('#dataList').datagrid('load', {
                    username: $('#search-studentname').val(),//获取学生名称
                    usersno:$('#search-studentsno').val(),
                    clazzId: $('#search-clazzname').combobox('getValue')//获取年级名称
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

			$('#repassword').form({
				success:function(data){
					$.messager.alert('Info', data, 'info');
				}
			});
		});
		function getDoomStudentNum(){
		    var se_doom_id = document.getElementById("append_afterdoom_html").value;
		    alert(se_doom_id);
		    $.get("${pageContext.request.contextPath }/Admin/getDoomStudentNum",{doom_id:se_doom_id},
                function(data){
		        $("#append_afterdoom_html").append('<div style="color: red">'+data+'</div>');
            })
        };


	</script>

	<style type="text/css">

	</style>
</head>
<body class="easyui-layout">
<div data-options="region:'south',title:'South Title',split:true" style="height:100px;"></div>
<div data-options="region:'center',title:'操作模块'" style="padding:5px;background:#eee;height:1250px ">
	<div id="tt" class="easyui-tabs" style="height: 550px;">
		<div title="首页" style="padding:20px;display:none; width: 20%" >
            <div id="postBar">
                <div style="float: left;"><a id="post_add" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-add',plain:true">添加公告</a></div>
                <div style="float: left;" class="datagrid-btn-separator"></div>
                <div style="float: left;"><a id="post_edit" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-edit',plain:true">编辑公告</a></div>
                <div style="float: left;" class="datagrid-btn-separator"></div>
                <div style="float: left;"><a id="post_delete" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-remove',plain:true">删除公告</a></div>
            </div>
			<div>
				<div class=blank align="right">
					<font color="#8b0000" size="20">欢迎${requestScope.get("username")},系统管理员!</font>
				</div>
			</div>
            <table id="postList" cellspacing="0" cellpadding="0"></table>
        </div>
		<div title="宿舍管理员管理"  style="padding:20px;display:none; width: 20%">
            <div id="teacherbar">
                <div style="float: left;"><a id="t_add" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-add',plain:true">添加</a></div>
                <div style="float: left;" class="datagrid-btn-separator"></div>
                <div style="float: left;"><a id="t_edit" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-edit',plain:true">修改</a></div>
                <div style="float: left;" class="datagrid-btn-separator"></div>
                <div style="float: left;"><a id="t_delete" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-remove',plain:true">删除</a></div>
                <div style="float: left;"><a id="tea_acc_login" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-ok',plain:true">允许登陆</a></div>
                <div style="float: left;"><a id="tea_fib_login" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-lock',plain:true">禁止登陆</a></div>
            </div>
			<table id="roomTeacherList" cellspacing="0" cellpadding="0"></table>
		</div>
		<div title="学生管理" id="studentManage" style="padding:20px;display:none;width: 20%">
			<div id="studentbar">
				<div style="float: left;"><a id="add" href="javascript:" class="easyui-linkbutton"
											 data-options="iconCls:'icon-add',plain:true">添加</a></div>
				<div style="float: left;" class="datagrid-btn-separator"></div>
				<div style="float: left;"><a id="edit" href="javascript:" class="easyui-linkbutton"
											 data-options="iconCls:'icon-edit',plain:true">修改</a></div>
				<div style="float: left;" class="datagrid-btn-separator"></div>
				<div style="float: left;"><a id="delete" href="javascript:" class="easyui-linkbutton"
											 data-options="iconCls:'icon-remove',plain:true">删除</a></div>
                <div style="float: left;"><a id="stu_acc_login" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-ok',plain:true">允许登陆</a></div>
                <div style="float: left;"><a id="stu_fib_login" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-lock',plain:true">禁止登陆</a></div>
                <div style="margin-left: 10px;">
                    <div style="float: left;" class="datagrid-btn-separator"></div>
                    <!-- 班级名称下拉框 -->

                    <a href="javascript:" class="easyui-linkbutton"
                       data-options="iconCls:'icon-class',plain:true">班级名称</a>
                    <select id="search-clazzname" style="width: 155px;" class="easyui-combobox" name="clazzId">
                        <!-- 通过JSTL遍历显示年级信息,clazzList:为Contrller传递的来的,存储着Clazz的List对象 -->
                        <option value="">未选择班级</option>
                        <c:forEach items="${clazzList}" var="clazz">
                            <option value="${clazz.id}">${clazz.number}</option>
                        </c:forEach>
                    </select>

                    <a href="javascript:" class="easyui-linkbutton"
                       data-options="iconCls:'icon-user-teacher',plain:true">学生学号</a>

                    <input id="search-studentsno" class="easyui-textbox" name="se_stu_sno"/>
                    <!-- 搜索按钮 -->
                    <input hidden="true" value="search" name="searchType"><!--查询标记-->
                    <a id="search-btn" href="javascript:" class="easyui-linkbutton"
                       data-options="iconCls:'icon-search',plain:true">搜索</a>
                </div>
			</div>
			<table id="dataList" cellspacing="0" cellpadding="0"></table>

		</div>
		<div title="宿舍楼管理"  style="padding:20px;display:none;width: 20%">
			<table id="roomList" cellspacing="0" cellpadding="0"></table>
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
            <div style="margin-left: 10px;">
                <div style="float: left;" class="datagrid-btn-separator"></div>
                <!-- 班级名称下拉框 -->

                <a href="javascript:" class="easyui-linkbutton"
                   data-options="iconCls:'icon-class',plain:true">楼栋名称</a>
                <select id="re_search-roomname" style="width: 155px;" class="easyui-combobox" name="roomId">
                    <!-- 通过JSTL遍历显示年级信息,clazzList:为Contrller传递的来的,存储着Clazz的List对象 -->
                    <option value="">未选择楼栋</option>
                    <c:forEach items="${roomList}" var="clazz">
                        <option value="${room.id}">${room.name}</option>
                    </c:forEach>
                </select>
                <a href="javascript:" class="easyui-linkbutton"
                   data-options="iconCls:'icon-class',plain:true">宿舍名称</a>
                <select id="re_search-doomname" style="width: 155px;" class="easyui-combobox" name="doomId">
                    <!-- 通过JSTL遍历显示年级信息,clazzList:为Contrller传递的来的,存储着Clazz的List对象 -->
                    <option value="">未选择宿舍</option>
                    <c:forEach items="${doomList}" var="clazz">
                        <option value="${doom.id}">${doom.name}</option>
                    </c:forEach>
                </select>
                <a href="javascript:" class="easyui-linkbutton"
                   data-options="iconCls:'icon-user-teacher',plain:true">学生学号</a>

                <input id="re_search-studentsno" class="easyui-textbox" name="se_stu_sno"/>
                <!-- 搜索按钮 -->
                <input hidden="true" value="search"><!--查询标记-->
                <a id="re_search-btn" href="javascript:" class="easyui-linkbutton"
                   data-options="iconCls:'icon-search',plain:true">搜索</a>
            </div>
			<table id="recordList" cellspacing="0" cellpadding="0"></table>
		</div>
        <div title="用户操作日志"  style="padding:20px;display:none;width: 20%">
            <a href="javascript:" class="easyui-linkbutton"
               data-options="iconCls:'icon-user-teacher',plain:true">起始日期:</a>
            <input id="record_begin_date" data-options="formatter:ww4,required:true, missingMessage:'日期不能为空'" style="float:right" type="text" class="easyui-datetimebox" required="required">
            <a href="javascript:" class="easyui-linkbutton"
               data-options="iconCls:'icon-user-teacher',plain:true">结束日期:</a>
            <input id="record_end_data" style="float:right" data-options="formatter:ww4,required:true, missingMessage:'日期不能为空'" type="text" class="easyui-datetimebox" required="required">
            <script type="text/javascript">
                function ww4(date){
                        var date = new Date(date);
                        var y = date.getFullYear();
                        var m = date.getMonth() + 1;
                        var d = date.getDate();
                        var h = date.getHours();
                        var min = date.getMinutes();
                        var sec = date.getSeconds();
                        return y + '-' +m + '-' + d;
                }</script>
            <a id="date_record_search-btn" href="javascript:" class="easyui-linkbutton"
               data-options="iconCls:'icon-search',plain:true">搜索</a>
            <table id="userOperateList" cellspacing="0" cellpadding="0"></table>
        </div>
        <div title="密码修改"  style="padding:20px;display:none;width: 20%">
            <div align="center">
                <form id="repassword" action="${pageContext.request.contextPath }/admin/changePassword?sno=${requestScope.get("user_sno")}" method="post">
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
            <form action="${pageContext.request.contextPath }/admin/loginout" method="get">
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
            <tr hidden="true">
                <td>管理员_id</td>
                <td name="admin_id" id="add_admin" >${requestScope.get("admin_id")}</td>
            </tr>

            <tr>
                <td>姓名</td>
                <td colspan="1">
                    <input id="add_name" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="username" data-options="required:true, missingMessage:'姓名不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>班级</td>
                <td colspan="1">
                    <select id="add_clazz_name" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="clazzId" data-options="required:true, missingMessage:'班级不能为空'">
                        <c:forEach items="${clazzList}" var="clazz">
                            <option value="${clazz.id}">${clazz.number}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <tr>
                <td>学号</td>
                <td colspan="1">
                    <input id="add_sno" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="sno" data-options="required:true, missingMessage:'学号不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>性别</td>
                <td>
                    <select id="add_gender" class="easyui-combobox"
                            data-options="editable: false, panelHeight: 50, width: 60, height: 30,
                            required:true, missingMessage:'性别不能为空'" name="gender">
                        <option>男</option>
                        <option>女</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td>密码</td>
                <td colspan="1">
                    <input id="add_password" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="password" data-options="required:true, missingMessage:'密码不能为空'"/>
                </td>
            </tr>

            <tr>
                <td>电话</td>
                <td colspan="4"><input id="add_telephone" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="telephone" validType="mobile"
                                       data-options="required:true, missingMessage:'电话不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>楼栋</td>
                <td colspan="1">
                    <select id="add_room" style="width: 200px; height: 30px;"class="easyui-combobox" data-options="editable: false,required:false" name="room">
                    <c:forEach items="${roomList}" var="room">
                        <option value="${room.id}">${room.name}</option>
                    </c:forEach>
                    </select>
                </td>
            </tr>

            <tr>
                <td>宿舍</td>
                <td colspan="1">
                <select id="add_doom" style="width: 200px; height: 30px;"class="easyui-combobox" data-options="editable: false,required:false" name="doom">
                    <c:forEach items="${doomList}" var="doom">
                        <option value="${doom.id}">${doom.name}</option>
                    </c:forEach>
                    </select>
                </td>
            </tr>
        </table>
    </form>
</div>

<!--  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -->
<div id="editDialog" style="padding: 15px 0 0 55px;">

    <!-- 学生信息表单 -->
    <form id="editForm" method="post" action="#">
        <table id="editTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">

            <tr hidden="true">
                <td>管理员_id</td>
                <td name="admin_id" id="edit_admin">${requestScope.get("admin_id")}</td>
            </tr>
            <tr hidden="true">
                <td>管理员_id</td>
                <td name="stu_id" id="edit_stuId">${requestScope.get("stu_id")}</td>
            </tr>
            <tr>
                <td>姓名</td>
                <td colspan="1">
                    <input id="edit_name" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="username" data-options="required:true, missingMessage:'姓名不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>班级</td>
                <td colspan="1">
                    <select id="edit_clazz_name" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="clazzId" data-options="required:true, missingMessage:'班级不能为空'">
                        <c:forEach items="${clazzList}" var="clazz">
                            <option value="${clazz.id}">${clazz.number}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <tr>
                <td>学号</td>
                <td colspan="1">
                    <input id="edit_sno" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="sno" data-options="required:true, missingMessage:'学号不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>性别</td>
                <td>
                    <select id="edit_gender" class="easyui-combobox"
                            data-options="editable: false, panelHeight: 50, width: 60, height: 30,
                            required:true, missingMessage:'性别不能为空'" name="gender">
                        <option>男</option>
                        <option>女</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td>密码</td>
                <td colspan="1">
                    <input id="edit_password" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="password"/>
                </td>
            </tr>

            <tr>
                <td>电话</td>
                <td colspan="4"><input id="edit_telephone" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="telephone" validType="mobile"
                                       data-options="required:true, missingMessage:'电话不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>楼栋</td>
                <td colspan="1">
                    <select id="edit_room" style="width: 200px; height: 30px;"class="easyui-combobox" data-options="editable: false,required:true, missingMessage:'楼栋不能为空'" name="room">
                        <c:forEach items="${roomList}" var="room">
                            <option value="${room.id}">${room.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <tr>
                <td>宿舍</td>
                <td colspan="1">
                    <select id="edit_doom" style="width: 200px; height: 30px;"class="easyui-combobox" data-options="editable: false,required:true, missingMessage:'宿舍不能为空'" name="doom">
                        <c:forEach items="${doomList}" var="doom">
                            <option value="${doom.id}">${doom.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
        </table>
    </form>
</div>




<div id="t_addDialog" style="padding: 15px 0 0 55px;">

    <!-- 教师信息表单 -->
    <form id="t_addForm" method="post" action="#">
        <table id="t_addTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">
            <!-- 存储所上传的头像路径 -->
            <%--<input id="add_portrait-path" type="hidden" name="portrait_path"/>--%>

            <tr hidden="true">
                <td>管理员_id</td>
                <td name="admin_id" id="t_add_admin" >${requestScope.get("admin_id")}</td>
            </tr>

            <tr>
                <td>姓名</td>
                <td colspan="1">
                    <input id="t_add_name" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="username" data-options="required:true, missingMessage:'姓名不能为空'"/>
                </td>
            </tr>

            <tr>
                <td>工号</td>
                <td colspan="1">
                    <input id="t_add_sno" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="sno" data-options="required:true, missingMessage:'学号不能为空'"/>
                </td>
            </tr>

            <tr>
                <td>密码</td>
                <td colspan="1">
                    <input id="t_add_password" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="password" data-options="required:true, missingMessage:'密码不能为空'"/>
                </td>
            </tr>

            <tr>
                <td>电话</td>
                <td colspan="4"><input id="t_add_telephone" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="telephone" validType="mobile"
                                       data-options="required:true, missingMessage:'电话不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>邮箱</td>
                <td colspan="4"><input id="t_add_mail" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="mail" validType="mobile"
                                       data-options="required:true, missingMessage:'邮箱不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>楼栋</td>
                <td colspan="1">
                    <select id="t_add_room" style="width: 200px; height: 30px;"class="easyui-combobox" data-options="editable: false,required:true, missingMessage:'楼栋不能为空'" name="room">
                        <c:forEach items="${roomList}" var="room">
                            <option value="${room.id}">${room.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>


        </table>
    </form>
</div>

<!--  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -->
<div id="t_editDialog" style="padding: 15px 0 0 55px;">
    <!-- 设置添加头像功能 -->
    <%--<div style="float: right; margin: 15px 40px 0 0; width: 250px; border: 1px solid #EEF4FF" id="add-photo">
        <img id="add-portrait" alt="照片" style="max-width: 250px; max-height: 300px;" title="照片"
             src="/image/portrait/default_teacher_portrait.png"/>
        <!-- 头像信息表单 -->
        <form id="add-uploadForm" method="post" enctype="multipart/form-data" action="uploadPhoto"
              target="photo_target">
            <input id="choose-portrait" class="easyui-filebox" name="photo" data-options="prompt:'选择照片'"
                   style="width:200px;">
            <input id="add-upload-btn" class="easyui-linkbutton" style="width: 50px; height: 24px;;float:right;"
                   type="button" value="上传"/>
        </form>
    </div>--%>
    <!-- 教师信息表单 -->
    <form id="t_editForm" method="post" action="#">
        <table id="t_editTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">
            <!-- 存储所上传的头像路径 -->
            <%--<input id="add_portrait-path" type="hidden" name="portrait_path"/>--%>


            <tr hidden="true">
                <td>管理员_id</td>
                <td name="admin_id" id="t_edit_admin">${requestScope.get("admin_id")}</td>
            </tr>
            <tr hidden="true">
                <td>学生_id</td>
                <td name="stu_id" id="t_edit_stuId">${requestScope.get("stu_id")}</td>
            </tr>
            <tr>
                <td>姓名</td>
                <td colspan="1">
                    <input id="t_edit_name" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="username" data-options="required:true, missingMessage:'姓名不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>工号</td>
                <td colspan="1">
                    <input id="t_edit_sno" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="sno" data-options="required:true, missingMessage:'学号不能为空'"/>
                </td>
            </tr>

            <tr>
                <td>密码</td>
                <td colspan="1">
                    <input id="t_edit_password" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="password"/>
                </td>
            </tr>

            <tr>
                <td>电话</td>
                <td colspan="4"><input id="t_edit_telephone" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="telephone" validType="mobile"
                                       data-options="required:true, missingMessage:'电话不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>邮箱</td>
                <td colspan="4"><input id="t_edit_mail" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="mail" validType="mobile"
                                       data-options="required:true, missingMessage:'邮箱不能为空'"/>
                </td>
            </tr>
            <tr>
                <td>楼栋</td>
                <td colspan="1">
                    <select id="t_edit_room" style="width: 200px; height: 30px;"class="easyui-combobox" data-options="editable: false,required:true, missingMessage:'楼栋不能为空'" name="room">
                        <c:forEach items="${roomList}" var="room">
                            <option value="${room.id}" >${room.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>

        </table>
    </form>
</div>







<!--  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -->
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
            <tr id="append_afterdoom_html">
                <td id="se_doom">宿舍</td>
                <td colspan="1">
                    <select id="all_all_doom" style="width: 200px; height: 30px;"class="easyui-combobox" data-options="editable: false,required:true, missingMessage:'宿舍不能为空'" name="doom" onclick="getDoomStudentNum()">
                        <c:forEach items="${doomList}" var="doom">
                            <option value="${doom.id}" id="se_doom_id">${doom.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
        </table>
    </form>
</div>
<!--                    通知--------------------------------------------->

<div id="post_AddDialog" style="padding: 15px 0 0 55px;">

    <!-- 教师信息表单 -->
    <form id="post_AddForm" method="post" action="#">
        <table id="post_AddTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">
            <tr>
                <td>通知内容</td>
                <td colspan="1">
                    <input id="add_text" style="width: 400px; height: 300px;" class="easyui-textbox"
                           type="text" name="text" data-options="required:true, missingMessage:'内容不能为空'"/>
                </td>
            </tr>

        </table>
    </form>
</div>

<!--  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -->
<div id="post_EditDialog" style="padding: 15px 0 0 55px;">

    <!-- 教师信息表单 -->
    <form id="post_EditForm" method="post" action="#">
        <table id="post_EditTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">
            <tr>
                <td>通知内容</td>
                <td colspan="1">
                    <input id="edit_text" style="width: 400px; height: 300px;" class="easyui-textbox"
                           type="text" name="text" data-options="required:true, missingMessage:'内容不能为空'"/>
                </td>
            </tr>

        </table>
    </form>
</div>

</body>
</html>