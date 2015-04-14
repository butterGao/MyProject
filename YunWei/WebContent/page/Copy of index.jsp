<%@page import="com.saitu.model.Link"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
%>
<%@include file="../titlevalue.jsp"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titlename%></title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/common.css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.7.1.js"></script>
<link href="${ctx}/css/slideshow.css" rel="stylesheet" />
<script src="${ctx}/js/slideshow.js" type="text/javascript"></script>
<style>
tr {
	font-size: 16px;
}

.imags {
	line-height: 18px;
	padding-top: 0px;
	background: #fff;
	border: 2px solid rgb(187, 187, 187);
}

a.ss:link {
	color: #272727;
}

a.ss:visited {
	color: #272727;
}

form {
	margin: 0;
}

textarea {
	display: block;
}

body {
	font: 12px/1.5 Tahoma, 'Microsoft Yahei', 'Simsun';
	color: #444;
}

body,ul,li {
	margin: 0;
	padding: 0;
}

ul li {
	list-style: none;
}

a {
	color: #000;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

a img {
	border: none;
}

.cl:after {
	content: ".";
	display: block;
	height: 0;
	clear: both;
	visibility: hidden;
}

.cl {
	zoom: 1;
}

.frame {
	margin-bottom: 10px;
	border: 1px solid #e1e1e1;
	background: #FFF;
}

.title {
	padding: 0 10px;
	height: 32px;
	font-size: 14px;
	font-weight: 400px;
	line-height: 32px;
	overflow: hidden;
}

.block {
	margin: 10px 10px 0;
}

.slideshow {
	clear: both;
}

.slideshow li {
	position: relative;
	overflow: hidden;
}

.slideshow span.title {
	position: absolute;
	bottom: 0;
	left: 0;
	margin-bottom: 0;
	width: 341px;
	height: 14px;
	line-height: 14px;
	font-size: 14px;
	text-indent: 5px;
}

.slideshow span.title,.slidebar li {
	background: rgba(0, 0, 0, 0.3);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr= #30000000,
		endColorstr= #30000000);
	color: #FFF;
	overflow: hidden;
}

.slidebar li {
	float: left;
	margin-right: 1px;
	width: 20px;
	height: 20px;
	line-height: 20px;
	text-align: center;
	font-size: 10px;
	cursor: pointer;
}

.slidebar li.on {
	background: rgba(255, 255, 255, 0.5);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr= #50FFFFFF,
		endColorstr= #50FFFFFF);
	color: #000;
	font-weight: 700;
}

ul,li {
	list-style: none;
}

a:hover {
	text-decoration: underline;
	color: #a50001;
}

.frame {
	background: none;
	border: 0px solid #fff;
	margin-bottom: 0px;
}

.temp {
	margin: 0;
}

.slidebar {
	position: absolute;
	top: 5px;
	left: 4px;
}

.slideshow span.title,.slidebar li {
	background: rgba(0, 0, 0, 0.3);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr= #90000000,
		endColorstr= #90000000);
	color: #FFF;
	overflow: hidden;
}

.slidebar li.on {
	background: rgba(255, 255, 255, 0.5);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr= #90000000,
		endColorstr= #90000000);
	color: #ff0;
	font-weight: 700;
}

.slideshow SPAN.title {
	text-indent: 0px;
}

.block {
	margin: 0;
	position: relative;
}

#frameHlicAe {
	margin: 0px !important;
	border: 0px !important;
}

.comiis_wrapad {
	margin-top: 10px;
}

.comiis_wrapad img {
	float: left;
	margin-top: 0px;
}

