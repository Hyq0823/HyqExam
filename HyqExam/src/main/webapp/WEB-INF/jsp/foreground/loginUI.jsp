<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/common/settings.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>用户登录</title>
<meta name="viewport" content="width=device-width,initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="${fullpath }/js/jquery.min.js"></script>
<script src="${fullpath }/js/bootstrap.min.js"></script>
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link  rel="stylesheet" href="${fullpath }/css/index/login.css">
<script type="text/javascript" src="${fullpath }/js/login/login.js"></script>

<script type="text/javascript">
	$(document).ready(function() { 
		var a = navigator.userAgent;
		console.log(a);
 		if(a.toLowerCase().indexOf('windows') <0){
			$("#weixinLogIn").hide();
		}
	});
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
					
					<form id ="form_count" method="post" action="${fullpath }/login.action">
					<div class="form-group">
	    				<label for="name">用户名:</label>
	   					 <input type="text" name="nickname" class="form-control" id="username" placeholder="请输入用户名" value="${user.nickname}">
	  				</div>
					<div class="form-group">
	    				<label for="name">密码:</label>
	   					 <input id="password" type="password" name="password" class="form-control" id="password" placeholder="请输入密码">
	  				</div>
	  				
	  				<div id="div_error_count" class="error_tips">${error }</div>
	  				<div class="form-group">
	  					<button type="button" class="btn btn-success" onclick="javascript:location.href='${fullpath}/registerUI.action'">注册</button>
			    		<button type="button" class="btn btn-primary" onclick="login('0')">登录</button>
			    	</div>
			    	
			      </form>
			</div>
			
			<div id="msgcode" class="tab-pane fade" >
				<input type="hidden" name="formtoken" value="${token }">
					<div class="form-group">
	   			      <label for="name">${error }</label>
	  			   </div>
					
					<div class="form-group">
	    			 <div id="form" >
		
						<div class="form-group">
						<label for="name">手机号:</label>
	   					  <input  id="input_telphone" type="text" autocomplete="off"  name="phone" class="form-control" id="username" maxlength="11" placeholder="请输入手机号" onkeyup="value=value.replace(/\D/g,'')" style="ime-mode:disabled;" />
						</div>
							<div>
							<div class="form-group">
 								<input type="text" name="checkCode" class="form-control" id="input_code" maxlength="4"  placeholder="验证码" onkeyup="value=value.replace(/\D/g,'')" style="ime-mode:disabled;"/>
								<button style="border: 1px solid #ccc;" id="btn_code" class="btn btn-primary">发送验证码</button> 
							</div>
							</div>
							<div id="div_error_msgcode" class="error_tips"></div>
							<div class="form-group">
	  							<button type="button" class="btn btn-success" onclick="javascript:location.href='${fullpath}/registerUI.action'">注册</button>
								<button  type="button" class="btn btn-primary" id="btn_login" onclick="login('1')">登录</button>
							</div> 
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
