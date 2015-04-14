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
<style type="text/css">
#hhh {
	position: absolute;
	z-index: 1;
	left: 111px;
	top: 576px;
}
</style>
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

<script type="text/javascript">
	function cl() {
		document.getElementById("div1").style.display = "none";
		document.getElementById("div2").style.display = "";
		document.getElementById("date1").value = "";
		document.getElementById("date2").value = "";
	}
	function cc(id) {
		var a = document.getElementById(id).value;
		
		if (a == "路线名称") {
			document.getElementById("url").value="Route_listName";
			cl();
			document.form1.action = "Route_listName";
		}
		if (a == "更新日期") {
			document.getElementById("url").value="Route_listDate";
			document.getElementById("div1").style.display = "";
			document.getElementById("div2").style.display = "none";
			document.form1.action = "Route_listDate";
		}
		if (a == "运行状态") {
			document.getElementById("url").value="Route_listState";
			cl();
			document.form1.action = "Route_listState";
		}if(a == "没有照片"){
			document.getElementById("url").value="Route_listPath";
			cl();
			document.form1.action = "Route_listPath";
			document.form1.submit();
		}
	}
	
	function CrtTitle(o){
	if( o.crtTitle == undefined ){
	   o.crtTitle='true';
	   o.title=o.scrollWidth>o.clientWidth?o.innerText:"";
	}
	}
	
</script>
<%@include file="public.jsp"%>
<div align="center" id="Layer1">
	<s:form name="form1" action="Route_listName" theme="simple">
		<table width="376" border="1">
		<div style="display: none">
		<input type="text" name="URL" id="url"> 
		</div>
			<tr>
				查询
				<s:select id="select" onchange="cc(this.id)"
					list="{'请选择','路线名称','更新日期','运行状态','没有照片'}"></s:select>
				<td><div id="div1" style="display: none;">
						<s:textfield id="date1" name="date1"
							onclick="new Calendar().show(this);" />

						<s:textfield id="date2" name="date2"
							onclick="new Calendar().show(this);" />
						<s:submit value="提交"></s:submit>
					</div>
					<div id="div2">
						<s:textfield name="where"></s:textfield>
						<s:submit value="提交"></s:submit>
					</div></td>
			</tr>

		</table>
	</s:form>
	<p>&nbsp;</p>
	<table id="tab" class="Cspan"   style="width: 200px" border="1">
		<tr>
			<td width="44">ID</td>
			<td width="240"><h3 class="STYLE1">路线名称</h3></td>
			<td width="66"><h3 class="STYLE1">调度电话</h3></td>
			<td width="66"><h3 class="STYLE1">站点数</h3></td>
			<td width="66"><h3 class="STYLE1">运行状态</h3></td>
			<td width="66"><h3 class="STYLE1">更新日期</h3></td>
			<td width="66"><h3 class="STYLE1">临时期限</h3></td>
			<td width="77"><h3 class="STYLE1">操作</h3></td>
		</tr>
		<s:iterator value="pageModel.list" var="r">
			<tr>
				<td style="overflow: hidden; text-overflow: ellipsis;">${r.id}</td>
				<td onmouseover="CrtTitle(this)" width="240" align="left">${r.name}</td>
				<td>${r.phone}</td>
				<td>${r.zhandian}</td>
				<td>${r.state}</td>
				<td><s:date name="#r.updateDate" format="yyyy-MM-dd" /></td>
				<td><s:date name="#r.overDate" format="yyyy-MM-dd" /></td>
				<td><a href="${ctx}/Route_edit?id=${r.id}"> <img
						src="${ctx}/images/edit.gif" border="0" alt="详情"></a> <a
					href="${ctx}/Record_list11?id=${r.id}">···</a> <a href="${ctx}/image?image=${r.path}">照片</a></td>
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
				<a href="${pageUrl}&pn=${pageNumber}">末页 </a>
			</pg:last>
		</pg:index>
	</pg:pager>
	<s:debug></s:debug>
</div>
<div align="left" id="hhh">
<a href="count.jsp"> <span style="color: #FFFFFF">更新统计</span>  </a>
</div>
</body>
</html>