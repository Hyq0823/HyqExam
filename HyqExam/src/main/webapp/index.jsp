<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>三和报考系统</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<!-- 引入bootstrap的文件 -->
<jsp:include page="/common/bootstrapLink.jsp"></jsp:include>
</head>



<body>
	<jsp:include page="/common/indexHead.jsp"></jsp:include>
	
	<div style="height: 100px;">
	</div>
	首页内容<br />
	<c:if test="${currentUser==null }">
	<a href="${pageContext.request.contextPath }/loginUI.action	">登录</a>
	<a href="${pageContext.request.contextPath }/registerUI.action">注册</a>
	</c:if>
	<c:if test="${currentUser!=null }">
	欢迎您,<a href="${pageContext.request.contextPath }/userInfo.action">${currentUser.nickname }</a>
	&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath }/logout.action">注销</a>
	</c:if>
	<hr>
	
	<div>
		<a href="${pageContext.request.contextPath }/apply/applyList.action">报名</a>
	</div>
	<hr>
	
	<div>
		<a href="${pageContext.request.contextPath }/message/sendMsgUI.action">站内信</a>
	</div>
	<hr>
	
	
	<div>
		<a href="${pageContext.request.contextPath }/background/loginRequest.action" style="color: #c0c0c0;">后台管理</a>
	</div>
	
	<div>
	<div class="col-md-8"></div>
	<div class="col-md-4">
	<ul class="list-group">
		<c:forEach items="${noticeList }" var="notice">
   		<li class="list-group-item">${notice.title }
   			 <span class="badge">${notice.deployTime }</span>
   		</li>
   		</c:forEach>
</ul>
</div>
	
	</div>

</body>
</html>
