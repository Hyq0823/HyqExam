<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 引入jquery -->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript">
	function apply(infoId, hand,status) {
		if("未开始"==status){
			alert("报名尚未开始!");
			return;
		}
		
		if (confirm("您确定要报名吗?")) {
					$.ajax({
						type : "post",
						url : "${pageContext.request.contextPath }/apply/applyRequest.action",
						data : "infoId=" + infoId + "&hand=" + hand,
						dataType : "text",
						success : function(result) {
							alert(result);
							if (result == "报名成功!") {
								$("#" + infoId).attr("value", "已参与");
							}
						},
					});
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>前台报名主页面</title>
</head>
<body>
	前台报名： 1、首先肯定得列出所有的报名信息
	<br /> 2、然后得有一个报名按钮
	<br /> 3、进入这个页面可能用户已经报名了一个项目，要判断每个报名的状态,考虑要带过来用户报名的报名信息id
	<br />
	<div align="center">
		<c:forEach items="${applyInfoList }" var="applyInfo">
			<p>
				标题：<a
					href="${pageContext.request.contextPath }/apply/detail.action?applyId=${applyInfo.id}">${applyInfo.title }</a>
				<span>时间:</span>
				<span>${applyInfo.startTime }</span>
				---
				<span>${applyInfo.endTime  }</span>
				
				<span>状态:${applyInfo.status }</span> <span><input
					id="${applyInfo.id }" type="button" value="报名"
					onclick="apply('${applyInfo.id}','${applyInfo.isHandConfirm }','${applyInfo.status}');" /></span>
					
			</p>
		</c:forEach>
	</div>

</body>
</html>