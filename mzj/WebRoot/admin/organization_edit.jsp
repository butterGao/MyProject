<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../common/public.jsp" %>
<style type="text/css">
.yinc{
}
.yinc:HOVER {
color: red;
}
a{
color: black;
}
</style>
<script type="text/javascript">

</script>
<title>绩效考核系统</title>
</head>
<body>
	<%@include file="../common/head.jsp" %>
		<!-- Main --> 
		<div  style="float: left;height: 75%;width: 100%;position: relative;">
			<h3 style="margin-left: 5%;color: white;">请勾选参与考核的处室和人员</h3>
		<div style="float: left;width: 90%;"> 
			<input type="hidden" id="t_id" value="${t_id}">  
			<div  align="left" height="100%" width="70%" style="margin-left: 10%">
			<!-- 处室 列表--> 
				<c:forEach var="o" items="${orgs}" varStatus="status">  
					<div id="div${o.id}" class="" style="float: left; width: 25%;overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"> 
					<input id="${o.id}" onclick="checkCs(this)" class="check" type="checkbox" <c:if test="${o.on==1}"> checked="checked"</c:if> value="${o.id}">   
						<a id="n${o.id}" <c:if test="${o.lead=='0'}"> style="color: red;"</c:if>  onclick="ckxqWin('${o.id}')" href="javascript:void(0)">${o.short_name}</a>
					</div>
				</c:forEach> 
			</div> 
		</div>   
					<div style="position: fixed;bottom: 1%;left:10% ;color: white;"> 注：红色字体的处室未设置处室负责人。</div>
			<div style="width: 10%;height: 70%;position:fixed;right: 2%;">  
				
				<div onclick="updateDate()" class="button buttonimg3" style="position: absolute;bottom: 15%"> 更新数据</div>
				<div onclick="javascript:history.go(-1)" class="button buttonimg2" style="position: absolute;bottom: 5%"> 返回</div>
			</div>
		</div>
		  
	</div>  
	
</body>  
<!-- 弹窗 -->
<div id="userWin" style="overflow: auto;padding-top: 1%" class="show"> 
         	<div style="height: 90%;width: 100%;overflow: auto;"> 
         		<input type="hidden" id="o_id">
         	   <table class="table" id="userTable" style="margin-left: 8%;width: 90%">  
			   </table>
         	</div>
	        <div style="position:absolute;bottom:3%;width: 98%;left: 2%;">
	         	<div  onclick="closeWin('userWin')" class="button buttonimg2" style="float: right;margin-right:2%;width: 20%;"> 取消 </div> 
	         	<div  onclick="updateUser()" class="button buttonimg3" style="float: right;margin-right:2%;width: 20%;"> 确定 </div> 
         	</div>
</div>
<div id="orgWin" style="overflow: auto;padding-top: 1%;float: right;right: 280px" class="bigshow"> 
         	<div id="orgDiv" style="height: 90%;width: 100%;overflow: auto;"> 
         		
         	   
         	</div>
	        <div style="position:absolute;bottom:3%;width: 98%;left: 2%;">
	         	<div  onclick="showCloseA('orgWin')" class="button buttonimg2" style="float: right;margin-right:2%;width: 20%;"> 取消 </div> 
	         	<div id="selectFxg"  class="button buttonimg3" style="float: right;margin-right:2%;width: 20%;"> 确定 </div> 
         	</div>
</div>


		 
<div id="bg"></div>	
<script type="text/javascript"> 
function checkCs(o){
	var url="saveOrg";
	if(!o.checked){
		url="delOrg";
	}
	$.post(url,{o_id:$(o).val()});
	
	
}

function fxg(id){
	var style='style="float: left; width: 31%;overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"';
	$.ajax({
				type : "POST",
				url : "getOrgs",
				async:false,
				data :{id:id},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					var html="";
					$.each(data,function(i,o) {   
						html+="<div "+style+">";
						if(o.CHECKED==1){
							html+="<input id='chefxg"+o.ID+"' checked='checked' type='checkbox' value='"+o.ID+"'>";
						}else{
							html+="<input id='chefxg"+o.ID+"' type='checkbox' value='"+o.ID+"'>";
						}
						html+=o.SHORT_NAME;
						html+="</div>";
					});
					$("#orgDiv").html(html);
				}
			});
	$("#selectFxg").attr("onclick","selectFxg('"+id+"')");
	showWinA('orgWin');
}

function selectFxg(id){
	$("#selectFxg").find("input[type=checkbox]:checked");
	var orgs="";
	$.each($("input[id^='chefxg']:checked"),function(i,o) {  
		orgs+=$(o).val()+",";
	});
	$.ajax({
				type : "POST",
				url : "selectFxg",
				async:false,
				data :{id:id,orgs:orgs},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					alertWin("设置成功");
				}
			});
}

function ckxqWin(id){
	 $.ajax({
				type : "POST",
				url : "users",
				async:false,
				data :{o_id:id},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					var html='<tr><td>选择参与人员 </td>  <td align="center">处室负责人<span  title="有权限进行处室互评，填写工作目标和工作总结。" class="glyphicon glyphicon-question-sign"></span></td></tr>';
					$.each(data,function(i,o) {
						html+="<tr>"+"<td>";
						if(o.ON==1){
							if(id=="c504c59b8a9fd8c1129dc62cdb51ef41"){
								var help='<span style="cursor:pointer;" title="点击设置管辖处室" class="glyphicon glyphicon glyphicon-cog"></span>';
								html+='<input name="userChe"  type="checkbox" checked="checked" value="'+o.ID+'"><span onclick="fxg(\''+o.ID+'\')">'+o.USER_NAME+help+'</span></td>';
							}else{
								html+='<input name="userChe"  type="checkbox" checked="checked" value="'+o.ID+'"><span>'+o.USER_NAME+'</span></td>';
							}
						}else{
							if(id=="c504c59b8a9fd8c1129dc62cdb51ef41"){
								html+='<input name="userChe" type="checkbox" value="'+o.ID+'"><span onclick="fxg(\''+o.ID+'\')">'+o.USER_NAME+'</span></td>';
							}else{
								html+='<input name="userChe" type="checkbox" value="'+o.ID+'">'+o.USER_NAME+'</td>';
							}
							
						}
						if(o.LEAD==1){
							html+='<td align="center"><input type="radio" checked="checked" name="userRadio" value="'+o.ID+'">';
						}else{
							html+='<td align="center"><input type="radio" name="userRadio" value="'+o.ID+'">';
						}
						html+="</td></tr>";
					});
					$("#o_id").val(id);
					$("#userTable").html(html);
				}
			});
	showWin("userWin");
}
function updateUser(){
	var u_id="";
	$("input[name=userChe]").each(function(){
		if(this.checked){
			u_id+=$(this).val()+";";
		}
	});
		$.ajax({
					type : "POST",
					url : "sxUser",
					async:false,
					data :{o_id:$("#o_id").val(),u_id:u_id,lead:$('input:radio:checked').val()},
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) {
						closeWin();
						alertWins("goUrl('index')","设置成功");
					}
				});
	
	
}

function updateDate(){
	alertWins("upda()","你确定进行更新吗?<br>请在所有任务都结束时更新。")
}
function upda(){
	$.ajax({
		type : "POST",
		url : "updateDate",
		async:false,
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			if(data){
				alertWins("goUrl('index')","更新成功");
			}else{
				alertWins("alertClose","更新出现异常!");
			}
		}
	});
}
function addTd(str){
	return "<td>"+str+"</td>";
}
</script>
</html>
