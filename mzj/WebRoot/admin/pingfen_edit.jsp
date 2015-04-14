<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../common/public.jsp" %>
<style type="text/css">
.check{
}
</style>
<script type="text/javascript">
var aid;
function pingfen(){//评分列表
	var html="";
	$.each($("input:checked"),function(i,o) { 
		var id=$(o).attr("id");   
		html+="<tr><td>"; 
		html+=$("#n"+id).html()+"<td  width='70px;'>";
		html+='<input id="pf'+id+'"  class="form-control" maxlength="3" value="100"  type="text">';
		html+="</td></tr>";
		$("#ptable").html(html);
	});     
	$("input[id^=pf]").keyup(function () {
	    //如果输入非数字，则替换为''，如果输入数字，则在每4位之后添加一个空格分隔
	    this.value = this.value.replace(/[^\d]/g, '').replace(/(\d{4})(?=\d)/g, "$1 ");
	    $.each($("input[id^=pf]"),function(i,o) {   
	     if( $(o).val()>100)$(o).val(100);
		}); 
	});
	showdiv('pfWin');
}
function weiping(){//全部未打分评分列表
	$("input[type=checkbox]").each(function (){
		if($(this).val()==""){
			this.checked=true;
		}
	});     
}

function pingfenb(){
	$.each($("input:checked"),function(i,o) { 
		var id=$(o).attr("id");   
		var code=$("#pf"+id).val();
		$("#"+id).val(code); 
		code==""?"未评":code;
		$("#a"+id).html("("+code+")");      
		$(o).attr("checked",false);
	});
	showClose('pfWin');
}

function pingfena(){
	$("#a"+aid).html("("+$("#pfinput").val()+")");
	$("#"+aid).val($("#pfinput").val());
	showClose('ckxqWin');
}


</script>
<title>绩效考核系统</title>
</head>
<body>
	<%@include file="../common/head.jsp" %>
		<!-- Main --> 
		<div  style="float: left;height: 75%;width: 100%;position: relative;">
			<h3 style="margin-left: 5%;color: white;">请为下列处室评分</h3>
		<div style="float: left;width: 90%;font-size: 18px;font-weight: bold;"> 
			<input type="hidden" id="t_id" value="${t_id}"> 
			<div  align="left" height="100%" width="70%" style="margin-left: 10%">
			<!-- 处室 列表-->
				<c:forEach var="o" items="${lists}" varStatus="status"> 
					<div id="div${o.id}" class="new" style="float: left; width: 30%;overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"> 
					<input id="${o.id}" class="check" type="checkbox" value="${o.score}" name="${o.id}" ><a id="a${o.id}" style="color: red;width: 20px"><c:if test="${o.score>0}">(${o.score})</c:if></a> 
					<a id="n${o.id}" style="color: black;" onclick="ckxqWin('${o.short_name}','${o.id}')" href="javascript:void(0)">${o.short_name}</a>
					</div>
				</c:forEach> 
			</div> 
		</div>  
			<div style="position: fixed;bottom: 1%;left:10% ;font-size: 18px;font-weight: bold;"> 
			小贴士：<br> 
			1.点击处室名称可查看处室总结并打分。<br> 
				   2.可点击‘全选’按钮进行快速打分。<br>
		       	   3.在考核任务截止时间前可保存评分,在考核任务结束前可修改。<br>
                   4.提交后将不能修改。<br>
		      	   5.如未在截止日期前提交评分,则系统按本次考核规定默认计算分数。<br>
			
			</div>
			<div style="width: 10%;height: 70%;position:fixed;right: 2%;"> 
				<div onclick="quanxuan()" id="quanxuan" class="button buttonimg2" style="">全选</div>			 	
				<div onclick="weiping()" class="button buttonimg2" style=""> 勾选未评分</div>			 	
				<div onclick="pingfen()" class="button buttonimg2 marginTop" > 评分</div>				
				<div onclick="tijiao(0)" class="button buttonimg2 marginTop" > 保存</div>				
				<div onclick="tijiao(1)" class="button buttonimg3" style="position: absolute;bottom: 15%"> 提交</div>
				<div onclick="javascript:history.go(-1)" class="button buttonimg2" style="position: absolute;bottom: 5%"> 返回</div>
			</div>
		</div>
	</div>  
	
</body>  
<!-- 弹窗 -->
<div id="pfWin" style="padding-top: 2%; padding-left: 2%" class="show">  
		<div style="height: 90%;width: 100%;overflow: auto;">
       	    <table id="ptable" class="table" width="100%">
				
			</table>  
         </div> 
		 <div style="position:absolute;bottom:3%;width: 98%;left: 2%;">
	         	<div onclick="showClose('pfWin')" class="button buttonimg2" style="float: right;margin-right:8%;width: 40%;"> 取消 </div> 
	         	<div  onclick="pingfenb()" class="button buttonimg3" style="float: right;margin-right:6%;width: 40%;"> 确定 </div> 
         </div>
		  
