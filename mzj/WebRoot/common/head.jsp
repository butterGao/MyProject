<%@ page language="java" contentType="text/html; charset=utf8" pageEncoding="utf8"%>
	
		<div id="backgroud"  style="background-image:url('${cp}/images/bg.png');background-size: 100% 100%;width:100%;min-width:1000px; 
		filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/bg.png', sizingMethod='scale');">
		
		<!-- 头部分 -->
			<div style="height: 4%;"></div>
			<div style="height: 10%;"> 
				<div id="hand" style="padding-right: 2%;" align="right" >
					<div class="lianjie"><a style="color: white;"> ${org.short_name} | </a><a style="color: white;">${users.user_name} | </a><a href="${cp}/users/logout" style="color: white;position: relative;"> 退出 </a></div>
				</div>
			</div>
			<div style="background-image:url('${cp}/images/bg2.png');background-size: 100% 100%;height:86%;
			">
				<div id="fanhuidiv" style="height: 4%;width:100%; ">
					<div style="float: left;width: 70%;"><h3 id="smalltitle" style="display: inline;padding-left: 10% "></h3>	</div>
					<div style="float: right;width: 20%">
						<%-- <img alt="" onclick="javascript:history.go(-1);" style="cursor: pointer;padding-left: 70%" src="${cp}/images/fanhui.png"> --%>
					</div>
				</div>
		