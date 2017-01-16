<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ include file="/common/headLink.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>字典列表</title>
<script type="text/javascript">
$(document).ready(function(){
	$('#dg').datagrid({
		toolbar: [{
			iconCls: 'icon-edit',
			handler: function(){alert('编辑按钮')}
		},'-',{
			iconCls: 'icon-help',
			handler: function(){alert('帮助按钮')}
		}]
	});
});




</script>
</head>
<body>


	<table class="easyui-datagrid" id="dg">
		<thead>
			<tr>
				<th data-options="field:'name',width:200">字典名称</th>
				<th data-options="field:'value',width:200">字典值</th>
				<th data-options="field:'type',width:200">字典类型</th>
				<th data-options="field:'description',width:200">字典描述</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${dicts }" var="dict">
				<tr>
					<td>${dict.name }</td>
					<td>${dict.value }</td>
					<td>${dict.type }</td>
					<td>${dict.description }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>


 <div id="newDict" class="easyui-dialog" title="新建字典" style="width:400px;height:200px;"   
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">
        <table align="center">
        	<tr>
        	<td>字典名称:</td>
        <td> <form:input path="name" /></td>   
        	</tr>
        	<tr>
        		<td>字 典 值：</td>
        		<td><form:input path="value" ></td>
        	</tr>
        	<tr>
        		<td>字典类型：</td>
        		<td><form:input path="type" /></td>
        	</tr>
        	<tr>
        		<td>字典描述：</td>
        		<td><form:input path="description" /></td>
        	</tr>
        	
        	<tr>
        		<td><a id="addOrUpdate" href="javascript:addRole();" class="easyui-linkbutton" iconCls="icon-save" plain="true">添加</a></td>
        		<td><a href="javascript:clear();" class="easyui-linkbutton" iconCls="icon-cut" plain="true">重置</a></td>
        	</tr>
        </table>
</div>



</body>
</html>