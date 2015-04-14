<%@page import="com.saitu.model.Link"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
%>
<%@include file="../titlevalue.jsp"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titlename%></title>
<script type="text/javascript" src="${ctx}/js/jquery-1.7.1.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/common.css" />
<style>
tr {
	font-size: 16px;
}
 .float{
            width:200px;height:50px;background:red;
            z-index:100;right:2px;top:85px;
            position:absolute;visibility: visible;
        }

</style>

</head>
<body>
	<div style="height: 1800px;"></div>
	<DIV id="flow" onMouseOver="javascript:moveflow=0;"
		onMouseOut="javascript:moveflow=1;"
		style="LEFT: 350px; WIDTH: 400px; POSITION: absolute; TOP: 147px; HEIGHT: 163px; <!--background-color: #EFEFEF; layer-background-color: #EFEFEF; background-color:#7EF030; layer-background-color: #7EF030;  border: 1px none #000000; --> border:none; background-color:transparent; z-index:999; visibility:visible">
		<DIV align=left>
			<table border="0" width="400" height="163" cellspacing="0"
				cellpadding="0" style="border-collapse: collapse" bordercolor="blue">
				<tr height="10">
					<td><span id="guanbi"
						onclick='javascript:(document.getElementById("flow")).style.display="none";'><font
							color="black">关闭</font></span></td>
				</tr>
				<tr height="153">
					<td>
						<p align="center">
							<map name="FPMap1">
								<area onFocus="blur()" href="http://blog.csdn.net/wongleetion"
									target="_blank" shape="rect" coords="0,0,400,153" />

							</map>
							<img style="cursor: hand;" border="0" src="flyimage.jpg"
								width="400" height="153" usemap="#FPMap1" />
					</td>
				</tr>
			</table>
		</DIV>
	</DIV>



</body>
<script type="text/javascript">
	var xPos = 350;
	var yPos = 200;
	var step = 1;
	var delay = 30;
	var height = 0;
	var Hoffset = 0;
	var Woffset = 0;
	var yon = 0;
	var xon = 0;
	var pause = true;
	var interval;
	var moveflow = 1;
	flowE = document.getElementById("flow");
	flowE.style.top = yPos + "px";

	function changePos() {
		width = document.body.clientWidth;
		height = document.body.clientHeight;

		Hoffset = flowE.offsetHeight;
		Woffset = flowE.offsetWidth;
		flowE.style.left = (xPos + document.body.scrollLeft) + "px";
		flowE.style.top = (yPos + document.body.scrollTop) + "px";
		if (moveflow == 1) {
			if (yon) {
				yPos = yPos + step;
			}
			else {
				yPos = yPos - step;
			}
			if (yPos < 0) {
				yon = 1;
				yPos = 0;
			}
			if (yPos >= (height - Hoffset)) {
				yon = 0;
				yPos = (height - Hoffset);
			}
			if (xon) {
				xPos = xPos + step;
			}
			else {
				xPos = xPos - step;
			}
			if (xPos < 0) {
				xon = 1;
				xPos = 0;
			}
			if (xPos >= (width - Woffset)) {
				xon = 0;
				xPos = (width - Woffset);
			}
		}
	}

	function start() {
		flowE.style.visibility = "visible";
		//flowE.style.visibility = "hidden";
		interval = setInterval('changePos()', delay);
	}
	start();
</script>
</html>
