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
	left: 211px;
	top: 576px;
}
</style>

<%@include file="public.jsp"%>

<div align="center" id="Layer1">
	<s:form name="form1"  action="Count_count" theme="simple">
			<table width="456" border="1" style="border-collapse: collapse;">
		<tr ><h2>更新统计</h2>
		<td>查询更新时间段:
		<s:textfield name="date1"
							onclick="new Calendar().show(this);" />
						
							<s:textfield name="date2"
							onclick="new Calendar().show(this);" />
							
					<s:submit  value="提交"></s:submit>
		</td>
		</tr>
	</table>
	</s:form>


<div >
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>更改站点数  ：${st}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>&nbsp;</p>
<p>更新线路数 ：${cr}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>	
</div>

</body>
</html>