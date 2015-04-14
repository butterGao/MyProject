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
<link  rel="stylesheet" type="text/css" href="../css/common.css"/>
<script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
<script>
$(document).ready(function(e) {
    $("#OPINION a:eq(0)").css({"color": "black"});
	   $("#OPINION a:eq(1)").css({"color": "white"}); 
 });
	$(function(){
		$("#content1").css("display","block");
		$("#content2").css("display","none");
		$("#content3").css("display","none");
		$("#content4").css("display","none");
		$("#p1 a").css("color","#F36");
		$("#p1").click(function(){
			$("#content1").css("display","block");
			$("#content2").css("display","none");
			$("#content3").css("display","none");
			$("#content4").css("display","none");
			$("a",this).css("color","#F36");
			$("#p2 a").css("color","#000");
			$("#p3 a").css("color","#000");
			$("#p4 a").css("color","#000");
		});	
		$("#p2").click(function(){
			$("#content1").css("display","none");
			$("#content2").css("display","block");
			$("#content3").css("display","none");
			$("#content4").css("display","none");
			$("a",this).css("color","#F36");
			$("#p1 a").css("color","#000");
			$("#p3 a").css("color","#000");
			$("#p4 a").css("color","#000");
		});	
		$("#p3").click(function(){
			$("#content1").css("display","none");
			$("#content2").css("display","none");
			$("#content3").css("display","block");
			$("#content4").css("display","none");
			$("a",this).css("color","#F36");
			$("#p1 a").css("color","#000");
			$("#p2 a").css("color","#000");
			$("#p4 a").css("color","#000");
		});	
		$("#p4").click(function(){
			$("#content1").css("display","none");
			$("#content2").css("display","none");
			$("#content3").css("display","none");
			$("#content4").css("display","block");
			$("a",this).css("color","#F36");
			$("#p1 a").css("color","#000");
			$("#p2 a").css("color","#000");
			$("#p3 a").css("color","#000");
		});
	});
</script>
</head>

<body>
	<div id="center">
		<%@include file="../page/header.jsp"%>
		<div id="zhongti"
			style="width: 780px; height: 600px; background-color: #FFF; font-family: 宋体; font-size: 12px; margin: 0px 0px 0px 20px;">
			<div
				style="float: left; width: 120px; height: auto; background-color: #FFF; font-size: 14px; line-height: 150%; cursor: pointer; text-align: left;">
				<div
					style="border-bottom: 1px #003399 solid; background-color: #069; padding-left: 10px;; color: white;">意见反馈</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p1">
					<a style="text-decoration: none; color: #F36; font-size: 10pt">考核评价</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p2">
					<a style="text-decoration: none; color: #000; font-size: 10pt">统计成果</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p3">
					<a href="javascript:void(0);"
						style="text-decoration: none; color: #000; font-size: 10pt">投诉信箱</a>
				</div>
			</div>

			<div
				style="float: right; width: 600px; height: 600px; background-color: #FFF; cursor: pointer;"
				id="content1">
				<div style="width: 100%; height: 24px;">
					<div style="float: right;">
						<div
							style="width: auto; color: #06F; float: right; padding-top: 5px;">
							意见反馈&nbsp;&bull;&nbsp;<b style="color: #000;">考核评价</b>
						</div>
					</div>
					<div style="height: 10px;"></div>
