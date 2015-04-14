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
</script>
<title>绩效考核系统</title>
</head>
<body>
	<%@include file="../common/head.jsp" %>
		<!-- Main --> 
		<div  style="float: left;height: 75%;width: 100%;position: relative;"> 
			<h3 style="margin-left: 5%;color: white;">考评结果</h3>
		<div style="float: left;width: 90%;">  
			<input type="hidden" id="t_id" value="${t_id}"> 
			<div  align="left" height="100%" width="70%" style="margin-left: 10%">
			<!-- 处室 列表--> 
				<c:forEach var="o" items="${lists}" varStatus="status">         
					<div id="div${o.id}" class="new" style="float: left; width: 32%;overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
					<span style="color: red;">(${o.score})</span>   
					
					<span    <c:if test="${power!=null and power.queryScore}">onclick="xq('${o.id}','${t_id}','${o.short_name}')"</c:if>  title="${o.short_name}" style="color:black;cursor: pointer;" >${o.short_name}</span>
					</div>    
				</c:forEach>   
			</div> 
		</div>    
			<div style="width: 10%;height: 70%;position:fixed;right: 2%;"> 
				 <c:if test="${power!=null and power.queryScore}">
					 <div onclick="goUrl('download?t_id=${t_id}')" class="button buttonimg3" style="position: absolute;bottom: 15%">导出</div>
				 </c:if>
				<div onclick="javascript:history.go(-1)" class="button buttonimg2" style="position: absolute;bottom: 5%"> 返回</div>
			</div> 
		</div>
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
<div id="xqWin"  class="show"> 
	<h3 style="color: white;padding-left: 20px">得分详情</h3>
	<div style="height: 78%;width:90%;margin-left:5%; overflow: auto;">
	<table class="table" id="xqtable">
	
	</table>  
	
	</div>
	<!-- 确定按钮 -->
	<div>
		  <div onclick="closeWin('xqWin')" class="button buttonimg1" style="float: right;width: 30%;margin-right: 15%;"> 取 消 </div>  
		  <div id="exportOrg" onclick="" class="button buttonimg3" style="float: right;width: 30%;margin-right: 15%;"> 导出 </div>  
	</div>	
</div>

<div id="zpWin" style="loat: right;right: 280px;" class="show">  
	<h3 style="color: white;padding-left: 20px">处室自评</h3>
	<div style="height: 78%;width:90%;margin-left:5%; overflow: auto;">
	<table class="table" id="zptable">
	
	</table>  
	
	</div>
	<!-- 确定按钮 -->
	<div>
		  <div onclick="showCloseA('zpWin')" class="button buttonimg1" style="float: right;width: 30%;margin-right: 15%;"> 取 消 </div>  
	</div>	
</div>
	<div id="bg"></div>
<script type="text/javascript">
	function zpfen(oid,tid){
		$.ajax({
					type : "POST",
					url : "qeuryZp",
					async:false,
					data :{oid:oid,tid:tid},
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) {
						var html="<tr><td style='font-size: 16px;color:white;width:120px;'>评测者</td><td style='font-size: 16px;color:white;width:30px;'>评分</td></tr>";
						$.each(data,function(i,o) {   
								html+="<tr><td>"+o.USER_NAME+"</td><td>"+o.SCORE+"</td></tr>";
						});
						$("#zptable").html(html); 
					}
				});
		
		
		showWinA('zpWin');
	}


	function xq(oid,tid,name){
		$.ajax({
					type : "POST",
					url : "../getScoreForOrg",
					async:false,
					data :{o_id:oid,t_id:tid}, 
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) { 
						var html="<tr><td style='font-size: 16px;color:white;width:120px;'>评测者</td><td style='font-size: 16px;color:white;width:30px;'>评分</td></tr>";
						$.each(data,function(i,o) {   
							if(o.name=="处室自评"){
								html+="<tr><td style='cursor: pointer;color:bule' onclick='zpfen(\""+oid+"\",\""+tid+"\")'>"+o.name+"</td><td>"+o.score+"</td></tr>";
							}else{ 
								html+="<tr><td>"+o.name+"</td><td>"+o.score+"</td></tr>";
							}
							
						});
						$("#xqtable").html(html); 
					}
				});		
		$("#exportOrg").attr("onclick","goUrl('exportOrg?filename="+name+"评测分.xls&oid="+oid+"&tid="+tid+"')");
		showdiv('xqWin'); 
	}


</script>
</html>
