<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <jsp:include page="/common/headLink.jsp"></jsp:include>
    <title>知识分类预览</title>
    <script type="text/javascript">
    	//添加知识点
    	function addKpoint()
    	{
    		
    		$("#add_kpoint_dialog").dialog("open");
    	}
    	function closekpDialog()
    	{
    		$("#add_kpoint_dialog").dialog("close");
    	}
    	function closetopKp()
    	{
    		$("#add_kpointTop_dialog").dialog("close");
    	}
    	//添加上级知识点
    	function addParentKpoint()
    	{
    		$("#add_kpointTop_dialog").dialog("open");
    	}
    	
    	
    	//按钮
    	function addTopKp()
    	{
    		var name = $("#top_kp_name").val();
    		if(name==null || name==""){
    			$.messager.alert("温馨提示","请输入知识点名称!");
    			return;
    		}
    		var description = $("#top_kp_desc").val();
    		if(description==null || description==""){
    			$.messager.alert("温馨提示","请输入知识点描述!");
    			return;
    		}
    		$.ajax({
    			url:"${pageContext.request.contextPath}/question/addTopKp.action",
    			data:"text="+name+"&description="+description,
    			type:"post",
    			success:function(data){
    				if(data){
    					//刷新二级面板
    					$("#kp_cc").combobox('reload');    
    					$.messager.alert("温馨提示","一级知识点添加成功!");
    					$("#top_kp_name").val("");
    					$("#top_kp_desc").val("");
    					
    					$("#tg_knowLege").treegrid("reload");
    					
    				}else{
    					$.messager.alert("温馨提示","添加失败!");
    				}
    			}
    		});
    	}
    	
    	//添加二级知识点
    	function addKp()
    	{
    		var topId  = $("#kp_cc").combobox("getValue");
    		var name = $("#kp_name").val();
    		if(name==null || name==""){
    			$.messager.alert("温馨提示","请输入知识点名称!");
    			return;
    		}
    		var description = $("#kp_desc").val();
    		if(description==null || description==""){
    			$.messager.alert("温馨提示","请输入知识点描述!");
    			return;
    		}
    		$.ajax({
    			url:"${pageContext.request.contextPath}/question/addSimpleKp.action",
    			data:"text="+name+"&description="+description+"&parentId="+topId,
    			type:"post",
    			success:function(data){
    				if(data){
    					$.messager.alert("温馨提示","二级知识点添加成功!");
    					$("#kp_name").val("");
    					$("#kp_desc").val("");
    					$("#kp_cc").combobox("select",$("#kp_cc").combobox("getData")[0].id);
    				
    					//重新载表格
    					$("#tg_knowLege").treegrid("reload");
    					
    				}else{
    					$.messager.alert("温馨提示","添加失败!");
    				}
    			}
    		});
    	}
    </script>
    <script type="text/javascript">
    // 在双击一个单元格的时候开始编辑并生成编辑器,然后定位到编辑器的输入框上
  $(document).ready(function(){
	  var editFlag = true;
	$("#tg_knowLege").treegrid({
	onDblClickCell: function(field,row){//双击事件
		if(editFlag){
			 editFlag = false;
		 	 $(this).datagrid("beginEdit", row.id);
			 $(".datagrid-editable-input").keypress(function(event){  
			    var keycode = (event.keyCode ? event.keyCode : event.which);  
			    if(keycode == '13'){  //回车事件
			        editFlag = true;//完成一个单元行编辑,将状态设置为可编辑
			        $("#tg_knowLege").treegrid("endEdit",row.id); //结束编辑节点
			    }  
			});  
			 
		}
			
		},
		onAfterEdit:function(row,changes){ //结束编辑事件
		if(changes!=null&& (changes.text!=null ||changes.description!=null)){
			$.ajax({
				url:"${pageContext.request.contextPath}/question/editKpoint.action",
				type:"post",
				data:"id="+row.id+"&text="+row.text+"&description="+row.description,
				success:function(data){
					if(data){
						$.messager.alert("温馨提示","修改成功!");
						$("#tg_knowLege").treegrid("reload");
					}else{
						$.meesager.alert("温馨提示","修改失败!");
					}
						
				}
			
			});
		}
	},
		onContextMenu:function(e,row){
			$("#kpoint_mm").menu("show",{
	    		left:e.pageX,
	    		top:e.pageY
	    	});
	    	e.preventDefault();  //阻止浏览器自带的右键菜单弹出
		}
	});
  });
    
    //删除一行
    function delRow()
    {
    	var node = $("#tg_knowLege").treegrid("getSelected");
    	if(node ==null){
    		$.messager.alert("温馨提示","请选择一个要删除的节点!");
    		return;
    	}
    	$.messager.confirm("确认","将级联删除子知识点,您确定要删除这些记录吗？",function(r){
    		if(r){
    			$.ajax({
    				url:"${pageContext.request.contextPath}/question/deleteKpoint.action",
    				type:"post",
    				data:"id="+node.id,
    				success:function(data){
    					if(data){
    						$.messager.alert("温馨提示","删除成功!");
    						$("#tg_knowLege").treegrid("reload");
    					}else{
    						$.meesager.alert("温馨提示","修改失败!");
    					}
    						
    				}
    			
    			});
    		}
    	});
    	
    	
    }
	
    
