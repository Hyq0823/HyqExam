<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>公告详细页面</title>
      <jsp:include page="/common/headLink.jsp"></jsp:include>
  </head>
  
  <body>
  <div id="p" class="easyui-panel" title="公告明细"     
        style="width:500px;height:150px;padding:10px;background:#fafafa;"   
        data-options="iconCls:'icon-save',closable:true,    
                collapsible:true,minimizable:true,maximizable:true">   
    <p>${notice.id }</p>   
    <p>${notice.title }</p>   
    <p>${notice.content }</p>   
    <p>${notice.deployTime }</p>   
    <p>${notice.deployer }</p>   
</div> 
  </body>
</html>
