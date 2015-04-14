<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	pageContext.setAttribute("ctx", request.getContextPath());
	String tid=request.getParameter("tid");
%>
	<%@include file="../titlevalue.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titlename%></title>
<link rel="stylesheet" type="text/css" href="../css/common.css" />
<script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../js/jquery.pagination.js"></script>
<link rel="stylesheet" href="../js/pagination.css" />
<style type="text/css">
table {
	width: 100%;
}
td {
	border-bottom: #96BABE dashed 1px
}
</style>
<script>
var id=<%=tid%>;
if(id>0){
	fquery(id);
}else{
	init(11,"国家部门政策");
}
function dd(index,title,id){
	$("#Pagination").pagination(index, {
		num_edge_entries: 1, //边缘页数
		num_display_entries: 10, //主体页数
		callback: pageselectCallback,
		items_per_page:10, //每页显示1项
		prev_text: "前一页",
		next_text: "后一页"
	});
	function pageselectCallback(p, jq){
		showList(id,title,p+1);
		return false;
	}
}
function init(id,title){
	var url="ajax_showlist";
	$.ajax({
		   type: "POST",
		   url: url,
		   data: "id="+id,
		   success: function(msg){
			   var data=eval('('+msg+')');
			   if(data.p==9999999){
				   window.location="../loginuser.jsp";
			   }else{
				   dd(data.one.totalRecords,title,id);
			   }
			   
		   }
		});
}

function query(id){ 
	$.ajax({
		   type: "POST",
		   url: "ss_policy",
		   data: "id="+id,
		   async:false,
		   success: function(msg){
			   var data=eval('('+msg+')');
		    $("#title").html(data.first.title);
		    $("#contents").html(data.first.content);
		   }
		});
	   showEntry();
}
function fquery(id){ 
	$.ajax({
		   type: "POST",
		   url: "ss_policy",
		   data: "id="+id,
		   success: function(msg){
			   var data=eval('('+msg+')');
		    $("#title").html(data.first.title);
		    $("#contents").html(data.first.content);
		    showEntry();
		   }
		});
}



	function showEntry(){
		$("#entry").css("display", "block");
		$("#content1").css("display", "none");
		$("#content2").css("display", "none");
		$("#content3").css("display", "none");
		$("#content4").css("display", "none");
		$("#content5").css("display", "none"); 
		var hight=$("#entry").css("height");
		if(hight.substring(0,hight.indexOf("p"))<700){
			hight="700px";
		}
		 $("#zhongti").css("height", hight);
	}
	$(document).ready(function(e) {
		$("#POLICY a:eq(0)").css({
			"color" : "black"
		});
		$("#POLICY a:eq(1)").css({
			"color" : "white"
		});
	});
	function showList(id,title,p){
		$.ajax({
			   type: "POST",
			   url: "ajax_showlist",
			   data: "id="+id+"&p="+p,
			   success: function(msg){
				   var data=eval('('+msg+')');
			    $("#listtitle").html("政策流程&nbsp;&bull;&nbsp;<b style='color: #000;'>"+title+"</b>");
			    var body="";
			    var cc=data.one.list;
			    if(cc[0]==undefined){
			    	alert("该项暂时没有内容");
			    }else{
			    $.each(cc, function(i, c) {
			    body+="<tr><td height=\"32\" width=\"380\" align=\"left\"><img src=\"${ctx}/images/li.jpg\"";
			    if(c.types==1) body+="height=\"13\"><a href=\"/YunWei/page/xz?id="+c.id+"\">"+c.title+"</a> ";
		    	else
		    	  body+="height=\"13\"><a onclick=\"query("+c.id+")\">"+c.title+"</a> ";
			    body+= "</td> <td width=\"99\">"+c.creatTime.substring(0,10)+" </td> </tr>";
			   });
			    $("#listcontent").html(body);
			    $("#content2").css("display", "block");
			   }}
			});
	}
	$(function() {
		$("#content1").css("display", "block");
		$("#content2").css("display", "none");
		$("#content3").css("display", "none");
		$("#content4").css("display", "none");
		$("#content5").css("display", "none");
		$("#entry").css("display", "none");
		$("#p1 a").css("color", "#F36");
		$("#p1").click(function() {
			$("#content1").css("display", "block");
			$("#entry").css("display", "none");
			$("a", this).css("color", "#F36");
			$("#p2 a").css("color", "#000");
			$("#p3 a").css("color", "#000");
			$("#p4 a").css("color", "#000");
			$("#p5 a").css("color", "#000");
			init(11,"国家部门政策");
		});
	/* 	$("#p2").click(function() {
			$("#content1").css("display", "block");
			$("#entry").css("display", "none");
			$("a", this).css("color", "#F36");
			$("#p1 a").css("color", "#000");
			$("#p3 a").css("color", "#000");
			$("#p4 a").css("color", "#000");
			$("#p5 a").css("color", "#000");
			showList(12,"运维政策");
		}); */
		$("#p3").click(function() {
			$("#content1").css("display", "block");
			$("#entry").css("display", "none");
			$("a", this).css("color", "#F36");
			$("#p1 a").css("color", "#000");
			$("#p2 a").css("color", "#000");
			$("#p4 a").css("color", "#000");
			$("#p5 a").css("color", "#000");
			init(13,"职责方针");
		});
		$("#p4").click(function() {
			$("#content1").css("display", "block");
			$("#entry").css("display", "none");
			$("a", this).css("color", "#F36");
			$("#p1 a").css("color", "#000");
			$("#p2 a").css("color", "#000");
			$("#p3 a").css("color", "#000");
			$("#p5 a").css("color", "#000");
			init(14,"制度");
		});
		$("#p5").click(function() {
			$("#content1").css("display", "block");
			$("#entry").css("display", "none");
			$("a", this).css("color", "#F36");
			$("#p1 a").css("color", "#000");
			$("#p2 a").css("color", "#000");
			$("#p3 a").css("color", "#000");
			$("#p4 a").css("color", "#000");
			init(15,"工作流程");
		});
	});