</script>

    
  </head>
  <body style="margin: 1px">
  
  <!-- 添加知识点-->
<div id="add_kpoint_dialog" class="easyui-dialog" title="添加二级知识点" style="width:300px;height: 200px;"
  closed="true" buttons="#addUserBtns" 
   data-options="draggable:'true',inline:'true',left:80,top:30 ">
  	<table cellspacing="5px;">
  		<tr>
  			<td>上级：</td>
  			<td>
  			<select id="kp_cc" class="easyui-combobox" data-options="valueField:'id',textField:'text',url:'${pageContext.request.contextPath}/question/getTopList.action'" name="parentId" style="width:100px;">   
    <option value="">无(默认)</option> 
</select>  
<a href="javascript:addParentKpoint();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"/>
	</td>
  		</tr>
  		
  		<tr>
  			<td>知识点名称：</td>
  			<td><input type="text" id="kp_name" name="name" class="easyui-validatebox" required="true"/></td>
  		</tr>
  		<tr>
  			<td>描述</td>
  			<td><input onkeydown="if(event.keyCode == 13) addKp();"  type="text" id="kp_desc" name="description" class="easyui-validatebox" required="true"/></td>
  	</table>
</div>
<!-- 添加知识点  end -->

  <!-- 添加上级知识点-->
<div id="add_kpointTop_dialog" class="easyui-dialog" title="添加一级知识点" style="width:300px;height: 200px;"
  closed="true" buttons="#addTopKp" 
   data-options="draggable:'true',inline:'true',left:180,top:130 ">
  	<table cellspacing="5px;">
  		<tr>
  			<td>知识点名称：</td>
  			<td><input type="text" id="top_kp_name" name="name" class="easyui-validatebox" required="true"/></td>
  		</tr>
  		<tr>
  			<td>描述</td>
  			<td><input onkeydown="if(event.keyCode == 13) addTopKp();" type="text" id="top_kp_desc" name="description" class="easyui-validatebox" required="true"/></td>
  	</table>
</div>
<!-- 添加上级知识点  end -->
  
  
  
  
  <table id="tg_knowLege" class="easyui-treegrid" title="知识点分类"  style="height: 472px" 
        data-options="url:'${pageContext.request.contextPath}/question/listAllKpoint.action',idField:'id',treeField:'text',striped:true">   
    <thead>   
        <tr>   	
	<th data-options="width:20,align:'center'"><a href="javascript:addKpoint();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"/></th>
            <th data-options="field:'id',width:180,align:'center'">编号</th>   
            <th data-options="field:'text',width:460,align:'center',editor:'text'">知识点</th>   
            <th data-options="field:'description',width:400,align:'center',editor:'text'">描述</th>   
        </tr>   
    </thead>   
</table>  








 <div id="addUserBtns">
	<a href="javascript:addKp();" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closekpDialog();" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div>

<!-- 顶级知识点的添加 -->
 <div id="addTopKp">
	<a href="javascript:addTopKp();" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closetopKp();" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div>


<!-- 知识点的右键菜单 -->
 <div id="kpoint_mm" class="easyui-menu" style="width:120px;">   
    <div data-options="iconCls:'icon-add'" onclick="delRow();">删除</div>   
</div>  
<!-- 知识点的右键end -->






  	
  	
  	
  </body>
  
  
</html>
