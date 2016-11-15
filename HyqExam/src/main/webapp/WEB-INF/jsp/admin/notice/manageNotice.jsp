<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <title>公告管理</title>
  <jsp:include page="/common/headLink.jsp"></jsp:include>
  <script type="text/javascript">
  	//修改公告
  	function editNotice()
  	{
  		var selectedRows = $("#dg").datagrid("getSelections");
  		if(selectedRows.length<1)
  		{
  			$.messager.alert("温馨提示","请选择要修改的公告!");
  			return;
  		}
  		if(selectedRows.length>1)
  		{
  			$.messager.alert("温馨提示","每次只能修改一个!");
  			return;
  		}
  		
  		var data = selectedRows[0]; //获取要修改的项
  		window.parent.openTab('更新公告','notice/addNoticeUI.action?noticeId='+data.id,'icon-bklb');
  	}
  	
  	//删除公告
  	function deleteNotice()
  	{
  		var selectedRows = $("#dg").datagrid("getSelections");
  		if(selectedRows<1)
  		{
  			$.messager.alert("温馨提示","请选择要删除的公告!");
  			return;
  		}
  		var oldIds = [];
  		for(var i=0;i<selectedRows.length;i++)
  		{
  			oldIds.push(selectedRows[i].id);
  		}
  		var ids = oldIds.join(",");
  		$.messager.confirm("温馨提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗?",function(r){
  			if(r) 
  			{
  				$.ajax({
  					url:"${pageContext.request.contextPath}/notice/deleteByIds.action",
  					data:"ids="+ids,
  					type:"post",
  					dataType:"json",
  					success:function(result)
  					{
  						if(result)
  						{
  							$.messager.alert("温馨提示","删除成功!");
  							$("#dg").datagrid("reload");
  						}else
  						{
  							$.messager.alert("温馨提示","删除失败！");
  						}
  					}
  				});
  			}
  		});
  	}
  	
  	function formatterTitle(val,row)
  	{
  		//return "<a  href='${pageContext.request.contextPath}/notice/noticeDetail.action?noticeId="+row.id+"'>"+val+"</a>";
  		return '<a href=javascript:openNoticeDetailTab('+row.id+')>'+val+'</a>';
  	}
  	
  	//打开通知详细信息面板
  	function openNoticeDetailTab(id)
  	{
  		
  		$('#dd').dialog({    
  		    title: 'My Dialog22222',    
  		    width: 400,    
  		    height: 200,    
  		    closed: false,    
  		    cache: false,    
  		    href: '${pageContext.request.contextPath}/notice/noticeDetail.action?noticeId='+id,    
  		    modal: true   
  		});   
  		$("#dd").dialog("open").dialog("setTitle","公告明细"); //打开一个面板并且设置它的标题是公告明细  		
  	}
  	
  function formatOp(value,row,index)
  {
	  return '<a class="later-load" onclick="moveUp('+row.position +','+  row.id  +')";>上移</a>'
	  + '<a class="later-down" onclick="moveDown('+row.position  +','+  row.id + ')">下移</a>';
	 // return '<a href="#" onclick="editUser('+index+')">修改</a>';
  }
  
  function moveUp(position,id)
  {
	  if(position ==  1)
	{
		  $.messager.alert("温馨提示","第一个不能继续上移!");
		  return;
	}
	  $.ajax({
		  url:'${pageContext.request.contextPath}/notice/moveUp.action',
		  data:"position="+position+"&noticeId="+id,
		  type:"post",
		  dataType:"json",
		  success:function(result)
			{
				if(result)
				{
					$("#dg").datagrid("reload");
				}else
				{
					$.messager.alert("温馨提示","上移失败！");
				}
			}
	  });
  }
  function moveDown(position,id)
  {
	  $.ajax({
		  url:'${pageContext.request.contextPath}/notice/moveDown.action',
		  data:"position="+position+"&noticeId="+id,
		  type:"post",
		  dataType:"json",
		  success:function(result)
			{
				if(result)
				{
					$("#dg").datagrid("reload");
				}else
				{
					$.messager.alert("温馨提示","不能继续下移!");
				}
			}
	  });
  }
  
  	$(document).ready(function(){
  		$("#dg").datagrid({onLoadSuccess:function(data)
  			{
  				$(".later-load").linkbutton({text:'上移',plain:'true',iconCls:'icon-add'});
  				$(".later-down").linkbutton({text:'下移',plain:'true',iconCls:'icon-add'});
  			}});
  	});
  	
  </script>
  </head>
  
  <body>
  
  	<body style="margin: 1px">
<table id="dg" title="公告管理" class="easyui-datagrid"
   fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/notice/listAllNotices.action" fit="true" toolbar="#tb" onLoadSuccess="loadSuccess();">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="id" width="20" align="center">编号</th>
   		<th field="title" width="100" align="center" formatter="formatterTitle">标题</th>
   		<th field="deployTime" width="50" align="center">发布日期</th>
   		<th field="deployer" width="50" align="center">发布人</th>
   		<th field="1" width="50" align="center" formatter="formatOp">操作</th>

   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		<a href="javascript:editNotice()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
 		<a href="javascript:deleteNotice()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 	</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 	<div>
 		&nbsp;标题：&nbsp;<input type="text" id="s_title" size="20" onkeydown="if(event.keyCode==13) searchBlog()"/>
 		<a href="javascript:searchBlog()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 	</div>
 </div>
 
 
   	
<div id="dd" buttons="#notice-buttons"></div>  

<div id="notice-buttons">
		<a href="#" onclick="javascript:$('#dd').dialog('close');" class="easyui-linkbutton" iconCls="icon-ok">确定</a>
	</div>






   	
 

 

 
 
 
 
  
  
  </body>
</html>
