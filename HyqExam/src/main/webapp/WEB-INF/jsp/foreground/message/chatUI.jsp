<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <jsp:include page="/common/bootstrapLink.jsp"></jsp:include>
    <title>聊天界面</title>
    	<style type="text/css">
			#online_left {
				width: 300px;
				height: 500px;
				border: 1px solid greenyellow;
				background:#dff0d8;
			}
			
			#userInfo {
				border: 1px solid #cfcfcf;
			}
			
			#right_messageInfo{
			margin-left: 5px;
			width:534px;
			height: 500px;
			border:1px solid #C3C3C3;
			
			}
			#right_chatArea{
			overflow:auto;
			height:242px;
			border-bottom: 1px solid #cfcfcf;
			border-top: 1px solid #CFCFCF;
			}
		</style>
		
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
			alert("请先输入要发送的消息!");
			return;
		}
		
		//未取到adminId这个字段属性值
		//msg=2&sendId=eec83f77-1e68-11e6-bacc-5cf9dd5e9d93&adminId=
		//如何在一个div中换行。
		$("#right_chatArea").append("\r\n"+"您说:"+msg);
		$("#txtArea").val("");
		$.ajax({
			url:"${pageContext.request.contextPath}/message/sendMsgToAdmin.action",
			type:"post",
			data:"msg="+msg+"&sendId=${currentUser.id}&adminId="+adminId,
			success:function(data){
				//alert("发送状态!"+data);
				$("#right_chatArea").append("[ok]"+"\r\n");
				//将聊天显示区显示到最下面
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
						$("#right_chatArea").append("["+list[i].sendName+"]说： <p>"+list[i].content+"</p>");
						}
				}
			}
		});

	}
</script>

  </head>
  
  <body>
  <jsp:include page="/common/indexHead.jsp"></jsp:include>
  	<div style="height: 10px;"></div>
  
  		<div style="height: 50px;"></div>
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-md-8">
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
									<p><a id="${friend.id }" onclick="startChat('${friend.truename}','${friend.id }')" href="javascript:void(0);">${friend.truename }</span></a><span class="pull-right">在线</span></p>
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
				<div>
				<div id="right_messageInfo" style="float:left">
						<!--提示-->
                	<div class="alert alert-success">正在与<strong id="accepterName" style="color: red;">大彪子</strong>对话中</div>
                <!--提示end-->
                
                <!--文本域-->
            
                	<div id="right_chatArea">
                		
                	</div>
           
                <!--文本域end-->
                
                <!--发送框-->
                    <form role="form">
  						<div class="form-group">
  					  	<label for="name">消息发送框</label>
   						 <textarea id="txtArea" class="form-control" rows="3" style="resize: none;"></textarea>
   						 <span style="color: #C0C0C0;">按ENTER键发送消息</span>
   						 <span style="padding-left: 416px;" class="input-group-btn" style="padding-bottom: 4px;"> 
   						 <button onclick="sendTo();"  type="button" style="width: 110px;" class="btn btn-primary" data-toggle="button">发送</button>
   						 </span>
 					 </div>
					</form>
				</div>
				<!--右边聊天界面end-->
				<div style="clear: both;"></div>
				</div>
			
		</div><!--面板结尾-->
		
			
			
		</div>
		</div>
		</div>
		
		
		<div class="col-md-2"></div>
		</div>
  
  
  
  </body>
</html>
