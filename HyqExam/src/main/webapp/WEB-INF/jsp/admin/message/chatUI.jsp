<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%
	String ids = request.getParameter("userIds");
%>
<title>聊天界面</title>
<jsp:include page="/common/headLink.jsp"></jsp:include>
<script type="text/javascript">
	function sendMessage() {
		//获取文本
		var msg = $("#msg").val();
		//判断文本的有效性
		if (msg == null || "" == msg) {
			$.messager.alert("温馨提示", "您不能发送空消息!");
			return;
		}
		//在文本域中追加
		$("#msgList").append("您说:" + msg);
		
		var oldIds = "${userIds}";
		var ids = [];
		ids = oldIds.split(",");
		//ajax发送给服务器端
		$.ajax({
			url : '${pageContext.request.contextPath}/message/sendMsg.action',
			data : "content=" + msg
					+ "&sender.id=${sender.id}&userIds="+ids,
			type : "post",
			success : function(data) {
				$("#msgList").append("[ok]<br />");
			},
			error : function(data) {
				$.messger.alert("抱歉!发生了未知异常!");
			}
		});
	}
</script>
<script type="text/javascript">
	$(document).ready(function() {
		//开启定时器定时轮询消息
		//setInterval("getMessage()", 15000);
	});

	function getMessage() {
		$.ajax({
			url : '${pageContext.request.contextPath}/message/getMsg.action',
			data : "t=" + new Date().getTime() + "&myId=${sender.id}",
			success : function(data) {
				var list = eval( "("  +data+  ")" );
				for(var i =0;i<list.length;i++)
				{
					if(list[i].content!="无")
						{
							$("#msgList").append(
							"${accepterList[0].nickname }"+"(对方)说:" + list[i].content+ "<br />");
						}
				}
			}
		});

	}
</script>
</head>

<body>
	聊天界面
	<br /> 发送者: ${sender.nickname }
	<br />
	 接受者：
	<c:forEach items="${accepterList }" var="accepter">
	${accepter.nickname }<span> | </span>
	 </c:forEach>
	 

	<table>
		<tr>
			<td>聊天信息</td>
			<td><textarea id="msgList" rows="10" cols="20"
					name="messageList"></textarea></td>
		</tr>
		<tr>
			<td>消息</td>
			<td><input id="msg" type="text" name="message"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="button" value="发送"
				onclick="sendMessage();"></td>
		</tr>
	</table>
</body>
</html>
