<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../titlevalue.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
</style>
<!-- <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=njDguoF26pwtrjdqQlYCaa9G"></script> -->
<title><%=titlename%></title>
<link rel="stylesheet" type="text/css" href="../css/common.css" />
<script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
<style type="text/css">
.boldhead {
	font-weight: bold;
	font-size: 24px;
	text-align: center;
	padding: 20px
}
.pichead {
	overflow: auto;
	height: 100px;
	width: 96%;
	font-size: 14px;
	font-weight: bold;
	margin: auto auto auto auto;
	border: 2px solid #0066CC;
	background: #FFFFFF;
	padding-top: 10px;
	padding-bottom: 10px;
}

.pichead li {
	float: left;
	margin: 5px;
	width: 400px;
}

.picview {
	width: 96%;
	text-align: center;
	background: #FFFFFF;
	height: 500px;
	overflow: hidden;
	margin-left: 22px;
	margin-top: 33px;
}

.picview img {
	width: 600px;
	cursor: move;
	margin: 15px;
	z-index: 1;
}

#contral {
	position: absolute;
	z-index: 10;
	left: 15px;
	top: 240px;
}

#contral img {
	width: auto;
	margin: auto;
	cursor: auto;
	width: 20px;
	border: 0px;
}

#contral ul {
	width: 88px;
}

#contral li {
	width: 26px;
	height: 26px;
	float: left;
	list-style: none;
}
</style>

	<script> 
	$(document).ready(function(e) {
	    $("#MAP a:eq(0)").css({"color": "black"});
		   $("#MAP a:eq(1)").css({"color": "white"}); 
	 });
	function pingbi(e){
		if (e&&e.preventDefault) { // Firefox     
	      e.preventDefault();     
	       e.stopPropagation();     
	} else { // IE 
		window.event.returnvalue=false;

	       // window.event.keyCode = -1;     
	       return false;     
	}     
	}
	function xiufu(e){
		if (e&&e.preventDefault) { // Firefox     
	      e.preventDefault();     
	       e.stopPropagation();     
	} else { // IE 
		window.event.returnvalue=true;
	       // window.event.keyCode = -1;     
	       return true;     
	}     
	}
	function mwEvent(e) 
	{ 
	pingbi(e);
	if (!e) e = window.event;
	//alert(e.keyCode);
	//if(e.preventDefault)e.preventDefault();
		//else e.returnvalue=false;
		//alert(e.keyCode);

	if ( e.wheelDelta <= 0 || e.detail > 0) {
		smallit();
	}else { 
		bigit();
	} 
	window.status=n; 


	} 
	function pbie(){
		document.onmousewheel= pingbi;
	}
	function xfie(){
		document.onmousewheel= xiufu;
	}
	//if(document.attachEvent){ 
	//document.attachEvent("onmousewheel",mwEvent); 
	//}else{ 
	//window.addEventListener("DOMMouseScroll", mwEvent, false); 
	//} 
	//window.onscroll=function(e){alert(window.event.keyCode);};
	

	function init(){

	var tt=document.getElementById("viewArea");
	tt.onmouseover=pbie;
	tt.onmouseout=xfie;
	if(tt.attachEvent){ 
	tt.attachEvent("onmousewheel",mwEvent); 
	}else{ 
	tt.addEventListener("DOMMouseScroll", mwEvent, false); 
	} 
	$("#p1").click(function() {
		$("#smap").css("height",600);
		$("#smap").css("width",500);
		$("a", this).css("color", "#F36");
		$("#p2 a").css("color", "#000");
		$("#smap").attr("src","../images/smap.jpg");
		$("#smapdiv").css("display","block");
		$("#picview").css("display", "none");
		changeImage("../images/hkmap.jpg");
	});
	$("#p2").click(function() {
		$("a", this).css("color", "#F36");
		$("#p1 a").css("color", "#000");
		$("#smap").attr("src","../images/spm.jpg");
		$("#smap").css("height",200);
		$("#smap").css("width",180);
		$("#smapdiv").css("display","block");
		$("#picview").css("display", "none");
		vv.scrollTop = 400;
		vv.scrollLeft = 400;
		changeImage("../images/pm.jpg");
		
	});
	}
	function show(){
		$("#smapdiv").css("display","none");
		$("#picview").css("display", "block");
	}
	</script> 
