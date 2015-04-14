<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function del() {
		var msg = "您真的确定要删除吗？\n\n请确认！";
		if (confirm(msg) == true) {
			return true;
		} else {
			return false;
		}
	}
</script>
<%@include file="public.jsp" %>
<div align="center" id="Layer1">
	
		<h2>今日任务</h2>
		
	<p>&nbsp;</p>
	<table id="tab" class="Cspan" style="width:200px" border="1">
		<tr>
			<td width="44">ID</td>
			<td width="280"><h3 class="STYLE1">标         题</h3></td>
			<td width="66"><h3 class="STYLE1">公告来源</h3></td>
			<td width="66"><h3 class="STYLE1">发布日期</h3></td>
			<td width="66"><h3 class="STYLE1">更新日期</h3></td>
			<td width="66"><h3 class="STYLE1">备          注</h3></td>
			<td width="66"><h3 class="STYLE1">操作</h3></td>
		</tr>
		<s:iterator value="pageModel.list" var="l">
			<tr>
				<td>${l.id}</td>
				<td>${l.title}</td>
				<td>${l.source}</td>
				<td><s:date name="#l.publishDate" format="yyyy-MM-dd"/></td>
				<td><s:date name="#l.updateDate" format="yyyy-MM-dd"/></td>
				<td>${l.comment}</td>
				<td align="center"><a href="${ctx}/Record_edit?id=${l.id}"><img
						src="${ctx}/images/edit.gif" border="0" alt="更新"></a> <a href="${ctx}/image?image=${l.path}">照片</a> </td>
			</tr>
		</s:iterator>
	</table>
	<p>共${count}条记录</p>
	<pg:pager id="pageModel" url="${ctx}/Record_listToday"
		items="${pageModel.totalRecords}" maxPageItems="${pageModel.pageSize}"
		maxIndexPages="5">
		<pg:index>
			<pg:first>
				<a href="${pageUrl}&pn=${pageNumber}">首页</a>
			</pg:first>
			<pg:prev>
				<a href="${pageUrl}&pn=${pageNumber}">&lt;上一页</a>
			</pg:prev>
			<pg:pages>
				<a href="${pageUrl}&pn=${pageNumber}">${pageNumber}</a>
			</pg:pages>
			<pg:next>
				<a href="${pageUrl}&pn=${pageNumber}">下一页&gt;</a>
			</pg:next>
			<pg:last>
				<a href="${pageUrl}&pn=${pageNumber}">末页 
			</pg:last>
		</pg:index>
	</pg:pager>
	</div>
	<s:debug></s:debug>
</body>
</html>