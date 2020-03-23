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
            $('#doomRepairList').datagrid({iconCls: 'icon-more',//图标
                border: true,
                collapsible: false,//是否可折叠
                fit: true,//自动大小
                method: "post",
                url: "${pageContext.request.contextPath }/student/getRepairList?stu_id="+${requestScope.get("stu_id")},
                idField: 'id',
                fitColumns:true,
                singleSelect: false,//是否单选
                rownumbers: true,//行号
                pagination: true,//分页控件
                sortOrder: 'DESC',
                remoteSort: false,
                columns: [[
                    {field: 'chk', checkbox: true, width: 150,editor:{type:'text',required:true}},
                    {field:'id',title: 'id', width: 150},
                    {field:'roomname',title: '楼栋号', width: 150},
                    {field: 'doomname', title: '宿舍名', width: 150,editor:{type:'text',required:true}},
                    {field: 'createDate', title: '上报时间', width: 150,editor:{type:'text',required:true},formatter : function(value){
                            var date = new Date(value);
                            var y = date.getFullYear();
                            var m = date.getMonth() + 1;
                            var d = date.getDate();
                            var h = date.getHours();
                            var min = date.getMinutes();
                            var sec = date.getSeconds();
                            return y + '-' +m + '-' + d +  '  '+ h+':'+min+':'+sec;
                        }},
                    {field:'record',title: '上报记录', width: 150}
                ]],
				toolbar:"#doomRepair"
            });


			$('#recordList').datagrid({
				iconCls: 'icon-more',//图标
				border: true,
				collapsible: false,//是否可折叠
				fit: true,//自动大小
				method: "post",
				url: "${pageContext.request.contextPath }/student/getRecordList?stu_id="+${requestScope.get("stu_id")},
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
							return y + '-' +m + '-' + d +  '  '+ h+':'+min+':'+sec}},
					{field: 'sno', title: '学号', width: 150,editor:{type:'text',required:true}},
					{field: 'username', title: '用户名', width: 150},
					{field: 'roomlevel', title: '宿舍楼', width: 150, sortable: true,editor:{type:'text',required:true}},
					{field: 'roomname', title: '寝室', width: 150, sortable: true,editor:{type:'text',required:true}},
					{field: 'note', title: '记录', width: 150, sortable: true,editor:{type:'text',required:true}}
				]],
				toolbar: "#recordbar"//工具栏
			});

			$("#add_repair").click(function () {
				table = $("#addTable");
				$("#addTable").form("clear");//清空表单数据
				$("#addDialog").dialog("open");//打开添加窗口
			});


			$("#addDialog").dialog({
				title: "维修上报窗口",
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
						text: '上报',
						plain: true,
						iconCls: 'icon-add',
						handler: function () {
							var validate = $("#addForm").form("validate");
							if (!validate) {
								$.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
							} else {
								var data = $("#addForm").serialize();//序列化表单信息
								$.ajax({
									type: "post",
									url: "${pageContext.request.contextPath }/student/addRepairRecord?id="+${requestScope.get("stu_id")},
									dataType: 'json',
									data:data,
									success: function (data) {
										if (data.type="success") {
											//关闭窗口
											$("#addDialog").dialog("close");
											//重新刷新页面数据
											$('#doomRepairList').datagrid("reload");
											$('#doomRepairList').datagrid("uncheckAll");
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



			$('#repassword').form({
				success:function(data){
					$.messager.alert('Info', data, 'info');
				}
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
					<font color="#8b0000" size="20">欢迎登录，${requestScope.get("username")}</font>
				</div>
			</div>
			<table id="postList" cellspacing="0" cellpadding="0"></table>
		</div>

        <div title="水电维修"  style="padding:20px;display:none;width: 20%">
            <div id="doomRepair">
                <div style="float: left;"><a id="add_repair" href="javascript:" class="easyui-linkbutton"
                                             data-options="iconCls:'icon-edit',plain:true">维修上报</a></div>
            </div>
            <table id="doomRepairList" cellspacing="0" cellpadding="0"></table>
        </div>

		<div title="缺勤记录"  style="padding:20px;display:none;width: 20%">
			<table id="recordList" cellspacing="0" cellpadding="0"></table>
		</div>

		<div title="密码修改"  style="padding:20px;display:none;width: 20%">
			<div align="center">
				<form id="repassword" action="${pageContext.request.contextPath }/student/changePassword?sno=${requestScope.get("user_sno")}" method="post">
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
			<form action="${pageContext.request.contextPath }/student/loginout" method="get">
				<input type="submit" value="安全退出">
			</form>
		</div>
	</div>
</div>


<div id="addDialog" style="padding: 15px 0 0 55px;">
	<form id="addForm" method="post" action="#">
		<table id="addTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">

			<tr>
				<td>上报内容</td>
				<td colspan="1">
					<input id="add_repair" style="width: 400px; height: 300px;" class="easyui-textbox"
						   type="text" name="text" data-options="required:true, missingMessage:'内容不能为空'"/>
				</td>
			</tr>
		</table>
	</form>
</div>

</body>
</html>