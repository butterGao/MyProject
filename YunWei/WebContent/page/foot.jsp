<%@page import="com.saitu.model.Link"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
a {
	font-size: 12px;
}
.index_bottom {
    color: #999;
}
.index_bottom_rt ul li {
    color: #999;
    float: left;
    line-height: 20px;
}
.index_bottom_rt_copy {
	font-size:12px;
    width: 100%;
     color: #999;
    padding: 5px 10px;
    line-height: 18px;
}
.divs {
	text-align: center;
	width: 100%;
	background-color: #f1f1f1;
	font: 12px/1.7, 宋体, Verdana, Geneva, sans-serif;
}
.Footer{
background-color: #f1f1f1;
}
.zi{
	font-size: 12px;
	font:  宋体, Verdana, Geneva, sans-serif;
}
</style>
<script type="text/javascript">
	function addFavorite(url, title) {
		url = encodeURI(url);
		try {
			window.external.addFavorite(url, title);
		} catch (e) {
			try {
				window.sidebar.addPanel(title, url, "");
			} catch (e) {
				alert("加入收藏失败，请使用Ctrl+D进行添加,或手动在浏览器里进行设置.");
			}
		}
	}
</script>
</head>
<body>
	<div class="Footer" style="line-height: 18px; padding-top: 0px; height: auto; background: #fff; border: 2px solid rgb(208, 235, 255)">
<div class="divs" > 
	<a href="javascript:void(0)" > 联 系 我 们</a>&nbsp | &nbsp 
	<a onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('http://211.136.131.242:8087/YunWei');" href="javascript:;">设 为 首 页 </a> &nbsp|&nbsp
	<a href="Javascript:window.external.addFavorite('http://211.136.131.242:8087/YunWei','空口运维服务中心')"> 加 入 收 藏 夹 </a>&nbsp | &nbsp 
	<a href="javascript:void(0)" > 免 责 声 明</a>&nbsp | &nbsp 
	<a href="map.jsp" >  网 站 地 图</a> <br> 
	
	<a href="http://www.hkedu.sh.cn" target="_blank"> 虹口教育信息网</a>&nbsp | &nbsp 
	<a href="http://hkq.sh.gov.cn" target="_blank"> 区政府网</a>&nbsp | &nbsp 
	<a href="http://www.shmec.gov.cn" target="_blank"> 市装备部</a>&nbsp | &nbsp 
	<a href="http://www.zfcg.sh.gov.cn" target="_blank"> 市采购平台</a>&nbsp | &nbsp 
	<a href="http://www.jjsbglz.sjedu.cn" target="_blank"> 市教育基建</a>&nbsp | &nbsp 
	
	<div class="index_bottom_rt_copy">
                 <span>
                       版权所有: 上海市虹口区教育局 上海市虹口区教育信息中心&nbsp;&nbsp; 沪ICP备11034047号-1  &nbsp;&nbsp;邮政编码：200003&nbsp;&nbsp;电话：4008205307
<br />
                        Shanghai Municipal Education Commission Address: 100 Da Gu Road, Shanghai, China 200003<br/>
                 </span>
            </div>
	</div>  
</div>

</body>
</html>