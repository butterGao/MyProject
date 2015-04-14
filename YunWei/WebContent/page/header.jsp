<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="s" uri="/struts-tags"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
%>
<style>
td {
	border-bottom: #96BABE dashed 1px
}
.logimg{
margin-left: 108px;
margin-top: 20px;
}
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<div id="center">
		<div class="head1">
		<%-- <img align="left" class="logimg" src="${ctx}/images/logo.png"> --%>
		</div> 
		<div class="header"> 
			<div class="d1" style="background-image: url('../images/hdimg.png');"> 
				<div class="d11" id="shouye" style="margin-left: 70px;">   
					<a href="${ctx}/page/init" style="text-decoration: none;color: white;">首页</a><br />
					<a>HOME</a>
				</div>
				<div class="img1">
					<img src="${ctx}/images/line.png" />
				</div>
				<div class="d11" id="${c1.eng}">
					<a href="${ctx}/page/${c1.url}" style="text-decoration: none;color: white;">${c1.title}</a><br />
					<a>${c1.eng}</a>
				</div>
				<div class="img1">
					<img src="${ctx}/images/line.png" />
				</div>
				<div class="d11" id="${c2.eng}">
					<a href="${ctx}/page/${c2.url}" style="text-decoration: none;color: white;">${c2.title}</a><br />
					<a>${c2.eng}</a>
				</div>
				<div class="img1">
					<img src="${ctx}/images/line.png" />
				</div> 
				<div class="d11" id="${c3.eng}">
					<a href="${ctx}/page/${c3.url}" style="text-decoration: none;color: white;">${c3.title}</a><br />
					<a>${c3.eng}</a>
				</div>
				<div class="img1">
					<img src="${ctx}/images/line.png" />
				</div>
				<div class="d11" id="${c4.eng}">
					<a href="${ctx}/page/${c4.url}" style="text-decoration: none;color: white;">${c4.title}</a><br />
					<a>${c4.eng}</a>
				</div>
				<div class="img1">
					<img src="${ctx}/images/line.png" />
				</div>
				<div class="d11" id="${c5.eng}">
					<a href="${c5.url}" style="text-decoration: none;color: white;">${c5.title}</a><br />
					<a>${c5.eng}</a>
				</div>
				<div class="img1">
					<img src="${ctx}/images/line.png" />
				</div>
				<div class="d11" id="${c6.eng}">
					<a href="${ctx}/page/${c6.url}" style="text-decoration: none;color: white;">${c6.title}</a><br />
					<a>${c6.eng}</a>
				</div>
				<div class="img1">
					<img src="${ctx}/images/line.png" />
				</div>
				<div class="d11" id="${c7.eng}">
					<a href="${ctx}/page/${c7.url}" style="text-decoration: none;color: white;">${c7.title}</a><br />
					<a>${c7.eng}</a>
				</div>
				<div class="img1">
					<img src="${ctx}/images/line.png" />
				</div>
				<div class="d11" id="${c8.eng}">
					<a href="${ctx}/page/${c8.url}" style="text-decoration: none;color: white;">${c8.title}</a><br />
					<a>${c8.eng}</a>
				</div>
			</div>
		</div>
	</div>
