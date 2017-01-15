
function login(type){ //0 账号  1短信验证码
	if("0" == type){
		var name = $("#username").val();
		if(name == null || name == ""){
			$("#div_error_count").text("用户名不能为空!");
			return 
		}
		var password = $("#password").val();
		if(password == null || password == ""){
			$("#div_error_count").text("密码不能为空!");
			return 
		}
		
		//TODO 登录安全校验
		$("#form_count").submit();
	}
}
$(document).ready(function(){
	//绑定发送验证码的按钮事件
	$("#btn_code").click(function(){
		sendMsg();//发送短信
	});
	
	disable_tel_btn();//tel input失效
	$("#input_telphone").keypress(function(){//验证手机号input只输入数字
		return event.keyCode>=48&&event.keyCode<=57;
	});
	$("#input_code").keypress(function(){//验证码input
		return event.keyCode>=48&&event.keyCode<=57;
	});
	$("#input_code").keyup(function(){//控制快速删除是否显示
		var code = $("#input_code").val();
		if(code==""){
		}else{
			$("#div_error").text("");
		}
	});
	$("#input_telphone").keyup(function(){//手机号input——
		var tel= $("#input_telphone").val();
		//11位时，让发送验证码按钮可用
		if(tel.length == 11){
			$("#btn_code").attr("disabled",false);
			$("#btn_code").css({"background-color":"#6688f5","border":"1px solid #6688f5"});
			$("#input_code").attr("readonly",false);
		}else{
			disable_tel_btn();
			$("#div_error_msgcode").text("");
		}
	});
	
});


//发送短信验证码
var timer = null;
var send_flag = true;
//发送短信
function sendMsg(){
	if(!send_flag){//在倒计时时，不发短信
		console.log("正在倒计时,不发送短信")
		return;
	}
	$("#div_error").text("");
	
	//前端-正则验证
	var regex = /^1\d{10}$/;
	//var regex =/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
	var phone = $("#input_telphone").val();
	var uid = $("#uid").val();
	
	if(phone=="" || !regex.test(phone) ){
		$("#div_error_msgcode").text("请输入一个有效的手机号码！");
		return;
	}
	/*$.ajax({
		url: '${ctx}/dz/sendMsg',
		data: {'uid': uid, 'phone': phone},
		type: 'post',
		dataType: 'json',
		success: function(da) {
			if(da.result == "ok") {//发送短信成功
				countDownTimer();//倒计时
			} else if(da.result == "fail_teacher"){
				$("#div_error").text("教师不能登录大众版！");
			}else if(da.result == "fail_sendError"){
				$("#div_error").text("发送短信失败！");
			}else if(da.result == "invalid_session"){
				$("#div_error").text("验证码已过期,请重新扫码登录！");
			}else{
				$("#div_error").text("服务器发生异常！");
			}
		}
	});
	*/
	alert("send msg");
}

//倒计时
function countDownTimer(){
	var time = 60;
	send_flag = false;
	
	setDisable_sendBtnInput();//发送验证码按钮不可用
	
	timer = window.setInterval(function(){
		$("#btn_code").attr("value",time + "秒后重新发送");
		time--;
		if(time == 0 && timer != null) { // 计时结束后，让发送短信按钮生效
			send_flag = true;
			$("#btn_code").attr("value","发送验证码");
			clearInterval(timer);
			clearDisable_sendBtnInput();//让按钮可用
		}
	},1000);
}
//--------------------------------------------------------------------------------------------------
function setDisable_sendBtnInput(){
	$("#btn_code").attr("disabled",true);
	$("#btn_code").css({"background-color":"#dcdcdc","border":"1px solid #cccccc"});
}
function clearDisable_sendBtnInput(){
	$("#btn_code").attr("disabled",false);
	$("#btn_code").css({"background-color":"#6688f5","border":"1px solid #6688f5"});
}


//让发送不可用
function disable_tel_btn(){
	$("#btn_code").attr("disabled",true);
	$("#btn_code").css({"background-color":"#dcdcdc","border":"1px solid #cccccc"});
	$("#input_code").attr("readonly","readonly");
}