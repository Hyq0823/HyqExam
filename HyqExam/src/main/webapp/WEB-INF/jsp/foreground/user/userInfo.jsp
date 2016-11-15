<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户详细信息</title>
<!-- 引入bootstrap的文件 -->
<jsp:include page="/common/bootstrapLink.jsp"></jsp:include>
<script language="javascript" type="text/javascript"
	src="/datepicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript">
	$(document).ready(function(e) {
		$("#enableDoc_yes").hide();
		$("#enableDoc_no").hide();
	});
	//是否有从医资格
	function DocChange() {
		if ($("#isPrime").val() == "yes") {
			$("#enableDoc_yes").show();
			$("#enableDoc_no").hide();
		} else if ($("#isPrime").val() == "no") {
			$("#enableDoc_no").show();
			$("#enableDoc_yes").hide();
		} else {
			$("#enableDoc_no").hide();
			$("#enableDoc_yes").hide();
		}
	}
	//添加教育经历
	var count = 5;

	function addEdu() {
		if (count > 0) {
			var tr = $("#edu").clone();
			//修改新行的id
			tr.attr("id", "edu_clone" + count);

			//加入一个新的行
			tr.append('<td><a href="javascript:removeEdu('
							+ "edu_clone"
							+ count
							+ ');"><span class="glyphicon glyphicon-remove"></span></td>');
			//alert($("#edu_clone"));
			count = count - 1;
			tr.insertAfter($("#edu:last"));
		}
	}
	//移除教育经历
	function removeEdu(obj) {
		$(obj).remove();
		count = count + 1;
	}

	//提交基本信息表单
	function baseSubmit() {
		var truename = $("#truename").val();
		if ("" == truename) {
			alert("请输入真实姓名!");
			return;
		}

		var sex = $("#sex option:selected").val();
		if (null == sex || "" == sex) {
			alert("请选择性别!");
			return;
		}

		var email = $("#email").val();
		if (null == email || "" == email) {
			alert("请输入邮箱!");
			return;
		}

		var phone = $("#phone").val();
		if (null == phone || "" == phone) {
			alert("请输入手机号码!");
			return;
		}
		var idCardType = $("#idCardType option:selected").val();
		var idCardNumber = $("#idCardNumber").val();
		var birth = $("#birth").val();
		var address = $("#address").val();
		var status = $("#status option:selected").val();
		
		//alert(truename+"-"+sex+"-"+email+"-"+phone+"-"+idCardType+"-"+idCardNumber+"-"+birth+"-"+"-"+address+"-"+status);
		var  data="truename="+truename+"&sex="+sex+"&email="+email+
		"&phone="+phone+"&idCardType="+idCardType+"&idCardNumber="+idCardNumber+"&birth="+birth+"&address="+address+"&status="+status;
		alert(data);

		
		//表单提交
		//$("#base").submit();
		$.ajax({
			data:"truename="+truename+"&sex="+sex+"&email="+email+
			"&phone="+phone+"&idCardType="+idCardType+"&idCardNumber="+idCardNumber+"&birth="+birth+"&address="+address+"&status="+status,
			url:"${pageContext.request.contextPath }/base.action",
			type:"post",
			success:function(msg)
			{
				alert(msg);
				//显示展示页面并且让表单不可再次提交
			}
		});

	}
	
	//保存教育经历
	function eduSave()
	{
		var data = '';
		var strutName = document.getElementsByName("structName");
		var startTime = document.getElementsByName("startTime");
		var endTime = document.getElementsByName("endTime");
		var description = document.getElementsByName("description");
		for(var i=0;i<strutName.length;i++)
		{
			//判断添加行的合法性
			var flag = checkRowData(i,strutName[i],startTime[i],endTime[i],description[i]);
			if(!flag)
			{
				return;
			}
			data += strutName[i].value +"@";
			data += startTime[i].value +"@";
			data += endTime[i].value +"@";
			data += description[i].value +"#";
		}
		//发送数据
		$.ajax({
			url:"${pageContext.request.contextPath }/edu.action",
			type:"post",
			data: "eduData="+data,
			success:function(msg)
		{
				alert(msg);
			}
		});
	}
	
	//对添加的每一行【教育信息】检查它的合法性
	function checkRowData(row,strutName,startTime,endTime,Description)
	{
		row = row + 1;
		if(strutName.value==null || strutName.value == "")
		{
			alert("第"+row+"行机构名称不能是空!");
			return false;
		}
		
		if(startTime.value==null || startTime.value == "")
		{
			alert("第"+row+"行开始时间不能是空!");
			return false;
		}
		if(endTime.value==null || endTime.value == "")
		{
			alert("第"+row+"行结束时间不能是空!");
			return false;
		}
		if(Description.value==null || Description.value == "")
		{
			alert("第"+row+"行描述不能是空!");
			return false;
		}
		return true;
	}
	
	//保存工作经验
	function saveExp()
	{
		var exp = $("#exp option:selected").val();
		if(exp==null || ""==exp)
		{
			alert("请选择工作年限!");
			return;
		}
		
		var companyName = $("#companyName").val();
		if(companyName == null || "" == companyName)
		{
			alert("请输入公司名称!");
			return;
		}
		var positionName = $("#positionName").val();
		if(positionName == null || "" == positionName)
		{
			alert("请输入职位名称!");
			return;
		}
		
		var qualification = $("#qualification option:selected").val();
		if(qualification==null || ""==qualification)
		{
			alert("请选择最高学历!");
			return;
		}
		
		
		var data = exp + "@" + companyName +"@" + positionName +"@"  + qualification+"#";
		$.ajax({
			url:"${pageContext.request.contextPath }/exp.action",
			type:"post",
			data:"exp="+data,
			success:function(msg){
				alert(msg);
			}
		});
	}
	
	//保存从医经历
	function saveDoc(type)
	{
		var data = "";
		//要去除输入框前后的空格
		if(1==type)
		{
			data+="yes@";
			var docNum = $("#doctorNum").val();
			if(docNum == null || "" == docNum)
			{
				alert("请输入执业资格号!");
				return;
			}
			data+=docNum+"#";
		}
		
		if(2==type)
		{
			data+="no@";
			var enablePass = $("#enablePass option:selected").val();
			if(enablePass == null || "" == enablePass)
			{
				alert("请选择是否有资格考取!");
				return;
			}
			data+=enablePass+"#";
		}
		
		
		$.ajax({
			url:"${pageContext.request.contextPath }/doc.action",
			type:"post",
			data:"doc="+data,
			success:function(msg){
				alert(msg);
			}
		});
	}
	
	//保存其他想说的话
	function saveOther()
	{
		var otherSay = $("#otherSay").val();
		$.ajax({
			url:"${pageContext.request.contextPath }/other.action",
			type:"post",
			data : "other="+otherSay,
			success:function(msg){
				alert(msg);
			}
		});
	}
