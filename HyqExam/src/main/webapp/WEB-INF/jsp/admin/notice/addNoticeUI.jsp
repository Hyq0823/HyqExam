<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/common/headLink.jsp"></jsp:include>
<script type="text/javascript" charset="gbk"
	src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="gbk"
	src="${pageContext.request.contextPath}/ueditor/ueditor.all.min.js">
	
</script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="gbk"
	src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">
	//发布公告
	function addNotice() {
		var title = $("#title").val();
		if (title == null || "" == title) {
			alert("请输入公告标题");
			return;
		}
		var content = UE.getEditor('editor').getContent();
		if (content == null || "" == content) {
			alert("请输入公告内容!");
			return;
		}

		//如果都有值就提交

		$.ajax({
			url : "${pageContext.request.contextPath}/notice/addNotice.action",
			data : "title=" + title + "&content=" + content,
			type : "post",
			dataType : "json",
			success : function(msg) {
				if (msg) {
					alert("公告发布成功!");
					$("#title").val("");
					UE.getEditor('editor').setContent(""); 
					
				} else {
					alert("公告发布失败!");
				}
			},
			error : function() {
				alert("请求错误！");
			}
		});

	}
</script>
<title>添加公告</title>
</head>

<body style="margin: 1px">
	<div id="p" class="easyui-panel" title="发布公告" style="padding: 10px">
		<table cellspacing="20px">
			<tr>
				<td width="80px">公告标题：</td>
				<td><input type="text" id="title" name="title" value="${notice.title }"
					style="width: 400px;" /></td>
			</tr>

			<tr>
				<td valign="top">公告内容：</td>
				<td><script id="editor" type="text/plain"
						style="width:100%;height:200px;"></script></td>
			</tr>
			<tr>
				<td></td>
				<td><a href="javascript:addNotice()" class="easyui-linkbutton"
					data-options="iconCls:'icon-submit'">发布公告</a></td>
			</tr>
		</table>
	</div>

	<script type="text/javascript">
		//实例化编辑器
		//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
		var ue = UE.getEditor('editor');
	</script>
</body>
</html>
