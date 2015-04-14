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
	background-color: #f5f5f7;
} /*偶数行的背景色*/
.s_jishuhang {
	background-color: #FFFFFF;
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
	function edit(id) {
		$.ajax({
			type : "POST",
			url : getroot()+"/admin/ajax_Floatw_edit",
			data : "id=" + id,
			success : function(msg) {
				var data = eval('(' + msg + ')');
				$("#floatwinfo").val(data.floatw.info);
				$("#floatwurl").val(data.floatw.urlss);
				$("#floatwss").val(data.floatw.stutrs);
				$("#floatwid").val(data.floatw.id);
				$("#img1").attr("src",
						getroot() + "/upload/" + data.floatw.path);
				$("#dlg").dialog("open").dialog('setTitle', '编辑');
			}
		});
	}
	function CrtTitle(o) {
		if (o.crtTitle == undefined) {
			o.crtTitle = 'true';
			o.title = o.scrollWidth > o.clientWidth ? o.innerText : "";
		}
	}
	function save(){
		$("#fm1").submit();
	}
	
	function del(id,cid) {
		var msg = "您真的确定要删除吗？\n\n请确认！";
		if (confirm(msg) == true) {
			$.ajax({
				   type: "POST",
				   url: "ajaxf_delete",
				   data: {"id":id},
				   success: function(msg){
					   alert("删除成功");
					   window.location.href="floatw_show";
				   }
				});
		} else {
			return false;
		}
	}
</script>
</head>
<body>
	<br>
	<br>
	<div id="dlg" class="easyui-dialog"
		style="width: 320px; height: 220px; padding: 10px 20px;" closed="true"
		buttons="#dlg-buttons">
		<form id="fm1" name="form1" method="post" action="${ctx}/admin/floatw_update" enctype="multipart/form-data">
			<input type="hidden" id="floatwid" name="floatw.id">
			<input type="hidden" id="floatwurl" name="floatw.urlss">
			<input type="hidden" id="floatwss" name="floatw.stutrs">
			<div class="fitem">
				<label>描述</label> <input id="floatwinfo" name="floatw.info"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label>更换图片</label> <input id="image1" type="file" name="mgfile"
					onchange="" />
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a class="easyui-linkbutton" onclick="save()" iconcls="icon-save">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>
	<%-- 		<table id="tab" border="0" rules="none" width="100%">
			<tr>
				<td height="32" width="480">
					<h3>标题</h3>
				</td>
				<td width="99"><h3>日期</h3></td>
				<td width="43"><h3>操作</h3></td>
			</tr>
			<s:iterator value="floatws" var="l">
				<tr>
					<td width="480" height="32" align="left"
						onmouseover="CrtTitle(this)"><a
						href="javascript:void(0)" onclick="edit()">${l.info}</a></td>
					<td width="99"><s:date name="#l.creatTime" format="yyyy-MM-dd" /></td>
					<td width="43" align="center"> <a href="javascript:void(0)"
						onclick="update(${l.id})"><img
							src="${ctx}/images/edit.gif" border="0" alt="更新"></a></td>
				</tr>
			</s:iterator>
		</table> --%>
	<s:iterator value="floatws" var="l">
		<div style="float: left; width: 33%">
		<img onclick="edit(${l.id},${l.urlss},${l.stutrs})" width="237" height="230" alt="" src="${ctx}/upload/${l.path}"><br>
		<input type="text" readonly="readonly" size="33" value="${l.info}"> <input type="button" onclick="del(${l.id})" value="删除">
		</div>
	</s:iterator>
</body>
</html>
