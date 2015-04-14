// JavaScript Document
var lastSubmitDateTime=0;
var lastShowMapCityName="";
var currentCheckNameByUserCity=null;
$(function(){
	var cityName=$("#checkMapPositionByCityName").val();
	alert(cityName);
	if(cityName!=null && cityName!="" && cityName!="null" && typeof(cityName)!="undefined"){		
		currentCheckNameByUserCity=cityName.split(",");
		window.setTimeout("checkMapPosition()",3000); //开启位置区域监控
	}
})

function checkMapPosition(){
	map.addEventListener("tilesloaded",checkMapPosition_more); 
}

//检测范围（多城市）
function checkMapPosition_more(){
	var currentSubmitTime=new Date().getTime();
	if(lastSubmitDateTime>0 && (currentSubmitTime-lastSubmitDateTime)<3000) return false;
	lastSubmitDateTime=currentSubmitTime; 
	var pt=map.getCenter();
	var geoc = new BMap.Geocoder();
	geoc.getLocation(pt, function(rs){
		try{
			var addComp = rs.addressComponents;
			if(addComp){
				var codeProvince=addComp.province;
				var codeCity=addComp.city;
				var isInArea=checkIsInOwerCity(codeCity,codeProvince);  
				if(!isInArea){ 
					var IndexCityName=currentCheckNameByUserCity[0];
					if(lastShowMapCityName!=""){
						IndexCityName=lastShowMapCityName;
					}else{
						lastShowMapCityName=IndexCityName;
					}
					$(".switchCityContent").html(IndexCityName);
					map.centerAndZoom(IndexCityName, (parseInt(zoom)-0));  // 初始化地图,设置中心点坐标和地图级别	
				}else{
					lastShowMapCityName=codeCity;
				}
			}
		}catch(e){
			//alert("地址反编码失败");
		} 
	});
}

//检测当前城市是否存在于用户有权使用的城市列表中
function checkIsInOwerCity(codeCity,codeProvince){
	if(currentCheckNameByUserCity==null) return true;
	var isInArea=false;
	for(var i=0;i<currentCheckNameByUserCity.length;i++){
		var cCity=currentCheckNameByUserCity[i]; 
		if(codeCity!="" && codeCity!=null && codeCity!="null" && typeof(codeCity)!="undefined"){
			if(startWith(cCity,codeCity) || startWith(codeCity,cCity)){
				isInArea=true;
				break;
			}
		}
		if(codeProvince!="" && codeProvince!=null && codeProvince!="null" && typeof(codeProvince)!="undefined"){
			if(startWith(cCity,codeProvince) || startWith(codeProvince,cCity)){
				isInArea=true;
				break;
			}
		} 
	}
	return isInArea;
}

//无权使用提示
function alertStrFunc(typePFlag){
	map.clearOverlays();
	var deValue="";
	if(typePFlag=="index"){
		try{deValue=document.getElementById("searchContentText").defaultValue;}catch(e){deValue=""}
		$("#searchContentText").val(deValue);
		$("#searchContentText").attr("lang",""); 
	}else if(typePFlag=="jingzheng"){ 
		try{
			deValue=window.frames["iframe_left_type"].document.getElementById("searchContentText").defaultValue;
		}catch(e){deValue=""}
		$(window.frames["iframe_left_type"].document).find("#searchContentText").val(deValue);
		$(window.frames["iframe_left_type"].document).find("#searchContentText").attr("lang",""); 	
	}
	alert("对不起,您没有使用该地域的权限!");
}

//检测当前位置是否在规定的地图范围内（单个城市）
function checkMapPosition_less(){
	var name=currentCheckNameByUserCity;
	if(name=="" || name=="null" ||name==null || typeof(name)=="undefined") return false;
	//1.查找行政区划
	var bdary = new BMap.Boundary();
	bdary.get(name, function(rs){       //获取行政区域
		var count = rs.boundaries.length; //行政区域的点有多少个
		if(count<=0){
			alert("查询该城市区域失败");	
			return false;
		}
		var ply = new BMap.Polygon(rs.boundaries[0]); //建立多边形覆盖物
		//2.获得当前地图中心点
		//var cpt=map.getCenter();
		//var isIn=BMapLib.GeoUtils.isPointInPolygon(cpt,ply);
		//获得该多边形的bound
		var bounds=ply.getBounds();
		try {	
			BMapLib.AreaRestriction.setBounds(map, bounds);
		}catch(e){
			alert("添加地图区域控制失败");
		}
	});   
}
