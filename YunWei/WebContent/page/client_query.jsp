<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
%>
<%@include file="../titlevalue.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titlename%></title>
<link rel="stylesheet" type="text/css" href="../css/common.css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.7.1.js"></script>
<script>
	$(document).ready(function(e) {
		$("#QUERY a:eq(0)").css({
			"color" : "black"
		});
		$("#QUERY a:eq(1)").css({
			"color" : "white"
		});
	});

	$(function() {
		$("#content1").css("display", "block");
		$("#content2").css("display", "none");
		$("#p1 a").css("color", "#F36");
		$("#p1").click(function() {
			//alert("ddd");
			$("#content1").css("display", "block");
			$("#content2").css("display", "none");
			$("a", this).css("color", "#F36");
			$("#p2 a").css("color", "#000");
		});
		$("#p2").click(function() {
			$("#content1").css("display", "none");
			$("#content2").css("display", "block");
			$("a", this).css("color", "#F36");
			$("#p1 a").css("color", "#000");
		});

	});
</script>
</head>

<body>
	<div id="center">
		<%@include file="../page/header.jsp"%>
		<div
			style="width: 800px; height: 600px; background-color: #FFF; font-family: 宋体; font-size: 12px; margin: 0px 0px 0px 20px;">
			<div
				style="float: left; width: 120px; height: auto; background-color: #FFF; font-size: 14px; line-height: 150%; cursor: pointer; text-align: left;">
				<div
					style="border-bottom: 1px #003399 solid; background-color: #069; padding-left: 10px; color: white;">客户查询</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p1">
					<a style="text-decoration: none; color: #000; font-size: 10pt">常用报表</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p2">
					<a href="#"
						style="text-decoration: none; color: #000; font-size: 10pt">学校保修信息</a>

				</div>
			</div>
			<div
				style="float: right; width: 600px; height: 600px; background-color: #FFF; cursor: pointer;"
				id="content1">
				<div style="width: 100%; height: 24px;">
					<div style="float: right;">
						<div
							style="width: auto; color: #06F; float: right; padding-top: 5px;">
							客户查询&nbsp;&bull;&nbsp;<b style="color: #000;">常用报表</b>
						</div>
					</div>
				</div>
				<div style="height: 20px;"></div>
				<div
					style="width: 100%; height: auto; text-align: center; margin-top: 0px; float: left;">
					<img src="../images/jianse.jpg" width="600px" height="400px;" />
					<p style="text-align: left; text-indent: 2em; line-height: 200%;">

					</p>
				</div>
			</div>

			<div
				style="float: right; width: 600px; height: 600px; background-color: #FFF; cursor: pointer;"
				id="content2">
				<div style="width: 100%; height: 24px;">
					<div style="float: right;">
						<div
							style="width: auto; color: #06F; float: right; padding-top: 5px;">
							客户查询&nbsp;&bull;&nbsp;<b style="color: #000;">学校保修信息</b>
						</div>
					</div>
				</div>
				<div style="height: 20px;"></div>
				<div
					style="width: 100%; height: auto; text-align: center; margin-top: 0px; float: left;">
					<img src="../images/jianse.jpg" width="600px" height="400px;" />
					<p style="text-align: left; text-indent: 2em; line-height: 200%;">

					</p>
				</div>
			</div>
		</div>
		<jsp:include page="foot.jsp"></jsp:include>
	</div>
</body>
</html>
