<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <jsp:include page="/common/headLink.jsp"></jsp:include>
    <title>试题管理</title>
    <style type="text/css">
    .citem{
    padding-left: 10px;
    }
    
    .active{
    	padding: 3px;
    	background: #5bc0de;
    }
    
    </style>
   <script type="text/javascript">
   	function openaddQuestionTab()
   	{
   		window.parent.openTab("添加试题","question/addQuestionUI.action","icon-grxxxg");
   	}
   	function deleteAQuestion()
   	{
   		var selectedRows = $("#question_grid").datagrid("getSelections");
   		if(selectedRows==null || selectedRows.length<1){
   			$.messager.alert("温馨提示","请选择要删除的记录!");
   			return;
   		}
   		var oldIds = [];
  		for(var i=0;i<selectedRows.length;i++)
  		{
  			oldIds.push(selectedRows[i].id+"@"+selectedRows[i].typeId);
  		}
  		var ids = oldIds.join(",");
  		$.messager.confirm("温馨提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗?",function(r){
  			if(r) 
  			{
  				$.ajax({
  					url:"${pageContext.request.contextPath}/question/deleteByIdandTypeId.action",
  					data:"ids="+ids,
  					type:"post",
  					success:function(result)
  					{
  						if(result)
  						{
  							$.messager.alert("温馨提示","删除成功!");
  							$("#question_grid").datagrid("reload");
  						}else
  						{
  							$.messager.alert("温馨提示","删除失败！");
  							clear();
  						}
  					}
  				});
  			}
  		});
   		
   		
   		
   	}
   	
   	function typeFormat(value,row,index)
   	{
   		switch (row.typeId) {
		case 1: return "单项选择题"; break;
		case 2: return "判断题"; break;
		case 3: return "问答题"; break;
		case 4: return "多项选择题"; break;
		default: return "未知"; break;
		}
   	}
   	
   	/*
   	function cateAssist(typeId){
   		$.ajax({
   			//url:"${pageContext.request.contextPath}/question/limitByTypeId.action",
   			type:"post",
   			data:"typeId="+typeId,
   			success:function(data){
   				if(data){
   					
   				}else
   				{
   					$.messager.alert("温馨提示","筛选分类失败!");
   				}
   			}
   		});
   	}
   	*/
   	//修改试题
   	function editQuestion()
   	{
   		$.messager.alert("温馨提示","抱歉，本次版本暂不支持修改功能!");
   		return;
   	}
   	
   	function changePointBackground(id)
   	{
   		$("#point"+id).parent().find("a").removeClass("active");
   		$("#point"+id).addClass("active");
   		
   	 var type = $("#qtype").find(".active").text();
		 var level = $("#qlevel").find(".active").text();
		 var point = $("#qpoint").find(".active").text();
		
		$("#question_grid").datagrid("load",{    
		    type:type,    
		    level:level,
		    point:point
	});
   		
   	}
   </script>
  <script type="text/javascript">
  	$(document).ready(function(){
  		$("#qtype a").click(function(){
  			if($(this).hasClass(".active")) return false;
  			$("#qtype a").removeClass("active");	
  			$(this).addClass("active");
  			 var type = $("#qtype").find(".active").text();
  			 var level = $("#qlevel").find(".active").text();
  			 var point = $("#qpoint").find(".active").text();
  			
  			$("#question_grid").datagrid("load",{    
  			    type:type,    
  			    level:level,
  			    point:point
  			});
  		});
  		
  		$("#qlevel a").click(function(){
  			if($(this).hasClass(".active")) return false;
  			$("#qlevel a").removeClass("active");	
  			$(this).addClass("active");
  			 var type = $("#qtype").find(".active").text();
  			 var level = $("#qlevel").find(".active").text();
  			 var point = $("#qpoint").find(".active").text();
  			
  			$("#question_grid").datagrid("load",{    
  			    type:type,    
  			    level:level,
  			    point:point
  		});
  			
  		});
  	});
  	
  	
  	
  		
  </script>
  </head>
  <body style="margin: 1px">
  <table id="question_grid" title="试题管理" class="easyui-datagrid" fitColumns="true" 
    pagination="true" rownumbers="true" url="${pageContext.request.contextPath }/question/getAllQuestions.action" fit="true" toolbar="#tb">
    <thead>
    	<tr>
    		<th field="cb" checkbox="true" align="center"></th>
    		<th field="title" width="200" align="center">题目</th>
    		<th field="typeId" width="50" align="center" formatter="typeFormat">类型</th>
    		<th field="level" width="40" align="center">难度</th>
    		<th field="point" width="220" align="center">知识点</th>
    		<th field="answerAnalysis" width="220" align="center">答案解析</th>
    	</tr>
    </thead>
</table>



<div id="tb">
	<div id="cate">
		<span id="qtype">
		<span>试题类型:</span>
		<a href="#" class="active">全部</a>  
		<a href="#">单项选择题</a>  
		<a href="#">判断题</a>  
		<a href="#">问答题</a>  
		<a href="#">多项选择题</a>  
		<span style="border-left: 1px solid #ccc;border-right: 1px solid white;margin-left: 20px"></span>
		</span>
		
		<span id="qlevel">
		<span class="citem">难度:</span>
		<a href="#" class="active" >全部</a>
		<a  href="#">困难</a>
		<a href="#">一般</a>
		<a href="#">容易</a>
		</span>
		   
		<span style="border-left: 1px solid #ccc;border-right: 1px solid white;margin-left: 20px"></span>
		
		<span class="citem"> 知识点:</span>
		<span id="qpoint">
		<a id="point00" href="#" class="active" onclick="changePointBackground('00');">全部</a>
		<c:forEach items="${kpList }" var="kp">
		<a id="point${kp.id }" onclick="changePointBackground('${kp.id}');" href="#">${kp.text }</a>  
		</c:forEach>
		</span>  
	</div>
	<div>
		<a href="javascript:openaddQuestionTab()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
		<a href="javascript:editQuestion();" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
		<a href="javascript:deleteAQuestion()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
	</div>
</div>
  
  
  
  </body>
  
  
  
  
</html>
