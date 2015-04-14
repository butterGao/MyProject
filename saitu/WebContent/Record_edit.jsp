<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑公告</title>


<%@include file="public.jsp" %>
	<div align="left" id="Layer1">
	<s:form action="Record_update" theme="simple" enctype="multipart/form-data">
		<table id="tab" >
		<s:hidden name="record.id"></s:hidden>
		<s:hidden name="record.path"></s:hidden>
		<s:hidden name="record.b"></s:hidden>
		<s:hidden name="record.route.id"></s:hidden>
			<tr>
				<td>标题:</td>
				<td><s:textfield name="record.title"/></td>
			</tr>
			<tr>
				<td>公告来源</td>
				<td><s:textfield name="record.source"/></td>
			</tr>
			<tr>
				<td>发布日期</td>
				<td><s:textfield name="record.publishDate" onclick="new Calendar().show(this);" readonly="readonly"/></td>
			</tr>
			<tr>
				<td>更新日期</td>
				<td><s:textfield name="record.updateDate" onclick="new Calendar().show(this);" readonly="readonly"/></td>
			</tr>
			<tr>
				<td><a href="${ctx}/image?image=${record.path}">照       片</a></td>
				<td>
				<s:file name="file"></s:file> </td>
			</tr>
			<tr>
				<td>操作员</td>
				<td><s:textfield name="record.username"/></td>
			</tr>
			<tr>
				<td>内容</td>
				<td> 	<s:textarea rows="10%"  cols="27%" name="record.content" /></td>
			</tr>
			<tr>
				<td >备注</td>
				<td> <s:textfield  name="record.comment" /></td>
			</tr>
			<tr>
				<td>处理结果</td>
				<td><s:textfield name="record.result"/></td>
			</tr>
			<tr>
				<td>  </td>
				<td align="right"><s:submit name="submit" value="保存" /></td>
			</tr>
		</table>
		
	</s:form>
</body>
</html>