#slidesImgs li {
	width: 500px;
	height: 230px;
	display: none;
}
</style>
<script type="text/javascript">
	$(document).ready(function(e) {
		$("#shouye a:eq(0)").css({
			"color" : "#F63"
		});
		$("#shouye a:eq(1)").css({
			"color" : "#0C6"
		});
	});
	function CrtTitle(o) {
		if (o.crtTitle == undefined) {
			o.crtTitle = 'true';
			o.title = o.scrollWidth > o.clientWidth ? o.innerText : "";
		}
	}
	$(function() {
		$("#floatimg").click(function() {
		});
		$("#content1").css("display", "block");
		$("#content2").css("display", "none");
		$("#content3").css("display", "none");
		$("#p1 a").css("color", "#F36");
		$("#p1").click(function() {
			$("#content1").css("display", "block");
			$("#content2").css("display", "none");
			$("#content3").css("display", "none");
			$("a", this).css("color", "#F36");
			$("#p2 a").css("color", "#000");
			$("#p3 a").css("color", "#000");
		});
		$("#p2").click(function() {
			$("#content1").css("display", "none");
			$("#content2").css("display", "block");
			$("#content3").css("display", "none");
			$("a", this).css("color", "#F36");
			$("#p1 a").css("color", "#000");
			$("#p3 a").css("color", "#000");
		});
		$("#p3").click(function() {
			$("#content1").css("display", "none");
			$("#content2").css("display", "none");
			$("#content3").css("display", "block");
			$("a", this).css("color", "#F36");
			$("#p1 a").css("color", "#000");
			$("#p2 a").css("color", "#000");
		});
	});
	function tiaozhuan(u, id) {
		var url="show_policy";
		if(u<40&&u>30){
			url="show_display";
		}else if(u<30&&u>20){
			url="show_work";
		}
		else if(u<50&&u>40){
			url="show_opinion";
		}else {
			url="show_policy";
		}
		if(u==37){
			url="show_experience";
		}
		var ul='<%=request.getContextPath()%>'+"/page"+"/"+url+"?tid=" + id;
		window.location.href=ul;
	}
	function cloaking() {
		$("#FloatDiv1").css("display", "none");
	}
	var N=141;
	function noneAds() 
	{ 	
	  	N=N-5;
	    if(N<0) 
	    { 
	        document.getElementById("floatimg").style.display = "none";
	        document.getElementById("floatimg2").style.display = ""; 
	        return; 
	    } 
	    document.getElementById("floatimg").style.height = N+"px"; 
	    setTimeout("noneAds()",30); 
	} 
	function noneAds2(){
		N=141;
	        document.getElementById("floatimg2").style.display = "none";
	        document.getElementById("floatimg").style.height = N+"px"; 
	        document.getElementById("floatimg").style.display = "";
	}