</script>
<style type="text/css">
/* Custom Styles */
ul.nav-tabs {
	width: 140px;
	margin-top: 20px;
	border-radius: 4px;
	border: 1px solid #ddd;
	box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067);
}

ul.nav-tabs li {
	margin: 0;
	border-top: 1px solid #ddd;
}

ul.nav-tabs li:first-child {
	border-top: none;
}

ul.nav-tabs li a {
	margin: 0;
	padding: 8px 16px;
	border-radius: 0;
}

ul.nav-tabs li.active a,ul.nav-tabs li.active a:hover {
	color: #fff;
	background: #0088cc;
	border: 1px solid #0088cc;
}

ul.nav-tabs li:first-child a {
	border-radius: 4px 4px 0 0;
}

ul.nav-tabs li:last-child a {
	border-radius: 0 0 4px 4px;
}

ul.nav-tabs.affix {
	top: 30px;
	/* Set the top position of pinned element */
}
</style>
</head>
<body>

	<div style="height: 50px;"></div>

	<div class="row">
		<div class="col-md-2" id="myScrollspy">
			<ul id="tips" class="nav nav-tabs nav-stacked" data-spy="affix"
				data-offset-top="125">
				<li class="active"><a href="#part1" data-toggle="tab">基本资料(必填)</a></li>
				<li><a href="#part2" data-toggle="tab">教育及培训</a></li>
				<li><a href="#part3" data-toggle="tab">在职描述</a></li>
				<li><a href="#part4" data-toggle="tab">从医经历</a></li>
				<li><a href="#part5" data-toggle="tab">其他</a></li>
			</ul>
		</div>

		<div class="col-md-8">
			<div class="tab-content">
				<div class="tab-pane fade in active" id="part1">
					<!--第一部分
					<form id="base" role="form" method="post"
						action="${pageContext.request.contextPath }/base.action">-->
						<table class="table table-bordered table-striped table-hover"
							id="section-1">
							<caption>基本资料</caption>
							<tbody>
								<tr>
									<!--提示-->
									<div class="alert alert-danger">
										<button type="button" class="close" data-dismiss="alert"
											aria-hidden="true">&times;</button>
										<strong>注意!</strong> 为确保您报名成功,请请务必填写带*号选项
									</div>
									<!--提示end-->
								</tr>

								<tr>
									<td>真实姓名<span
										style="color: #F00; font-size:18px; font-weight:bold;">*</span></td>
									<td><input id="truename" type="text" name="truename"
										class="form-control" value="${currentUser.truename }" /></td>
									<td>性别<span
										style="color: #F00; font-size:18px; font-weight:bold;">*</span></td>
									<td><select id="sex" name="sex">
											<option value="" selected="selected">请选择</option>
											<option value="男">男</option>
											<option value="女">女</option>
									</select></td>

									<td>邮箱<span
										style="color: #F00; font-size:18px; font-weight:bold;">*</span></td>
									<td><input id="email" type="text" name="email" value="${currentUser.email }"
										class="form-control" /></td>
								</tr>

								<tr>
									<td>手机号码<span
										style="color: #F00; font-size:18px; font-weight:bold;">*</span></td>
									<td><input id="phone" type="text" name="phone"
										class="form-control" value="${currentUser.phone }" /></td>
									<td>证件类型</td>
									<td><select name="idCardType" id="idCardType">
											<option value="" selected="selected">请选择</option>
											<option value="身份证">身份证</option>
											<option value="护照">护照</option>
									</select></td>
									<td>证件号码</td>
									<td><input type="text" name="idCardNumber" id="idCardNumber"
										class="form-control"  value="${currentUser.idCardNumber }"/></td>
								</tr>

								<tr>
									<td>出生年月</td>
									<td><input value="${currentUser.birth }" name="birth" id="birth" class="form-control"
										onclick="WdatePicker({el:'birth',dateFmt:'yyyy年MM月dd日'})"
										type="text"> <img src="datepicker/a.gif"
										onclick="WdatePicker({el:'birth',dateFmt:'yyyy年MM月dd日'})"></td>
									<td>地址</td>
									<td><input id="address"  value="${currentUser.address }" type="text" name="address" class="form-control" /></td>
									<td>当前状态</td>
									<td><select name="status" id="status">
											<option value="" selected="selected">请选择</option>
											<option value="在校">在校</option>
											<option value="在职">在职</option>
											<option value="其他">其他</option>
									</select></td>
								</tr>
								<tr>
									<td colspan="6"><button type="button"
											onclick="baseSubmit();" class="btn btn-primary btn-block">保存信息</button></td>
								</tr>
							</tbody>
						</table>
			<!-- 	</form> -->
				</div>
				<!--第一部分end-->

				<!--第二部分-->
					<div class="tab-pane" id="part2">
				<form>
						<table class="table" id="section-2">
							<caption>教育及培训</caption>
							<tbody>
								<tr>
							<thead>
								<th>机构名称</th>
								<th>开始时间</th>
								<th>结束时间</th>
								<th>内容描述</th>
								<th></th>
							</thead>
							</tr>
							<tr id="edu">
								<td><input id="structName" type="text" name="structName"
									class="form-control" /></td>
								<td><input id="startTime" class="form-control" name="startTime"
									id="startTime" onclick="WdatePicker({dateFmt:'yyyy年MM月'})"
									type="text"></td>
								<td><input id="endTime"  class="form-control" name="endTime" id="endTime"
									onclick="WdatePicker({dateFmt:'yyyy年MM月'})" type="text">
								</td>
								<td><input id="description" type="text" name="description"
									class="form-control" /></td>

							</tr>
							</tbody>

						</table>
				</form>
						<button type="button" class="btn btn-info" onclick="addEdu();">
							<span class="glyphicon glyphicon-plus"></span> 添加
						</button>
						<button type="button" class="btn btn-success" onclick="eduSave();">
							<span class="glyphicon glyphicon-floppy-disk"></span>保存
						</button>

					</div>
				<!--第二部分end-->

				<!--第3部分-->
					<div class="tab-pane" id="part3">
						<table class="table">
				<form>
							<caption>在职</caption>
							<tbody>
								<tr>
									<thead>
						<th>工作年限</th>
						<th>公司名称</th>
						<th>职位名称</th>
						<th>最高学历</th>
					</thead>
					</tr>
					<tr id="work">
						<td><select name="exp" id="exp">
								<option selected="selected" value="">请选择</option>
								<option value="1年">1年</option>
								<option value="2年">2年</option>
								<option value="3年">3年</option>
								<option value="4年">4年</option>
								<option value="5年">5年</option>
								<option value="6年">6年</option>
								<option value="7年">7年</option>
								<option value="8年">8年</option>
								<option value="9年">9年</option>
								<option value="10年">10年</option>
								<option value="10年以上">10年以上</option>
						</select></td>
						<td><input id="companyName" type="text" name="companyName"
									class="form-control" /></td>
						<td><input id="positionName" type="text" name="positionName"
									class="form-control" /></td>
						<td><select name="qualification" id="qualification">
								<option selected="selected" value="">请选择学位</option>
								<option value="硕士">硕士</option>
								<option value="学士">学士</option>
								<option value="博士">博士</option>
						</select></td>
					</tr>

					</tbody>

				</table>
				</form>
				<button type="button" class="btn btn-success" onclick="saveExp();">
					<span class="glyphicon glyphicon-floppy-disk" ></span>保存
				</button>
			</div>
			<!--第三部分end-->

			<!--第四部分 医师信息-->
				<div class="tab-pane" id="part4">
					<table class="table">
						<caption>从医经历</caption>
						<tbody>
							<tr>
								<td>是否具有中医执业医师资格证</td>
								<td><select id="isPrime" name="isDocNum"
										onchange="DocChange();">
										<option selected="selected">请选择</option>
										<option value="yes">是</option>
										<option value="no">否</option>
								</select></td>
							</tr>
						</tbody>
					</table>

					<div id="enableDoc">
						<div id="enableDoc_yes">
							<tr>
								<td>请输入执业资格号</td>
								<td><input id="doctorNum" type="text" name="doctorNum"
										class="form-control" /></td>
								<td><button type="button" class="btn btn-success" onclick="saveDoc('1')";>
										<span class="glyphicon glyphicon-floppy-disk" ></span>保存
									</button></td>
							</tr>

						</div>
						<div id="enableDoc_no">
						<tr>
								<td>是否有资格考取</td>
								<td><select id="enablePass" name="enablePass">
										<option value="" selected="selected">请选择</option>
										<option value="yes">是</option>
										<option value="no">否</option>
								</select></td>
								<td><button type="button" class="btn btn-success" onclick="saveDoc('2')";>
										<span class="glyphicon glyphicon-floppy-disk"></span>保存
									</button></td>
							</tr>
						</div>
					</div>

				</div>


			<!--tab end-->
			<!--第四部分end-->

			<!--第五部分-->
			<div class="tab-pane" id="part5">
			<form>
				<table class="table">
					<caption>其他信息</caption>
					<tbody>
						<tr>
							<td>其他想说的</td>
							<td><textarea id="otherSay" name="otherSay" class="form-control"
											style="resize: none" rows="4"></textarea></td>
						</tr>
					</tbody>
				</table>
			</form>
				<button type="button" class="btn btn-success" onclick="saveOther();">
					<span class="glyphicon glyphicon-floppy-disk"></span>保存
				</button>
			</div>
			<!--第五部分end-->

		</div>
		<!--部分end-->

	</div>
		<!-- row end -->
	<div class="col-md-2"></div>

</body>
</html>