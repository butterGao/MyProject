<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
	String tid = request.getParameter("tid");
%>
<%@include file="../titlevalue.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	init(31,"总包介绍");
}
function query(id){ 
	$.ajax({
		   type: "POST",
		   url: "ss_policy",
		   data: "id="+id,
		   async:false,
		   success: function(msg){
			   var data=eval('('+msg+')');
			   $("#entss").html("<h1>"+data.first.title+"</h1><p>"+data.first.content+"</p>");
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
			   $("#entss").html("<h1>"+data.first.title+"</h1><p>"+data.first.content+"</p>");
			   showEntry();
		   }
		});
}


function querycg(id,cid){ 
	$.ajax({
		   type: "POST",
		   url: "ss_policy",
		   data: "id="+id,
		   success: function(msg){
			   var data=eval('('+msg+')');
			   var fh="<div align='right'><a href=\"javascript:void(0)\" onclick=\"inits("+cid+")\">返回</a></div>";
			   $("#entss").html(fh+"<h1>"+data.first.title+"</h1><p>"+data.first.content+"</p>");
		    showEntry();
		   }
		});
}
function inits(id){
	$("#content1").css("display", "block");
	$("#entry").css("display", "none");
	$("a", this).css("color", "#F36");
	$("#p1 a").css("color", "#000");
	$("#p2 a").css("color", "#000");
	$("#p3 a").css("color", "#000");
	$("#p5 a").css("color", "#000");
	$("#p6 a").css("color", "#000");
	init(id,'100');
}
	function showEntry(){
		$("#entry").css("display", "block");
		$("#content1").css("display", "none");
		var hight=$("#entry").css("height");
		if(hight.substring(0,hight.indexOf("p"))<700){
			hight="700px";
		}
		 $("#zhongti").css("height", hight);
	}
	$(document).ready(function(e) {
		$("#DISPLAY a:eq(0)").css({
			"color" : "black"
		});
		$("#DISPLAY a:eq(1)").css({
			"color" : "white"
		});
	});
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
			if(title==100){
				listcg(id,title,p+1);
				return false;
			}
			showList(id,title,p+1);
			return false;
		}
	}
	function listcg(id,title,p){
		$.ajax({
			   type: "POST",
			   url: "ajax_chenguo",
			   data: "id="+id+"&p="+p,
			   success: function(msg){
				   var data=eval('('+msg+')');
			    var body="";
			    var cc=data.one.list;
			    if(cc[0]==undefined){
			    	alert("该项暂时没有内容");
			    }else{
			    $.each(cc, function(i, c) {
			    body+="<tr><td height=\"32\" width=\"380\" align=\"left\"><img src=\"${ctx}/images/li.jpg\"";
			    	  body+="height=\"13\"><a onclick=\"querycg("+c.id+","+id+")\">"+c.title+"</a> ";
			    	  if(c.creatTime!=null){
			    		  c.creatTime=c.creatTime.substring(0,10);
			    	  }
			    body+= "</td> <td width=\"99\">"+c.creatTime+" </td> </tr>";
			    
			    count=i;
			   });
			    $("#listcontent").html(body);
			    $("#content2").css("display", "block");
			   }}
			});
	}
	
	function init(id,title){
		var url="ajax_showlist";
		if(title==100){
			url="ajax_chenguo";
		}
		$.ajax({
			   type: "POST",
			   url: url,
			   data: "id="+id,
			   success: function(msg){
				   var data=eval('('+msg+')');
				   dd(data.one.totalRecords,title,id);
			   }
			});
	}
	
	
	function showList(id,title,p){
		$.ajax({
			   type: "POST",
			   url: "ajax_showlist",
			   data: "id="+id+"&p="+p,
			   success: function(msg){
				   var data=eval('('+msg+')');
			    $("#listtitle").html("宣传展示&nbsp;&bull;&nbsp;<b style='color: #000;'>"+title+"</b>");
			    var body="";
			    var cc=data.one.list;
			    if(cc[0]==undefined){
			    	alert("该项暂时没有内容");
			    }
			    $.each(cc, function(i, c) {
			    body+="<tr><td height=\"32\" width=\"380\" align=\"left\"><img src=\"${ctx}/images/li.jpg\"";
			    if(id==34||id==31){
			    	  body+="height=\"13\"><a onclick=\"init("+c.id+",'100')\">"+c.title+"</a> ";
			    }else{
			    	if(c.types==1) body+="height=\"13\"><a href=\"/YunWei/page/xz?id="+c.id+"\">"+c.title+"</a> ";
			    	else
			    	  body+="height=\"13\"><a onclick=\"query("+c.id+")\">"+c.title+"</a> ";
			    }
			    if(c.creatTime!=null){
		    		  c.creatTime=c.creatTime.substring(0,10);
		    	  }
		    body+= "</td> <td width=\"99\">"+c.creatTime+" </td> </tr>";
			   });
			    $("#listcontent").html(body);
			    $("#content2").css("display", "block");
			   }
			});
	}
	$(function() {
		$("#content1").css("display", "block");
		$("#content2").css("display", "none");
		$("#content3").css("display", "none");
		$("#content4").css("display", "none");
		$("#content5").css("display", "none");
		$("#content6").css("display", "none");
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
			$("#p6 a").css("color", "#000");
		/* 	showList(31,"总包介绍"); */
			init(31,"总包介绍");
		});
		$("#p2").click(function() {
			$("#content1").css("display", "block");
			$("#entry").css("display", "none");
			$("a", this).css("color", "#F36");
			$("#p1 a").css("color", "#000");
			$("#p3 a").css("color", "#000");
			$("#p4 a").css("color", "#000");
			$("#p5 a").css("color", "#000");
			$("#p6 a").css("color", "#000");
			init(32,"分包介绍");
		});
		$("#p3").click(function() {
			$("#content1").css("display", "block");
			$("#entry").css("display", "none");
			$("a", this).css("color", "#F36");
			$("#p1 a").css("color", "#000");
			$("#p2 a").css("color", "#000");
			$("#p4 a").css("color", "#000");
			$("#p5 a").css("color", "#000");
			$("#p6 a").css("color", "#000");
			init(33,"运维信息");
		});
		$("#p4").click(function() {
			$("#content1").css("display", "block");
			$("#entry").css("display", "none");
			$("a", this).css("color", "#F36");
			$("#p1 a").css("color", "#000");
			$("#p2 a").css("color", "#000");
			$("#p3 a").css("color", "#000");
			$("#p5 a").css("color", "#000");
			$("#p6 a").css("color", "#000");
			init(34,"成果展示");
		});
		$("#p5").click(function() {
			$("#content1").css("display", "block");
			$("#entry").css("display", "none");
			$("a", this).css("color", "#F36");
			$("#p1 a").css("color", "#000");
			$("#p2 a").css("color", "#000");
			$("#p3 a").css("color", "#000");
			$("#p4 a").css("color", "#000");
			$("#p6 a").css("color", "#000");
			init(35,"活动花絮");
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
					style="border-bottom: 1px #003399 solid; background-color: #069; padding-left: 10px;; color: white;">宣传展示</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p1">
					<a style="text-decoration: none; color: #F36; font-size: 10pt">总包介绍</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p2">
					<a style="text-decoration: none; color: #000; font-size: 10pt">分包介绍</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p3">
					<a style="text-decoration: none; color: #000; font-size: 10pt">运维信息</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p4">
					<a style="text-decoration: none; color: #000; font-size: 10pt">成果展示</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p5">
					<a style="text-decoration: none; color: #000; font-size: 10pt">活动花絮</a>
				</div>
			</div>


			<div
				style="float: right; width: 600px; height: 600px; background-color: #FFF; cursor: pointer;"
				id="content1">
				<div style="width: 100%; height: 24px;">
					<div style="float: right;">
						<div id="listtitle"
							style="width: auto; color: #06F; float: right; padding-top: 5px;">
							宣传展示&nbsp;&bull;&nbsp;<b style="color: #000;">总包介绍</b>
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
				</div>
				<br>
				<div id="Pagination" class="pagination"></div>
			</div>
			<div
				style="float: right; width: 600px; height: auto; background-color: #FFF; cursor: pointer;"
				id="entry">
				<div style="width: 100%; height: auto;">
					<div style="height: 10px;"></div>
					<div id="entss" style="width: 100%; height: auto; text-align: center; margin-top: 0px; float: left;">
						<h1 align="center" id="title"></h1>
						<p id="contents" align="left"></p>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="foot.jsp"></jsp:include>
	</div>
</body>
</html>