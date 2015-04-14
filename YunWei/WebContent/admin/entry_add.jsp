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
<title>Insert title here</title>
<style>
		</style>
		<script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
		<link rel="stylesheet" href="${ctx}/plugins/code/prettify.css" />
		<link rel="stylesheet" href="${ctx}/themes/default/default.css" />
		<script charset="utf-8" src="${ctx}/kindeditor-min.js"></script> 
		<script charset="utf-8" src="${ctx}/js/zh_CN.js"></script> 
		<script charset="utf-8" src="${ctx}/plugins/code/prettify.js"></script>
		<script>
		KindEditor.ready(function(K) { 
			var editor1 = K.create('textarea[id="content"]', {
				cssPath : '${ctx}/plugins/code/prettify.css', 
				uploadJson : '${ctx}/admin/upload_json.jsp',
				fileManagerJson : '${ctx}/admin/file_manager_json.jsp',
				allowFileManager : true,
				afterBlur:function(){this.sync()},
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
				}
			}); 
			prettyPrint();
		});
		
		/*function via(){
		 var a=$("#content").val();
			if(a.length>465000){
				alert("编辑文字太多，请上传");
				return false;
			}
			return true;
		} */
	</script>
</head>
<body>
		<form name="example" method="post" onsubmit="return via()" action="${ctx}/admin/entry_add"> 
		<div style="display: none">
		<input type="text" name="cid" value="<%=request.getParameter("cid")%>"> 
		<input type="text" name="cg" value="<%=request.getParameter("cg")%>">
		</div>
		<s:hidden name="entry.path"></s:hidden>
		<s:hidden name="entry.creatTime"> </s:hidden>
		<s:hidden name="entry.categoryid"> </s:hidden>
		<div align="center">	<span style="color : #fffff;"><s:textfield style="text-align:center" name="entry.title" size="28"></s:textfield><font size="2" style="color: red;">(上传图请设置下图片大小)</font></span>
		<hr>
			<s:textarea id="content" name="entry.content" style="width:800px;height:400px;visibility:hidden;"></s:textarea>
			<input type="submit"  name="button" value="提交内容" />
		</form>
		</div>
		<s:debug></s:debug>
</body>
</html>
<%!
private String htmlspecialchars(String str) {
	str = str.replaceAll("&", "&amp;");
	str = str.replaceAll("<", "&lt;");
	str = str.replaceAll(">", "&gt;");
	str = str.replaceAll("\"", "&quot;");
	return str;
}
%>