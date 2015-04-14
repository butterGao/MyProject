<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../common/public.jsp" %>
<style type="text/css">

</style>
<script type="text/javascript">

</script>
<title>绩效考核系统</title>
</head>
<body>
	<%@include file="../common/head.jsp" %>
		<!-- Main --> 
		<div  style="float: left;height: 75%;width: 100%;position: absolute;" >
			<h3 style="margin-left: 5%;color: white;">指标详情</h3>
			<div style="float: left;width: 75%;padding-left: 5%;word-break:break-all"> 
				<input type="hidden" name="id" value="${target.id}">
				<h4 align="center">${target.title}</h4>     
				<span > ${target.content}</span>  
			</div>  
			<!-- 右边功能键 -->  
		<div style="width: 15%;height: 80%;position:fixed;right: 5%;">  
				<c:if test="${yulan==null}">
				<div onclick="showdiv('qzWin')" class="button buttonimg2"> 查看权重 </div>
				<div onclick="javascript:history.go(-1)" class="button buttonimg2" style="bottom: 15%;position:absolute;"> 返回 </div>    
				</c:if>
				<c:if test="${yulan==1}">
				<div onclick="javascript:window.close()" class="button buttonimg2" style="bottom: 15%;position:absolute;"> 关闭 </div>    
				</c:if>
		</div> 
		</div>  
	</div>
	</div>
</body>

 <div id="qzWin" style="background-size:100% 100%;overflow: auto;position: fixed;" class="bigshow"> 
         	     	<div style="height: 90%;width: 100%;overflow: auto;">
         	     	<table id="table" class="table" width="100%">  
		         	<tr>	 
		         		<td width="20%">评测者</td>   
		         		<td width="10%">权重</td>   
		         		<td >计分方式</td>    
		         		<td  width="10%">  </td>
		         	</tr>
		     
		         	<c:forEach items="${lists}" var="l">
		         	<tr>  
		         		<td>${l.name}</td> 
		         		<td>  
		         				<label class='form-control'>${l.code}%</label>
		         		</td>
		         		<td>
		         				<label class='form-control'>${l.typename}</label>
		         		</td>
		         		<td> </td>
		         	</tr> 
		         	
		         	
		         	</c:forEach>
	         	</table>  
         	</div>
	         	
	        <div style="position:absolute;bottom:3%;width: 98%;left: 2%;">
	         	<div  onclick="showClose('qzWin')" class="button buttonimg2" style="float: right;margin-right:2%;width: 20%;"> 取消 </div> 
         	</div>
	</div>

	<div style="position: fixed;" id="bg"></div>
		
</html>
