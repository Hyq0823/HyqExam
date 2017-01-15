<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/common/settings.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加字典</title>
</head>
<body>
		<form:form method="post" action="${fullpath }/dict/save"  modelAttribute="dict" autocomplete="off" >
			<label>字典名称：</label>
			<form:input path="name" /> <br />
			
			<label>字 典 值：</label>
			<form:input path="value" /> <br />
			
			<label>字典类型：</label>
			<form:input path="type" /> <br />			
			
			<label>字典描述：</label>
			<form:input path="description" />

			<input type="submit" value="提交">
		</form:form>
</body>
</html>