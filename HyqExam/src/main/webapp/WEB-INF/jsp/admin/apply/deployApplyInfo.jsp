<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/common/headLink.jsp"></jsp:include>
<script type="text/javascript">
	function checkSub() {
		   var parent = $("#applyParent").combotree("getValue");//获取id
		   if(parent==null || parent==""){
			   $.messager.alert("温馨提示","请选择上级报名信息!");
			   return;
		   }
		 var applyTitle = $("#applyTitle").val();
		if (applyTitle == null || "" == applyTitle) {
			 $.messager.alert("温馨提示","请输入报名标题!");
			return ;
		}
		var description = $("#description").val();
		if (description == null || "" == description) {
			 $.messager.alert("温馨提示","请输入报名描述!");
			return ;
		}
		var startTime = $("#startTime").datetimebox("getValue");
		if (startTime == null || "" == startTime) {
			$.messager.alert("温馨提示","请选择开始时间!");
			return ;
		}
		var endTime = $("#endTime").datetimebox("getValue");
		if (endTime == null || "" == endTime) {
			$.messager.alert("温馨提示","请选择结束时间!");
			return ;
		}
		//var sc = $("#startTime").datetimebox("calendar");//
		//var endSpinner = $("#endTime").datetimebox("spinner");//返回时间微调对象
		
		if(startTime>endTime){
			$.messager.alert("温馨提示","开始时间不能大于结束时间!");
			return ;
		}

		var isHandConfirm = $("#isHandConfirm").combobox("getValue");
		if (isHandConfirm == null || "" == isHandConfirm) {
			$.messager.alert("温馨提示","请选择是否手工审核考生!");
			return;
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath}/apply/deploy.action",
			data:"parentId="+parent+"&title="+applyTitle+"&description="+description+"&startTime="+startTime+"&endTime="+endTime+"&isHandConfirm="+isHandConfirm,
			type:"post",
			success:function(data){
				if(data){
					$.messager.alert("温馨提示","发布成功!");
					$('#ff').form('clear');
				}else{
					$.messager.alert("温馨提示","发布失败!");
				}
			}
		});
		
		
	}


</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发布报名信息页面</title>
</head>
<body>
	<div style="width: 1000px;height: 20px;background: red;"></div>

	<div style="margin:10px 0;"></div>
	
	<div class="easyui-panel" title="发布报名信息" align="center">
		<div style="padding:10px 0 10px 60px">
			<form id="ff" method="post">
				<table align="center">
					<tr>
						<td>上轮报名信息:</td>
						<td><select id="applyParent" name="parentId" class="easyui-combotree"
						data-options="url:'${pageContext.request.contextPath }/apply/getTreeApplyInfos.action'"
							style="width:200px;"></select></td>
					</tr>
					<tr>
						<td>报名标题:</td>
						<td><input class="easyui-validatebox" id="applyTitle"  type="text" name="name"
							data-options="required:true"></input></td>
					</tr>
					<tr>
						<td>报名描述:</td>
						<td><input class="easyui-validatebox" type="text" id="description"
							name="email" data-options="required:true,"></input></td>
					</tr>
					<tr>
						<td>开始时间:</td>
						<td>
						<input class="easyui-datetimebox" name="startTime"  id="startTime"  
        data-options="required:true,showSeconds:false"  >  
							</td>
					</tr>
					<tr>
						<td>结束时间:</td>
						<td>
							
						<input class="easyui-datetimebox" name="endTime"    id="endTime" 
        data-options="required:true,showSeconds:false" >  
							</td>
					</tr>
					<tr>
						<td>是否手动审核考生:</td>
						<td><select id="isHandConfirm" class="easyui-combobox" name="dept"
						>
								<option value="" selected="selected">--请选择--</option>
								<option value="yes">是</option>
								<option value="no">否</option>
						</select></td>

					</tr>
				</table>
			</form>
		</div>
		
		<div style="text-align:center;padding:5px">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="checkSub()">发布</a> <a href="javascript:void(0)"
				class="easyui-linkbutton" onclick="clearForm()">重置</a>
		</div>
	</div>
	<script>
		function submitForm() {
			$('#ff').form('submit');
		}
		function clearForm() {
			$('#ff').form('clear');
		}
	</script>





</body>
</html>