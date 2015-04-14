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
<script type="text/javascript" src="${ctx}/js/jquery-1.7.1.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/common.css" />
<style>
tr {
	font-size: 16px;
}


</style>
<script type="text/javascript">
	$(document).ready(function(e) {
		$("#shouye a:eq(0)").css({
			"color" : "black"
		});
		$("#shouye a:eq(1)").css({
			"color" : "white"
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
	<div style="width: 900px;height:450px;background-image:url('../images/juanzou.png');background-size:100% 100%;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../images/juanzou.png', sizingMethod='scale');"">
	<div style="height: 28px;"></div>        
	<div style="width:820px;height:395px;margin:auto;">        
		<div id="carousel-example-generic" class="carousel slide"  
			data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">  
							<s:iterator value="floatws" var="l" status="i">
									<li onmousemove="active('${i.index}')" onclick="active('${i.index}')" id="li${i.index}">   </li>
								</s:iterator>
			</ol>
 
			<!-- Wrapper for slides -->  
			<div class="carousel-inner" style="width: 100%;height: 100%" role="listbox">
								 <s:iterator value="floatws" var="l"  status="i">  
									<div onclick="tiaozhuan(${l.urlss},${l.stutrs})" id="imgd${i.index}" class="item " style="">
									<img  height="395px" style="max-width: 820px" alt="" src="../upload/${l.path}">    
									<div class="carousel-caption">${l.info}</div>
	 							</div> 
								</s:iterator>
			</div>
		</div> 
	</div>  
	</div>
	<div align="right" style="margin-right: 80px;"> 今日访问：<a style="color: red">${count2}</a>历史访问：<a style="color: red">${count1}</a>    </div>
	<br><br>
		<div style="width: 900px;height: 350px;">     
		   <div style="float: left;margin-left: 1%;width: 32%;height:100%; background-image:url('../images/hkbg1.png');background-size:100% 100%;
								filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../images/hkbg1.png', sizingMethod='scale');">
		  	  <div align="right" style="margin-right: 20px;margin-top: 20px"> <a href="show_policy">更多>></a></div>
		    	<table  style="text-align: left;table-layout: fixed;width: 280px;">    
							<s:iterator value="policies" var="l" status="i"> 
								<tr>
									<s:if test="#l.types==1">
										<td><img src="${ctx}/images/li.jpg" 
											height="25"> <a href="${ctx}/page/xz?id=${l.id}">${l.title}</a></td>
										<td><s:date name="#l.creatTime" format="MM-dd" /></td>
									</s:if>
									<s:else>   
										<td style="table-layout: fixed;overflow: hidden;text-overflow:ellipsis;white-space:nowrap;width: 260px;"> <img src="${ctx}/images/li.jpg"
											height="25">
											<s:if test="#l.cid>10||#l.cid<20"><a title="${l.title}" <s:if  test="#i.index==0">style="color: blue;font-weight:bold"</s:if>class="ss" href="${ctx}/page/show_policy?tid=${l.id}">${l.title}</a><</s:if>
											<s:elseif test="#l.cid>20||#l.cid<30"><a title="${l.title}" <s:if  test="#i.index==0">style="color: blue;font-weight:bold"</s:if> class="ss" href="${ctx}/page/show_display?tid=${l.id}">${l.title}</a></s:elseif>
											<s:elseif test="#l.cid>30||#l.cid<37"><a title="${l.title}"<s:if  test="#i.index==0">style="color: blue;font-weight:bold"</s:if> class="ss" href="${ctx}/page/show_work?tid=${l.id}">${l.title}</a></s:elseif>
											<s:else ><a title="${l.title}" <s:if  test="#i.index==0">style="color: blue;font-weight:bold"</s:if> class="ss" href="${ctx}/page/show_work?tid=${l.id}">${l.title}</a></s:else>
										</td>
										<td></td>
									</s:else>
								</tr> 
							</s:iterator>
						</table>
		    	
		  </div>
		   <div style="float: left;margin-left: 1%;width: 32%;height:100%; background-image:url('../images/hkbg2.png');background-size:100% 100%;
								filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../images/hkbg2.png', sizingMethod='scale');">
		   <div align="right" style="margin-right: 20px;margin-top: 20px"> <a href="show_work">更多>></a></div>
		    <table  style="text-align: left;table-layout: fixed;width: 280px;">   
							<s:iterator value="displaies" var="l" status="i">
								<tr>
									<s:if test="#l.types==1">
										<td <s:if  test="#i.index==0">style="color: blue;font-weight:bold"</s:if>><img src="${ctx}/images/li.jpg"
											height="25"> <a href="${ctx}/page/xz?id=${l.id}">${l.title}</a></td>
										<td><s:date name="#l.creatTime" format="MM-dd" /></td>
									</s:if> 
									<s:else>  
										<td style="table-layout: fixed;overflow: hidden;text-overflow:ellipsis;white-space:nowrap;width: 226px; "> <img src="${ctx}/images/li.jpg"
											height="25"><s:if test="#l.cid>10||#l.cid<20"><a title="${l.title}" <s:if  test="#i.index==0">style="color: blue;font-weight:bold"</s:if> class="ss" href="${ctx}/page/show_policy?tid=${l.id}">${l.title}</a><</s:if>
											<s:elseif test="#l.cid>20||#l.cid<30"><a title="${l.title}" <s:if  test="#i.index==0">style="color: blue;font-weight:bold"</s:if> class="ss" href="${ctx}/page/show_display?tid=${l.id}">${l.title}</a></s:elseif>
											<s:elseif test="#l.cid>30||#l.cid<37"><a title="${l.title}" class="ss" href="${ctx}/page/show_work?tid=${l.id}">${l.title}</a></s:elseif>
											<s:else ><a title="${l.title}" <s:if  test="#i.index==0">style="color: blue;font-weight:bold"</s:if> class="ss" href="${ctx}/page/show_work?tid=${l.id}">${l.title}</a></s:else>
										</td>
										<td style="font-size: 13px;"><s:date name="#l.creatTime" format="MM-dd" /></td>
									</s:else>
								</tr>
							</s:iterator>
						</table>
		   </div>
		   <div style="float: left;margin-left: 1%;width: 32%;height:100%; background-image:url('../images/hkbg3.png');background-size:100% 100%;
								filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../images/hkbg3.png', sizingMethod='scale');">
		     <div align="right" style="margin-right: 20px;margin-top: 20px"> <a href="show_work">更多>></a></div>
		     <table  style="text-align: left;table-layout: fixed;width: 280px;">   
							<s:iterator value="works" var="l" status="i">
								<tr>
									<s:if test="#l.types==1">
										<td ><img src="${ctx}/images/li.jpg"
											height="25"> <a href="${ctx}/page/xz?id=${l.id}">${l.title}</a></td>
										<td><s:date name="#l.creatTime" format="MM-dd" /></td>
									</s:if> 
									<s:else>
										<td style="table-layout: fixed;overflow: hidden;text-overflow:ellipsis;white-space:nowrap;width: 226px; "> <img src="${ctx}/images/li.jpg"
											height="25"><s:if test="#l.cid>10||#l.cid<20"><a title="${l.title}" <s:if  test="#i.index==0">style="color: blue;font-weight:bold"</s:if> class="ss" href="${ctx}/page/show_policy?tid=${l.id}">${l.title}</a><</s:if>
											<s:elseif test="#l.cid>20||#l.cid<30"><a title="${l.title}" <s:if  test="#i.index==0">style="color: blue;font-weight:bold"</s:if> class="ss" href="${ctx}/page/show_display?tid=${l.id}">${l.title}</a></s:elseif>
											<s:elseif test="#l.cid>30||#l.cid<37"><a title="${l.title}" <s:if  test="#i.index==0">style="color: blue;font-weight:bold"</s:if> class="ss" href="${ctx}/page/show_work?tid=${l.id}">${l.title}</a></s:elseif>
											<s:else ><a title="${l.title}" <s:if  test="#i.index==0">style="color: blue;font-weight:bold"</s:if> class="ss" href="${ctx}/page/show_work?tid=${l.id}">${l.title}</a></s:else>
										</td>
									</s:else>  
									<td style="font-size: 13px;"><s:date name="#l.creatTime" format="MM-dd" /></td>
								</tr>
							</s:iterator>  
			</table>
		   </div>
		</div>
		
		
		
		
		
		
	<br>
		
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
	
	
	<!--  -->
		<DIV id="flow" onMouseOver="javascript:moveflow=0;"
		onMouseOut="javascript:moveflow=1;"
		style="LEFT: 350px; WIDTH: 400px; POSITION: absolute; TOP: 147px; HEIGHT: 163px; <!--background-color: #EFEFEF; layer-background-color: #EFEFEF; background-color:#7EF030; layer-background-color: #7EF030;  border: 1px none #000000; --> border:none; background-color:transparent; z-index:999; visibility:visible">
	
							<img style="cursor: hand;" border="0" src="../images/flowimg.png"
								width="220" height="110" usemap="#FPMap1" /> 
	</DIV>

	
</body>
<script type="text/javascript">

var index=0;
function active(id){
	index=id;
	$("li[id^=li]").removeClass("active");
	$("div[id^=img]").removeClass("active");
	$("#li"+id).addClass("active");
	$("#imgd"+id).addClass("active");
}
function lubbo(){

	$("li[id^=li]").removeClass("active");
	$("div[id^=img]").removeClass("active");
	$("#li"+index).addClass("active");
	$("#imgd"+index).addClass("active");
	index++;
	if(index>5)index=0; 
	setTimeout(lubbo, 4000);
}
setTimeout(lubbo, 0);


var xPos = 350; 
var yPos = 200; 
var step = 1; 
var delay = 30; 
var height = 0; 
var Hoffset = 0; 
var Woffset = 0; 
var yon = 0; 
var xon = 0; 
var pause = true; 
var interval;
var moveflow=1; 
flowE=document.getElementById("flow");
flowE.style.top = yPos+"px";

function changePos() { 
width = document.body.clientWidth; 
height = document.body.clientHeight; 
 
Hoffset = flowE.offsetHeight; 
Woffset = flowE.offsetWidth; 
flowE.style.left = (xPos + document.body.scrollLeft)+"px"; 
flowE.style.top = (yPos + document.body.scrollTop)+"px"; 
if (moveflow==1){
	if (yon) {
		yPos = yPos + step;
		} 
	else {
		yPos = yPos - step;
		} 
	if (yPos < 0) { 
		yon = 1; 
		yPos = 0; 
		} 
	if (yPos >= (height - Hoffset)) { 
		yon = 0; 
		yPos = (height - Hoffset); 
		} 
	if (xon) { 
		xPos = xPos + step; 
		} 
	else { 
		xPos = xPos - step; 
		} 
	if (xPos < 0) { 
		xon = 1; 
		xPos = 0; 
		} 
	if (xPos >= (width - Woffset)) { 
		xon = 0; 
		xPos = (width - Woffset); 
		}
	} 
} 

function start() {
flowE.style.visibility = "visible";
//flowE.style.visibility = "hidden";
interval = setInterval('changePos()', delay); 
} 
start();
</script>
</html>
