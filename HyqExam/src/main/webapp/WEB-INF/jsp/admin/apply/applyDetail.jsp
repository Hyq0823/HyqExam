<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>报名信息详情</title>
</head>
<body>
	<div align="center">
		<form action="${pageContext.request.contextPath}/apply/deploy.action"
			method="post">
			<table>
			<tr>
			<td>上级报名id:</td>
			<td> ${applyInfo.parentId }</td>
			</tr>
				<tr>
					<td>报名标题</td>
					<td><label>${applyInfo.title }</label></td>
				</tr>

				<tr>
					<td>报名描述</td>
					<td>${applyInfo.description }</td>
				</tr>

				<tr>
					<td>开始时间</td>
				<td>	<fmt:formatDate value="${applyInfo.startTime }" type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>

				<tr>
					<td>结束时间</td>
					<td>
					 <fmt:formatDate value="${applyInfo.endTime  }" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>


				<tr>
					<td>是否手工审核报名考生:</td>
					<td>${applyInfo.isHandConfirm }</td>

				</tr>


			</table>
		</form>
	</div>
</body>
</html>