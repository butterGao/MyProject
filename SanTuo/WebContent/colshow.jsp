<%@page import="com.sitemap.util.TimeTool"%> 
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'colshow.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page"> 
	<link rel="stylesheet"  href="mapcss/ControlsUtil.css" />
	 <!--画点、线、面、圆工具样式文件-->
	<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" /> 
    <!--弹出框样式文件-->
	<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
    <!--路况-->
    <link href="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.css" rel="stylesheet" type="text/css" />
    <script src="mapjs/jquery-1.7.1.js"></script> 
    <script src="mapjs/MapUtil.js"></script>
    <script src="mapjs/pageUtil.js"></script>
      <!--城市列表工具-->
    <script type="text/javascript" src="http://api.map.baidu.com/library/CityList/1.2/src/CityList_min.js"></script>
    <!--画点、线、面、圆工具JS文件-->
    <script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
    <!--弹出框JS文件-->    
    <script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
    <!--路况-->
	<script type="text/javascript" src="http://api.map.baidu.com/library/TrafficControl/1.2/src/TrafficControl_min.js"></script>
 	<script src="My97DatePicker/WdatePicker.js"></script>
 	<script type="text/javascript">
	 	$(function(){
	 		//baojing();
	 		loadMap(null);
	 		dingwei();
	 		
	 	});
 	 	
 	</script>
<script> 
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}
function dingwei(){
	var userid=getUrlParam("id");
	$.ajax({
				type : "POST",
				url :"/SanTuo/warn/dingwei",
				data :{id:userid},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					 var pt=new BMap.Point(data.LNG,data.LAT); 
					 var marker = new BMap.Marker(pt,{title:data.UNAME});  // 创建图标和标注 
					 map.addOverlay(marker);
				}
			});
}

	function showGuiJi(){
       		var userid=getUrlParam("id");
  			var starttime=$("#starttime").val();
  			var endtime=$("#endtime").val();
  			var polyline;  //创建折线
  			$.ajax({
						type : "POST",
						url :"/SanTuo/map/queryGPS",
						async:true,
						data :{userid:userid,starttime:starttime,endtime:endtime},
						contentType : 'application/x-www-form-urlencoded;charset=utf-8',
						success : function(data) {
							var array=[];
							$.each(data,function(i,o) {   
								 array.push(new BMap.Point(o.LNG,o.LAT));
							  	if(i==1){locationPointForSample('',o.LNG,o.LAT,3,null);}
							  	else if(i==data.length-1) {
								  	  locationPointForSample(o.UNAME,o.LNG,o.LAT,4,null);
								  	 }
							  	else{
							  		var icon=createIcon(6); 
								  	var marker = new BMap.Marker(new BMap.Point(o.LNG,o.LAT),{icon:icon});  // 创建图标和标注 
								 	 map.addOverlay(marker);
							  	}
							 	 //else{
							//	  locationPointForSample(o.UNAME,to.LNG,o.LAT,1,null);
							//	 } 
							});
							 polyline=  new BMap.Polyline(array, {strokeColor:"red", strokeWeight:3, strokeOpacity:2});
							 map.addOverlay(polyline);
							 map.setViewport(array); 
						}
					});
	}
</script>
  </head>
  <body>
  		<input type="hidden" value="" id="userid">
  		<input type="hidden" value="${point}" id="point">
  		  <div style="height: 99%;width:99%; border: 1px solid #ccc;position: absolute;  ">
   
        <div style="position:relative;border:0px solid #ccc; float:left; width:100%;height:600px; ">
        	 		<!--  地图布局开始  -->
                    <%@ include file="map.jsp"%> 
        	 </div>
       </div>

</body>
</html>
