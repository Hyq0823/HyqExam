<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <jsp:include page="/common/bootstrapLink.jsp"></jsp:include>
     <script type="text/javascript" src="${pageContext.request.contextPath }/js/message/message.js"></script>
     <link rel="stylesheet" href="${pageContext.request.contextPath }/css/message/message.css" />
    <title>聊天界面</title>
<script type="text/javascript">
	var adminId ;
	//开始进行对话
	function startChat(o,id){
		if(id == "${currentUser.id}")
		{
			alert("您不能给自己发消息!");
			return;
		}
		
		//设置具体与哪一个管理员发送消息
		adminId = id;
		
		//先设置对话的人物
		setChatName(o);
		//查找出与此人对话的详细内容
		$.ajax({
			url:'${pageContext.request.contextPath}/message/getMyReadedMsgByOnePerson.action',
			type:"post",
			data:"me=${currentUser.id}&you="+id,
			success:function(data){
				$("#right_chatArea").text("");
				var list = eval( "("  +data+  ")" );
				for(var i =0;i<list.length;i++){
					if(list[i].content!="无"){
							$("#right_chatArea").append(
							"<p>"+o+"(对方)说:" + list[i].content+ "</p>");
						}
				}
	$("#right_chatArea").append("<p style='border-bottom:1px dashed red '>历史消息</p>");
			}
		});
	}
	
	//设置对话名
	function setChatName(o)
	{
		$("#accepterName").text(o);
	}
	
	//点击发送按钮
	function sendTo()
	{
		var msg = $("#txtArea").val();
		if(msg ==null || msg==""){
			$("#msg_alert").slideUp("slow",function(){
				$("#msg_alert").hide();
			});
			return;
		}
		//未取到adminId这个字段属性值
		//msg=2&sendId=eec83f77-1e68-11e6-bacc-5cf9dd5e9d93&adminId=
		//如何在一个div中换行。
		// $("#right_chatArea").append("\r\n"+"您说:"+msg+"\r\n");
		var chatarea = $(".right_chat_area:eq(0)").clone();
		$(chatarea).find(".cotent_p").text(msg);
		//将聊天显示区显示到最下面
		$("#right_chatArea").append(chatarea);
		//document.getElementById('right_chatArea').scrollTop = document.getElementById('right_chatArea').scrollHeight
		$("#right_chatArea").scrollTop($("#right_chatArea")[0].scrollHeight);
		
		$("#txtArea").val("");
		$.ajax({
			url:"${pageContext.request.contextPath}/message/sendMsgToAdmin.action",
			type:"post",
			data:"msg="+msg+"&sendId=${currentUser.id}&adminId="+adminId,
			success:function(data){
				//alert("发送状态!"+data);
				//$("#right_chatArea").append("[ok]");
				
			},
			error:function(data){
				$("#right_chatArea").append("[fail]\r\n");
				alret("未知的错误发生了!"+data);
			}
		});
	}
</script>
<script type="text/javascript">
	$(document).ready(function() {
		//开启定时器定时轮询消息
		setInterval("getMessage()", 15000);
	});

	function getMessage(){
		$.ajax({
			url : '${pageContext.request.contextPath}/message/getMsg.action',
			data : "t=" + new Date().getTime() + "&myId=${currentUser.id}",
			success : function(data) {
				var list = eval( "("  +data+  ")" );
				for(var i =0;i<list.length;i++){
					if(list[i].content!="无"){
						$("#right_chatArea").append("\r\n["+list[i].sendName+"]说： <p>"+list[i].content+"</p>\r\n");
						}
				}
			}
		});

	}
</script>

  </head>
  
  <body>
  <jsp:include page="/common/indexHead.jsp"></jsp:include>
  	<div style="height: 20px;"></div>
  
  		<div style="height: 25px;"></div>
