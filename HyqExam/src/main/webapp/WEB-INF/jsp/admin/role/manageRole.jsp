<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>角色管理</title>
  <jsp:include page="/common/headLink.jsp"></jsp:include>
  <script type="text/javascript">
  var id ;
  
	function newRole()
	{
		clear();
		$("#newRole").dialog("open");
	}
	
	function addRole()
	{
		var name = $("#rname").val();
		if(name ==null || name=="")
		{
			$.messager.alert("温馨提示","请输入角色名称!");
			return;
		}
		
		var des = $("#rdesc").val();
		if(des ==null || des=="")
		{
			$.messager.alert("温馨提示","请输入角色描述!");
			return;
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath}/role/addRole.action",
			data:"name="+name+"&description="+des,
			type:"post",
			success:function(data)
			{
				if(data)
				{
					$.messager.alert("温馨提示","角色添加成功!");
					$("#newRole").dialog("close");
					$("#dg").datagrid("reload");
					
				
				}else
				{
					$.messager.alert("温馨提示","角色添加失败!");
				}
			}
		});
	}
	function clear()
	{
		$("#rname").val("");
		$("#rdesc").val("");
	}
	function clear2()
	{
		$("#editName").val("");
		$("#editDesc").val("");
	}
	
	function editRole()
	{
		var selectedRows = $("#dg").datagrid("getSelections");
		if(selectedRows.length<1)
  		{
  			$.messager.alert("温馨提示","请勾选角色!");
  			return;
  		}
		if(selectedRows.length>1)
  		{
  			$.messager.alert("温馨提示","每次只能修改一个角色!");
  			return;
  		}
		
		
		$("#editRole").dialog("open");
		var name = selectedRows[0].name ;
		var des = selectedRows[0].description ;
		
		//为全局变量id赋值
		 id = selectedRows[0].id ;
		
		$("#editName").val(name);
		$("#editDesc").val(des);
		
	}
	
	function RealEidtRole()
	{
		var name = $("#editName").val();
		if(name ==null || name=="")
		{
			$.messager.alert("温馨提示","请输入要更新的角色名称!");
			return;
		}
		
		var des = $("#editDesc").val();
		if(des ==null || des=="")
		{
			$.messager.alert("温馨提示","请输入要更新的角色描述!");
			return;
		}
		if(id ==null)
		{
			$.messager.alert("未获取到要修改的id!");
			return;
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath}/role/edit.action",
			data:"name="+name+"&description="+des+"&id="+id,
			type:"post",
			success:function(data)
			{
				if(data)
				{
					$.messager.alert("温馨提示","角色更新成功!");
					$("#editRole").dialog("close");
					$("#editName").val("");
					$("#editDesc").val("");
					$("#dg").datagrid("reload");
					
				
				}else
				{
					$.messager.alert("温馨提示","角色更新失败!");
				}
			}
		});
	}
	
	function deleteRole()
	{
		var selectedRows = $("#dg").datagrid("getSelections");
		if(selectedRows.length<1)
  		{
  			$.messager.alert("温馨提示","请勾选要删除的角色!");
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
  					url:"${pageContext.request.contextPath}/role/deleteByIds.action",
  					data:"ids="+ids,
  					type:"post",
  					success:function(result)
  					{
  						if(result)
  						{
  							$.messager.alert("温馨提示","删除成功!");
  							$("#dg").datagrid("reload");
  							clear();
  						}else
  						{
  							$.messager.alert("温馨提示","删除失败！");
  							clear();
  						}
  					}
  				});
  			}
  		});
  		
	}
	
	function setPrivilege4Role()
	{
		var selectedRows = $("#dg").datagrid("getSelections");
		if(selectedRows.length!=1)
  		{
  			$.messager.alert("温馨提示","请勾选一个要授权的角色!");
  			return;
  		}
		//打开授权面板
		$("#setPrivilegeDialog").dialog("open");
		//加载权限树
		$("#privilegeTree").tree({
			url:'${pageContext.request.contextPath}/role/showSelectedRowTree.action?roleId='+selectedRows[0].id,
			type:"post",
			checkbox:true,
			lines:true,
			cascadeCheck:false,
			onCheck:treeOnCheck
		
		});
	}
	
	//选择复选框时触发
	//node --节点对象   checked--true/false
	function treeOnCheck(node,checked)
	{
		//如果当前节点是 【选择】 状态,如果当前节点有父亲，就让父亲被选中。
		if(checked)
		{
			var parent = $("#privilegeTree").tree("getParent",node.target);
			if(parent!=null)
			{
				$("#privilegeTree").tree("check",parent.target);
			}
		}else	//如果当前节点是要做 取消 选择
		{
		//把它的子节点也全部取消。
			var childrens = $("#privilegeTree").tree("getChildren",node.target);
			for(var i=0;i<childrens.length;i++){
				$("#privilegeTree").tree("uncheck",childrens[i].target);
			}
		}
		
	}
	
	//取消角色授权
	function cancelSetPrivilege()
	{
		$("#setPrivilegeDialog").dialog("close");
	}
	
	//保存权限
	function savePrivilege()
	{
		var nodes = $("#privilegeTree").tree("getChecked");
		if(nodes ==null || nodes=="")
		{
			$.messager.alert("温馨提示","请先分配权限!");
			return;
		}
		var pIds = [];
		for(var i=0;i<nodes.length;i++)
		{
			pIds.push(nodes[i].id);
		}
		var ids = pIds.join(",");
		var role = $("#dg").datagrid("getSelections")[0];
		
		$.ajax({
			url:"${pageContext.request.contextPath}/role/assistPrivilege.action",
			type:"post",
			data:"ids="+ids+"&roleId="+role.id,
			success:function(data)
			{
				if(data){
					$.messager.alert("温馨提示","分配成功!");
					$("#setPrivilegeDialog").dialog("close");
				}else{
					$.messager.alert("温馨提示","分配失败!");
				}
			}
		});
		
		
	}
  </script>
  </head>
  
  <body>
  
  	<body style="margin: 1px">