</script>
</head>
<body>
	<%-- <script src="http://76953.fy.kf.qycn.com/vclient/state.php?webid=76953"
		language="javascript" type="text/javascript"></script>  --%>
	<div id="FloatDiv1"
		style="position: fixed; width: 179px; height: 141px; visibility: visible; right: 10px; top: 80px; bottom: 10px; border: 2px;">
		<img border="0" onclick="noneAds2()" title="报修电话" style="display: none"
			src="${ctx}/images/guapai.png" id="floatimg2" width="22px"
			height="18px"> <img title="报修电话" onclick="noneAds()" border="0"
			src="${ctx}/images/baoxiu3.png" id="floatimg" width="179px"
			height="141px">
	</div>
	<div id="center">
		<%@include file="../page/header.jsp"%>
		<br>
		<div class="middle1">
			<div
				style="width: 100%; height: 250px; font-family: 宋体; font-size: 12px;">
				<div
					style="border: #C30 solid 0px; width: 51%; height: 250px; float: left;">
					<div class="comiis_wrapad" id="slideContainer">
						<div class="block">
							<ul class="slideshow" id="slidesImgs">
								<s:iterator value="floatws" var="l">
									<li><img class="imags"
										onclick="tiaozhuan(${l.urlss},${l.stutrs})"
										src="../upload/${l.path}" width="358" height="220" alt="" />
										<span class="title">${l.info}</span></li>
								</s:iterator>
							</ul>
							<div class="slidebar" id="slideBar">
								<ul>
									<%
										int count = 0;
									%>
									<s:iterator value="floatws" var="l">
										<%
											count++;
										%>
										<li><%=count%></li>
									</s:iterator>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div
					style="border: #C30 solid 0px; width: 49%; height: 150px; float: right;"
					onclick="qu('repair.html')">
					<div
						style="width: 100%; height: 24px; font-family: 宋体; font-size: 12px;">
						<div style="height: 100%; float: left; width: 80px;">
							<div style="width: 20px; float: left;">
								<img src="${ctx}/images/6.png" height="20px" />
							</div>
							<div
								style="width: 60px; color: #06F; float: right; padding-top: 5px;">
								<a href="show_policy">&nbsp;政策流程</a>
							</div>
						</div>
						<div style="float: right;">
							<div
								style="width: 60px; color: #06F; float: right; padding: 5px 5px 0px 0px;">
								<a href="show_policy">更多>></a>
							</div>
						</div>
					</div>
					<div align="left" style="width: 444px; height: 144px">
						<table>
							<s:iterator value="policies" var="l">
								<tr>
									<s:if test="#l.types==1">
										<td width="320px"><img src="${ctx}/images/li.jpg"
											height="25"> <a href="${ctx}/page/xz?id=${l.id}">${l.title}</a></td>
										<td><s:date name="#l.creatTime" format="MM-dd" /></td>
									</s:if>
									<s:else>
										<td onmousemove="CrtTitle(this)"><img
											src="${ctx}/images/li.jpg" height="25"> <a class="ss"
											href="${ctx}/page/show_policy?tid=${l.id}">${l.title}</a></td>
										<td><s:date name="#l.creatTime" format="MM-dd" /></td>
									</s:else>
								</tr>
							</s:iterator>
						</table>
					</div>
				</div>
			</div>
			<hr style="border: #96BABE dashed 1px" width="100%" />

			<div
				style="width: 100%; height: 250px; font-family: 宋体; font-size: 12px;">
				<div
					style="border: #C30 solid 0px; width: 49%; height: 100%; float: left;"
					onclick="qu('work_advance.jsp')">
					<div
						style="width: 100%; height: 24px; font-family: 宋体; font-size: 12px;">
						<div style="height: 100%; float: left; width: 80px;">
							<div style="width: 20px; float: left;">
								<img src="${ctx}/images/dynamic.png" height="20px" />
							</div>
							<div
								style="width: 60px; color: #06F; float: right; padding-top: 2px;">
								<a href="show_work">&nbsp;工作推进</a>
							</div>
						</div>
						<div style="float: right;">
							<div
								style="width: 60px; color: #06F; float: right; padding: 2px 5px 0px 0px;">
								<a href="show_work">更多>></a>
							</div>
						</div>
					</div>
					<div align="left" style="width: 444px; height: 144px">
						<table>
							<s:iterator value="works" var="l">
								<tr>
									<s:if test="#l.types==1">
										<td width="320px"><img src="${ctx}/images/li.jpg"
											height="25"> <a href="${ctx}/page/xz?id=${l.id}">${l.title}</a></td>
										<td><s:date name="#l.creatTime" format="MM-dd" /></td>
									</s:if>
									<s:else>
										<td width="320px"><img src="${ctx}/images/li.jpg"
											height="25"> <a class="ss"
											href="${ctx}/page/show_work?tid=${l.id}">${l.title}</a></td>
										<td><s:date name="#l.creatTime" format="MM-dd" /></td>
									</s:else>
								</tr>
							</s:iterator>
						</table>
					</div>
				</div>

				<div
					style="border: #C30 solid 0px; width: 49%; height: 150px; float: right;"
					onclick="qu('repair.html')">
					<div
						style="width: 100%; height: 24px; font-family: 宋体; font-size: 12px;">
						<div style="height: 100%; float: left; width: 80px;">
							<div style="width: 20px; float: left;">
								<img src="${ctx}/images/6.png" height="20px" />
							</div>
							<div
								style="width: 60px; color: #06F; float: right; padding-top: 5px;">
								<a href="show_display">&nbsp;宣传展示</a>
							</div>
						</div>
						<div style="float: right;">
							<div
								style="width: 60px; color: #06F; float: right; padding: 5px 5px 0px 0px;">
								<a href="show_display">更多>></a>
							</div>
						</div>
					</div>
					<div align="left" style="width: 444px; height: 144px">
						<table>
							<s:iterator value="displaies" var="l">
								<tr>
									<s:if test="#l.types==1">
										<td width="320px"><img src="${ctx}/images/li.jpg"
											height="25"> <a href="${ctx}/page/xz?id=${l.id}">${l.title}</a></td>
										<td><s:date name="#l.creatTime" format="MM-dd" /></td>
									</s:if>
									<s:else>
										<td width="320px"><img src="${ctx}/images/li.jpg"
											height="25"> <a class="ss"
											href="${ctx}/page/show_display?tid=${l.id}">${l.title}</a></td>
										<td><s:date name="#l.creatTime" format="MM-dd" /></td>
									</s:else>
								</tr>
							</s:iterator>
						</table>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="foot.jsp"></jsp:include>

		<%-- <table>
			<%List<Link> ls=(List)request.getAttribute("links"); 
			int i=0;
				for(Link l:ls){
					if(i==0){
					%>
					<tr>
					<% }
					if(i==5){
						i=0;
						%>
						</tr>
						<%
					}
					%>
				<td><img width="22" height="22" src="${ctx}/upload/<%=l.getPath()%>"></td> <td align="left" height="30" width="130">
				<a href="<%=l.getUrl()%>"><%=l.getName()%></a> </td>
					<%
					i++;
				}
			%>
			</table> --%>
	</div>


	<%-- <script type="text/javascript">
		function qu(u) {
			window.location = u
		}
	</script> --%>
</body>
</html>
<script type="text/javascript">
	SlideShow(3000);
</script>
