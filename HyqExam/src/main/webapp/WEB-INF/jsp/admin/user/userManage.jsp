<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <jsp:include page="/common/headLink.jsp"></jsp:include>
    <title>用户管理</title>
    
  <script type="text/javascript">
  	function openUserModifyDialog()
  	{
  		
  		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("温馨提示","请选择一条要编辑的数据");
			return;
		}
  		
  		//打开编辑用户窗体
  		$("#edit_user_dialog").dialog("open");
  		//填入数据
  		var value = selectedRows[0];
  		$("#userInfo_form").form("load",value);
  		//如果没有角色,表明应该是要分配角色
  		if( value.role ==null)
  		{
  			//不做操作，正常提交的url，就做添加角色的操作
  		}else  //否则就可能修改角色
  		{
  			
  			//为角色框赋值
  			$("#roleName").attr("value",value.role.name);
  			$("#roleId").attr("value",value.role.id);
  			//改变url为更新操作
  			$("#userInfo_form").attr("action","${pageContext.request.contextPath}/user/eidtUserInfoAndUpdateRole.action");
  		}
  		
  		
  	}
  	
  	//选择角色按钮
  	function pickRole()
  	{
  		var select = $("#rolelist").datagrid("getSelected");
  		if(select == null){
  			$.messager.alert("温馨提示","请在下方选择一个角色!");
  			return;
  		}
  		//设置角色名称框的值
  		$("#roleId").attr("value",select.id);
  		$("#roleName").attr("value",select.name);
  	}
  	
  	function resetRole(){
  		$("#roleId").attr("value","");
  		$("#roleName").attr("value","");
  	}
  	
  	function searchRoleLoaded(data){
  		alert(data);
  	}
  	
  	function closeEidtDialog(){
  		$("#edit_user_dialog").dialog("close");
  	}
  	
  	//保存修改信息
  	function saveEditDialog()
  	{
  		var nickname = $("#nickname").val();
  		if(nickname==null || ""==nickname)
  		{
  			$.messager.alert("温馨提示","修改的昵称不能为空！");
  			return;
  		}
  		
  		var truename = $("#truename").val();
  		if(truename==null || ""==truename)
  		{
  			$.messager.alert("温馨提示","修改的真实姓名不能为空！");
  			return;
  		}
  		
  		var email = $("#email").val();
  		if(email==null || ""==email){
  			$.messager.alert("温馨提示","修改的邮箱不能为空！");
  			return;
  		}
  		
  		var password = $("#password").val();
  		if(password==null || ""==password)
  		{
  			$.messager.alert("温馨提示","修改的密码不能为空！");
  			return;
  		}
  		
  		var phone = $("#phone").val();
  		if(phone==null || ""==phone)
  		{
  			$.messager.alert("温馨提示","修改的联系方式不能为空！");
  			return;
  		}
  		var roleName = $("#roleName").val();
  		if(roleName==null || ""==roleName)
  		{
  			$.messager.alert("温馨提示","修改的角色名称不能为空！");
  			return;
  		}
  		
  		//如何异步提交表单(提交表单之后，页面必须跳转吗)
  		$("#userInfo_form").submit();
  		
  		
  	}
  	
  	//角色姓名列
  	function roleNameFormat(value,data,index)
  	{
  		var value =data.role;
  		if(value!=null){
  			return value.name;
  		}else{
  			return "";
  		}
  		
  	}
  	//角色描述
  	function roleDesFormat(value,data,index)
  	{
  		var value = data.role;
  		return value==null?"":value.description;
  	}
  	
  	//搜索
  	function searchUser()
  	{
  		$("#dg").datagrid("load",{
  			truename:$("#s_userName").val(),
  			roleId:$("#combobox_role").combobox("getValue")
  		});
  	}
  	
  	//重置搜索
  	function resetSearch()
  	{
  		$("#s_userName").val("");
  		//如何用js选中 第一行
  		$("#combobox_role").combobox("select",$("#combobox_role").combobox("getData")[0].id);
  		//$("#combobox_role").combobox("select",$("#combobox_role")[0]);
  	}
  	
  	//打开添加用户对话框
  	function openAddUserDialog()
  	{
  		$("#add_user_dialog").dialog("open");
  	}
  	
  	
  	//关闭添加用户的对话框
  	function closeAddUserDialog()
  	{
  		$("#add_user_dialog").dialog("close");
  	}
  	
  	//确认添加用户
  	function sureAddUser()
  	{
  		var nickname = $("#add_nickname").val();
  		if(nickname==null || ""==nickname)
  		{
  			$.messager.alert("温馨提示","添加的昵称不能为空！");
  			return;
  		}
  		
  		var truename = $("#add_truename").val();
  		if(truename==null || ""==truename)
  		{
  			$.messager.alert("温馨提示","添加的真实姓名不能为空！");
  			return;
  		}
  		
  		var email = $("#add_email").val();
  		if(email==null || ""==email)
  		{
  			$.messager.alert("温馨提示","添加的邮箱不能为空！");
  			return;
  		}
  		
  		var password = $("#add_password").val();
  		if(password==null || ""==password)
  		{
  			$.messager.alert("温馨提示","添加的密码不能为空！");
  			return;
  		}
  		
  		var phone = $("#add_phone").val();
  		if(phone==null || ""==phone)
  		{
  			$.messager.alert("温馨提示","添加的联系方式不能为空！");
  			return;
  		}
  		
  		$.ajax({
  			url:"${pageContext.request.contextPath}/user/addUserByAdmin.action",
  			type:"post",
  			data:"nickname="+nickname+"&truename="+truename+"&email="+email+"&password="+password+"&phone="+phone,
  			success:function(data)
  			{
  				if(data)
  				{
  					$.messager.alert("温馨提示","添加用户成功!");
  					$("#add_nickname").val("");
  					$("#add_truename").val("");
  					$("#add_email").val("");
  					$("#add_password").val("");
  					$("#add_phone").val("");
  					$("#add_user_dialog").dialog("close");
  					$("#dg").datagrid("reload");
  				}else
  				{
  					$.messager.alert("温馨提示","添加失败!");
  				}
  			}
  		});
  	}
  	
  	
  //删除
  	function deleteAUser()
  	{
  		var selectedRows = $("#dg").datagrid("getSelections");
  		if(selectedRows<1)
  		{
  			$.messager.alert("温馨提示","请选择要删除的用户!");
  			return;
  		}
  		var oldIds = [];
  		for(var i=0;i<selectedRows.length;i++)
  		{
  			oldIds.push(selectedRows[i].id);
  		}
  		var ids = oldIds.join(",");
  		$.messager.confirm("温馨提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗?",function(r){
  			if(r) 
  			{
  				$.ajax({
  					url:"${pageContext.request.contextPath}/user/deleteByIds.action",
  					data:"ids="+ids,
  					type:"post",
  					dataType:"json",
  					success:function(result)
  					{
  						if(result){
  							$.messager.alert("温馨提示","删除成功!");
  							$("#dg").datagrid("reload");
  						}else
  						{
  							$.messager.alert("温馨提示","删除失败！");
  						}
  					}
  				});
  			}
  		});
  	}
  	
  
  	
  		
	

  </script>
  </head>
 
 
 
 
 
 <body style="margin: 1px;">
