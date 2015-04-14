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

</script>
<title>绩效考核系统</title>
</head>
<body>
	<%@include file="../common/head.jsp" %>
		<!-- Main --> 
		<div  style="float: left;height: 75%;width: 100%;position: absolute;" >
			<h3 style="margin-left: 5%;color: white;">目标详情</h3>
			<div style="float: left;width: 75%;padding-left: 5%;word-break:break-all;"> 
			<c:if test="${over != null}">
					<c:if test="${mubiao.title==null||mubiao.title==''}">
						<h4 align="center">您尚未在规定时间内填写工作目标</h4>     
					</c:if>
				</c:if>
				<h4 align="center">${mubiao.title}</h4>     
				<span > ${mubiao.content}</span>  
			</div>  
			<!-- 右边功能键 -->  
			
		<div style="width: 15%;height: 80%;position:fixed;right: 5%;">  
				<c:if test="${over == null}">  
					<div onclick="windowClose()" class="button buttonimg2" style="bottom: 15%;position:absolute;"> 关闭 </div>
				</c:if>
				<c:if test="${over != null}">
					<div onclick="javascript:history.go(-1)" class="button buttonimg2" style="bottom: 15%;position:absolute;"> 返回 </div>
				</c:if>
				
		</div> 
		</div>  
  </div>
</div>
</body>

<!-- 弹窗 -->

	<div id="bg"></div>
		
</html>
