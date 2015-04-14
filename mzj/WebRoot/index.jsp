<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="common/public.jsp" %>
<style type="text/css">

</style>
<script type="text/javascript">
function login(){
	$("#lg_name").html("");
	$("#lg_word").html("");
	var name=$("#login_name").val();
	var word=$("#password").val();
	removeInfos();
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
							 location.href="";
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
$(document).keyup(function(event) {
	if (event.keyCode == 13) {
		login();
	}
});
function quanxian(user){
/* 	if(user){
		alertWin("没有此操作权限");
		setTimeout("alertClose()", 1000);
	}else{ */
		showdiv('login');
	//}
}
	
	
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
					<div class="lianjie"><c:if test="${users != null}"><a style="color: white;"> ${org.short_name} | ${users.user_name} | </a><a style="color: white;position:relative;" href="${cp}/users/logout"> 退出 </a> </c:if>
						<c:if test="${users == null}"><a href="javascript:void(0)" onclick="showdiv('login')" style="color: white;position:relative;">  未登录 </a> </c:if>
					</div> 
				</div>
			</div>
			<div style="background-image:url('${cp}/images/bg2.png');background-size: 100% 100%;height:86%;
			">
		<!-- Main -->         
 		<div style="width: 880px; height: 440px; margin: auto;padding-top: 5%;position:relative;" >
		<!-- <iframe src="../ff.jsp" width="100%" height="100%" frameborder="0">
		</iframe> --> 
			 <div style="width: 380px;height:440px;float: left;">				
				<c:if test="${power.mubiao}">
					<div id="" onclick="goUrl('${cp}/mubiao/index')" class="lump"  style="width:100% ;height:38%;margin-bottom: 2%;background-image:url('${cp}/images/gzmb.png');
						filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/gzmb.png', sizingMethod='scale');">
						<c:if test="${mbSize>0}"><div class="tubiao yuan" style="background-color: red;" >${mbSize}</div></c:if>
					</div> 
				</c:if>
				<c:if test="${power==null or !power.mubiao}">
					<div id="" onclick="quanxian('${users.ID}')" class="lump"  style="width:100% ;height:38%;margin-bottom: 2%;background-image:url('${cp}/images/gzmb_.png');
						filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/gzmb_.png', sizingMethod='scale');">
					</div>
				</c:if>
				<c:if test="${power.zongjie}">
					<div id="" onclick="goUrl('${cp}/zongjie/index')" class="lump" style="width:49% ;height:60%;background-image:url('${cp}/images/gzzj.png');
								filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/gzzj.png', sizingMethod='scale');"> 
						<c:if test="${zjSize>0}"><div class="tubiao yuan" style="background-color: red;" >${zjSize}</div></c:if>
					</div>
				</c:if>
				<c:if test="${power==null or !power.zongjie}">
					<div id="" onclick="quanxian('${users.ID}')" class="lump" style="width:49% ;height:60%;background-image:url('${cp}/images/gzzj_.png');
								filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/gzzj_.png', sizingMethod='scale');"> 
					</div>
				</c:if>
				
				
				<c:if test="${power.kaohe}">
				<div id="" onclick="goUrl('${cp}/pingfen/index')" class="lump" style="width:49% ;height:60%;float: right;background-image:url('${cp}/images/jxkh.png');
							filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/jxkh.png', sizingMethod='scale');">
					<c:if test="${khSize>0}"><div class="tubiao yuan" style="background-color: red;" >${khSize}</div></c:if>
				</div>
				</c:if>
				<c:if test="${power==null or !power.kaohe}">
					<div id="" onclick="quanxian('${users.ID}')" class="lump" style="width:49% ;height:60%;float: right;background-image:url('${cp}/images/jxkh_.png');
							filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/jxkh_.png', sizingMethod='scale');">
				</div>
				</c:if>
				
				
			</div>
			<div  style="width: 210px;height:440px;float: left;margin-left: 2%;position: relative;">
				<c:if test="${power.task}">
					<div id="" class="lump" style="cursor:default;width:100% ;height:60%;margin-bottom: 2%;background-image:url('${cp}/images/ywgl.png');filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../images/ywgl.png', sizingMethod='scale');position: relative;">  
								<div style="height: 50%"></div> 
								<div onclick="goUrl('${cp}/organization/index')"  style="width: 48%;height: 10%;cursor: pointer;margin-bottom: 2%;position: relative;z"></div>
								<div onclick="goUrl('${cp}/target/index')" style="width: 48%;height: 10%;cursor: pointer;position: relative;"></div>
								<div onclick="goUrl('${cp}/task/index?type=null')"  style="width: 48%;height: 10%;cursor: pointer;margin-bottom: 2%;position: relative;"></div>
					</div>
				</c:if>
				<c:if test="${power==null or !power.task}">
					<div id="" onclick="quanxian('${users.ID}')"  class="lump" style="cursor:pointer;width:100% ;height:60%;margin-bottom: 2%;background-image:url('${cp}/images/ywgl_.png');filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../images/ywgl_.png', sizingMethod='scale');position: relative;">  
					 
					</div>
				</c:if>
				<c:if test="${power.task}">
				<div id="" onclick="goUrl('${cp}/count/tasks')" class="lump" style="width:100% ;height:38%;background-image:url('${cp}/images/kpjg.png');filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../images/kpjg.png', sizingMethod='scale');position: relative;"> 
				</div>
				</c:if>
				 
				<c:if test="${power==null or !power.task}">
					<div id="" onclick="quanxian('${users.ID}')" class="lump" style="width:100% ;height:38%;background-image:url('${cp}/images/kpjg_.png');filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='../images/kpjg_.png', sizingMethod='scale');position: relative;"> 
				</div>
				</c:if> 
			</div>  
			<div  style="width:240px;height:440px;float: right;margin-left: 2%">  
					<div id="" class="lump" style="width:100% ;height:38%;cursor: default;margin-bottom: 2%;background-image:url('${cp}/images/dkf1.png');filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/dkf1.png', sizingMethod='scale');">
					
					</div> 
					<div id="" class="lump"  style="width:100% ;height:60%;cursor: default;background-image:url('${cp}/images/dkf2.png');filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/dkf2.png', sizingMethod='scale');">
					</div>
			</div> 
		</div>  
		<div style="width: 60%;  margin: auto;z-index: 2;" >
	   		 <marquee  direction="left" scrollamount="3" onmouseover="this.stop" onmouseout="this.start" style="position:relative;">
		   	 	<c:forEach items="${newTask}" var="t">
		   	 		<span  style="color: blue;margin-left: 120px;font-size: 18px;position:relative;cursor: pointer;" onclick="goUrl('${cp}/task/show?id=${t.id}')"  > &bull;&nbsp;  ${t.title} </span>
		   	 	</c:forEach> 
	    	</marquee> 
 		</div>  
		
		<!--  -->
	</div>
	</div>
	
	
</body>
<!-- 弹窗 -->
<div id="login" style="" class="show">  
<div style="height: 31%;padding-left: 100px;padding-top: 50px;">     
<img alt="" src="${cp}/images/loginimg.png">
 </div>   
	<form id="loginForm"  style="width: 85%;margin-left: 10%;" action="login">
		<div id="divLoginName" style="padding-left: 3%;" class="form-group has-feedback">   
		  <input type="text" class="form-control" id="login_name" name="login_name" placeholder="用户名"> 
		  <span class="glyphicon glyphicon-user form-control-feedback"></span>  
		</div>    
		<br>
		<div id="divLoginPas" style="padding-left: 3%;" class="form-group has-feedback">
		  <input type="password" class="form-control" style="" id="password" name="password"  placeholder="密码"> 
		  <span class="glyphicon glyphicon-lock form-control-feedback"></span> 
		</div>  
		<div id="lg_word" class="error">${word}</div>
		<div  style="margin-left: 60%;"><img title="登录" alt="登录" src="${cp}/images/submit.png" style="opacity: 0.8;cursor:pointer;" onclick="login()"></div>
	</form>  
	
	<div style="padding-left: 20px;">注：跟OA系统用户密码相同。</div>    
</div>
		<!-- <input id="btnshow" type="button" value="Show" onclick="showdiv();" /> -->
	<div onclick="showClose('login')" id="bg"></div>
</html>
