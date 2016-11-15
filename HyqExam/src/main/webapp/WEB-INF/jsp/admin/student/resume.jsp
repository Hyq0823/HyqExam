<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/common/bootstrapLink.jsp"></jsp:include>
<title>考生简历</title>
</head>

<body>
	考生简历
	<br>


	<div style="height: 50px;"></div>

    <c:if test="${before!=null }">
	<div style="width: 20px;height: 20px;background: red;">
		<span style="font-size: 17px;float: left;"><a href="${pageContext.request.contextPath }/userResume.action?uid=${before}&aid=${applyId}&infoId=${infoId}">《</a></span>
	</div>
	</c:if>
	
    <c:if test="${after!=null }">
	<div>
		<span style="font-size: 17px;float: right;"><a href="${pageContext.request.contextPath }/userResume.action?uid=${after}&aid=${applyId}&infoId=${infoId}">》</a></span>
	</div>
</c:if>


	<div class="container">
		<div class="col-md-1"></div>
		<div class="row">
			<div class="col-md-10" style="height:800px;">
				<div id="baseInfo">
					<div class="jumbotron">
						<div>
							<div id="baseInfo_head">基本资料</div>
							<div class="baseInfo_left">
								<ul id="ul_left">
									<li>
										<p>
											真实姓名<span>${user.truename }</span>
											nickname==><span>${user.nickname }</span>
										</p>
									</li>
									<li>
										<p>
											性别<span>男</span>
										</p>
									</li>
									<li>
										<p>
											出生日期<span>1994年8月23日</span>
										</p>
									</li>
									<li>
										<p>
											邮箱<span>823547749@qq.com</span>
										</p>
									</li>
								</ul>

							</div>
							<div class="baseInfo_right">
								<ul id="ul_right">
									<li>
										<p>
											手机号码<span>19422222222</span>
										</p>
									</li>
									<li>
										<p>
											身份证<span>942343242</span>
										</p>
									</li>
									<li>
										<p>
											地址<span>8888地址8号</span>
										</p>
									</li>
									<li>
										<p>
											当前状态<span>在职</span>
										</p>
									</li>
								</ul>
							</div>
							<div class="clear"></div>
						</div>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>

				</div>
				<!--基本资料end-->

				<!--教育及培训-->
				<div>
					<div class="jumbotron">
						<div class="container">
							<table class="table">
								<caption>教育及培训经历</caption>
								<thead>
									<th>机构名称</th>
									<th>开始时间</th>
									<th>结束时间</th>
									<th>内容描述</th>
								</thead>
								<tbody>
									<tr>
										<td>传智播客</td>
										<td>2016年1月2日</td>
										<td>2016年4月4日</td>
										<td>3个多月的学习</td>
									</tr>
									<tr>
										<td>传智播客</td>
										<td>2016年1月2日</td>
										<td>2016年4月4日</td>
										<td>3个多月的学习</td>
									</tr>
									<tr>
										<td>传智播客</td>
										<td>2016年1月2日</td>
										<td>2016年4月4日</td>
										<td>3个多月的学习</td>
									</tr>

								</tbody>

							</table>
						</div>
					</div>
				</div>
				<!--教育及培训end-->

				<!--工作经历-->
				<div>
					<div class="jumbotron">
						<div class="container">
							<table class="table">
								<caption>在职经历</caption>
								<thead>
									<th>工作年限</th>
									<th>公司名称</th>
									<th>职位名称</th>
									<th>最高学历</th>
								</thead>
								<tbody>
									<tr>
										<td>3年</td>
										<td>华为科技</td>
										<td>总经理</td>
										<td>学士</td>
									</tr>


								</tbody>

							</table>
						</div>
					</div>
				</div>
				<!--教育及培训end-->


			</div>

		</div>

		<div class="col-md-1"></div>

	</div>




</body>
</html>