</head>
<body onload="init()">
	<div id="center">
		<%@include file="../page/header.jsp"%>
		<div
			style="width: 780px; height: 800px; background-color: #FFF; font-family: 宋体; font-size: 12px; margin: 0px 0px 0px 20px;">
			<div
				style="float: left; width: 120px; height: auto; background-color: #FFF; font-size: 14px; line-height: 150%; cursor: pointer; text-align: left;">
				<div
					style="border-bottom: 1px #003399 solid; background-color: #069; padding-left: 10px; color: white;">电子地图</div>
<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p1">
					<a style="text-decoration: none; color: #F36; font-size: 10pt">地图</a>
				</div>
				<div style="border-bottom: 1px #003399 solid; padding-left: 10px;"
					id="p2">
					<a style="text-decoration: none; color: #000; font-size: 10pt">厨房平面图</a>
				</div>

			</div>
			
			<div
				style="float: right; width: 600px; height: auto; background-color: #FFF; cursor: pointer;"
				id="content1">
				<div style="width: 100%; height: 44px;">
					<div style="float: right;">
						<div
							style="width: 200px; color: #06F; float: right; padding-top: 5px;">
							电子地图&nbsp;&bull;&nbsp;<b style="color: #000;"></b>
						</div>
					</div>
				</div>
			</div>
			<div id="smapdiv">
				<img onclick="show()" style="height: 600;width: 500" id="smap" src="../images/smap.jpg" 
				/>
			</div>
			<div id="picview" class="picview" style="display:none">
				<img src="../images/hkmap.jpg" alt="Moving" name="viewArea"
					id="viewArea" />
			</div>

		</div>
		<jsp:include page="foot.jsp"></jsp:include>
	</div>

</body>
</html>
<script language="javascript">
	var rate = 0.2;
	var pp = document.getElementById("viewArea");
	var vv = document.getElementById("picview");

	var ie = document.all;
	var nn6 = document.getElementById && !document.all;
	var isdrag = false;
	var y, x;
	var st, sl;

	function moveMouse(e) {
		if (isdrag) {
			var mouseX = nn6 ? e.clientX : event.clientX;
			var mouseY = nn6 ? e.clientY : event.clientY;

			vv.scrollTop = st + (y - mouseY);
			vv.scrollLeft = sl + (x - mouseX);
			//document.getElementById('mouseData').innerHTML = "x="+x+" y="+y+" x-mouseX="+(x-mouseX)+" y-mouseY="+(y-mouseY);
			return false;
		}
	}

	function initDrag(e) {
		var oDragHandle = nn6 ? e.target : event.srcElement;
		isdrag = true;
		x = nn6 ? e.clientX : event.clientX;
		y = nn6 ? e.clientY : event.clientY;
		st = vv.scrollTop;
		sl = vv.scrollLeft;

		document.onmousemove = moveMouse;
		return false;
	}
	pp.onmousedown = initDrag;
	pp.onmouseup = new Function("isdrag=false");

 	function bigit() {
		pp.style.height = pp.height * (1 + rate) + "px";
		pp.style.width = pp.width * (1 + rate) + "px";
	}
	function smallit() {
		pp.style.height = pp.height * (1 - rate) + "px";
		pp.style.width = pp.width * (1 - rate) + "px";
	}

	/* function realsize() {
		var newImg = new Image();
		newImg.src = pp.src;
		pp.style.height = newImg.height + "px";
		pp.style.width = newImg.width + "px";
	}
 */
	/* function clickMove(s) {
		if (s == "up") {
			vv.scrollTop = vv.scrollTop - 100;
		} else if (s == "down") {
			vv.scrollTop = vv.scrollTop + 100;
		} else if (s == "left") {
			vv.scrollLeft = vv.scrollLeft - 100;
		} else if (s == "right") {
			vv.scrollLeft = vv.scrollLeft + 100;
		}
	}
 */
	function changeImage(path) {
		pp.src = path;
		vv.scrollTop = 0;
		vv.scrollLeft = 0; 
	}
</script>

<!-- <script type="text/javascript">

// 百度地图API功能
var map = new BMap.Map("allmap");                        // 创建Map实例
map.centerAndZoom(new BMap.Point(121.51161,31.270213), 14);     // 初始化地图,设置中心点坐标和地图级别
map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
map.enableScrollWheelZoom();                            //启用滚轮放大缩小
map.addControl(new BMap.MapTypeControl());          //添加地图类型控件
map.setCurrentCity("虹口区");           // 设置地图显示的城市 此项是必须设置的
</script> -->
