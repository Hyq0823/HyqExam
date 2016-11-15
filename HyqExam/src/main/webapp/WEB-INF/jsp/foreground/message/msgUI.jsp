<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <jsp:include page="/common/headLink.jsp"></jsp:include>
       <script type="text/javascript">
    	//给管理员发送消息
    	function sendMsgToAdmin()
    	{
    		var msg = $("#msgContent").val();
    		if(msg ==null || msg=="")
    		{
    			$.messager.alert("温馨提示","请输入消息内容!");
    		}
    		$.ajax({
    			url:"${pageContext.request.contextPath}/message/sendMsgToAdmin.action",
    			type:"post",
    			data:"msg="+msg+"&sendId=${currentUser.id}",
    			success:function(data)
    			{
    				alert("发送状态!"+data);
    			}
    		});
    	}
    </script>
    <title>我的站内信</title>
    
	<meta http-equiv="cache-control" content="no-cache">

  </head>
  
  <body>
		
		
		<div>
			<p>我的消息列表:</p>
			<br />
  		<c:forEach items="${readedMsgList}" var="msg">
  			${msg.content }<br />
  		</c:forEach>
  		
  		</div>  
  		
  		<hr>
  		<div>
  			<input id="msgContent" type="text" name="msg">
  			<input type="button" value="发送" onclick="sendMsgToAdmin();"> 
  		
  		</div>
		
		
		
		
  </body>
</html>
