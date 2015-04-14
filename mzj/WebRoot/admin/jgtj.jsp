<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../common/public.jsp" %>
<style type="text/css">

</style>
<script type="text/javascript">
</script>
<title>绩效考核系统</title>
</head>
<body>
	<%@include file="../common/head.jsp" %>
			<div style="height: 6%;"></div>
		<div style="margin: auto;height:65%; width: 74%; 
		background-size:100% 100%;background-image:url('${cp}/images/tjjg1.png');
						filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/tjjg1.png', sizingMethod='scale');">
		<div style="height: 10%"></div>
		<div onclick="goUrl('order')" class="button" style="float:left;height: 73%;width: 30%;margin-left: 3%;"></div>
		<div onclick="goUrl('tasks')" class="button" style="float:left;height: 73%;width: 30%;margin-left: 3%"></div>
		<div class="button" style="float:left;height: 73%;width: 30%;margin-left: 3%"></div>
		
	</div>
</body>
<!-- 弹窗 -->

	<div id="bg"></div>
		
</html>
