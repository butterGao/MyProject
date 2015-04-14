<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
	String big=request.getParameter("big");
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
	
	function addshouye(){
		$.ajax({
			   type: "POST",
			   url: "ajaxf_count",
			   success: function(msg){
				   var data=eval('('+msg+')');
				   if(data.id<6){
					   $("#fm2").attr("action","floatw_addshouye");
						$("#fm2").submit();
				   }else{
					   alert("最大幻灯为6个，请编辑");
				   }
			   }
			});
	}
	function del(id,cid) {
		var msg = "您真的确定要删除吗？\n\n请确认！";
		if (confirm(msg) == true) {
			$.ajax({
				   type: "POST",
				   url: "ajaxe_exist",
				   data: {"id":id},
				   success: function(msg){
					   var data=eval('('+msg+')');
					   if(data.count>0){
						   alert("该文章设置为首页显示，请先替换首页信息");
					   }else{
							$.ajax({
								   type: "POST",
								   url: "entry_delete",
								   data: {"id":id,"cid":cid},
								   success: function(msg){
									   window.location.reload();
								   }
								});
					   }
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
	function sc(){
		$("#dlg").dialog("open").dialog('setTitle', '添加');
	}
	function shouye(id,cid,title){
		$("#floatwss").val(id);
		$("#floatwurl").val(cid);
		$("#floatwti").val(title);
		$("#dlg2").dialog("open").dialog('setTitle', '设置幻灯');
	}
</script>
</head>
<body>
	<br>
	<br>
		<br>
		<div id="dlg" class="easyui-dialog"
		style="width: 320px; height: 220px; ;padding: 10px 20px;" closed="true"
		buttons="#dlg-buttons">
		<form id="fm1" name="form1" method="post" action="${ctx}/admin/entry_upload"
			enctype="multipart/form-data">
			<input type="hidden" id="entryid" name="entry.id">
			<input type="hidden" id="entrycid" name="entry.categoryid">
			<div class="fitem">
				<label> 标题 </label> <input id="entry" size="34" name="entry.title"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label>文档</label> <input id="cont" type="file"
					 name="file" /> 
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a  class="easyui-linkbutton" onclick="save(${cid})" iconcls="icon-save">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>
<!-- dlg2-->	
	<br>
		<div id="dlg2" class="easyui-dialog"
		style="width: 320px; height: 220px; ;padding: 10px 20px;" closed="true"
		buttons="#dlg-buttons2">
		<form id="fm2" name="form2" method="post" action="${ctx}/admin/entry_upload"
			enctype="multipart/form-data">
			<input type="hidden" id="floatwurl" name="floatw.urlss">
			<input type="hidden" id="floatwss" name="floatw.stutrs">
			<div class="fitem">
				<label> 标题 </label> <input id="floatwti" size="34" name="floatw.info"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label>幻灯照片</label> <input id="cont" type="file"
					 name="mgfile" /> 
			</div>
		</form>
	</div>
	<div id="dlg-buttons2">
		<a  class="easyui-linkbutton" onclick="addshouye()" iconcls="icon-save">确定</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#dlg2').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>
<!-- dlg2-->	
	
	
	<div align="center" id="Layer1">
		<s:form name="form1" action="admin/entry_query" theme="simple">
			<table border="0" width="100%">
				<s:hidden name="id"></s:hidden>
				<s:hidden name="cid"></s:hidden>
				<td align="left"><s:textfield name="date1" readonly="true" size="9"
						onclick="new Calendar().show(this);" /> <s:textfield name="date2" readonly="true"
						size="9" onclick="new Calendar().show(this);" /> <s:submit
						style="width:60px; height:20px;  border:0; background:url('/YunWei/images/19.png') no-repeat"
						value=""></s:submit></td>
				<td align="right" width="380">
				<a onclick="sc()">上传</a>
				<a href="${ctx}/admin/entry_add.jsp?cid=${cid}&cg=${cg}"><img border="0"
						alt="添加" src="/YunWei/images/add.png"></a></td>
			</table>
		</s:form>
		<p>&nbsp;</p>
		<table id="tab" border="0" rules="none" width="100%">
			<tr>
				<td height="32" width="480">
					<h3>标题</h3>
				</td>
				<td width="99"><h3>日期</h3></td>
				<td width="63"><h3>操作</h3></td>
			</tr>
			<s:iterator value="pageModel.list" var="l">
				<tr><s:if test="#l.types==1">
				<td width="480" height="32" align="left"
						onmouseover="CrtTitle(this)">${l.title}</td>
					<td width="99"><s:date name="#l.creatTime" format="yyyy-MM-dd" /></td>
					<td width="43" align="center"><a href="${ctx}/page/xz?id=${l.id}">下载</a>
					<a
						onclick="del(${l.id},${cid})"><img
							src="${ctx}/images/delete.gif" border="0" alt="删除"></a></td>
				</s:if>
					<s:else>
					<td width="480" height="32" align="left"
						onmouseover="CrtTitle(this)"><a
						href="admin/entry_edit?id=${l.id}&cg=${cg}">${l.title}</a></td>
					<td width="99"><s:date name="#l.creatTime" format="yyyy-MM-dd" /></td>
					
					<td width="77" align="right">
					<a onclick="shouye(${l.id},${cid},'${l.title}')">幻灯</a>
					 <a
						href="admin/entry_edit?id=${l.id}&cg=${cg}"><img
							src="${ctx}/images/edit.gif" border="0" alt="详情"></a> <a
						onclick="del(${l.id},${cid})"><img
							src="${ctx}/images/delete.gif" border="0" alt="删除"></a></td>
						</s:else>	
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
