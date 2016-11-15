<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>后台管理员登录</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){

	});

	function checkRegiste() {
		var username = $("#username").val();
		if (username == null || username == "") {
			$("#error").html("用户名不能为空!");
			return false;
		}
		var password = $("#password").val();
		if (password == null || password == "") {
			$("#error").html("密码不能为空!");
			return false;
		}
		$("#form_sub").attr("disabled",true);
		return true;
	}
</script>

</head>

<body>
	后台/管理员登录界面
	<form id="registerFrm" action="${pageContext.request.contextPath }/loginAdmin.action" method="post" onsubmit="return checkRegiste();">
	<input type="hidden" name="formtoken" value="${token }">
		<table>
			<tr>
				<td colspan="2"><span><font color="red" id="error">${error }</font></span></td>
			</tr>
			<tr>
				<td>用户名:</td>
				<td><input id="username" type="text" name="nickname" value="${user.nickname}"
					placeholder="请输入用户名" /></td>
			</tr>
			<tr>
				<td>密码:</td>
				<td><input id="password" type="password" name="password"
					placeholder="请输入密码" /></td>
			</tr>

			<tr>
				<td colspan="2"><input id="form_sub" type="submit" value="提交"></td>
			</tr>
		</table>
	</form>
</body>
</html>
