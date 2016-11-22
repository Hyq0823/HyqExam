<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/common/settings.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>用户登录</title>
<meta name="viewport" content="width=device-width,initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<link  rel="stylesheet" href="${pageContext.request.contextPath }/css/index/login.css">
<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">

<script type="text/javascript">
	$(document).ready(function() { 
		var a = navigator.userAgent;
		console.log(a);
 		if(a.toLowerCase().indexOf('windows') <0){
			$("#weixinLogIn").hide();
		}
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
 	
	
	<div id="all"></div>
	<div id="form_parent">
	  <div id="myTabContent" class="tab-content">
		<div id="registerFrm" class="tab-pane fade in active" role="form">
		<input type="hidden" name="formtoken" value="${token }">
				<c:if test="${currentUser!=null }">
				   <div class="form-group">
	   			      <label for="name">您已经登录了!</label>
	  			   </div>
			    </c:if>
					<c:if test="${message!=null }">
					<div class="form-group">
	   			      <label for="name">${message }</label>
	   			      <label for="name">${error }</label>
	  			   </div>
					</c:if>
					<div class="form-group">
	    				<label for="name">用户名:</label>
	   					 <input type="text" class="form-control" id="username" placeholder="请输入用户名" value="${user.nickname}">
	  				</div>
					<div class="form-group">
	    				<label for="name">密码:</label>
	   					 <input id="password" type="password" class="form-control" id="password" placeholder="请输入密码">
	  				</div>
	  				
	  				<div class="form-group">
	  					<button type="button" class="btn btn-success">注册</button>
			    		<button type="button" class="btn btn-primary">登录</button>
			    	</div>
			</div>
			
			<div id="msgcode" class="tab-pane fade" >
				<input type="hidden" name="formtoken" value="${token }">
					<div class="form-group">
	   			      <label for="name">${error }</label>
	  			   </div>
					
					<div class="form-group">
	    			 <div id="form" >
						<form id="info_form" action="${ctx}/dz/afterLoginOrRegiste" method="post">
		
						<div class="div_box">
						<label for="name">手机号:</label>
	   					 <input  id="input_telphone" type="text"  name="phone" class="form-control" id="username" maxlength="11" placeholder="请输入手机号" onkeyup="value=value.replace(/\D/g,'')" style="ime-mode:disabled;" />
						</div>
							<div>
							<div class="div_box">
								<input type="text" name="checkCode" class="form-control" id="input_code" maxlength="4"  placeholder="验证码" onkeyup="value=value.replace(/\D/g,'')" style="ime-mode:disabled;"/>
								<button id="btn_code" class="btn btn-primary">发送验证码</button> 
							</div>
							</div>
							<div id="div_error"></div>
							<div class="div_box" style="margin-top: 10%">
								<button type="button" class="btn btn-primary" id="btn_login">登录</button>
							</div> 
		</form>
	</div>
	  				</div>
			</div>	
			
			
			
			
			<div id="erweima" class="tab-pane fade">
				<img width="100%" alt="扫一扫" src="${fullpath }/images/login/erweima.png">
				<div class="alert alert-info" style="padding: 6px;">请使用微信扫一扫</div>
			</div>	
		
		</div>
		<!-- content内容end -->
		
			<div>
  		 	<ul id="myTab" class="nav nav-tabs">
				<li class="active"><a href="#registerFrm" data-toggle="tab">账号登录</a></li>
				<li><a href="#msgcode" data-toggle="tab">短信登录</a></li>
					<li id="weixinLogIn"><a href="#erweima" data-toggle="tab">微信登录</a></li>
			</ul>
  			</div>
	</div>
	
	
</body>
</html>