</div>


	<div id="tjWin" class="show"> 
		<div id="msgTj" style="margin-top: 65%;text-align: center;"> 提交后将不能修改</div>
		<div style="margin-top: 25%">
			 <div onclick="save(1)" class="button" style="float: left;width: 30%;margin-left: 15%;background-image:url('${cp}/images/button1.png')"> 确 定 </div> 
		 	 <div onclick="showClose('tjWin')" class="button" style="float: right;width: 30%;background-image:url('${cp}/images/button1.png');margin-right: 15%;"> 取 消 </div>  
		</div>
	</div> 
	<div id="ckxqWin" style="padding-left: 2%;height: 98%;width: 95%" class="bigshows">      
		<div style="width: 100%;height: 90%;overflow:auto;">  
			<h4 style="font-size: 20px;" id="mbTitle" align="center"></h4> 	
			<div id="mbContent" style="word-break:break-all;width: 98%">  
		    </div>   
		    <hr> 
		    <h4 style="font-size: 20px;" id="zjTitle" align="center">${task.file_title}</h4> 	 
			<div id="zjContent" style="word-break:break-all;"> 
			</div>  
		</div> 
	<div style="width: 100%;margin-top: 1%">    
		 <div style="float: left;width: 25%;margin-left: 15%;">   
		 	<div style="float: left;"> 
		  	<label  class="form-control">请评分:</label>
		  	</div>    
		 	<div style="width: 50%;float: right;"> 
		   	 <input id="pfinput"  class="form-control" maxlength="3" value="100"  type="text">
		  	</div> 
		 </div>  
	  <div onclick="closeWin()" class="button buttonimg2" style="float: right;width: 15%;margin-right: 5%;"> 取 消 </div>  
	  <div onclick="pingfena()" class="button buttonimg2" style="float: right;width: 15%;margin-right: 5%;"> 确定 </div>  
	</div>	
		 
	</div>
	<div id="bg"></div>
<script type="text/javascript" src="${cp}/js/json2.js"></script>
<script type="text/javascript">
//提交按钮 
function tijiao(type){
	if(type==0){
		$.ajax({
			type : "POST",
			url : "../taskid",
			async:false,
			data :{id:$("#t_id").val()},
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			success : function(data) {
				var time=data.KHEND.replace("-", "年").replace("-", "月").replace(" ", "日").substring(0,11); 
				alertWins("save(0)","将临时保存为草稿，<br>请在"+time+"前提交。"); 
			}
		});
		
		
	}else{
		var bool=true; 
		$(".check").each(function(){
			if($(this).val()=='on' || $(this).val()==""){
				bool=false;
			}
		});
		if(bool){
			alertWins("save(1)","提交后将不能修改");
		}else{
			alertWin("请给全部处室评分"); 
		}
	}
}

function save(type){
	function param(id,code){
		this.id=id;
		this.code=code;
	}
	var list=new Array();
	$(".check").each(function(){
		if($(this).val()=='on' || $(this).val()==""){
			
		}else{
			list.push(new param($(this).attr("id"),$(this).val()));
		}
	});
	$.ajax({
				type : "POST",
				url : "pingfen",
				async:false,
				data :{t_id:$("#t_id").val(),json:JSON.stringify(list),commit:type},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					if(data){
						alertWins("goUrl('index')","评分成功");
					}
					else{
						alertWin("出现异常");
					}
				}
			});
}

function ckxqWin(name,id) {
	this.aid=id;
	$.ajax({
				type : "POST",
				url : "showContent",
				async:false,
				data :{id:id,t_id:$("#t_id").val()},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					if(data.mubiao ==null){
						$("#mbTitle").html("未填工作目标");
						$("#mbContent").html("");
					}else{
						$("#mbTitle").html(data.mubiao.TITLE);
						$("#mbContent").html(data.mubiao.CONTENT); 
					}
					if(data.zongjie ==null){
						$("#zjTitle").html("未填写工作总结");
						$("#zjContent").html("");
					}else{
						$("#zjTitle").html(data.zongjie.TITLE);
						$("#zjContent").html(data.zongjie.CONTENT);
					}
				}
			});
	$("#titlexq").html(name);	
	showdiv('ckxqWin');
}

function quanxuan(){	 
	if($("#quanxuan").html()=="全选"){
		$("input[type=checkbox]").each(function (){
			this.checked=true;
		});
		$("#quanxuan").html("全不选");
	}else{
		$("input[type=checkbox]").each(function (){
			this.checked=false;
		});
		$("#quanxuan").html("全选"); 
	}
}


$("input[id^=pf]").keyup(function () {
    //如果输入非数字，则替换为''，如果输入数字，则在每4位之后添加一个空格分隔
    this.value = this.value.replace(/[^\d]/g, '').replace(/(\d{4})(?=\d)/g, "$1 ");
    $.each($("input[id^=pf]"),function(i,o) {   
     if( $(o).val()>100)$(o).val(100);
	}); 
});
</script>
</html>
