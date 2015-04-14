<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%pageContext.setAttribute("ctx", request.getContextPath());%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css"> 
<!--
body {
	background-image: url(images/busl.jpg);
}
-->
</style></head>

<body style="border-color: transparent;">
<p>&nbsp;</p>
<p>&nbsp;</p><p>&nbsp;</p>
<table width="191" height="36" border="0">
  <tr>
    <td><div align="center"><a href="${ctx}/Record_list" target="showframe">查询所有公告</a></div></td>
  </tr> 
</table>
<table width="194" height="52" border="0">
  <tr>
    <td width="184"><div align="center"><a href="${ctx}/Record_list1" target="showframe" >查询所有记录</a></div></td>
  </tr>
</table> 
<table width="192" height="44" border="0">
  <tr>
    <td><div align="center"><a href="{ctx}/Route_list" target="showframe">查询所有线路</a></div></td>
  </tr>
</table>
</body>
</html>
