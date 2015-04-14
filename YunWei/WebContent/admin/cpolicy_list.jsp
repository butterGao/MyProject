<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%pageContext.setAttribute("ctx", request.getContextPath());%>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
<link rel="stylesheet" type="text/css" href="../js/easyui.css">
<link rel="stylesheet" type="text/css" href="../js/icon.css">
<script type="text/javascript" src="../js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="../js/ChineseCalendar.js"></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../js/utilJs.js"></script>
<style type="text/css">
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

tr {
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
}

td {
	table-layout: fixed;
	overflow: hidden;
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
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
	function swap(id,order){
		$.ajax({
			   type: "POST",
			   url: "cpolicy_swap",
			   data: {"id":id,"order":order},
			   success: function(msg){
				   location.href="cpolicy_list";
			   }
			});
	}
	function edit(id){
		$.ajax({
			   type: "POST",
			   url: "ajaxc_edit",
			   data:"id="+id,
			   success: function(msg){
				   var data=eval('('+msg+')');
				   var path=data.cpolicy.path;
				   $("#cpolicytitle").val(data.cpolicy.title);
				   $("#cpolicysunxu").val(data.cpolicy.sunxu);
				   $("#cpolicyeng").val(data.cpolicy.eng);
				   $("#cpolicyurl").val(data.cpolicy.url);
				   $("#cpolicyid").val(data.cpolicy.id);
				   $("#dlg").dialog("open").dialog('setTitle', '编辑');
				   $("#fm1").attr("action",getroot()+"/admin/cpolicy_update");
			   }
			});
	}
	function add() {
		$("#dlg").dialog("open").dialog('setTitle', '添加');
		 $("#fm1").attr("action",getroot()+"/admin/link_add");
	}
	function save() {
		$("#fm1").submit();
	}
	function del() {
		var msg = "您真的确定要删除吗？\n\n请确认！";
		if (confirm(msg) == true) {
			return true;
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
</script>
</head>
<body >
	<br>
	<br>
	<div align="center" id="dlg" class="easyui-dialog"
		style="width: 320px; height: 220px; padding: 10px 20px;" closed="true"
		buttons="#dlg-buttons">
		<form id="fm1" name="form1" method="post" 
			enctype="multipart/form-data">
			<input type="hidden" id="cpolicyid" name="cpolicy.id">
			<input type="hidden" id="cpolicysunxu" name="cpolicy.sunxu">
			<input type="hidden" id="cpolicyurl" name="cpolicy.url">
			<div class="fitem">
				<label> 名称 </label> <input id="cpolicytitle" name="cpolicy.title"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label> 英文</label> <input id="cpolicyeng" name="cpolicy.eng"
					class="easyui-validatebox" />
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a  class="easyui-linkbutton" onclick="save()" iconcls="icon-save">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>
	<div align="center" id="Layer1">
		<table id="tab" style="width:100% ; table-layout: fixed;" border="0"
			rules="none">
			<tr>
				<td height="36" width="131"><h3>标题</h3></td>
				<td width="99"><h3>英文</h3></td>
				<td width="33"><h3>顺序</h3></td>
				<td width="77"><h3>操作</h3></td>
			</tr>
			<s:iterator value="list" var="l">
				<tr>
					<td height="32" align="left" onmouseover="CrtTitle(this)">${l.title}</td>
					<td onmouseover="CrtTitle(this)">${l.eng}</td>
					<td><input size="4" onchange="swap(${l.id},this.value)" value="${l.sunxu}"></td>
					<td align="center">
					<a href="#"><img onclick="edit(${l.id})"
							src="${ctx}/images/edit.gif" border="0" id="${l.id}" alt="详情"></a> 
					</td>
				</tr>
			</s:iterator>
		</table>
	</div>
</body>
</html>
