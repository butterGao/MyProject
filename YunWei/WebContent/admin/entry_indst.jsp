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
	function del(id) {
		var msg = "您真的确定要删除吗？\n\n请确认！";
		if (confirm(msg) == true) {
			$.ajax({
				   type: "POST",
				   url: "entry_delete",
				   data: {"id":id},
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
		$("#entrycid").val(34);
		$("#fm1").submit();
	}
	function update(id,title) {
		$("#dlg").dialog("open").dialog('setTitle', '编辑');
		$("#entrycid").val(34);
		$("#entrytitle").val(title);
		$("#entryid").val(id);
		$("#fm1").attr("action", '<%=request.getContextPath()%>'+"/admin/entry_update");
	}
	
	function queryUserx(cid,oid) {
		var a=0;
		var b=100;
		if(cid==1){
			a=10;b=20;
		}
		if(cid==2){
			a=20;b=30;
		}if(cid==3){
			a=30;b=40;
		}
			
		$("#dlg").dialog("open").dialog('setTitle','选择显示文章');
		$('#elist')
				.datagrid(
						{
							pageSize : 10,
							pageList : [ 5, 10, 15, 20, 25, 30, 35, 40, 45, 50 ],
							nowrap : true,
							striped : true,
							collapsible : true,
							url : "ajaxe_catelist",
							queryParams : {a:a,b:b},
							loadMsg : '数据装载中......',
							remoteSort : false,
							fitColumns : true,
							singleSelect : true,
							frozenColumns : [ [ {
								field : 'id',
								checkbox : true
							} ] ],
							columns : [ [
									{
										field : 'title',
										title : '标题',
										width : 100,
										align : 'center'
									},
									{
										field : 'creatTime',
										title : '时间',
										width : 100,
										align : 'center',
										formatter : function(value, row) {
											return row.creatTime.substring(0, 10);
										}
									},
									{
										field : 'opt',
										title : '操作',
										width : 50,
										align : 'center',
										formatter : function(value, rec) {
											var btn = "<a class='editcls' style='height:23px' onclick='editRow("+rec.id+","+oid+")' href='javascript:void(0)'>编辑</a>";  
											return btn;
										}	
									}

							] ],
							pagination : true,
							rownumbers : true,
							onLoadSuccess : function(data) {
								$('.editcls').linkbutton({
									text : '首页显示',
									plain : true,
									iconCls : 'icon-edit'
								});
							}
						});
		
		$('#elist').datagrid('getPager').pagination({
			beforePageText : '第',// 页数文本框前显示的汉字
			afterPageText : '页    共 {pages} 页',
			displayMsg : '当前显示{to}条记录   共{total}条记录',
			onBeforeRefresh : function(pageNumber, pageSize) {
				$(this).pagination('loading');
				$(this).pagination('loaded');
			}
		});
	}
	function zhiding(cid,id){
		$.ajax({
					type : "POST",
					url : "ajaxe_zhiding",
					async:false,
					data :{id:id,cid:cid},
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) {
							alert("设置成功");
						 window.location.reload();
					}
				});
	}
	
	function editRow(eid,oid){
			var msg = "要设置到首页吗？\n\n请确认！";
			if (confirm(msg) == true) {
				$.ajax({
					   type: "POST",
					   url: "ajaxe_exist",
					   data: {"id":eid},
					   success: function(msg){
						   var data=eval('('+msg+')');
						   if(data.count>0){
							   alert("该文章已经设置过");
						   }else if(data.entry.types==1){
							   alert("该文章是个下载文件");
						   }
						   else{
							   $.ajax({
								   type: "POST",
								   url: "ajaxe_edite",
								   data: {"id":oid,"cid":eid},
								   success: function(msg){
									  alert("设置成功");
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
</script>
</head>
<body>
	<br>
	<br>
	<div align="center" id="Layer1">
		<p>&nbsp;</p>
		<table id="tab" border="0" rules="none" width="100%">
			<tr>
				<td height="32" width="480">
					<h3>标题</h3>
				</td>
				<td width="99"><h3>日期</h3></td>
				<td width="43"><h3>操作</h3></td>
			</tr>
			<s:iterator value="rows" var="l">
				<tr>
					<td width="480" height="32" align="left"
						onmouseover="CrtTitle(this)"><a>${l.title}</a></td>
					<td width="99"><s:date name="#l.creatTime" format="yyyy-MM-dd" /></td> 
					<td width="43" align="center">
					<%-- <a onclick="del(${l.id})"><img src="${ctx}/images/delete.gif" border="0" alt="删除"></a> --%>
					<s:if test="%{#l.indexs.orders==0}"> <a onclick="zhiding(${cid},${l.indexs.id})">置顶</a></s:if>
					<s:else>
					&nbsp;&nbsp;&nbsp;&nbsp;
					</s:else>
					<a onclick="queryUserx(${cid},${l.id})"> <img src="${ctx}/images/edit.gif" border="0" alt="设置"></a></td>
				</tr>
			</s:iterator>
		</table>
		<div id="dlg" class="easyui-dialog"
			style="width: 780px; height: 480px;; padding: 10px 20px;"
			closed="true" buttons="#dlg-buttons">
			<div id="elist"></div>
		</div>
		<div id="dlg-buttons">
				<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
		</div>

	</div>
</body>
</html>
