<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
	String tid = request.getParameter("tid");
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
</style>
<script>
var id=<%=tid%>;
if(id>0){
	fquery(id);
}else{
	init(21,"阶段性工作情况通报");
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
		    $("#listtitle").html("工作推进&nbsp;&bull;&nbsp;<b style='color: #000;'>"+title+"</b>");
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
		 $("#zhongti").height(hight);
	}
	
	$(document).ready(function(e) {
       $("#WORK a:eq(0)").css({"color": "black"});
	   $("#WORK a:eq(1)").css({"color": "white"});  
    });
	
	$(function(){
		$("#content1").css("display","block");
		$("#content2").css("display","none");
		$("#content3").css("display","none");
		$("#content4").css("display","none");
		$("#entry").css("display", "none");
		$("#p1 a").css("color","#F36");
		$("#p1").click(function(){
			$("#content1").css("display","block");
			$("#entry").css("display", "none");
			$("a",this).css("color","#F36");
			$("#p2 a").css("color","#000");
			$("#p3 a").css("color","#000");
			$("#p4 a").css("color","#000");
			$("#p6 a").css("color","#000");
			$("#p5 a").css("color","#000");
			init(21,"阶段性工作情况通报");
		});	
		$("#p2").click(function(){
			$("#content1").css("display","block");
			$("#entry").css("display", "none");
			$("a",this).css("color","#F36");
			$("#p1 a").css("color","#000");
			$("#p3 a").css("color","#000");
			$("#p4 a").css("color","#000");
			$("#p6 a").css("color","#000");
			$("#p5 a").css("color","#000");
			init(22,"巡检工作计划");
		});	
		$("#p3").click(function(){
			$("#content1").css("display","block");
			$("#entry").css("display", "none");
			$("a",this).css("color","#F36");
			$("#p1 a").css("color","#000");
			$("#p2 a").css("color","#000");
			$("#p4 a").css("color","#000");
			$("#p6 a").css("color","#000");
			$("#p5 a").css("color","#000");
			init(23,"季度工作汇报及相关报表");
		});	
		$("#p4").click(function(){
			$("#content1").css("display","block");
			$("#entry").css("display", "none");
			$("a",this).css("color","#F36");
			$("#p1 a").css("color","#000");
			$("#p2 a").css("color","#000");
			$("#p3 a").css("color","#000");
			$("#p6 a").css("color","#000");
			$("#p5 a").css("color","#000");
			init(24,"活动保障");
		});	
		$("#p5").click(function(){
			$("#content1").css("display","block");
			$("#entry").css("display", "none");
			$("a",this).css("color","#F36");
			$("#p1 a").css("color","#000");
			$("#p2 a").css("color","#000");
			$("#p3 a").css("color","#000");
			$("#p4 a").css("color","#000");
			$("#p6 a").css("color","#000");
			init(25,"运维服务培训");
		});
		$("#p6").click(function(){
			$("#content1").css("display","block");
			$("#entry").css("display", "none");
			$("a",this).css("color","#F36");
			$("#p1 a").css("color","#000");
			$("#p2 a").css("color","#000");
			$("#p3 a").css("color","#000");
			$("#p4 a").css("color","#000");
			$("#p5 a").css("color","#000");
			init(26,"运维设备清洗保养工作");
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
					style="border-bottom: 1px #003399 solid; background-color: #069; padding-left: 10px;; color: white;">工作推进</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p1">
					<a style="text-decoration: none; color: #F36; font-size: 10pt">阶段性工作情况通报</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p2">
					<a style="text-decoration: none; color: #000; font-size: 10pt">巡检工作计划</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p3">
					<a href="javascript:void(0);"
						style="text-decoration: none; color: #000; font-size: 10pt">季度工作汇报及相关报表</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p4">
					<a href="javascript:void(0);"
						style="text-decoration: none; color: #000; font-size: 10pt">活动保障</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p5">
					<a href="javascript:void(0);"
						style="text-decoration: none; color: #000; font-size: 10pt">运维服务培训</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p6">
					<a href="javascript:void(0);"
						style="text-decoration: none; color: #000; font-size: 10pt">运维设备清洗保养工作</a>
				</div>
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
			<div
				style="float: right; width: 600px; height: 600px; background-color: #FFF; cursor: pointer;"
				id="content1">
				<div style="width: 100%; height: 24px;">
					<div style="float: right;">
						<div id="listtitle"
							style="width: auto; color: #06F; float: right; padding-top: 5px;">
							工作推进&nbsp;&bull;&nbsp;<b style="color: #000;">阶段性工作情况通报 </b>
						</div>
					</div>
				</div>
				<div style="height: 10px;"></div>
				<div
					style="width: 100%; height: auto; text-align: center; margin-top: 0px; float: left;">
					<table align="right" id="listcontent" border="0" rules="none">

					</table>
				</div>
				<br>
				<div id="Pagination" class="pagination"></div>

			</div>

		</div>
		<jsp:include page="foot.jsp"></jsp:include>
	</div>
</body>
</html>
