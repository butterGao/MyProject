<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
	<%@page import="java.net.InetAddress"%>
<!DOCTYPE html>
<html >
<head>
<meta charset="utf-8" />
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<%@include file="../common/public.jsp"%>
<style type="text/css">
.group{
width: 200px;
height: 175px;
float: left;
margin: 10px; 
border:1px solid #c4e3f4; 
}
.groupImg{
margin:auto;
margin-left:16px;
margin-top:13px;    
cursor: pointer; 
}
.tubiao{
height:100%;
width: 28%;
float: right;
background-color: #c4e3f4;
}
.qunliao{
	display: none;
	position: absolute;
	top: 10%;
	float:right;
	right: 0;
	width: 280px;
	border: 0;
	padding-left: 0px;
	height: 526px;
	z-index: 1002;
	border: 1px solid #E5E5E5;
}

</style>
</head>
<body style="background-color: white;">
<div class="modal fade" id="myModal" tabindex="-1"  style="z-index: 99999;" role="dialog" aria-labelledby="myModalLabel" aria-hidden="">
   <div class="modal-dialog modal-lg">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close"  data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 id="div_win_title" class="modal-title" id="myModalLabel">
               		聊天
            </h4>
         </div>
         <div class="modal-body">
        	 <div class="embed-responsive embed-responsive-16by9">
  				<iframe  name="winIframe" id="winIframe" class="embed-responsive-item" src=""></iframe>
			</div>
         
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
</div>


							<input type="hidden" id="username" value="${user.columns['UNAME']}">
							<input type="hidden" id="userid" value="${user.columns['ID']}">
							<input type="hidden" id="gid" value="${gid}">
							<button id="btn_qunliao" onclick="qunliao_toggel()" class="btn" style="position: absolute;float: right;right: 10px;top: 5%"><span class="glyphicon glyphicon-earphone"></span>群聊</button>
							<div id="div_qunliao" class="qunliao panel panel-default">
								<div class="panel-heading">
											<span class="glyphicon glyphicon-user"></span> &nbsp;勾选人员
								</div>
								<div class="panel-body chat-body" style="overflow: auto;height: 429px;">
									<ul id="treeDemo" class="ztree"></ul>
								</div>
								<div class="panel-footer">
									 <button type="button" class="btn btn-default" onclick="qunliao_toggel()" >关闭  </button>
						           	 <button type="button" onclick="qunliao()" class="btn btn-primary">
						            		聊天
						            </button>
								</div>
							</div>
							
							<%-- <div style="width: 100%;height: 30px;background-color: #00CCCC ">
									<span  style="float: left;height: 100%;font-size: 20px;margin-left: 10px;">项目:</span>	 
								  	<div style="float: left;">  
								  		<select id="pid" onchange="change(this)" class="">
										 	<c:forEach var="t" items="${project}">
								   					 <option  value="${t.id}"> ${t.name}</option> 
								  			 </c:forEach>
										</select>	
								  	</div>	  
								  	<span  style="float: left;height: 100%;font-size: 20px;margin-left: 2px;">==>>小组:</span>	 
								  	<div style="float: left;">
										<select onchange="queryUserForGroup(this)" id="gid"  class="">
										 
										</select>	
									</div>	 
							</div> --%>
					<div id="groupDiv" style="width: 100%;overflow: auto;">
					<div style="margin-top: 200px;font-size: 20px;color: red;margin-left: 45%">当前分组没有数据</div>
							<!-- <div class="group">   
									<div style="height:100%;width: 70%;float: left; ">
										<div style="float: left;width: 100%;height: 40%;"> 
											<table style="width: 100%;height: 100%">
												<tr>
													<td><img style="width: 40%;height: 100%;margin-left: 30px" alt="" src="image/74.png"></td>
													<td style="color: red;font-size: 20px">ss</td>
												</tr>
											</table>
										</div>
										<div style="height: 49%;float: left;font-size: 20px;margin-left: 15px">
										<br>
											姓名:<span>ss</span>
											<br>
											电话:<span>ss</span>
										</div>
									</div>
									<div style="height:100%;width: 28%;float: right;">
										<img class="groupImg"  alt="" src="image/1.png">
										<img class="groupImg"  alt="" src="image/2.png">
										<img class="groupImg"  alt="" src="image/3.png">
										<img class="groupImg"  alt="" src="image/4.png">
									</div>
							</div> -->
					</div>		 
<form id="call_form" action="call/call" method="post" target="winIframe" style="display: none;">
	<input type="text" id="f_userid" name="userid">
	<input type="text" id="f_sendid" name="sendid">
	<input type="text" id="f_callname" name="callname">
	<input type="text" id="f_callType" name="callType">
	<input type="text" id="f_username" name="username">
</form>
								
</body>
<script src="page/queryUserForTree.js"></script>
<script type="text/javascript">
function queryUserForGroup(id){
	$.ajax({
				type : "POST",
				url :getval("root")+"/outuser/queryUserForGroup",
				async:false,
				data :{gid:id},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					html="";
					$.each(data,function(i,o) {   
						html+=groupDiv(o.ID,o.UNAME,o.PHONE,'00'+i);
					});
					if(html!=""){
						$("#groupDiv").html(html);
					}
				}
			});
} 

