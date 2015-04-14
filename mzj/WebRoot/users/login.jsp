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
function login(){
	$("#lg_name").html("");
	$("#lg_word").html("");
	var name=$("#login_name").val();
	var word=$("#password").val();
	$("label[name='infos']").remove();
	$("#divLoginName").removeClass("has-error");
	$("#divLoginPas").removeClass("has-error");
	if(name==""){ 
		$("#divLoginName").addClass("has-error");
		$("#divLoginName").append('<label name="infos" class="control-label" >用户名不能为空</label>');
		
	}
	else if(word==""){
		$("#divLoginPas").addClass("has-error");
		$("#divLoginPas").append('<label name="infos" class="control-label" >密码不能为空</label>');
	}else{
		$.ajax({
					type : "POST",
					url : "login?"+$("#loginForm").serialize(),
					async:false,
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) {
						if(data.judge){
							 location.href="index";
						}else{
							if(data.type=="1"){
							$("#divLoginName").addClass("has-error");
							$("#divLoginName").append('<label name="infos" class="control-label" >用户名不存在</label>');
							}else if(data.type=="2"){
								$("#divLoginPas").addClass("has-error");
								$("#divLoginPas").append('<label name="infos" class="control-label" >密码不正确</label>');
							}
							else{
								$("#lg_word").html("登陆异常");
							}
							}
					}
				});
	}
}
$(function (){
	$("#fanhuidiv").attr("display","none");
});
$(document).keyup(function(event) {
	if (event.keyCode == 13) {
		login();
	}
});
</script>
<title>绩效考核系统</title>
</head>
<body style="height: 100%">
		<div id="backgroud"  style="background-image:url('${cp}/images/bg.png');background-size: 100% 100%;width:100%;min-width:1000px;
		filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/bg.png', sizingMethod='scale');">
		<!-- 头部分 -->
			<div style="height: 4%;"></div>
			<div style="height: 10%;"> 
				<div id="hand" style="padding-right: 2%;" align="right" >
					<div class="lianjie">
						<c:if test="${users == null}"><a href="javascript:void(0)" onclick="showdiv('login')" style="color: white;">  未登录 </a> </c:if>
					</div>
				</div>
			</div>
			<div style="background-image:url('${cp}/images/bg2.png');background-size: 100% 100%;height:86%;
			filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/bg2.png', sizingMethod='scale');">
		<!-- Main --> 
 	<div style="width: 880px; height: 460px; margin: auto;padding-top: 5%" >
		<!-- <iframe src="../ff.jsp" width="100%" height="100%" frameborder="0">
		</iframe> --> 
			 <div style="width: 42%;height:100%;float: left;">
				<div id="" onclick="goUrl('${cp}/task/index?type=mubiao')" class="lump" style="width:100% ;height:38%;margin-bottom: 2%;background-image:url('${cp}/images/gzmb_.png');
					filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/gzmb_.png', sizingMethod='scale');">
					<c:if test="${MBsize>0}"><div class="tubiao yuan" style="background-color: red;" >${MBsize}</div></c:if>
				</div>
				<div id="" onclick="goUrl('${cp}/task/index?type=zongjie')" class="lump" style="width:49% ;height:60%;background-image:url('${cp}/images/gzzj_.png');
filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/gzzj_.png', sizingMethod='scale');"> 
				<c:if test="${ZJsize>0}"><div class="tubiao yuan" style="background-color: red;" >${ZJsize}</div></c:if>
				</div>
				<div id="" onclick="goUrl('${cp}/task/index?type=pingfen')" class="lump" style="width:49% ;height:60%;float: right;background-image:url('${cp}/images/jxkh_.png');
filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/jxkh_.png', sizingMethod='scale');">
					<c:if test="${Khsize>0}"><div class="tubiao yuan" style="background-color: red;" >${Khsize}</div></c:if>
				</div>
			</div>
			<div  style="width: 24%;height:100%;float: left;margin-left: 2%">
					<div id="" class="lump" style="cursor:default;width:100% ;height:60%;margin-bottom: 2%;background-image:url('${cp}/images/ywgl_.png');filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../images/ywgl_.png', sizingMethod='scale');">  
							<div style="height: 60%"></div> 
							<div onclick="goUrl('${cp}/task/index?type=null')"  style="width: 48%;height: 10%;cursor: pointer;margin-bottom: 2%"></div>
							<div onclick="goUrl('${cp}/target/index')" style="width: 48%;height: 10%;cursor: pointer;"></div>
					</div>
					<div id="" onclick="goUrl('${cp}/count/index')" class="lump" style="width:100% ;height:38%;background-image:url('${cp}/images/kpjg.png');filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../images/kpjg.png', sizingMethod='scale');"> 
					</div>
			</div>
			<div  style="width:30%;height:100%;float: right;margin-left: 2%">
					<div id="" class="lump" style="width:100% ;height:38%;margin-bottom: 2%;background-image:url('${cp}/images/dkf1.png');"> 
					
					</div>
					<div id="" class="lump" style="width:100% ;height:60%;background-image:url('${cp}/images/dkf2.png');"> 
					
					</div>
			</div> 
		</div> 
		<div style="width: 30%;  margin: auto;" >
	   	 <marquee  direction="left" scrollamount="3" onmouseover="this.stop()" onmouseout="this.start()">
	       	<a onclick="goUrl('${cp}/task/show?id=${newTask[0].id}')" href="javascript:void(0)" >${newTask[0].title}</a>
	        <a onclick="goUrl('${cp}/task/show?id=${newTask[1].id}')" href="javascript:void(0)" >${newTask[1].title}</a>
	        <a onclick="goUrl('${cp}/task/show?id=${newTask[2].id}')" href="javascript:void(0)" >${newTask[2].title}</a>
	    </marquee>
 	</div>
		
		<!--  -->
	</div>
	</div>
	
</body>
<!-- 弹窗 -->
<div id="login" style="" class="show"> 
<div style="height: 31%;">   
</div>    
	<form id="loginForm"  style="width: 85%;margin-left: 10%" action="login">
		<div id="divLoginName" style="padding-left: 3%;" class="form-group has-feedback">   
		  <input type="text" class="form-control"  id="login_name" name="login_name" placeholder="用户名"> 
		  <span class="glyphicon glyphicon-user form-control-feedback"></span>  
		 
		</div>  
		<br>
		<div id="divLoginPas" style="padding-left: 3%;" class="form-group has-feedback">
		  <input type="password" class="form-control"  id="password" name="password"  placeholder="密码"> 
		  <span class="glyphicon glyphicon-lock form-control-feedback"></span> 
		</div> 
		<div id="lg_word" class="error">${word}</div>
		<div style="margin-left: 70%"><img alt="" src="${cp}/images/submit.png" style="opacity: 0.8;cursor:pointer;" onclick="login()"></div>
	</form>
</div>
	<div onclick="goUrl('../index')" id="bg"></div>
		<c:if test="true">
			<script type="text/javascript">
			showdiv("login");
			</script>
		</c:if>
</html>

		