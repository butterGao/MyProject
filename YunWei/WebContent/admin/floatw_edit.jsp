<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
<link rel="stylesheet" type="text/css" href="../js/easyui.css">
<link rel="stylesheet" type="text/css" href="../js/icon.css">
<script type="text/javascript" src="../js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="../js/ChineseCalendar.js"></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../js/utilJs.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var struts =
<%=request.getAttribute("floatw.stutrs")%>
	if (struts == 1) {
			$("#struts").html("隐藏");
		} else {
			$("#struts").html("显示");
		}

	});
	$(function() {
		$("tr:even").addClass("s_oushuhang");//偶数行的背景色
		$("tr:odd").addClass("s_jishuhang");//奇数行的背景色
		$(".table_gehang").delegate("tr", "hover", function() {
			$(this).toggleClass("s_mouseover");
		});
	});
	(function($) {
		$.fn.file = function(_obj, _objHover, txt) {
			$(this).each(
					function(i, item) {
						//input[type=file]固定的样式
						$(this).css({
							position : "absolute",
							"z-index" : "1",
							width : "66px",
							overflow : "hidden",
							filter : "alpha(opacity=0)",
							opacity : "0",
							display : "none",
							height : "28px",
							cursor : "pointer"
						});
						var obj = _obj || "file_intv";
						var objHover = _objHover || "file_intv_hover";
						var text = (!txt) ? " " : txt;
						var $label = $("<label>" + text + "</label>");
						var _name = $(this).attr("name") == "" ? "upload" : $(
								this).attr("name");
						$label.insertBefore($(this)).attr("class", obj).attr(
								"for", _name);
						$label.mouseover(function(e) {
							$(this).removeClass().addClass(objHover);
							var _left = e.pageX - $(item).width() * 0.6;
							var _top = e.pageY - $(item).height() * 0.6;
							$(item).css({
								display : "block",
								left : _left,
								top : _top
							});
						});
						$(item).mouseout(function(e) {
							$label.removeClass().addClass(obj);
							$(item).css({
								display : "none"
							});
						});
						//传值
						$(this).change(function() {
							$label.val($(this).val());
						});
					});
		};
	})(jQuery);
	
	function edit(id){
		$.ajax({
			   type: "POST",
			   url: "ajaxf_show",
			   data:"id="+id,
			   success: function(msg){
				   var data=eval('('+msg+')');
				   $("#floatwinfo").val(data.floatw.info);
				   $("#floatwurl").val(data.floatw.urlone);
				   $("#floatwid").val(data.floatw.id);
				   $("#img1").attr("src",getroot()+"/upload/"+data.floatw.path);
				   $("#dlg").dialog("open").dialog('setTitle', '编辑');
				   $("#fm1").attr("action",getroot()+"/admin/floatw_update");
			   }
			});
	}
	function save() {
		$("#fm1").submit();
	}
	$(function() {
		$(".file_real").file();
	});
	function ons() {
		var st = $("#stutrs").val();
		if (st == 1) {
			$("#struts").html("显示");
		} else {
			$("#struts").html("隐藏");
		}
		$.ajax({
			   type: "POST",
			   url: "ajaxf_change",
			   success: function(msg){
				   var data=eval('('+msg+')');
				   $("#stutrs").val(data.floatw.stutrs);
				   alert($("#struts").html()+"!");
			   }
			});
	};
</script>
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

.file_intv {
	background: url(/YunWei/images/file.gif) no-repeat;
	width: 97px;
	height: 23px;
	cursor: pointer;
	display: inline-block;
	text-align: center;
	font-size: 12px;
	line-height: 23px;
}

.file_intv_hover {
	background: url(/YunWei/images/file.gif) -107px 0 no-repeat;
	width: 97px;
	height: 23px;
	cursor: pointer;
	display: inline-block
}
</style>
</head>
<body>
		<div id="dlg" class="easyui-dialog"
		style="width: 320px; height: 220px; padding: 10px 20px;" closed="true"
		buttons="#dlg-buttons">
		<form id="fm1" name="form1" method="post" action="${ctx}/admin/floatw_update"
			enctype="multipart/form-data">
			<s:hidden name="floatw.stutrs"></s:hidden>
			<input type="hidden" id="floatwid" name="floatw.id">
			<div class="fitem">
				<label> 描述 </label> <input id="floatwinfo" name="floatw.info"
					class="easyui-validatebox" required="true" />
			</div>

			<div class="fitem">
				<label>连接</label> <input id="floatwurl" name="floatw.urlone" class="easyui-vlidatebox"
				required="true" />
			</div>
			<div class="fitem">
				<label>图片</label> <input id="image1" type="file"
					 name="mgfile" /> 
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a  class="easyui-linkbutton" onclick="save()" iconcls="icon-save">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>


	<br>
	<h3 align="center" style="font-size: 15px">浮动窗口编辑</h3>
	<br>
	<s:form id="form1" action="floatw_update" enctype="multipart/form-data">
		<s:hidden name="floatw.id"></s:hidden>
		<s:hidden id="stutrs" name="floatw.stutrs"/>
		<table align="center" width="100%">
			<tr>
			<td><h3 style="font-size: 19px">图片</h3></td>
			<td><h3 style="font-size: 19px">连接</h3></td> 
			<td><h3 style="font-size: 19px">描述</h3></td>
			<td align="center"><h3 style="font-size: 19px">操作</h3></td>
			</tr>
			<tr>
			
				<!-- <td><input id="image1" class="file_real" size="1" type="file"
					name="mgfile" /></td> -->
				<td align="center"><img width="88" height="88"
					src="${ctx}/upload/${floatw.path}"></td>
				<td><input type="text" name="floatw.urlone"
					value="${floatw.urlone}"></td>
				<td><input type="text" name="floatw.info"
					value="${floatw.info}"></td></td>
				<td align="center">
				<a href="#"><img onclick="edit(1)"
							src="${ctx}/images/edit.gif" border="0" alt="详情"></a>
				<button id="struts" onclick="ons()"
						type="button" name="floatw.path"></button></td>
			</tr>
		</table>
	</s:form>
</body>
</html>
