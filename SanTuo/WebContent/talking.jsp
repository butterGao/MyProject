<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URI"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta content="text/html;chartset=utf-8" http-equiv="contentType">
	<title>
		<%=
			URLDecoder.decode(request.getParameter("title"),"utf-8")
		%>
	</title>
</head>
<body>
	<%-- <applet
	ID="talking_app"
	CODE="com.applet.TalkClient.class"
	codebase="classes"
	width="${ param.width}"
	height="${ param.height }"
	>
	<param name="height" value="${param.height }">
	<param name="width" value="${param.width }">
	<param name="host" value="${param.host }">
	<param name="port" value="${param.port }">
	<param name="to" value="${param.uid }">
	<param name="from" value="${param.sid }">
	</applet> --%>
	
	
	<!-- signed jar -->
	<applet style="z-index: 999999"
	ID="talking_app"
	CODE="com.applet.TalkClient.class"
	codebase="signed"
	archive="video-chat.jar"
	width="${ param.width}"
	height="${ param.height }"
	>
	<param name="height" value="${param.height }">
	<param name="width" value="${param.width }">
	<param name="host" value="${param.host }">
	<param name="port" value="${param.port }">
	<param name="to" value="${param.uid }">
	<param name="from" value="${param.sid }">
	</applet>
	
</body>
</html>