<div class="row" style="margin: 0;">
	<div class="col-md-1"></div>
	<div class="col-md-10">
	<div id="userInfo">
		<div class="panel panel-success">
			<div class="panel-heading">
				<h3 class="panel-title">站内信</h3>
			</div>
			<div class="panel-body">
				<!--左边的树形结构 -->
				<div id="online_left" style="float:left">
							<h2 >我的联系人</h2>
							<div>
							<ul id="online_list" class="nav nav-tabs">
								<li class="active">
									<a href="#online_list_recent" data-toggle="tab">我的好友/网站用户</a>
								</li>

								<li>
									<a href="#online_list_all" data-toggle="tab">联系管理员</a>
								</li>
							</ul>
							
								<!--我的好友 内容 -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="online_list_recent">
									<p><a id="${friend.id }" onclick="startChat('${friend.truename}','${friend.id }')" href="javascript:void(0);">${friend.truename }</a><span class="pull-right">在线</span></p>
								</div>
								<!--最近联系人内容  end-->

								<!--所有联系人内容 -->
								<div class="tab-pane fade in" id="online_list_all">
								<c:forEach items="${admins }" var="admin">
									<p><a onclick="startChat('${admin.truename}','${admin.id }')"  href="javascript:void(0);">
									${admin.truename }<c:if test="${admin.id == currentUser.id }"><span>(我)</span></c:if>
									</a><span class="pull-right">在线</span></p>
									</c:forEach>
								</div>
								</div>
								<!--所有联系人内容  end-->
								</div>

				</div>
				<!--左边的树形结构end-->
				
				<!--右边聊天界面-->
				<div id="right_messageInfo">
						<!--提示-->
                	<div class="alert alert-success">正在与<strong id="accepterName" style="color: red;">大彪子</strong>对话中</div>
                <!--提示end-->
                
                <!--文本域-->
                	<div id="right_chatArea">
                		<!-- 左边聊天气泡 -->
                		<div class="left_chat_area">
                		<div class="clearfix msg">
                			<div class="face_container">
                			 <div class="face_left">
                			<a class="face_left">
                				<img class="face_radius" height="50" width="50"  alt="" src="http://tb2.bdstatic.com/tb/editor/images/face/i_f25.png?t=20140803">
                			</a>
                			 </div>
                			</div>
                			<div class="content_left_container">
                			   <div class="content_arrow"></div>
	                			<div class="content_left">
	                				<p class="cotent_p">我是滑稽hah滑稽h滑稽h滑稽h 滑稽h 滑稽h 滑稽h 滑稽h 滑稽h 滑稽h 滑稽h 滑稽h 滑稽h </p>
	                			</div>
                			</div>
                				<span class="time time_left">2016-11-17 11:24:15</span>
                			</div>
                			</div>
                			<!-- 左边聊天气泡 end -->
                			
                		<!-- 右边聊天气泡 -->
                		<div class="right_chat_area">
                		<div class="clearfix">
                			<div class="face_container">
                			 <div class="face_right">
                			<a class="face_right">
                				<img class="face_radius" height="50" width="50"  alt="" src="http://tva2.sinaimg.cn/crop.0.0.180.180.50/005ucAanjw8ed9w6bsypfj30500500so.jpg">
                			</a>
                			 </div>
                			</div>
                			<div class="content_right_container">
                			<div class="content_arrow_right"></div>
	                			<div class="content_left">
	                				<p class="cotent_p">很厉害很厉害很厉害很厉害</p>
	                			</div>
                			</div>
                			<span class="time time_right">2016-11-17 11:24:15</span>
                			</div>
                			</div>
                			<!-- 右边聊天气泡 end-->
                			
                			<!-- 右边聊天气泡 -->
                		<div class="right_chat_area">
                		<div class="clearfix">
                			<div class="face_container">
                			 <div class="face_right">
                			<a class="face_right">
                				<img class="face_radius" height="50" width="50"  alt="" src="http://tva2.sinaimg.cn/crop.0.0.180.180.50/005ucAanjw8ed9w6bsypfj30500500so.jpg">
                			</a>
                			 </div>
                			</div>
                			<div class="content_right_container">
                			<div class="content_arrow_right"></div>
	                			<div class="content_left">
	                				<p class="cotent_p">很厉害很厉害很厉害很厉害</p>
	                			</div>
                			</div>
                			<span class="time time_right">2016-11-17 11:24:15</span>
                			</div>
                			</div>
                			<!-- 右边聊天气泡 end-->
                		</div>
                	</div>
                <!--文本域end-->
				<!--右边聊天界面end-->
              
              	<div>
                    <form role="form">
  						<div class="form-group">
  					  	<label for="name">消息发送框</label>
  					  <div id="msg_alert" class="alert alert-danger">请输入消息内容</div>
   						 <textarea id="txtArea" class="form-control" rows="2" style="resize: none;"></textarea>
   						<div>
   						 <div class="btn-group btn-group-md" id="btns_send">
	   				 	   <button onclick="sendTo();"  type="button"  class="btn btn-primary" data-toggle="button">发送</button>
   						   <div class="dropup" id="btns_send">
							    <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">&nbsp;<span class="caret"></span></button>
							    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
							      <li role="presentation"><a role="menuitem" tabindex="-1" href="javascript:changeSendWay('1')"><span id="span_e" class="glyphicon glyphicon-ok"></span>按ENTER键发送消息</a></li>
							      <li role="presentation" class="divider"></li>
							      <li role="presentation"><a role="menuitem" tabindex="-1" href="javascript:changeSendWay('2')"><span id="span_ce" class="glyphicon glyphicon-ok"></span>按Ctrl + ENTER键发送消息</a></li>
							    </ul>
 						    </div>
  				 			</div>			 
   						  <span id="sendTip" style="color: #C0C0C0;">按Ctrl+ENTER键发送消息</span>
   						 </div>
   						 </div>
					</form>
              
				</div>
				<div style="clear: both;"></div>
				</div>
			
		</div><!--面板结尾-->
		</div>
		</div>
		<div class="col-md-1"></div>
  	</div>
  </body>
</html>
