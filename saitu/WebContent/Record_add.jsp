<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>添加公告</title>
  <script type="text/javascript">
  function via() {
	  var file=$("#file").val();
	  var com=$("#content").val();
	  if(""==file && ""==com){
		  alert("照片或内容至少添加一个");
		  return false;
	  }
	return true;
}
  </script>
<%@include file="public.jsp" %>
	<div align="center" id="Layer1">
	<h2>添加公告</h2>
	<s:form action="Record_add" theme="simple" onsubmit="return via()" enctype="multipart/form-data">
		<table id="tab">
			<tr>
				<td>标题:</td>
				<td align="left"><s:textfield name="record.title"/></td>
			</tr>
			<tr>
				<td>公告来源</td>
				<td align="left"><s:textfield name="record.source"/></td>
			</tr>
			<tr>
				<td>发布日期</td>
				<td align="left"><s:textfield name="record.publishDate" onclick="new Calendar().show(this);" readonly="readonly"/></td>
			</tr>
			<tr>
				<td>更新日期</td>
				<td align="left"><s:textfield name="record.updateDate" onclick="new Calendar().show(this);" readonly="readonly"/></td>
			</tr>
			<tr>
				<td> 照片</td>
				<td align="left"><s:file name="file" id="file"></s:file> </td>
			</tr>
			<tr>
				<td>内容</td>
				<td  align="left"><s:textarea rows="10%"  cols="27%" name="record.content" id="content"/></td>
			</tr>
			<tr>
			<td>备注</td>
			<td  align="left"><s:textarea name="record.comment"/></td>
			</tr>
			<tr>
				<td align="left"></td>
				<td ><s:submit name="submit" value="添加" /></td>
			</tr>
		</table>
	</s:form>
	</div>
	<s:debug></s:debug>
</body>
</html>