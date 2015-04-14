<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加路线</title>
  <script type="text/javascript">
  function via() {
	  var file=$("#zhandian").val();
	  if(""==file||0==file){
		  alert("站点必须填");
		  return false;
	  }
	return true;
}
  </script>
<%@include file="public.jsp" %>
	<div align="center" id="Layer1">
		<h2>添加路线</h6>
	<s:form action="Route_add" theme="simple" onsubmit="return via()" enctype="multipart/form-data">
		<table id="tab" border="0" >
			<tr>
				<td>路线名称</td>
				<td align="left"><s:textfield name="route.name"/></td>
			</tr>
			<tr>
				<td>调度电话</th>
				<td align="left"><s:textfield name="route.phone"/></td>
			</tr>
			<tr>
				<td>站点数</th>
				<td align="left"><s:textfield id="zhandian" name="route.zhandian"/></td>
			</tr>
			<tr>
				<td>线路状态</td>
				<td align="left"><s:select name="route.state" list="{'正常运行','临时绕道','撤销路线','停运'}" ></s:select></td>
			</tr>
			<tr>
				<td>照片</td>
				<td align="left"><s:file  name="file"></s:file> </td>
			</tr>
			
			<tr>
			<td align="left"></td>
				<td ><s:submit name="submit" value="添加" /></td>
			</tr> 
		</table>
	</s:form>
	<s:debug></s:debug>
</body>
</html>