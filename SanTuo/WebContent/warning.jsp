<%@page import="com.sitemap.util.TimeTool"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'yujing.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
 	<%@include file="../common/public2.jsp"%>
	<link rel="stylesheet"  href="mapcss/ControlsUtil.css" />
	 <!--画点、线、面、圆工具样式文件-->
	<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" /> 
    <!--弹出框样式文件-->
	<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
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
 	<script src="My97DatePicker/WdatePicker.js"></script>
 	<link rel="stylesheet" href="js/ztree/css/zTreeStyle/zTreeStyle.css" />
		<script type="text/javascript" src="js/ztree/jquery.ztree.all-3.5.js"></script>
 	<script type="text/javascript">
 		$(function(){
 			loadMap(null);
 		});
 		//画多边形
 	 function drawduobianxing(){
	 	drawRect(3,false,2);
	 }
	 	//画圆
	 function drawyuan(xry){
	 	drawRect(1,false);
	 }
	   //画矩形
	 function drawjuxing(){
	 	drawRect(2,true);
	 }
	 function getRectInforDuouianXing(xys){//多边形
			$("#duobianxinglng").val(xys);
			document.getElementById("right_show").style.display="block";
			showinfo();
			$("#xingzhuang").val("多边形");
	 }
	 function getRectInfor(xys){//矩形
		$("#juxinglng").val(xys);
		document.getElementById("right_show").style.display="block";
		showinfo();
		$("#xingzhuang").val("矩形");
	}
	 function right_show(){
			document.getElementById("right_show").style.display="block";
	}
	 function right_show_none(){
			document.getElementById("right_show").style.display="none";
	}
	 function showDiv( ) 
     { 
     	document.getElementById("username").style.display = "block"; 
     } 
     //隐藏层 
     function hiddenDiv(divName) 
     { 
     	document.getElementById("username").style.display = "none"; 
     } 
	
	function showinfo(){
			 $("#myModal").show();
					 right_show();
	}
	//这个地方就是添加预警信息，主要跟APP对接查看是否有画范围 ，如果有就直接更新
	function addYuJingInfo(){
	if(confirm("如果存在报警区域将更新坐标点")){
		var xingzhuang=$("#xingzhuang").val();
		var areaType=1;
		var bianliang="";
		if(xingzhuang=="多边形"){
			areaType=1;
			bianliang=$("#duobianxinglng").val();//获取画圈的范围值
		}else if(xingzhuang=="矩形"){
			areaType=2;
			bianliang=$("#juxinglng").val();
		}
		var starttime=$("#starttime").val();
		var endtime=$("#endtime").val();
		var otherid=getOtherid();
		if(!jqCheckTime($("#starttime").val(),$("#endtime").val())[0]){
			alert(jqCheckTime($("#starttime").val(),$("#endtime").val())[1]);
		}else{
			$.ajax({
				type : "POST",
				url :getval("root")+"/warn/addwarn",
				async:false,
				data :{starttime:starttime,endtime:endtime,otherid:otherid,lnglat:bianliang,areaType:areaType},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
				alert("成功");
				right_show_none();
				}
			});

		}
	}
}
</script>
  </head>
  <!-- 
  	  
   -->
  <body>
  	    <input type="hidden" id="duobianxinglng" name="duobianxinglng" />
  	    <input type="hidden" id="juxinglng" name="juxinglng" />
  	    <input type="hidden" id="xingzhuang" name="xingzhuang"/>
  	     
	  <div style="height: 100%;width:100%; border: 1px solid #ccc;position: absolute;  ">
            <div style="width:100%; height:600px; border:0px solid #ccc;" >
            	<div style="position:relative;border:0px solid #ccc; float:left; width:100%;height:550px; ">
            		 <%@ include file="MyJsp.jsp"%> 
                </div>
                
                <div id="right_show" style="position:absolute;z-index:30;width:300px; height:509;right:0px;top:23px;border: 1px solid #15a9c7; display:none;background: #fff;margin-top: 20px;overflow: auto;">
                	 <div style="border-bottom: 0px solid #ccc; width: 280px;margin-top:0; font-size: 16px;"><b><font  color="red">画定报警区域人员信息</font></b></div>
                	 <div class="form-group">
                	 <div id="addmapinfo"  > 
                	 			<ul id="treeDemo" class="ztree"></ul>
                	 </div>
                	 </div>
                	<div>
                		 <span style="color:#15a9c7">开始时间：</span><input type="text" id="starttime" name="starttime" class="Wdate"  
							style="cursor: pointer; width: 206px;border: 1px solid #15a9c7;margin-top: 20px;" readonly="readonly" value="<%=TimeTool.dataToStr(TimeTool.addMinutes(new Date(), -10), null)%>" size=21
							onClick="WdatePicker({startDate:'%y-%M-01',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>  
                	</div>
                	<div>
                		<span style="color:#15a9c7">结束时间：</span><input type="text" id="endtime" name="endtime" class="Wdate" 
							style="cursor: pointer; width: 206px;border: 1px solid #15a9c7;margin-top: 20px;" readonly="readonly" value="<%=TimeTool.getTimeForMat(null) %>" size=21
							onClick="WdatePicker({startDate:'%y-%M-01',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true}) "  />
                	</div> 
                	<div align="center">
	                	<input type="button" value="添加" onclick="addYuJingInfo();" style="background:#15a9c7;border:0px solid #15a9c7;color:#fff;font-size:16px;margin-top:15px;margin-right: 20px; " width="30px;">
	                	<input type="button" value="取消" onclick="right_show_none();" style="background:#15a9c7;border:0px solid #15a9c7;color:#fff;font-size:16px;margin-top:15px;margin-left: 20px;" width="30px;">
               		 </div>
                </div>
                <div id="right_show2" style="position:absolute;z-index:30;width:500px; height:509px;right:0px;top:23px;border: 1px solid #15a9c7; display:none;background: #fff;margin-top: 20px;overflow: auto;">
                	 <div style="border-bottom: 0px solid #ccc; width: 100%;margin-top:0; font-size: 16px;"><b><font  color="red">查看报警区域</font></b><b style="float: right;right: 15px;cursor: pointer;" onclick="warn_div_close(2)"><font  color="red">X</font></b></div>
                	 <table class="table table-hover table-condensed">
                		 <tr>
                	 		<th>绘制人</th>
                	 		<th>报警时间</th>
                	 		<th>操作</th>
                	 	</tr> 
                	 	<c:forEach items="${draws}" var="c">
                	 	<tr id="draw_tr_${c.id}">
                	 		<td>${c.uname}</td>
                	 		<td>${c.startTime}-${c.endTime}</td>
                	 		<td><button class="btn btn-default" onclick="drawShow('${c.id}')">显示</button><button class="btn btn-default" onclick="warn_del_draw('${c.id}')">删除</button></td>
                	 	</tr>
                	 	</c:forEach>
                	 </table>
                </div>
                <div id="right_show3" style="position:absolute;z-index:30;width:300px; height:509px;right:0px;top:23px;border: 1px solid #15a9c7; display:none;background: #fff;margin-top: 20px;overflow: auto;">
                	 <div style="border-bottom: 0px solid #ccc; width: 100%;margin-top:0; font-size: 16px;"><b><font  color="red">报警区域人员</font></b><b style="float: right;right: 15px;cursor: pointer;" onclick="warn_div_close(3)"><font  color="red">X</font></b></div>
                	 <table id="warn_users_table" class="table table-hover table-condensed">
                		 
                	 </table>
                </div>
                
            </div>
	  </div> 
  </body>
  