<table id="dg" title="角色管理" class="easyui-datagrid"
   fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/role/listAllRoles.action" fit="true" toolbar="#tb">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="id" width="30" align="center">角色编号</th>
   		<th field="name" width="80" align="center">角色名称</th>
   		<th field="description" width="300" align="center">角色描述</th>

   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		<a href="javascript:newRole();" class="easyui-linkbutton" iconCls="icon-add" plain="true">新建</a>
 		<a href="javascript:editRole();" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
 		<a href="javascript:deleteRole();" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 		<a href="javascript:setPrivilege4Role();" class="easyui-linkbutton" iconCls="icon-search" plain="true">为角色授权</a>
 	</div>     
 </div>
 
 <div id="newRole" class="easyui-dialog" title="新建角色" style="width:400px;height:200px;"   
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">
        <table align="center">
        	<tr>
        	<td>角色名称:</td>
        <td> <input id="rname" type="text" name="name"></td>   
        	</tr>
        	<tr>
        		<td>角色描述:</td>
        		<td><input id="rdesc" type="text" name="description"></td>
        	</tr>
        	<tr>
        		<td><a id="addOrUpdate" href="javascript:addRole();" class="easyui-linkbutton" iconCls="icon-save" plain="true">添加</a></td>
        		<td><a href="javascript:clear();" class="easyui-linkbutton" iconCls="icon-cut" plain="true">重置</a></td>
        	</tr>
        </table>
</div>


 <div id="editRole" class="easyui-dialog" title="修改角色" style="width:400px;height:200px;"   
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">
        <table align="center">
        	<tr>
        	<td>角色名称:</td>
        <td> <input id="editName" type="text" name="name"></td>   
        	</tr>
        	<tr>
        		<td>角色描述:</td>
        		<td><input id="editDesc" type="text" name="description"></td>
        	</tr>
        	<tr>
        		<td><a id="addOrUpdate" href="javascript:RealEidtRole();" class="easyui-linkbutton" iconCls="icon-save" plain="true">修改</a></td>
        		<td><a href="javascript:clear2();" class="easyui-linkbutton" iconCls="icon-cut" plain="true">重置</a></td>
        	</tr>
        </table>
</div>

<div id="setPrivilegeDialog" class="easyui-dialog" title="角色授权" style="width:260px;height:400px;"   
        data-options="iconCls:'icon-edit',resizable:true,modal:true,closed:true,toolbar:'#setPrivilegeTool'">   
        <ul id="privilegeTree"></ul>  
</div>  

<div id="setPrivilegeTool">
 	<div>
 		<a href="javascript:savePrivilege();" class="easyui-linkbutton" iconCls="icon-add" plain="true">保存</a>
 		<a href="javascript:cancelSetPrivilege();" class="easyui-linkbutton" iconCls="icon-remove" plain="true">取消</a>
 	</div>     
</div>


 
 
   	







   	
 

 

 
 
 
 
  
  
  </body>
</html>
