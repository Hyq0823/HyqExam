<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="hyq" uri="/WEB-INF/tld/spring.tld"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'index.jsp' starting page</title>
  </head>
  
  <body>
  ${message }
  
<form:select path="type">
    <form:options items="${hyq:getDictListByType('dict_edu')}" itemLabel="name" itemValue="type"/>
</form:select>
  </body>
</html>