</script>
</head>
<body>
	<div id="center">
				<%@include file="../page/header.jsp"%>
		<div id="zhongti"
			style="width: 780px; height: 700px; background-color: #FFF; font-family: 宋体; font-size: 12px; margin: 0px 0px 0px 20px;">
			<div
				style="float: left; width: 120px; height: auto; background-color: #FFF; font-size: 14px; line-height: 150%; cursor: pointer; text-align: left;">
				<div
					style="border-bottom: 1px #003399 solid; background-color: #069; padding-left: 10px;; color: white;">政策流程</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p1">
					<a style="text-decoration: none; color: #F36; font-size: 10pt">国家部门政策</a>
				</div>
				<!-- <div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p2">
					<a style="text-decoration: none; color: #000; font-size: 10pt">运维政策</a>
				</div> -->
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p3">
					<a style="text-decoration: none; color: #000; font-size: 10pt">职责方针</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p4">
					<a style="text-decoration: none; color: #000; font-size: 10pt">制度</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p5">
					<a style="text-decoration: none; color: #000; font-size: 10pt">工作流程</a>
				</div>
			</div>
			<div
				style="float: right; width: 600px; height: 600px; background-color: #FFF; cursor: pointer;"
				id="content1">
				<div style="width: 100%; height: 24px;">
					<div style="float: right;">
						<div id="listtitle"
							style="width: 200px; color: #06F; float: right; padding-top: 5px;">
							政策流程&nbsp;&bull;&nbsp;<b style="color: #000;">国家部门政策</b>
						</div>
					</div>
				</div>
				<div style="height: 10px;"></div>
				<div
					style="width: 100%; height: auto; text-align: center; margin-top: 0px; float: left;">
					<table align="right" id="listcontent" border="0" rules="none">
						<s:iterator value="one.list" var="l">
							<tr>
													<s:if test="#l.types==1">
									<td height="32" width="380" align="left"><img
										src="${ctx}/images/li.jpg" height="13"><a
									href="${ctx}/page/xz?id=${l.id}">${l.title}</a></td>
								</s:if>
								<s:else >
									<td height="32" width="380" align="left"><img
										src="${ctx}/images/li.jpg" height="13"><a
										onclick="query(${l.id})">${l.title}</a></td>
								</s:else>

								<td width="99"><s:date name="#l.creatTime"
										format="yyyy-MM-dd" /></td>
							</tr> 
						</s:iterator>
					</table>

				</div>
<br>
		<div id="Pagination" class="pagination"></div>
			</div>

			
			<div
				style="float: right; width: 600px; height: auto; background-color: #FFF; cursor: pointer;"
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
			</div>
			<jsp:include page="foot.jsp"></jsp:include>
	
</body>
</html>
