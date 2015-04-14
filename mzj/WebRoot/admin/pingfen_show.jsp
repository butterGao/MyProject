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
function pingfen(){
	$.each($("input:checked"),function(i,o) { 
		$("#a"+$(o).val()).html($("#fenshu").val());
		$(o).attr("checked",false);
	});
	showClose('pfWin');
}
function tijiao(){
	history.go(-1);
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
</script>
<title>绩效考核系统</title>
</head>
<body>
	<%@include file="../common/head.jsp" %>
		<!-- Main --> 
		<c:if test="${q==1}">
		<div  style="float: left;height: 75%;width: 100%;position: relative;">
			<h3 style="margin-left: 5%;color: white;">点击处室名称查看总结</h3>
				<div style="float: left;width: 90%;"> 
				<input type="hidden" id="t_id" value="${t_id}"> 
				<div  align="left" height="100%" width="70%" style="margin-left: 10%">
				<!-- 处室 列表-->
					<c:forEach var="o" items="${lists}" varStatus="status"> 
						<div onclick="ckxqWin('${o.short_name}','${o.id}')" class="new" style="float: left; width: 21%;overflow: hidden; text-overflow: ellipsis; white-space: nowrap;cursor: pointer;">
							<div style="color:black;" >${o.short_name}</div> 
						</div> 
					</c:forEach> 
				</div> 
			</div>  
			<div style="width: 10%;height: 70%;position:fixed;right: 2%;"> 
				<div onclick="javascript:history.go(-1)" class="button buttonimg2" style="position: absolute;bottom: 5%"> 返回</div>
			</div>
		</div>
		</c:if>
		<c:if test="${q!=1}">
			<div  style="float: left;height: 75%;width: 100%;position: relative;">
				<h3 style="margin-left: 5%;color: white;">您的打分结果</h3>
			<div style="float: left;width: 90%;"> 
				<input type="hidden" id="t_id" value="${t_id}"> 
				<div  align="left" height="100%" width="70%" style="margin-left: 10%">
				<!-- 处室 列表-->
					<c:forEach var="o" items="${lists}" varStatus="status"> 
						<div id="div${o.id}" class="new" style="float: left; width: 4%;overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
							<div style="color: red;width: 22px">(${o.score})</div>    
						</div> 
						<div id="div${o.id}"  onclick="ckxqWin('${o.short_name}','${o.id}')" class="new" style="float: left; width: 21%;overflow: hidden; text-overflow: ellipsis; white-space: nowrap;cursor: pointer;">
							<div style="color:black;" >${o.short_name}</div>  
						</div> 
					</c:forEach> 
				</div> 
			</div>  
				<div style="width: 10%;height: 70%;position:fixed;right: 2%;"> 
					<div onclick="javascript:history.go(-1)" class="button buttonimg2" style="position: absolute;bottom: 5%"> 返回</div>
				</div>
			</div>
		
		</c:if>
	</div>  
	
</body>
<!-- 弹窗 -->
<div id="tjWin" style="background-image:url('${cp}/images/pfwin.png');background-size:100% 100%;" class="show"> 
		<div style="margin-left: 3%;margin-top: 3%;height: 70%;background-image:url('${cp}/images/tjpf.png');background-size:100% 100%;"></div>
		<div style="margin-top: 25%">
		 	 <div onclick="showClose('tjWin')" class="button buttonimg1" style="float: right;width: 30%;margin-right: 15%;"> 取 消 </div>  
		</div>
	</div>
	<%-- <div id="tjWin" style="background-image:url('${cp}/images/window.png');background-size:100% 100%;" class="show"> 
		<div style="margin-top: 65%;text-align: center;"> 提交后将不能修改</div>
		<div style="margin-top: 25%">
			 <div onclick="tijiao()" class="button" style="float: left;width: 30%;margin-left: 15%;background-image:url('${cp}/images/button1.png')"> 确 定 </div> 
		 	 <div onclick="showClose('tjWin')" class="button" style="float: right;width: 30%;background-image:url('${cp}/images/button1.png');margin-right: 15%;"> 取 消 </div>  
		</div>
	</div> --%>
	<div id="bg"></div>

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
	  <div onclick="closeWin()" class="button buttonimg2" style="float: right;width: 15%;margin-right: 5%;"> 取 消 </div>  
	</div>	
</div>		
</html>
