<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <jsp:include page="/common/headLink.jsp"></jsp:include>
    <title>添加试题</title>
    <script type="text/javascript">
    var count = 5;
    //定义一个数组
    var sum = 5;
    $(document).ready(function(){
    	//提示信息隐藏
    	$("#hideTipsInfo").hide();
    	$("#mutil_hideTipsInfo").hide();
    	
    	//选择题隐藏
    	$("#question_choice_form").hide();
    	//判断题隐藏
    	$("#question_justice_form").hide();
    	//隐藏问答题
    	$("#question_answer_form").hide();
    	//隐藏多项选择题
    	$("#question_MutilChoice_form").hide();
    	
    	
    	
    	
    	
    	//处理选项变化
    	$("#cb_qtype").combobox({
    		onSelect:function(record){
    			//隐藏提示
    			$("#hideTipsInfo").hide();
    	    	$("#mutil_hideTipsInfo").hide();
    	    	
    			if(record.id ==1){ //选择题
    				$("#question_choice_form").show();
    				$("#question_justice_form").hide();    
    				$("#question_answer_form").hide();
    				$("#question_MutilChoice_form").hide();
    			}else if(record.id==2){ //判断题
    				$("#question_justice_form").show();
    				$("#question_choice_form").hide();
    				$("#question_answer_form").hide();
    				$("#question_MutilChoice_form").hide();
    			
    			}else if(record.id==3){//问答题
    				$("#question_answer_form").show();
    				$("#question_choice_form").hide();
    				$("#question_justice_form").hide();
    				$("#question_MutilChoice_form").hide();
    			}else if(record.id==4){ //多项选择题
    				$("#question_MutilChoice_form").show();
    				$("#question_choice_form").hide();
    				$("#question_justice_form").hide();
    				$("#question_answer_form").hide();
    			}
    		}
    	});
    });
    
    //添加选择项
    function addChoicItem()
    {
    	var len = $(".item").length;
    	var value = String.fromCharCode(65 + len);
    	if(len<7){ 
    		$("#choice_2").append('<p class="scp" id=sc'+value+'><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id='+count+' value='+value+'  name="sc_trueItem"></span><span>  选项<span class="symbol"> '+value+'</span>：&nbsp;&nbsp;</span><span><input type="text" class="item" id="sci'+value+'"  name="lastItem" /></span><a class="scaa" href="javascript:delItem(\''+value+' \' );">删除</a></p>');
    	}else
    		$("#hideTipsInfo").show();
    	}
    //添加多项选择的项
    function addMultiChoicItem(){
    	if(sum>0){
    		sum--;
    		var len = $(".mut_p").length;
    		var value = String.fromCharCode(67+len);
    		$("#choice_muti").append('<p id=m'+value+' class="mut_p"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="mut_ckb" value="'+value+'"></span><span>  选项<span class="m_i">'+value+'</span>：&nbsp;&nbsp;</span><span><input id="dx'+value+'" class="muti" type="text" name="item" /></span><a class="mpa" href="javascript:delMutiItem(\''+value+'\');">删除</a></p>');
    	}else{
    		$("#mutil_hideTipsInfo").show();
    	}
    }
    
    //删除多项选择项
    function delMutiItem(value)
    {
    	sum = sum+1;
    	$("#m"+value).remove();
    	$(".m_i").each(function(index){
    		var v = String.fromCharCode(index+67);
    		$(this).text(v);
    		$(this).parent().parent().attr("id","m"+v);
    		$(this).parent().parent().find(".mpa").attr("href",'javascript:delMutiItem(\''+v+'\')');;
    	});
    	
    	if(sum>0){
    		$("#mutil_hideTipsInfo").hide();
    	}
    }
    //删除单选选择项
    function delItem(s)
    {
    	
    	$("#sc"+s).remove();
    	$("#hideTipsInfo").hide();
	var len = $(".symbol");
	len.each(function(index){
	var i =String.fromCharCode(67 + index);
	$(this).text(i);//改变选项
	//改变p的id
	 $(this).parent().parent().attr("id","sc"+i);
	//改变 删除的参数
	 $(this).parent().parent().find("a").attr("href",'javascript:delItem(\''+i+'\');');
});
    
    }
    
    //保存单选题表单
    function singleChoicSave()
    {
    	var answerItem='';
    	var title = $("#sc_title").val();
    	if(title==null || title==""){
    		$.messager.alert("温馨提示","请先输入题目!");
    		return;
    	}
    	
    	var itemA = $("#sciA").val();
    	if(itemA==null || itemA==""){
    		$.messager.alert("温馨提示","请先输入第一个选项的值!");
    		return;
    	}
    	var itemB = $("#sciB").val();
    	if(itemB==null || itemB==""){
    		$.messager.alert("温馨提示","请先输入第二个选项的值!");
    		return;
    	}
    	
    	var trueItem = $('input[name="sc_trueItem"]:checked').val();
    	if(trueItem==null || trueItem.length<1){
    		$.messager.alert("温馨提示","请选择一个正确答案!");
    		return;
    	}
    	
    	//正确答案 改如何获取，存在问题
    	var trueItemAnswer = $("#sci"+trueItem).val();
    	//后面的选择
    	var item = $("input[name='lastItem']");
    	var oLastItem = [];
    	for(var i=0;i<item.length;i++){
    		if(item[i].value == ""){
    			$.messager.alert("温馨提示","请 删除或输入选项!");
    			return;
    		}
    		oLastItem.push(item[i].value);
    	}
    	var lastItem = oLastItem.join(",");
    	
    	var qLevel = $('input[name="sc_qlevel"]:checked').val();
    	if(qLevel==null||qLevel.length<1){
    		$.messager.alert("温馨提示","请选择难易程度!");
    		return;
    	}
    	var sc_analysis = $("#sc_analysis").val();
    	
    	var old_points = [];
    	var points = [];
    	var t = $("#cb_kpoint").combotree('tree');	// 获取树对象
    	var kpointValues = t.tree("getChecked");
    	if(kpointValues!=null && kpointValues.length>0){
    		for(var i=0;i<kpointValues.length;i++){
    			old_points.push(kpointValues[i].text);
    		}
    		points =old_points.join(",");
    	}
	$.ajax({
    		url:'${pageContext.request.contextPath}/question/addSingleChoiceQuestion.action',
    		type:'post',
    		data:"point="+points+"&title="+title+"&itemA="+itemA+"&itemB="+itemB+"&lastItem="+lastItem+"&trueItem="+trueItemAnswer+"&answerAnalysis="+sc_analysis+"&level="+qLevel+"&typeId=1",
    		success:function(data){
    			if(data){
    				$.messager.alert("温馨提示","添加单选题成功");
    				dxReset();
    			}else{
    				$.messager.alert("温馨提示","添加失败!");
    			}
    		}
    	});
 
    }
    
    //保存判断题
    function pdQuestionSave()
    {
    	var title = $("#pd_title").val();
    	if(title==null || title==""){
    		$.messager.alert("温馨提示","请先输入题目!");
    		return;
    	}
    	var answer= $("#pd_combobox").combobox("getValue");
    	if(answer==null || answer==""){
    		$.messager.alert("温馨提示","请选择答案!");
    		return;
    	}
    	var pd_level = $('input[name="pd_qlevel"]:checked').val();
    	if(pd_level==null||pd_level.length<1){
    		$.messager.alert("温馨提示","请选择难易程度!");
    		return;
    	}
    	var pd_analysis = $("#pd_analysis").val();
     	var old_points = [];
    	var points = [];
    	var t = $("#cb_kpoint").combotree('tree');	// 获取树对象
    	var kpointValues = t.tree("getChecked");
    	if(kpointValues!=null && kpointValues.length>0){
    		for(var i=0;i<kpointValues.length;i++){
    			old_points.push(kpointValues[i].text);
    		}
    		points =old_points.join(",");
    	}
    	
    	
    	$.ajax({
    		url:'${pageContext.request.contextPath}/question/addJudgeQuestion.action',
    		type:'post',
    		data:"point="+points+"&title="+title+"&answer="+answer+"&answerAnalysis="+pd_analysis+"&level="+pd_level+"&typeId=2",
    		success:function(data){
    			if(data){
    				$.messager.alert("温馨提示","判断题添加成功");
    				pdReset();
    			}else{
    				$.messager.alert("温馨提示","添加失败!");
    			}
    		}
    	});
    }
    //保存问答题
    function wdSave()
    {
    	var title = $("#wd_title").val();
    	if(title==null || title==""){
    		$.messager.alert("温馨提示","请先输入题目!");
    		return;
    	}
    	
    	var wd_level = $('input[name="wd_level"]:checked').val();
    	if(wd_level==null||wd_level.length<1){
    		$.messager.alert("温馨提示","请选择难易程度!");
    		return;
    	}
    	
     	var wd_analysis = $("#wd_analysis").val();
     	
     	var old_points = [];
    	var points = [];
    	var t = $("#cb_kpoint").combotree('tree');	// 获取树对象
    	var kpointValues = t.tree("getChecked");
    	if(kpointValues!=null && kpointValues.length>0){
    		for(var i=0;i<kpointValues.length;i++){
    			old_points.push(kpointValues[i].text);
    		}
    		points =old_points.join(",");
    	}
    	
    	$.ajax({
    		url:'${pageContext.request.contextPath}/question/addWdQuestion.action',
    		type:'post',
    		data:"point="+points+"&title="+title+"&answerAnalysis="+wd_analysis+"&level="+wd_level+"&typeId=3",
    		success:function(data){
    			if(data){
    				$.messager.alert("温馨提示","问答题添加成功");
    				wdReset();
    			}else{
    				$.messager.alert("温馨提示","添加失败!");
    			}
    		}
    	});
    }
    
    //保存多选题
    function dxSave()
    {
    	var title = $("#dx_title").val();
    	if(title==null || title==""){
    		$.messager.alert("温馨提示","请先输入题目!");
    		return;
    	}
    	//遍历输入框
    	var isContinue = true;
    	var item = [];
    	$(".muti").each(function(index){
    		var value = $(this).val();
    		if(value==null || value==""){
    			$.messager.alert("温馨提示","请完善输入!");
    			isContinue = false;
    			item = [];
    			return;
    		}
    		item.push(value);
    	});
    	
    	var newItem = item.join(",");
    	var check = $('input[name="mut_ckb"]:checked');
    	if(check.length<2){
   			$.messager.alert("温馨提示","正确选项至少是两个!");
    		isContinue = false;
    		return;
    	}
    	
    	if(!isContinue){
    		$.messager.alert("温馨提示","请完善选择/输入!");
    		return;
    	}
    	
    	var answer = [];
    	check.each(function(index){
    		var item = $(this).val();
    		var inputValue = $("#dx"+item).val();
    		answer.push(inputValue);
    	});
    	var newAnswers = answer.join(",");
    	var analysisi = $("#dx_analysis").val();
    	
    	var dx_level = $('input[name="dx_level"]:checked').val();
    	if(dx_level==null||dx_level.length<1){
    		$.messager.alert("温馨提示","请选择难易程度!");
    		return;
    	}
    	
    	
    	var old_points = [];
    	var points = [];
    	var t = $("#cb_kpoint").combotree('tree');	// 获取树对象
    	var kpointValues = t.tree("getChecked");
    	if(kpointValues!=null && kpointValues.length>0){
    		for(var i=0;i<kpointValues.length;i++){
    			old_points.push(kpointValues[i].text);
    		}
    		points =old_points.join(",");
    	}
    	
    	$.ajax({
    		url:'${pageContext.request.contextPath}/question/addMutiChoiceQuestion.action',
    		type:'post',
    		data:"point="+points+"&title="+title+"&item="+newItem+"&trueItem="+newAnswers+"&answerAnalysis="+analysisi+"&level="+dx_level+"&typeId=4",
    		success:function(data){
    			if(data){
    				$.messager.alert("温馨提示","多选题添加成功");
    				m_dxReset();
    			}else{
    				$.messager.alert("温馨提示","添加失败!");
    			}
    		}
    	});
    	
    }
    
    
    //选择知识点的级联
    function kpointOnCheck(node,checked)
    {
		//如果当前节点是 【选择】 状态,如果当前节点有父亲，就让父亲被选中。
			var t = $("#cb_kpoint").combotree('tree');	// 获取树对象
		if(checked){
			var parent= t.tree("getParent",node.target);// 获取选择的节点
			if(parent!=null){
				t.tree("check",parent.target);
			}
		}else	{//如果当前节点是要做 取消 选择
		//把它的子节点也全部取消。
			var childrens = t.tree("getChildren",node.target);
			for(var i=0;i<childrens.length;i++){
				t.tree("uncheck",childrens[i].target);
			}
		}
    }
    
    //单选重置
    function dxReset()
    {
    	$("#sc_title").val("");
    	$("#sciA").val("");
    	$("#sciB").val("");
    	$(".scp").remove();
    	$("#cb_kpoint").combotree("clear");
    	$("#sc_analysis").val("");
    }
    
    //判断题重置
    function pdReset()
    {
    	$("#pd_title").val("");
    	$("#pd_combobox").combobox("select",$("#pd_combobox").combobox("getData")[0].value);
    	$("#pd_analysis").val("");
    	//还原知识点的选择
    	$("#cb_kpoint").combotree("clear");
    	$("#pd_analysis").val("");
    	
    }
    //问答题重置
    function wdReset()
    {
    	$("#wd_title").val("");
    	$("#wd_analysis").val("");
    	$("#cb_kpoint").combotree("clear");
    	
    }
    //多选重置
    function m_dxReset(){
    	$("#dx_title").val("");
    	$(".mut_p").remove();
    	$("#dx_analysis").val("");
      	$("#cb_kpoint").combotree("clear");
      	$("#dxA").val("");
      	$("#dxB").val("");
    }
    </script>
    <style type="text/css">
    </style>
  </head>
  
  <body style="margin: 1px">
  