<script src="page/queryUserForTree.js"></script>
  <script type="text/javascript">
 	$(function(){
 		$.ajax({
			type : "POST",
			url : getval("root")+"/au/queryUserForGroup",
			async:false,
			data :{},
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			success : function(data) {
				var html="";
				$.each(data,function(i,o) { 
					html+='<tr style="margin:10px">'+'<td width="120px;"> <input  onclick="area_checkCity(\''+i+'\')" type="checkbox" value="'+o.group+'" id="areacity'+i+'" >'+o.group+'</td><td>';
					$.each(o.user,function(e,d) {   
						html+='<div style="margin-left: 20px;float:left;"><input style="padding-left: 5px;"  onclick="area_checkDis(this,\''+i+'\')" name="areadis'+i+'" value="'+d.ID+'" type="checkbox">'+d.UNAME+'</div>';
					});
					html+='</td></tr><tr><td height="10px"> </td><td> </td></tr>';
						
				});
				//$("#addmapinfo").html(html);
			}
		});
 	});
 	function drawShow(id){
 		map.clearOverlays();
 		var bpoints=new Array();
 		//查询报警区域
 		$.ajax({
 					type : "POST",
 					url :getval("root")+"/warn/queryWaring",
 					data :{id:id},
 					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
 					success : function(data) {
 						var html="<tr><th>人员名称</th><th>操作</th></tr> ";
 						$.each(data.LNGLAT.split(";"),function(i,o) { 
 							bpoints.push(new BMap.Point(o.split(",")[0],o.split(",")[1]));
 						});
 						$.each(data.users,function(i,o) {
 							html+="<tr id='users_tr_"+o.USERID+"'><td>"+o.USERNAME+"</td><td><butten class='btn btn-default' onclick='warn_del_people(\""+o.USERID+"\")'>删除</butten></td></tr>";
						});
 						$("#warn_users_table").html(html);
 						$("#right_show2").toggle();
 						$("#right_show3").toggle();
 						var polygon = new BMap.Polygon(bpoints,{strokeColor:"blue", strokeWeight:2, strokeOpacity:0.5});  //创建多边形
 						 map.addOverlay(polygon);   //增加多边形
 						 map.setViewport(bpoints); 
 					}
 				});
 	}
 	function warn_del_draw(id){
 		map.clearOverlays();
 		ajaxFunction('warn/deleteDraw',{id:id},function(data){
 			$("#draw_tr_"+id).remove();
 		});
 	}
 	function warn_del_people(id){
 		ajaxFunction('warn/deletePeo',{id:id},function(data){
 			$("#users_tr_"+id).remove();
 		});
 	}
 	function warn_div_close(id){
 		map.clearOverlays();
 		$('#right_show'+id).toggle();
 	}
  </script>
</html>