<table id="dg" title="用户管理" class="easyui-datagrid" fitColumns="true" 
    pagination="true" rownumbers="true" url="${pageContext.request.contextPath }/user/listAllUsers.action" fit="true" toolbar="#tb">
    <thead>
    	<tr>
    		<th field="cb" checkbox="true" align="center"></th>
    		<th field="nickname" width="50" align="center">昵称</th>
    		<th field="truename" width="50" align="center">真实姓名</th>
    		<th field="password" width="100" align="center">用户密码</th>
    		<th field="email" width="100" align="center">邮箱</th>
    		<th field="phone" width="100" align="center">联系方式</th>
    		<th field="roleId" width="100" align="center" hidden="true">用户角色ID</th>
    		<th field="roleName" width="100" align="center" formatter="roleNameFormat">用户角色</th>
    		<th field="description" width="250" align="center" formatter="roleDesFormat">角色描述</th>
    	</tr>
    </thead>
</table>
<div id="tb">
	<div>
		<a href="javascript:openAddUserDialog();" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
		<a href="javascript:openUserModifyDialog();" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
		<a href="javascript:deleteAUser();" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true">简历</a>
	</div>
	<div>
		&nbsp;真实姓名：&nbsp;<input type="text" name="s_userName" id="s_userName" value="" size="20" onkeydown="if(event.keyCode==13) searchUser()"/>
		&nbsp;用户角色：&nbsp;<input class="easyui-combobox" id="combobox_role" name="s_roleId" size="20" data-options="editable:false,panelHeight:'auto',
		valueField:'id',textField:'name',url:'${pageContext.request.contextPath }/role/getExistRoleList.action' "/>
		<a href="javascript:searchUser()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		<a href="javascript:resetSearch()" class="easyui-linkbutton" iconCls="icon-add" plain="true">重置</a>
	</div>
