<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../common/public.jsp" %>
<style type="text/css">

</style>
<title>绩效考核系统</title>
</head>
<body>
	<%@include file="../common/head.jsp" %>
		<!-- Main --> 
		<div  style="float: left;height: 75%;width: 100%;position: absolute;" >
			<h3 style="margin-left: 5%;color: white;">任务详情</h3>
			<div style="float: left;width: 75%;padding-left: 5%;word-break:break-all"> 
				<input type="hidden" id="taskId" name="id" value="${task.id}">
				<h4 align="center">${task.title}</h4>     
				<span > ${task.content}</span>  
			</div>  
			<!-- 右边功能键 -->  
			<c:if test="${yulan==null}">
				<div style="width: 15%;height: 80%;position:fixed;right: 5%;">   
					<div onclick="goUrl('${cp}/target/show?id=${task.target_id}')" class="button buttonimg2"> 查看指标 </div>    
					<div onclick="showdiv('sxWin')" class="button buttonimg2 marginTop" > 查看参与处室 </div>    
					<div onclick="showdiv('tzWin')" class="button buttonimg2 marginTop" > 查看通知文件</div>    
					<div onclick="showdiv('timeWin')" class="button buttonimg2 marginTop" > 查看任务周期</div>    
					 
					 
					<c:if test="${power.task}">
					<c:if test="${task.count==0}">
					<div onclick="countScore()" class="button buttonimg3" style="bottom: 25%;position:absolute;"> 统计 </div>
					</c:if>
					<c:if test="${task.count==1}">
						<div  class="button buttonimg2" style="bottom: 25%;position:absolute;"> 已统计 </div>
					</c:if>
					</c:if>
					<div onclick="javascript:history.go(-1)" class="button buttonimg2" style="bottom: 15%;position:absolute;"> 返回 </div>
				</div> 
			</c:if>
			<c:if test="${yulan==1}">
				<div style="width: 15%;height: 80%;position:fixed;right: 5%;">   
					<div onclick="showdiv('tzWin')" class="button buttonimg2 marginTop" > 查看通知文件</div>    
					<div onclick="showdiv('timeWin')" class="button buttonimg2 marginTop" > 查看任务周期</div>    
					
					<div onclick="javascript:window.close()" class="button buttonimg2" style="bottom: 15%;position:absolute;"> 关闭</div>
				</div> 
			</c:if>
	
		</div>  
		
	</div>	
	</div>
	
</body>
<!-- 弹窗 -->
<div id="sxWin" style="background-image:url('${cp}/images/window.png');background-size:100% 100%;" class="show"> 
	<div style="height: 5%"></div>
	<div style="height: 78%;overflow: auto;">
		<table style="margin-left: 8%;">
			<c:forEach items="${orgs}" var="o">
			<tr>
				<td>${o.SHORT_NAME}</td> 
			</tr>
			</c:forEach>
		</table>
	</div>
	<div> 
		  <div onclick="showClose('sxWin')" class="button buttonimg1" style="float: right;width: 30%;margin-right: 15%;"> 取 消 </div>  
	</div>	
</div> 
<div id="tzWin" style="" class="bigshow"> 
	<div style="width: 100%;height: 90%">
		<h4 align="center">${task.file_title}</h4> 	
		 <div style="height:91%;width: 95%;overflow: auto;margin-left: 5%">
		 		${task.file_content}
		 </div>
	</div>
	<div style="width: 100%"> 
	  <div onclick="closeWin()" class="button buttonimg2" style="float: right;width: 15%;margin-right: 5%;"> 取 消 </div>  
	</div>	
</div> 
<div id="timeWin" style="width: 250px;" class="show">    
<form action="" id="timeForm"  style="height: 91%"> 
	<div style="width: 95%;height: 91%;padding-left: 6%;padding-top: 35%">  
		<h4> 设置目标周期</h4>
		 <div class="input-daterange input-group" id="datepicker1"> 
	    	<input type="text" class=" form-control" id="mbstart_" name="mbstart_" value="${task.mbstart}""/> 
	    	<span class="input-group-addon">to</span>   
	    	<input type="text" class=" form-control" id="mbend_" name="mbend_" value="${task.mbend}"/>
	    </div>
	    <br>
	    <h4> 设置总结周期</h4>
	    <div  class="input-daterange input-group" id="datepicker2">
	    	<input type="text" class=" form-control" id="zjstart_" name="zjstart_" value="${task.zjstart}"/>
	    	<span class="input-group-addon">to</span>
	    	<input type="text" class=" form-control" id="zjend_" name="zjend_" value="${task.zjend}"/>
	    </div>
	      <div id="divZj_" class="has-error" id="datepicker3"> 
	    </div>
	     <br>
	    <h4> 设置评分周期</h4>
	    <div class="input-daterange input-group" id="datepicker3">
	    	<input type="text" class=" form-control" id="khstart_" name="khstart_" value="${task.khstart}"/>
	    	<span class="input-group-addon">to</span>
	    	<input type="text" class=" form-control" id="khend_" name="khend_" value="${task.khend}"/>
	    </div>
	     <div id="divKh_" class="has-error" id="datepicker3">
	    </div>
	   
	</div>
</form>
	 
	
	<div  style="width: 100%;"> 
		    <div onclick="showClose('timeWin')" class="button buttonimg2" style="float: right;width: 20%;margin-right: 5%;bottom: 2%"> 取 消 </div>  
	</div>
</div>
	<div id="bg"></div>
<script type="text/javascript">
function pingfen(){
	$.ajax({
				type : "POST",
				url : "count",
				async:false,
				data :{id:$("#taskId").val()},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					if(data){
						alertWin("评分成功");
						window.history.go(-1);
					}else{
						alertWin("评分出现异常");
					}
				}
			});
}


function countScore(){
	  alertWins("pingfen","确定进行统计吗?<br>统计后该任务不能在进行评分");
}
</script>
</html>
