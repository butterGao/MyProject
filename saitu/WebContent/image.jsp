<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="s" uri="/struts-tags"%>
    <%
	pageContext.setAttribute("ctx", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="js/jquery-1.7.1.js" type="text/javascript"
	language="javascript"></script>
<script type="text/javascript">
var scrollFunc=function(e){ 
e=e || window.event; 
if(e.wheelDelta){//IE/Opera/Chrome 
	if(e.wheelDelta>0){
		var a=$("#a").val();
		a=a-2;
		$("#a").val(a);
		a=a+"%";
		$("#img1").css({ width: a, height: a});
	} 
	if(e.wheelDelta<0){
		var d=$("#a").val();
		d=d*1+2;
		$("#a").val(d);
		d=d+"%";
		$("#img1").css({ width: d, height: d});
	}
}
} 
/*注册事件*/ 
window.onmousewheel=scrollFunc;//IE/Opera/Chrome/Safari 

	</script>
</head>
<body>
<s:debug/>
<s:hidden id="a" value="100"></s:hidden>
<img  id="img1" height="1001px" width="1301px"  src="${ctx}/upload/${image}"/>
<%=request.getAttribute("image")
%>
</body>
</html>