<div id="dd" class="easyui-dialog" title="My Dialog" style="width:400px;height:200px;"   
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">   
        <p id="new_choice_item">
    		<span><input type="radio" name="answer"></span>
    			<span>选项2：</span>
    			<span><input type="text" name="item"></span>
    		</p>
</div>  

  
  
  
  <div id="p" class="easyui-panel" title="添加试题"     
        style="width:1100px;height:468px;padding:10px;background:#fafafa;"   
        data-options="iconCls:'icon-save',closable:true,    
                collapsible:true,minimizable:true,maximizable:true">   
    <div style="padding-bottom: 5px">   
        <label for="name">试题类型：</label>   
        <input id="cb_qtype" class="easyui-combobox" name="name"   
   		 data-options="valueField:'id',textField:'name',url:'${pageContext.request.contextPath }/question/getQuestionTypes.action'" /> 
   		 &nbsp;&nbsp;&nbsp;&nbsp;
   		  <label for="name">可选知识点：</label>   
   		 
   		 <select id="cb_kpoint" class="easyui-combotree" style="width:600px;"   
        data-options="url:'${pageContext.request.contextPath }/question/getComboboxKpoint.action',required:false,multiple:true,cascadeCheck:false,onCheck:kpointOnCheck"></select>  

   		 
    </div>   
    
    <!-- 选择题 -->
       <form id="question_choice_form" method="post">   
    <div  align="center">
    	<p id="hideTipsInfo"><font color="red">添加数量达到最大值!</font></p>
    	<div>
    			<p><span>题目：</span>
    			<textarea id="sc_title"  name="title"  placeholder="请输入题目描述"  style="resize:none" rows="4" cols="70"></textarea>
    			</p>	
    		<p>
    		<span><input id="1" value="A" type="radio" name="sc_trueItem"></span>
    			<span>选项A：</span>
    			<span><input type="text" class="item"  name="itemA" id="sciA"></span>
    		</p>
    		
    		<p id="choice_2">
    		<span><input id="2" value="B" type="radio" name="sc_trueItem"></span>
    			<span>选项B：</span>
    			<span><input type="text" class="item"  name="itemB" id="sciB"></span>
    		</p>
    		
    		
    	</div>
  <p align="center"><a href="javascript:addChoicItem();" class="easyui-linkbutton" data-options="iconCls:'icon-add'"></a></p>
    </div>
    <!-- 选择题end -->
    
    
      <!-- 通用div -->
    <div align="center" style="padding: 13px;">
    	<span>难易程度:</span>
    	<span><input value="困难" type="radio" name="sc_qlevel">困难</span>
    	<span><input value="一般" type="radio" name="sc_qlevel">一般</span>
    	<span><input value="容易" type="radio" name="sc_qlevel">容易</span>
    </div>
    
    <div align="center">
    			<p><span>答案解析：</span>
    			<textarea id="sc_analysis" placeholder="请输入答案解析/可为空"  name="analysis" style="resize:none" rows="4" cols="70"></textarea>
    			</p>	
    		</div>
    <!-- 通用div end -->
    
    <div align="center">
    	<a   href="javascript:singleChoicSave();" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>  
    	<a href="javascript:dxReset();" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">重置</a>  
    </div>
    </form>  
    <!-- 单向选择题end -->
    
    
      <!-- 判断题 -->
       <form id="question_justice_form" method="post">   
    <div align="center">
    			<p><span>题目：</span>
    			<textarea id="pd_title" placeholder="请输入题目描述" style="resize:none" rows="4" cols="70"></textarea>
    			</p>
    		
    		<div style="padding: 10px;">	
    		<p>
    			<span>答案：</span>
    			<span>
    				<select id="pd_combobox" class="easyui-combobox" name="answer" style="width:200px;">   
   					 	<option name="pd_answer"  value="" selected="selected">请选择...</option>   
   					 	<option value="正确">正确</option>   
			   			 <option value="错误">错误</option>   
					</select>  
    			</span>
    		</p>
    		</div>
    </div>
    <!-- 判断题end -->
    
    
      <!-- 通用div-->
    <div align="center" style="padding: 10px;padding-right: 68px;">
    	<span>难易程度：</span>
    	<span><input value="困难" type="radio" name="pd_qlevel">困难</span>
    	<span><input value="一般" type="radio" name="pd_qlevel">一般</span>
    	<span><input value="容易" type="radio" name="pd_qlevel">容易</span>
    </div>           
    
    <div align="center">
    			<p><span>答案解析：</span>
    			<textarea id="pd_analysis" placeholder="请输入答案解析/可为空"  name="analysis" style="resize:none" rows="4" cols="70"></textarea>
    			</p>	
    		</div>
    <!-- 通用div end -->
    
    <div align="center">
    	<a  href="javascript:pdQuestionSave();" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>  
    	<a href="javascript:pdReset();" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">重置</a>  
    </div>
    </form>  
    <!-- 判断题form end -->
    
    
          <!-- 问答题 -->
       <form id="question_answer_form" method="post">   
    <div align="center">
    			<p><span>题目：</span>
    			<textarea id="wd_title" placeholder="请输入题目描述" style="resize:none" rows="4" cols="70"></textarea>
    			</p>
    </div>
    <!-- 问答题end -->
    
    
      <!-- 通用div-->
    <div align="center" style="padding: 10px;padding-right: 68px;">
    	<span>难易程度：</span>
    	<span><input value="困难"  type="radio" name="wd_level">困难</span>
    	<span><input value="一般" type="radio" name="wd_level">一般</span>
    	<span><input value="容易" type="radio" name="wd_level">容易</span>
    </div>
    
    <div align="center">
    			<p><span>答案解析：</span>
    			<textarea id="wd_analysis" placeholder="请输入答案解析/可为空"  name="analysis" style="resize:none" rows="4" cols="70"></textarea>
    			</p>	
    		</div>
    <!-- 通用div end -->
    
    <div align="center">
    	<a  href="javascript:wdSave();" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>  
    	<a href="javascript:wdReset();" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">重置</a>  
    </div>
    </form>  
    <!-- 问答题form end -->
    
    
    
       <!-- 多项选择题 -->
       <form id="question_MutilChoice_form" method="post">   
    <div  align="center">
    	<p id="mutil_hideTipsInfo"><font color="red">添加数量达到最大值!</font></p>
    	<div>
    			<p><span>题目：</span>
    			<textarea id="dx_title"  placeholder="请输入题目描述"  style="resize:none" rows="4" cols="70"></textarea>
    			</p>	
    		<p>
    		<span><input type="checkbox" name="mut_ckb" value="A"></span>
    			<span>选项A：</span>
    			<span><input class="muti"  type="text" name="item" id="dxA"></span>
    		</p>
    		
    		<p id="choice_muti">
    		<span><input type="checkbox" name="mut_ckb" value="B"></span>
    			<span>选项B：</span>
    			<span><input class="muti" type="text" name="item" id="dxB"></span>
    		</p>
    	</div>
  <p align="center"><a href="javascript:addMultiChoicItem();" class="easyui-linkbutton" data-options="iconCls:'icon-add'"></a></p>
    </div>
    <!-- 选择题end -->
    
      <!-- 通用div -->
    <div align="center" style="padding: 13px;">
    	<span>难易程度:</span>
    	<span><input value="困难" type="radio" name="dx_level">困难</span>
    	<span><input value="一般" type="radio" name="dx_level">一般</span>
    	<span><input value="容易" type="radio" name="dx_level">容易</span>
    </div>
    <div align="center">
    			<p><span>答案解析：</span>
    			<textarea id="dx_analysis" placeholder="请输入答案解析/可为空"  name="analysis" style="resize:none" rows="4" cols="70"></textarea>
    			</p>	
    		</div>
    <!-- 通用div end -->
    
    <div align="center">
    	<a  href="javascript:dxSave();" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>  
    	<a href="javascript:m_dxReset();" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">重置</a>  
    </div>
    </form>  
    <!-- 多项选择题end -->
  


                
</div>  

  
  
  </body>
</html>
