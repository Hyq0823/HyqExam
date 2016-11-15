<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <jsp:include page="/common/headLink.jsp"></jsp:include>
    <title>报名列表</title>
    <script type="text/javascript">
    
    	
    
    	function deleteApplyInfo(){
    		var selectedRows = $("#applyInfo_dg").datagrid("getSelections");
    		if(selectedRows.length<1){
      			$.messager.alert("温馨提示","请勾选要删除的项目!");
      			return;
      		}
    		
    		var oldIds = [];
      		for(var i=0;i<selectedRows.length;i++){
      			oldIds.push(selectedRows[i].id);
      		}
      		var ids = oldIds.join(",");
      		$.messager.confirm("温馨提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗?",function(r){
      			if(r) 
      			{
      				$.ajax({
      					url:"${pageContext.request.contextPath}/apply/deleteByIds.action",
      					data:"ids="+ids,
      					type:"post",
      					success:function(result)
      					{
      						if(result)
      						{
      							$.messager.alert("温馨提示","删除成功!");
      							$("#applyInfo_dg").datagrid("reload");
      							clear();
      						}else{
      							$.messager.alert("温馨提示","删除失败！");
      							clear();
      						}
      					}
      				});
      			}
      		});
      		
    	}
    	
    	//修改报名信息
    	//tip1：带过去本次报名的id
    	function editApply(){

    		var selectedRows = $("#applyInfo_dg").datagrid("getSelections");
    		if(selectedRows.length<1){
      			$.messager.alert("温馨提示","请勾选要修改的项目!");
      			return;
      		}
    		if(selectedRows.length>1){
      			$.messager.alert("温馨提示","每次只能修改一个项目!");
      			return;
      		}
    		
    		//封装要修改的id
    		editId = selectedRows[0].id;
    		
    		$("#editDialog").dialog("open");
    		
    		//加载选择combobox
    		var value = selectedRows[0];
    		$("#applyParent").combotree("setValue",value.id);
    		$("#editapplyFrm").form("load",value);
    	}
    	
    //点击确认修改报名信息 事件
    function sureEditApply(){
    	var id = $("#applyInfoId").val();
    	var parent = $("#applyParent").combotree("getValue");//获取id
    	if(parent==null || parent==""){
    		$.messager.alert("温馨提示","请选择上级");
    		return;
    	}
    	var text = $("#applyParent").combotree("getText"); //获取text
    	
    	var title = $("#apply_title").val();
    	if(title==null || title==""){
    		$.messager.alert("温馨提示","请输入标题!");
    		return;
    	}
    	var desc = $("#apply_desc").val();
    	if(desc==null || desc==""){
    		$.messager.alert("温馨提示","请输入描述!");
    		return;
    	}
    	var start = $("#apply_start").datetimebox("getValue");
    	if(start==null || start==""){
    		$.messager.alert("温馨提示","请选择开始时间");
    		return;
    	}
    	var endTime = $("#apply_end").datetimebox("getValue");
    	if(endTime==null || endTime==""){
    		$.messager.alert("温馨提示","请选择结束时间");
    		return;
    	}
    	var isHand = $("#apply_isHand").combobox("getValue");
    	if(isHand==null || isHand==""){
    		$.messager.alert("温馨提示","请选择是否手工审核!");
    		return;
    	}
    	
    	$.ajax({
    		url:"${pageContext.request.contextPath}/apply/edit.action",
    		type:"post",
    		data:"id="+id+"&parentId="+parent+"&title="+title+"&description="+desc+"&startTime="+start+"&endTime="+endTime+"&isHandConfirm="+isHand,
    		success:function(data){
    			if(data){
    				$.messager.alert("温馨提示","修改成功!");
    				$("#editDialog").dialog("close");
    				$("#applyInfo_dg").datagrid("reload");
    			}else{
    				$.messager.alert("温馨提示","修改失败!");
    			}
    		
    		}
    	
    	});
    	
    	
    	
    	
    }
    </script>
  </head>
  <body style="margin: 1px">
  		<table id="applyInfo_dg" title="报名信息管理" class="easyui-datagrid"
   fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/apply/getApplyInfoList.action" fit="true" toolbar="#tb">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="id" width="20" align="center">编号</th>
   		<th field="title" width="120" align="center">报名标题</th>
   		<th field="description" width="120" align="center">描述</th>
   		<th field="startTime" width="200" align="center">起始时间</th>
   		<th field="endTime" width="200" align="center">结束时间</th>
   		<th field="status" width="120" align="center">状态</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true">审核考生</a>
 		<a href="javascript:editApply();" class="easyui-linkbutton" iconCls="icon-remove" plain="true">修改</a>
 		<a href="javascript:deleteApplyInfo();" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 </div>
 
 <!-- 修改报名信息对话框 -->
 <div id="editDialog" class="easyui-dialog" title="修改报名信息" buttons="#editTool"
 style="width: 400px;height: 300px;"
 	data-options="iconCls:'icon-save',resizable:true,modal:false,closed:true,left:200,top:80">
		<div style="padding:1px 0 10px 6px">
			<form id="editapplyFrm" method="post">
			<input type="hidden" name="id" id="applyInfoId">
				<table align="center">
					<tr>
						<td>上轮报名信息:</td>
						<td><select id="applyParent" class="easyui-combotree"
						 data-options="valueField:'id',textField:'text',url:'${pageContext.request.contextPath }/apply/getTreeApplyInfos.action'"
							style="width:200px;"></select></td>
					</tr>
					<tr>
						<td>报名标题:</td>
						<td><input class="easyui-validatebox" id="apply_title" type="text" name="title"
							data-options="required:true"></input></td>
					</tr>
					<tr>
						<td>报名描述:</td>
						<td><input class="easyui-validatebox" id="apply_desc" type="text"
							name="description" data-options="required:true,"></input></td>
					</tr>
					<tr>
						<td>开始时间:</td>
						<td>
						<input id="apply_start"  class="easyui-datetimebox" name="startTime"     
        data-options="required:true,showSeconds:false"  >  
							</td>
					</tr>
					<tr>
						<td>结束时间:</td>
						<td>
							
						<input id="apply_end"  class="easyui-datetimebox" name="endTime"     
        data-options="required:true,showSeconds:false" >  
							</td>
					</tr>
					<tr>
						<td>是否手动审核考生:</td>
						<td><select id="apply_isHand" class="easyui-combobox" name="isHandConfirm">
								<option value="" selected="selected">--请选择--</option>
								<option value="yes">是</option>
								<option value="no">否</option>
						</select></td>
					</tr>
					
					<tr>
        		<td><a  href="javascript:sureEditApply();" class="easyui-linkbutton" iconCls="icon-save" plain="true">确认修改</a></td>
        		<td><a href="#" class="easyui-linkbutton" iconCls="icon-cut" plain="true">重置</a></td>
        	</tr>
				</table>
			</form>
		</div>
		</div>
		
 
  	
  </body>
</html>
