<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>三和报考系统-后台管理</title>

<jsp:include page="/common/headLink.jsp"></jsp:include>
<script type="text/javascript">
$(document).ready(function(e) {
    //页面加载完成后启动查询消息的定时
    checkMyMsg();
   setInterval("checkMyMsg()",15000);
});


//获取消息
function getMyMsg(){
	//把消息列表设置为0条
	$("#myMsg").text("消息");
	openTab("我的消息列表","message/myMsgList.action?id=${currentUser.id}","icon-save");
}

function checkMyMsg()
{
	$.ajax({
		url:'${pageContext.request.contextPath}/message/checkMyMsg.action',
		type:"post",
		data:"id=${currentUser.id}",
		success:function(data){
			if(data!=0){
			$("#myMsg").text("消息("+data+")");
			}
		}
	});
}

function openTab(title,url,icon){
	
	if( $("#tabs").tabs('exists',title))
	{
		//选择显示的已有的标签页
		$("#tabs").tabs('select',title);
		//2 并且将其刷新一次
		//$("#tabs").tabs('refresh',url);
	}else
	{
		url = '${pageContext.request.contextPath }/' + url;
		  $("#tabs").tabs('add',{
            title: title,
            content: '<iframe style="width:100%;height:100%;" scrolling="auto" frameborder="0" src=' + url  + '></iframe>',
            closable: true,
            icon: icon
        });
	}

}

//打开在线人员列表
function openOnlinePeople()
{
	//$("#dialog_online").dialog("open").dialog("refresh",'${pageContext.request.contextPath}/message/onlineList.action');
	$('#table_online').datagrid({    
	    url:'${pageContext.request.contextPath}/message/onlineList.action',
	    singleSelectd:true, //设置只能单选一行
	    columns:[[   
	        {field:'cb',title:'选择',width:100,checkbox:true},
	        {field:'nickname',title:'Code',width:100},    
	        {field:'truename',title:'Name',width:100},    
	    ]],
	    toolbar: [{
			iconCls: 'icon-edit',
			text:'发送消息',
			handler: function()
			{
				var rows = $("#table_online").datagrid("getSelections");
				if(rows.length == 0)
				{
					$.messager.alert("温馨提示","请选择要发送的对象!");
					return;
				}
				alert(rows);
				var ids =[];
				for(var i=0;i<rows.length;i++)
				{
					ids.push(rows[i].id);
				}
				//打开聊天界面
				window.parent.openTab('聊天界面', 'message/chatUI.action?uid='+ids, 'icon-add');
				//2、隐藏列表
				$("#dialog_online").dialog("close");
			}
		},{
			iconCls: 'icon-help',
			handler: function(){alert('帮助按钮');}
		}],

	    onRowContextMenu:function(e,rowIndex,rowData){
	    	$("#online_mm").menu("show",{
	    		left:e.pageX,
	    		top:e.pageY
	    	});
	    	e.preventDefault();  //阻止浏览器自带的右键菜单弹出
	    }
	});
	
	$("#dialog_online").dialog("open");
}

//右键菜单-发送消息
function sendMsg()
{
	//获取表格中选择的数据
	var selected = $("#table_online").datagrid("getSelected");
	if(selected ==null){
		$.messager.alert("温馨提示","请先选择一个发送对象!");
		return;
	}
		//window.location.href = '${pageContext.request.contextPath}/message/chatUI.action?uid='+selected.id;
		//打开聊天界面
		window.parent.openTab('聊天界面', 'message/chatUI.action?uid=' + selected.id, 'icon-add');
		//2、隐藏列表
		$("#dialog_online").dialog("close");
		
		/*
		$.ajax({
			url:'${pageContext.request.contextPath}/message/chatUI.action',
			type:"post",
			data:"uid="+selected.id,
		});*/
}
</script>
</head>

<body class="easyui-layout">

<!-- 顶部的div 放login和提示信息 -->
<div region="north" style="height: 100px;background-color: #E0ECFF">
			<div id="head1">
            
                <div id="head1_left">
                    <img alt="logo" src="${pageContext.request.contextPath }/images/background/logo.png">
                </div>
                
                <div id="head1_right">
                    <div id="head1_right_name"><strong>您好：<img src="${pageContext.request.contextPath }/images/background/user.gif" /></strong><span style="color:red">${currentUser.nickname}</span></font></div>
                    <div id="head1_right_setting"><a href="#"><img src="${pageContext.request.contextPath }/images/background/user_setup.gif" />个人设置</a></div>
                </div>
            </div><!--head1 end-->
            <hr />
            <!--head2-->
            <div id="head2">
            	<div id="head2_left">
                	<ul id="head2_left_func">
                    	<li><a href="javascript:getMyMsg();"><img src="${pageContext.request.contextPath }/images/background/msg.gif" /><span id="myMsg" class="sty">消息</span></a></li>
                        <li class="head2_left_line"></li>
                        <li><a href="#"><img src="${pageContext.request.contextPath }/images/background/mail.gif" /><span class="sty">邮件</span></a></li>
                         <li class="head2_left_line"></li>
                        <li><a href="#"><img src="${pageContext.request.contextPath }/images/background/wait.gif" /><span  class="sty">代办事项(1)</span></a></li>
                    </ul>
                </div>
                <div id="head2_right">
                	<marquee style="WIDTH: 100%;" onMouseOver="this.stop()" onMouseOut="this.start()" scrollamount=1 scrolldelay=30 direction=left>
				<b style="color:red; font-size:14px">您有未读的消息,请注意查收！</b>
				</marquee>
                </div>
            </div>
            <!--head2 end-->
		
