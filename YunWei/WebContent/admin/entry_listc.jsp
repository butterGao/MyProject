<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
	String big = request.getParameter("big");
%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${ctx}/js/jquery-1.7.1.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/js/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/js/icon.css">
<script type="text/javascript" src="${ctx}/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${ctx}/js/ChineseCalendar.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx}/js/utilJs.js"></script>
<script type="text/javascript" src="${ctx}/js/entrylist.js"></script>
<script type="text/javascript" src="${ctx}/js/Calendar3.js"></script>

<style type="text/css">
#Layer1 {
	
}

a {
	TEXT-DECORATION: none;
	color: #444
}

a:hover {
	TEXT-DECORATION: underline
}

#Layer2 {
	position: absolute;
	left: 90px;
	background-color: black;
}

table {
	
}

tr {
	font-size: 16px;
	padding: 3px 3px 3px 8px;
	color: #000000;
}

.autocut:hover {
	overflow: visible;
	white-space: normal;
	word-wrap: break-word;
}
</style>
<style type="text/css">
* {
	font-size: 12px;
	margin: 0;
	padding: 0
}

.s_oushuhang {
	background-color: #FFFFFF;
} /*偶数行的背景色*/
.s_jishuhang {
	background-color: #f5f5f7;
} /*奇数行的背景色*/
.table_gehang tr {
	width: 300px;
	line-height: 30px;
}

.STYLE1 {
	color: black;
}

.table_gehang tr td {
	text-align: left;
	padding-left: 5%;
	_padding-left: 4%;
}
</style>
<script type="text/javascript">

	$(function() {
		$("tr:even").addClass("s_oushuhang");//偶数行的背景色
		$("tr:odd").addClass("s_jishuhang");//奇数行的背景色
		$(".table_gehang").delegate("tr", "hover", function() {
			$(this).toggleClass("s_mouseover");
		});
	});
</script>
<script type="text/javascript">
	
	function shouye(id,ccid){
			$.ajax({
				   type: "POST",
				   url: "entry_edite",
				   data: {"id":id,"ccid":ccid},
				   success: function(msg){
					   alert("设置成功!");
				   }
				});
	}
	function del(id,cid) {
		var msg = "您真的确定要删除吗？\n\n请确认！";
		if (confirm(msg) == true) {
			$.ajax({
				   type: "POST",
				   url: "entry_delete",
				   data: {"id":id,"cid":cid},
				   success: function(msg){
					   window.location.reload();
				   }
				});
		} else {
			return false;
		}
	}
	function CrtTitle(o) {
		if (o.crtTitle == undefined) {
			o.crtTitle = 'true';
			o.title = o.scrollWidth > o.clientWidth ? o.innerText : "";
		}
	}
	function save(id) {
		$("#entrycid").val(id);
		$("#fm1").submit();
	}
	function update(id,title) {
		$("#dlg").dialog("open").dialog('setTitle', '编辑');
		$("#entrytitle").val(title);
		$("#entryid").val(id);
		$("#fm1").attr("action", '<%=request.getContextPath()%>'+"/admin/entry_update2");
	}
	function add(){
		$("#dlg").dialog("open").dialog('setTitle', '添加展示项目');
	}
</script>
</head>
<body>
	<br>
	<br>
	<div id="dlg" class="easyui-dialog"
		style="width: 320px; height: 120px;; padding: 10px 20px;"
		closed="true" buttons="#dlg-buttons">
		<form id="fm1" name="form1" method="post"
			action="${ctx}/admin/entry_upload" enctype="multipart/form-data">
			<input type="hidden" id="entryid" name="entry.id"> <input
				type="hidden" id="entrycid" name="entry.categoryid"> <input
				type="hidden" id="chenguo" name="entry.chenguo">
			<div class="fitem">
				<label> 标题 </label> <input id="entrytitle" size="34"
					name="entry.title" class="easyui-validatebox" required="true" />
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a class="easyui-linkbutton" onclick="save(${id})" iconcls="icon-save">保存${id}</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>
	<div align="center" id="Layer1">
		<s:form name="form1" action="admin/entry_query" theme="simple">
			<table border="0" width="100%">
				<s:hidden name="id"></s:hidden>
				<s:hidden name="cid"></s:hidden>
				<td align="left"><s:textfield name="date1" readonly="true"
						size="9" onclick="new Calendar().show(this);" /> <s:textfield
						name="date2" readonly="true" size="9"
						onclick="new Calendar().show(this);" /> <s:submit
						style="width:60px; height:20px;  border:0; background:url('/YunWei/images/19.png') no-repeat"
						value=""></s:submit></td>
				<td align="right" width="380"><a onclick="add()"><img
						border="0" alt="添加" src="/YunWei/images/add.png"></a></td>
			</table>
		</s:form>
		<p>&nbsp;</p>
		<table id="tab" border="0" rules="none" width="100%">
			<tr>
				<td height="32" width="480">
					<h3>标题</h3>
				</td>
				<td width="43"><h3>操作</h3></td>
			</tr>
			<s:iterator value="pageModel.list" var="l">
				<tr>
					<td width="480" height="32" align="left"
						onmouseover="CrtTitle(this)"><a
						href="admin/entry_chenguo?cg=${l.id}">${l.title}</a></td>
					<td width="43" align="center"><a
						onclick="update(${l.id},'${l.title}')"><img
							src="${ctx}/images/edit.gif" border="0" alt="修改"></a></td>
				</tr>
			</s:iterator>
		</table>
		<pg:pager id="pageModel" url="${ctx}/admin/entry_list"
			items="${pageModel.totalRecords}"
			maxPageItems="${pageModel.pageSize}" maxIndexPages="5">
			<pg:param name="cid" value="${cid}" />
			<pg:index>
				<pg:first>
					<a href="${pageUrl}&p=${pageNumber}">首页</a>
				</pg:first>
				<pg:prev>
					<a href="${pageUrl}&p=${pageNumber}">&lt;上一页</a>
				</pg:prev>
				<pg:pages>
					<a href="${pageUrl}&p=${pageNumber}">${pageNumber}</a>
				</pg:pages>
				<pg:next>
					<a href="${pageUrl}&p=${pageNumber}">下一页&gt;</a>
				</pg:next>
				<pg:last>
					<a href="${pageUrl}&p=${pageNumber}">末页 
				</pg:last>
			</pg:index>
		</pg:pager>
	</div>
</body>
</html>