/* function change(o){
	$.ajax({
				type : "POST",
				url :getval("root")+"/au/zhu",
				async:false,
				data :{pid:$(o).val()},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					var html="";
					$.each(data,function(i,o) {   
						html+=' <option  value="'+o.ID+'">'+o.NAME+'</option> ';
					});
					$("#gid").html(html);
				}
			});
	
} */
//得到组div
function groupDiv(id,name,phone,index){
	return '<div class="group">'+
	'			<div style="height:100%;width: 70%;float: left; ">'+
	'			<div style="float: left;width: 100%;height: 40%;"> '+
	'				<table style="width: 100%;height: 100%">'+
	'					<tr>'+
	'						<td><img style="width: 40%;height: 100%;margin-left: 30px" alt="" src="image/74.png"></td>'+
	'						<td style="color: #438eb8;font-size: 20px">'+index+'</td>'+
	'					</tr>'+
	'				</table>'+
	'			</div>'+
	'			<div style="height: 49%;float: left;font-size: 20px;margin-left: 15px">'+
	'			<br>'+
	'				姓名:<span style="font-size: 12px;">'+name+'</span>'+
	'				<br>'+
	'				电话:<span style="font-size: 12px;">'+phone+'</span>'+
	'			</div>'+
	'		</div>'+
	'		<div class="tubiao" style="">'+
	'			<img  onclick="goUrl(\'colshow.jsp?id='+id+'\')" class="groupImg"  alt="定位" src="image/3.png">'+
	'			<img  onclick="openCall(\''+getval("username")+'\',\''+getval("userid")+'\',\''+id+'\',\''+name+'\')"  class="groupImg"  alt="聊天" src="image/1.png">'+
	'			<img  onclick="openWin(\''+getval("username")+'\',\''+getval("userid")+'\',\''+id+'\',\'<%=InetAddress.getLocalHost().getHostAddress()%>\',\''+name+'\')"  class="groupImg"  alt="视频" src="image/2.png">'+
	'			<img  onclick="_openTalkWin(\''+getval("username")+'\',\''+getval("userid")+'\',\''+id+'\',\'<%=InetAddress.getLocalHost().getHostAddress()%>\',\''+name+'\')"  class="groupImg"  alt="语音" src="image/4.png">'+
	'		</div>'+
	'		</div>';
			}
function openCall(name,uid,sid,sname){
	var n=encodeURI(encodeURI(name));
	$("#div_win_title").html("聊天:"+sname);
	//showModalDialog('/SanTuo/call/call?uname='+n+'&userid='+uid+'&sendid='+sid,'','dialogWidth:1000px;dialogHeight:550px;dialogLeft:200px;dialogTop:150px;center:yes;help:yes;resizable:yes;status:yes');
	showWin('/SanTuo/call/call?uname='+n+'&userid='+uid+'&sendid='+sid+'&callType='+1);
}

function qunliao_toggel(){
	$("#btn_qunliao").toggle();
	$("#div_qunliao").toggle();
}
//群聊
function qunliao(){
	$("#f_userid").val(getval("userid"));
	$("#f_sendid").val(getOtherid());
	$("#f_callname").val(getNameAndId());
	$("#f_callType").val(2);
	$("#f_username").val(getval("username"));
	qunliao_toggel();
	var sid=getOtherid();
	//var callname=encodeURI(encodeURI(getNameAndId()));
	 if(sid.length<2){
		alert("请选择聊天人员");
	}else{
		$("#div_win_title").html("聊天:群聊");
		$("#myModal").modal("show");
		$("#call_form").submit();
		
		//showWin('/SanTuo/call/call?uname='+encodeURI(encodeURI(getval("username")))+'&userid='+getval("userid")+'&sendid='+sid+'&callType=2&callname='+callname);
	} 
}
//打开视频窗口
function openWin(name,uid,sid,serverhost,sname){
	//openMonWin("From:"+name,500,500,serverhost,9005,sid,uid);
	var src="/SanTuo/monitor.jsp?title=" + encodeURI(encodeURI(sname)) + "&width=" + 800 + "px&height=" + 400 + "px&uid=" + uid + "&sid=" + sid + "&host=" + serverhost + "&port=" + 9005;
	//$("#div_win_title").html("视频:"+sname);
	//showWin(src,name);
	window.open (src, 'newwindow', 'height=400, width=800, top=150, left=150, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no'); 
}
//打开语音窗口
function _openTalkWin(name,uid,sid,serverhost,sname){
//	openTalkWin("From:"+name,500,500,serverhost,9005,sid,uid);
	//showModalDialog("/App/talking.jsp?title=" + encodeURI(encodeURI(title)) + "&width=" + width + "&height=" + height + "&uid=" + uid + "&sid=" + sid + "&host=" + serverhost + "&port=" + serverport,title,'dialogWidth:' + width + 'px;dialogHeight:' + height + 'px;dialogLeft:200px;dialogTop:150px;center:yes;help:no;resizable:no;status:yes;scroll:no');
	var src="/SanTuo/talking.jsp?title=" + encodeURI(encodeURI(sname)) + "&width=" + 800 + "px&height=" + 400 + "px&uid=" + uid + "&sid=" + sid + "&host=" + serverhost + "&port=" + 9005;
	//$("#div_win_title").html("语音:"+sname);
	//window.open(src);
//	$("#widiframe").attr("src",src);
//	showWin(src,name); 
	window.open (src, 'newwindow', 'height=400, width=800, top=150, left=150, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no'); 
}

function showWin(src,name){
	$("#winIframe").attr("src",src);
	$("#myModal").modal("show");
}
			
$(function(){
	//初始化组内所有人
	 queryUserForGroup(getUrlParam("gid"));
});
</script>
</html>
