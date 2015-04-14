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
		function cc(){
			document.getElementById("url").value="Record_listByDate1";
			document.form1.action="Record_listByDate1";
			
		}
</script>
<%@include file="public.jsp" %>
	<div align="center" id="Layer1">
	<s:form name="form1" action="Record_listByDate1" theme="simple">
		<table width="444" border="1" style="border-collapse: collapse;">
		<div style="display: none">
		<input type="text" name="URL" id="url"> 
		</div>
			<tr>
				<h2>历史公告</h2>
				<td>查询更改日期:<s:textfield name="date1"
						onclick="new Calendar().show(this);" /> <s:textfield name="date2"
						onclick="new Calendar().show(this);" /> <s:submit onclick="cc()" value="提交"></s:submit>

				</td>
			</tr>
		</table>
	</s:form>
	<p>&nbsp;</p>
	<table id="tab" class="Cspan" style="width:200px" border="1" >
		<tr>
			<td width="66">ID</td>
			<th width="280"><h3 class="STYLE1">标题</h3></td>
			<th width="66"><h3 class="STYLE1">公告来源</h3></td>
			<th width="66"><h3 class="STYLE1">发布日期</h3></td>
			<th width="66"><h3 class="STYLE1">更改日期</h3></td>
			<th width="66"><h3 class="STYLE1">处理结果</h3></td>
			<th width="66"><h3 class="STYLE1">操作员</h3></td>
			<th width="66"><h3 class="STYLE1">操作</h3></td>
		</tr>
		<s:iterator value="pageModel.list" var="l">
			<tr>
				<td>${l.id}</td>
				<td>${l.title}</td>
				<td>${l.source}</td>
				<td><s:date name="#l.publishDate" format="yyyy-MM-dd"/></td>
				<td><s:date name="#l.changeDate" format="yyyy-MM-dd"/></td>
				<td>${l.result}</td>
				<td>${l.username}</td>
				<td align="center"><a href="${ctx}/Record_edit?id=${l.id}"><img
						src="${ctx}/images/edit.gif" border="0" alt="更新"></a> <a href="${ctx}/image?image=${l.path}">照片</a></td>
			</tr>
		</s:iterator>
	</table>
	<p>共${count}条记录</p>
	<pg:pager id="pageModel" url="${ctx}/${URL}"
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
				<a href="${pageUrl}&pn=${pageNumber}">末页</a>
			</pg:last>
		</pg:index>
	</pg:pager>
	<s:debug></s:debug>
</body>
</html>