<div
					style="width: 100%; height: auto; text-align: center; margin-top: 0px; float: left;">
					<img src="../images/jianse.jpg" width="600px" height="400px;" />
					<p style="text-align: left; text-indent: 2em; line-height: 200%;">

					</p>
				</div>
					<%-- <div
						style="width: 100%; height: auto; text-align: center; margin-top: 0px; float: left;">
						<table align="right" id="tab" border="0" rules="none">
							<s:iterator value="one.list" var="l">
								<tr>
									<s:if test="#l.types==1">
										<td height="32" width="380" align="left"><img
											src="${ctx}/images/li.jpg" height="13"><a
											href="${ctx}/page/xz?id=${l.id}">${l.title}</a></td>
									</s:if>
									<s:else>
										<td height="32" width="380" align="left"><img
											src="${ctx}/images/li.jpg" height="13"><a
											onclick="query(${l.id})">${l.title}</a></td>
									</s:else>

									<td width="99"><s:date name="#l.creatTime"
											format="yyyy-MM-dd" /></td>
								</tr>
							</s:iterator>
						</table>
					</div> --%>
				</div>

			</div>
			<div
				style="float: right; width: 600px; height: aotu; background-color: #FFF; cursor: pointer;"
				id="entry">
				<div style="width: 100%; height: auto;">
					<div style="height: 10px;"></div>
					<div
						style="width: 100%; height: auto; text-align: center; margin-top: 0px; float: left;">
						<h1 align="center" id="title"></h1>
						<p id="contents" align="left"></p>
					</div>
				</div>
			</div>
			<div
				style="float: right; width: 600px; height: 600px; background-color: #FFF; cursor: pointer;"
				id="content2">
				<div style="width: 100%; height: 24px;">
					<div style="float: right;">
						<div
							style="width: auto; color: #06F; float: right; padding-top: 5px;">
							意见反馈&nbsp;&bull;&nbsp;<b style="color: #000;">统计成果</b>
						</div>
					</div>
				</div>
				<div style="height: 10px;"></div>
				<div
					style="width: 100%; height: auto; text-align: center; margin-top: 0px; float: left;">
					<img src="../images/jianse.jpg" width="600px" height="400px;" />
					<p style="text-align: left; text-indent: 2em; line-height: 200%;">

					</p>
				</div>
				<%-- <div
					style="width: 100%; height: auto; text-align: center; margin-top: 0px; float: left;">
					<table align="right" id="tab" border="0" rules="none">
						<s:iterator value="two.list" var="l">
							<tr>
								<s:if test="#l.types==1">
									<td height="32" width="380" align="left"><img
										src="${ctx}/images/li.jpg" height="13"><a
										href="${ctx}/page/xz?id=${l.id}">${l.title}</a></td>
								</s:if>
								<s:else>
									<td height="32" width="380" align="left"><img
										src="${ctx}/images/li.jpg" height="13"><a
										onclick="query(${l.id})">${l.title}</a></td>
								</s:else>

								<td width="99"><s:date name="#l.creatTime"
										format="yyyy-MM-dd" /></td>
							</tr>
						</s:iterator>
					</table>
				</div> --%>
			</div>

			<div
				style="float: right; width: 600px; height: 600px; background-color: #FFF; cursor: pointer;"
				id="content3">
				<div style="width: 100%; height: 24px;">
					<div style="float: right;">
						<div
							style="width: auto; color: #06F; float: right; padding-top: 5px;">
							意见反馈&nbsp;&bull;&nbsp;<b style="color: #000;">投诉信箱</b>
						</div>
					</div>
				</div>
				<div style="height: 10px;"></div>
				<div
					style="width: 100%; height: auto; text-align: center; margin-top: 0px; float: left;">
					<img src="../images/jianse.jpg" width="600px" height="400px;" />
					<p style="text-align: left; text-indent: 2em; line-height: 200%;">

					</p>
				</div>
				<%-- <div
					style="width: 100%; height: auto; text-align: center; margin-top: 0px; float: left;">
					<table align="right" id="tab" border="0" rules="none">
						<s:iterator value="three.list" var="l">
							<tr>
								<s:if test="#l.types==1">
									<td height="32" width="380" align="left"><img
										src="${ctx}/images/li.jpg" height="13"><a
										href="${ctx}/page/xz?id=${l.id}">${l.title}</a></td>
								</s:if>
								<s:else>
									<td height="32" width="380" align="left"><img
										src="${ctx}/images/li.jpg" height="13"><a
										onclick="query(${l.id})">${l.title}</a></td>
								</s:else>

								<td width="99"><s:date name="#l.creatTime"
										format="yyyy-MM-dd" /></td>
							</tr>
						</s:iterator>
					</table>
				</div> --%>
			</div>
		</div>
		<jsp:include page="foot.jsp"></jsp:include>
	</div>
</body>
</html>
