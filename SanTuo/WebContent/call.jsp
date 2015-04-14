<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@include file="../common/public2.jsp"%>
<style type="text/css">
 .chat-body{  
    height:350px;
    padding:0px;
}


.msg-list-body{
    margin:8px;
    height:340px;
    overflow: auto;
}

.msg-wrap{
    margin-top: 0px;
    margin-bottom: 8px;
    padding: 0px;
}

.msg-content{
    margin-top: 14px;
    padding: 8px;
    padding-bottom: 4px;
    background-color:#f5f5f5;
    border:1px solid #ccc;
    border-radius: 4px;
    word-break:break-all;
}

.img-icon{
    width: 64px;
    height: 64px;
    border:2px solid #ccc;
    border-radius: 4px;
}

.msg-head{
    z-index:100;
}

.msg-name{
    margin-left: 8px;
}

.msg-time{
    margin-left: 8px;
}

.list-table{
    margin-top: -1px;
    margin-bottom: 0px;
}

.emotion-panel{
    position:fixed;
    display:none;
    z-index:200;
}
</style>

</head>
<body style="">
	<!-- 聊天内容 -->
	<div class="panel panel-default">
		<div class="panel-heading">
			<span class="glyphicon glyphicon-earphone"></span> &nbsp;聊天内容
		</div>
		<div class="panel-body chat-body">
			<div id="msgContent" class="msg-list-body" style="float: left;">

				<!-- 聊天内容 -->	
			</div> 
			<div id="userTree" class="panel panel-default" style="float: right;width: 20%;height:350px;overflow: auto;display: none;">
				<div class="panel-heading">
					<span class="glyphicon glyphicon-user" style="margin-left: 32%;"></span>人员 
				</div>
				<div id="qunliao_div" class="panel-body" >
				 		
				</div>
			</div> 
		</div>
	</div>

	<!-- 输入框 -->  
	<div class="input-group input-group-lg" style="width: 90%;margin: auto;">
	<input type="hidden" id="uname" value="${pram.uname}">
		<input type="hidden" id="callType" value="${pram.callType}">
		<input type="hidden" value="${pram.callname}" id="callname" >
		<form id="msgForm" action="" onsubmit="return false;">
			<input type="hidden" value="${pram.userid}" id="userid" name="mid">
			<input type="hidden" value="${pram.sendid}" id="sendid" name="otherid">
			<div class="form-group">
				<div class="col-sm-10"> 
					<input class="form-control"  id="msgText" placeholder="请输入聊天内容" type="text" name="content">
				</div>
				<div class="col-sm-2">
					 <span class="input-group-btn">
							<button class="btn btn-default " type="button"  onclick="addMsg()">
							发送<span class="glyphicon glyphicon-send"></span>
							</button>
					</span>
				</div>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript"> 
var myname;
var uname;
$(function(){
	queryData();
	if($("#callType").val()==1){//单聊
		
	}else{//群聊
		$("#userTree").show();	
		$("#msgContent").width('75%');
		console.log($("#callname").val());
		$.each($("#callname").val().split(";"),function(i,o) {   
			if(o){
				$("#qunliao_div").append('<div id="'+o.split(",")[0]+'">'+o.split(",")[1]+'</div>');
			}
		});
		
	}
	setInterval(queryData, 5000); 
});

$(document).keyup(function(event) {
	if (event.keyCode == 13) {
		addMsg();
	}
});

	function addMsg(){
		//showModalDialog('http://127.0.0.1:8888/Tuoke/index2.jsp','','dialogWidth:1000px;dialogHeight:700px;dialogLeft:200px;dialogTop:150px;center:yes;help:yes;resizable:yes;status:yes');
		$.ajax({
					type : "POST",
					url :getval("root")+"/call/insert",
					async:true,
					data :$("#msgForm").serializeArray(),
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) {
						var uname=decodeURI($("#uname").val());
						$("#msgContent").append(getRedcontent(uname,newTime(),$("#msgText").val()));
						$("#msgText").val("");
					}
				});
	}
	function queryData(){
		var userid="";
		if(getval("sendid").split(";")>0){
			$.each(getval("sendid").split(";"),function(i,o) {   
				userid+=o.split(",")[0];
			});
		}else{
			userid=getval("sendid");
		}
		 $.ajax({
					type : "POST",
					url : getval("root")+"/call/queryInfo",
					async:true,
					data :{uid:getval("sendid"),sid:getval("userid")},
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) {
						//取数据
						$.each(data,function(i,o) { 
							$("#msgContent").append(getInfocontent(o.MNAME,o.CREATETIME,o.CONTENT));
							lookInfo(o.ID);
						});
					}
				}); 
	
	}

	function lookInfo(id){
		$.ajax({
					type : "POST",
					url :getval("root")+"/call/lookInfo",
					data :{id:id},
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) {
					}
				});
	}

	function getRedcontent(name,time,msg){
		window.scrollTo(0,document.body.scrollHeight);
		return '<div class="clearfix msg-wrap">	<div class="msg-head">'
		+'<span class="msg-name label label-danger pull-left"><span '
		+' class="glyphicon glyphicon-user">'+name+'</span>&nbsp;&nbsp;</span><span' 
		+' class="msg-time label label-default pull-left"><span'
		+' class="glyphicon glyphicon-time"></span>&nbsp;&nbsp;'+time+'</span>'
		+'</div><div class="msg-content">'+msg+'</div>'
		+'</div>';
	}	
	
	function getInfocontent(name,time,msg){
		return '<div class="clearfix msg-wrap">	<div class="msg-head">'
		+'<span class="msg-name label label-primary pull-left"><span'
		+' class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;'+name+'</span><span'
		+' class="msg-time label label-default pull-left"><span'
		+' class="glyphicon glyphicon-time"></span>&nbsp;&nbsp;'+time+'</span>'
		+'</div><div class="msg-content">'+msg+'</div>'
		+'</div>';
	}	
	
	function newTime(){
		var date=new Date();
		return date.getHours() + ":" + date.getMinutes() + ":"+ date.getSeconds();
	}
</script>
</html>