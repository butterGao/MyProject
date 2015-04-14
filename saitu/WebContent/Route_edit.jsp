<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑线路</title>
 <script type="text/javascript">
  function via() {
	  var file=$("#zhandian").val();
	  var us=$("#us").val();
	  if(""==file||0==file){
		  alert("站点必须填");
		  return false;
	  }
	  if(""==us||null==us)
		  {
		  alert("操作员必须填"); 
		  return false;
		  }
	return true;
}
  </script>
<%@include file="public.jsp" %>
	<div align="center" id="Layer1">
		<h2>编辑</h2>
	<s:form action="Route_update" theme="simple" onsubmit="return via()" enctype="multipart/form-data">
		<table id="tab">
		<s:hidden name="route.id"></s:hidden>
		<s:hidden name="route.path"></s:hidden>
			<tr>
				<td align="left">路线名称</td>
				<td align="left"><s:textfield name="route.name"/></td>
			</tr>
			<tr>
				<td align="left">调度电话</td>
				<td align="left"><s:textfield name="route.phone"/></td>
			</tr>
			<tr>
				<td align="left">站点数</td>
				<td align="left"><s:textfield id="zhandian" name="route.zhandian"/></td>
			</tr>
			<tr>
				<td align="left">线路状态</td>
				<td align="left"><s:select name="route.state" list="{'正常运行','临时绕道','临时停运','撤销'}" ></s:select></td>
			</tr>
			<tr>
				<td align="left">绕道期限</td>
				<td align="left"><s:textfield name="route.overDate" onclick="new Calendar().show(this);" readonly="readonly"/></td>
			</tr>
			<tr>
				<td align="left"><a href="${ctx}/image?image=${route.path}">照片</a>
				</td>
				<td align="left"><s:file name="file"></s:file> </td>
			</tr>
			<tr>
				<td align="left">最近记录</td>
				<td align="left"><a href="${ctx}/Record_edit?id=${record.id}"> ${record.title}</a> </td>
			</tr>
			<tr>
				<td align="left">更新日期</td>
				<td align="left"><s:textfield name="route.updateDate" readonly="true"/></td>
			</tr>
			<tr>
				<td align="left">备注</td>
				<td  align="left"> <s:textarea  name="route.comment"/></td>
			</tr>
			<tr>
			<td align="left">记录id</td>
			<td align="left"><s:textfield id="Rid" name="Rid"></s:textfield>   </td>
			</tr>
			<tr>
				<td align="left">操作员</td>
				<td align="left"><s:textfield id="us" name="username"></s:textfield> <s:submit  name="submit" value="更新" /></td>
			</tr> 
		</table>
	</s:form>
	<s:debug></s:debug>
</body>
</html>