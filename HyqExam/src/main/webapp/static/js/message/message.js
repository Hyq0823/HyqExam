//=================================设置发送消息的快捷键方式=======================================================================================
//改变发送消息的方式  1是enter 2是ctrl+enter
var sendFlag = true; //默认为ctrl + enter发送
function changeSendWay(id){
	if('1' ==id){
		sendFlag = false; 
		$("#span_e").addClass("glyphicon glyphicon-ok");
		$("#span_ce").removeClass("glyphicon glyphicon-ok");
		$("#sendTip").text("按Enter键发送消息");
	}else if('2' == id){
		sendFlag = true; 
		$("#span_e").removeClass("glyphicon glyphicon-ok");
		$("#span_ce").addClass("glyphicon glyphicon-ok");
		$("#sendTip").text("按Ctrl+ENTER键发送消息");
	}
}

$(document).ready(function(){
	//隐藏错误提示
	$("#msg_alert").hide(); 
	
	
	$("#span_e").removeClass("glyphicon glyphicon-ok");
	$("#txtArea").keydown(function(e){
		if(sendFlag){
			console.log(sendFlag);
			if(e.ctrlKey && e.keyCode==13){
				console.log("按下ctrl 和enter发送消息了");
				sendTo();
			}
		}else{
			if(e.keyCode ==13){
				console.log("按下enter发送 消息了");
				sendTo();
			}
		}
		
	});
});
//=====================================设置发送消息的快捷键方式end===================================================================================