</div>


<div id="dlg-buttons">
	<a href="javascript:saveEditDialog();" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closeEidtDialog();" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div>






<!-- 修改用户信息 -->
<div id="edit_user_dialog" class="easyui-dialog" title="修改用户信息" style="width:600px;height: 400px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">
  <form id="userInfo_form" method="post" action="${pageContext.request.contextPath}/user/eidtUserInfoAndAssitRole.action">
  	<table cellspacing="5px;">
  		<tr>
  			<td>昵称：</td>
  			<td><input type="text" id="nickname" name="nickname" class="easyui-validatebox" required="true"/></td>
		 <td> <input type="hidden" name="id" ></td> 
  			<td>真实姓名:</td>
  			<td><input type="text" id="truename" name="truename" class="easyui-validatebox" required="true"/></td>
  		</tr>
  	
  		
  		<tr>
  			<td>邮箱：</td>
  			<td><input type="text" id="email" name="email" class="easyui-validatebox" required="true"/></td>
  			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
  			<td>密码:</td>
  			<td><input type="text" id="password" name="password" class="easyui-validatebox" required="true"/></td>
  		</tr>
  		
  		<tr>
  			<td>联系方式</td>
  			<td colspan="4"><input type="text" id="phone" name="phone" class="easyui-validatebox" required="true"/></td>
  		</tr>
  			<tr>
  			<td>角色名称：</td>
  			<td><input type="hidden" id="roleId" name="roleId" /><input type="text" id="roleName" class="easyui-validatebox" required="true" name="roleName" readonly="readonly"></td>
  			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
  			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
  			<td ><a href="javascript:pickRole()" data-options="iconCls:'icon-search'" class="easyui-linkbutton" >选择角色</a></td>
  		</tr>
  	</table>
  	
  	        <table id="rolelist" class="easyui-datagrid" style="width:540px;height:210px"   
        data-options="url:'${pageContext.request.contextPath }/role/listAllRoles.action',fitColumns:true,singleSelect:true,pagination:true">   
    <thead>   
        <tr>   
            <th data-options="field:'id',width:100">编号</th>   
            <th data-options="field:'name',width:100">角色名称</th>   
            <th data-options="field:'description',width:300,align:'right'">角色描述</th>   
        </tr>   
    </thead>   
</table> 
  </form>
</div>
<!-- 修改用户信息end -->


<!-- 添加用户-->
<div id="add_user_dialog" class="easyui-dialog" title="添加用户" style="width:500px;height: 200px;padding: 10px 20px"
  closed="true" buttons="#addUserBtns">
  <form id="addUser_form" method="post" action="${pageContext.request.contextPath}/user/addUserByAdmin.action">
  	<table cellspacing="5px;">
  		<tr>
  			<td>昵称：</td>
  			<td><input type="text" id="add_nickname" name="nickname" class="easyui-validatebox" required="true"/></td>
  			<td>真实姓名:</td>
  			<td><input type="text" id="add_truename" name="truename" class="easyui-validatebox" required="true"/></td>
  		</tr>
  	
  		<tr>
  			<td>邮箱：</td>
  			<td><input type="text" id="add_email" name="email" class="easyui-validatebox" required="true"/></td>
  			<td>密码:</td>
  			<td><input type="text" id="add_password" name="password" class="easyui-validatebox" required="true"/></td>
  		</tr>
  		<tr>
  			<td>联系方式</td>
  			<td colspan="3"><input type="text" id="add_phone" name="phone" class="easyui-validatebox" required="true"/></td>
  	</table>
  </form>
</div>
<!-- 添加用户  end -->

 <div id="addUserBtns">
	<a href="javascript:sureAddUser();" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closeAddUserDialog();" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div>







</body>
 
 
 
  
 
</html>
