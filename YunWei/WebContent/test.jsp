<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/js/validate.js?d=<%=new Date() %>"></script>
<script type="text/javascript">

	$(function() {
		reapet('password', 'repassword', '两次输入不相同');
		number('age', '只能为数字');
		cellPhone('phone', '手机号格式不正确');
		phone('phone', '电话号码格式不正确');
		email('email', '邮箱格式不正确');
		unique('username', 'unique.html', 'name');
		form('form', 'user_regist.html');
	});
</script>
</head>
<body>
	<input id="txtTruename" validType="number" required="true" type="text" class="txt03" />
</body>
</html>