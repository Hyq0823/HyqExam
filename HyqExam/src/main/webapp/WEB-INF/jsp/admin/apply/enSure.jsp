<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>考生报名信息审核</title>

</head>
<body>


	<div align="center">
		<c:if test="${enSureList==null || enSureList.size()<1}">
			<h3 style="color: red;">当前没有需要审核的报名信息</h3>
		</c:if>
			<c:forEach items="${enSureList }" var="ensureVo">
				<p>
					<span>考生昵称:${ensureVo.user.nickname }</span>
					<span>考生真实姓名:${ensureVo.user.truename }</span>
					<span>考生电话:${ensureVo.user.phone }</span>
					<span>考生邮箱:${ensureVo.user.email}</span>
					<span style="color: #c0c0c0; font-size: 14px;"><a
					 href="${pageContext.request.contextPath }/userResume.action?uid=${ensureVo.user.id}&aid=${ensureVo.apply.id}&infoId=${ensureVo.applyInfo.id}">简历</a></span>
					<span style="border-left: dashed 1px red;"></span>
					
					<span>报名标题: ${ensureVo.applyInfo.title }</span>
					<span>报名描述: ${ensureVo.applyInfo.description }</span>
					<span style="border-left: dashed 1px red;"></span>
					
					
					<span>报名状态: ${ensureVo.apply.applyStatus }</span>
					<span><a href="${pageContext.request.contextPath }/apply/ensure_pass.action?applyId=${ensureVo.apply.id}&applyInfoId=${ensureVo.applyInfo.id}">通过</a></span>
					<span><a href="${pageContext.request.contextPath }/apply/ensure_fail.action?applyId=${ensureVo.apply.id}&applyInfoId=${ensureVo.applyInfo.id}">未通过</a></span>
				</p>
			</c:forEach>
			<hr>
			<a href="${pageContext.request.contextPath }/apply/exportStu.action?applyInfoId=${applyInfoId}">导出报名考生</a>
	</div>
</body>
</html>