</div>

<!-- 中部的div放 默认的一个tabs -->
<div region="center">
	<div class="easyui-tabs" fit="true" border="false" id="tabs">
		<div title="首页" data-options="iconCls:'icon-home'">
			<div align="center"><font color="red" size="10">欢迎使用</font></div>
            <div id="center_right">
            	<div id="cc" class="easyui-calendar" style="width:180px;height:180px;"></div>  
            </div>
            
           <div id="dialog_online" class="easyui-dialog" title="在线人员列表" style="width:280px;height:450px;"   
        data-options="iconCls:'icon-save',resizable:true,modal:false,left:200,top:136,closed:true">
        
        	<table id="table_online"  style="width:280px;height:390px">
        	</table>  

        	   
</div>  
		</div>
	</div>
</div>





<!-- 西边的菜单 -->
<div region="west" style="width: 200px" title="导航菜单" split="true">
	<div class="easyui-accordion" data-options="fit:true,border:false">
		<div title="常用操作" data-options="selected:true,iconCls:'icon-item'" style="padding: 10px">
			<a href="javascript:openTab('写博客','forumList.html')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px">写博客</a>
			<a href="javascript:openTab('评论审核','commentReview.jsp','icon-review')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-review'" style="width: 150px">评论审核</a>
		</div>
		<div title="报名管理"  data-options="iconCls:'icon-bkgl'" style="padding:10px;">
			<a href="javascript:openTab('发布报名信息','apply/addApplyInfoUI.action','icon-writeblog')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px;">发布报名信息</a>
			<a href="javascript:openTab('查看报名信息','apply/lookApplyInfo.action','icon-writeblog')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px;">查看报名信息</a>
			<a href="javascript:openTab('测试','apply/aaa.action','icon-writeblog')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px;">测试</a>
		</div>
		<div title="公告管理" data-options="iconCls:'icon-bklb'" style="padding:10px">
			<a href="javascript:openTab('发布公告','notice/addNoticeUI.action','icon-bklb')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-bklb'" style="width: 150px;">发布公告</a>
			<a href="javascript:openTab('公告管理','notice/manageNoticeUI.action','icon-bklb')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-bklb'" style="width: 150px;">公告管理</a>
		</div>
		<div title="站内信模块"  data-options="iconCls:'icon-plgl'" style="padding:10px">
			<a href="javascript:openTab('站内信','message/articleProvider?action=addArticleUI','icon-review')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-review'" style="width: 150px">添加文章</a>
			<a href="javascript:openTab('管理文章','blog/articleProvider?action=listAll','icon-plgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-plgl'" style="width: 150px;">管理文章</a>
		</div>
		<div title="用户、角色、权限模块 " data-options="iconCls:'icon-grxx'" style="padding:10px">
			<a href="javascript:openTab('用户管理','user/listAllUsersUI.action','icon-grxxxg')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-grxxxg'" style="width: 150px;">用户管理</a>
			<a href="javascript:openTab('角色管理','role/roleManage.action','icon-grxxxg')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-grxxxg'" style="width: 150px;">角色管理</a>
		</div>
		<div title="试题管理"  data-options="iconCls:'icon-system'" style="padding:10px">
			<a href="javascript:openTab('知识点管理','question/knowledgePointUI.action','icon-grxxxg')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-grxxxg'" style="width: 150px;">知识点管理</a>
			<a href="javascript:openTab('添加试题','question/addQuestionUI.action','icon-grxxxg')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-grxxxg'" style="width: 150px;">添加试题</a>
			<a href="javascript:openTab('试题管理','question/manageQuestion.action','icon-grxxxg')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-grxxxg'" style="width: 150px;">试题管理</a>
		</div>
	</div>
</div>
<div region="south" style="height: 25px;padding: 5px" align="center">
	<span style="float: left; padding-left: 200px;">当前在线人数: <a href="javascript:openOnlinePeople();" style="color: red;font-size: 17px;padding-bottom: 2px;">${userCount==null? 1 : userCount }</a>人</span>
	Copyright © 2012-2016 独行侠梦_版权所有
</div>

<div id="dlg" class="easyui-dialog" style="width:400px;height:200px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>用户名：</td>
   			<td><input type="text" id="userName" name="userName" readonly="readonly" value="${currentUser.nickname }" style="width: 200px"/></td>
   		</tr>
   		<tr>
   			<td>新密码：</td>
   			<td><input type="password" id="newPassword" name="newPassword" class="easyui-validatebox" required="true" style="width: 200px"/></td>
   		</tr>
   		<tr>
   			<td>确认新密码：</td>
   			<td><input type="password" id="newPassword2" name="newPassword2" class="easyui-validatebox" required="true" style="width: 200px"/></td>
   		</tr>
   	</table>
   </form>
 </div>
 
 <div id="dlg-buttons">
 	<a href="javascript:modifyPassword()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
 
 
 
 <div id="online_mm" class="easyui-menu" style="width:120px;">   
    <div onclick="sendMsg();">发送消息</div>   
    <div>   
        <span>Open</span>   
        <div style="width:150px;">   
            <div><b>Word</b></div>   
            <div>Excel</div>   
            <div>PowerPoint</div>   
        </div>   
    </div>   
    <div data-options="iconCls:'icon-save'">Save</div>   
    <div class="menu-sep"></div>   
    <div>Exit</div>   
</div>  

 


 
 
 
</body>
</html>