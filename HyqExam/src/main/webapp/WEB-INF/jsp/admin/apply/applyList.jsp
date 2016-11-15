<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/common/headLink.jsp"></jsp:include>
<title>报名列表页面</title>
<script type="text/javascript">
		function append(){
			var t = $('#tt'); //选中这个树
			var node = t.tree('getSelected'); //获取选中的节点
		
			t.tree('append', {
				parent: (node?node.target:null),
				data: [{
					text: '新建文件夹'}]
			});
		}
		function remove(){
			var node = $('#tt').tree('getSelected');
			$('#tt').tree('remove', node.target);
		}
		function collapse(){
			var node = $('#tt').tree('getSelected');
			$('#tt').tree('collapse',node.target);
		}
		function expand(){
			var node = $('#tt').tree('getSelected');
			$('#tt').tree('expand',node.target);
		}
	</script>
	
<script type="text/javascript">
function deleteCheck(id)
{
	if(confirm("删除报名信息会删除已报名的所有考生,请确认?"))
	{
		window.location.href="${pageContext.request.contextPath }/apply/deleteApply.action?applyId="+id;
	}
}
</script>
</head>
<body style="margin: 1px">
报名列表<br>
<c:if test="${applyInfoList!=null }">
<div align="left" style="float: left;">
<p>当前报名信息总览:</p>
	<ul id="tt" class="easyui-tree" data-options="
			//url: 'tree_data1.json', //指定数据源头
			animate: true, //在展开和折叠时显示动画效果
			onContextMenu: function(e,node){ //点击右键的时候触发
				e.preventDefault();
				$(this).tree('select',node.target);
				$('#mm').menu('show',{
					left: e.pageX,
					top: e.pageY
				});}">
<c:forEach items="${applyInfoList }" var="apply">
  <li> 
  	<span><a href="#">${apply.title }</a></span>
  </li>
  </c:forEach>
 
</ul>
</div>
</c:if>


<div id="mm" class="easyui-menu" style="width:120px;">
  <div onclick="append()" data-options="iconCls:'icon-add'">追加</div>
  <div onclick="remove()" data-options="iconCls:'icon-remove'">移除</div>
  <div class="menu-sep"></div>
  <div onclick="expand()">展开</div>
  <div onclick="collapse()">折叠</div>
</div>




<div align="center">
	<c:forEach items="${applyInfoList }" var="applyInfo">
		<p>标题：<a href="${pageContext.request.contextPath }/apply/detail.action?applyId=${applyInfo.id}">${applyInfo.title }</a>
		<span>时间:</span>
		<fmt:formatDate value="${applyInfo.startTime }" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>
		 ---
		 <fmt:formatDate value="${applyInfo.endTime  }" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>
		 <span>状态:${applyInfo.status }</span>
		 <span>操作</span>
		 	<a href="${pageContext.request.contextPath }/apply/editApplyUI.action?applyId=${applyInfo.id}">修改</a>
		 	<a onclick="deleteCheck('${applyInfo.id}');" href="#">删除</a>
		 	<a href="#">查看报名情况</a>
		 	
		 	<c:if test="${applyInfo.isHandConfirm =='yes' }">
		 	<a href="${pageContext.request.contextPath }/apply/ensureStu.action?applyInfoId=${applyInfo.id}">审核</a>
		 	</c:if>
		 </p>
	</c:forEach>
</div>

<hr>


	
	

</body>
</html>