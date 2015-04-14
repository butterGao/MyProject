<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<meta charset="utf-8" />
<%@include file="../common/public.jsp"%>
<script src='http://api.map.baidu.com/api?v=2.0&ak=Y1Hnz8WZaIDuiBjZFL4khydo'></script>
</head>
<body style="background-color: white;">
	<div class="modal fade" id="myModal" tabindex="-1" style="z-index: 99999" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   		<div class="modal-dialog">
     		 <div class="modal-content">
       			  <div class="modal-header">
			            <button type="button" class="close"  data-dismiss="modal" aria-hidden="true">
			                  &times;
			            </button>
		            <h4 class="modal-title" id="myModalLabel">
		               		签到位置
		            </h4>
        		 </div>
	         	 <div class="modal-body">
	        	 	<div id="dingwei_map" style="height: 400px">
	        	 	
	        	 	</div>
	        	 </div>
      		</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>						
							<table id="grid-table"></table>

							<div id="grid-pager"></div>

								
</body>
<script src="page/qiandao.js"></script>
<script type="text/javascript">
var map =null;
$(function(){
 map = new BMap.Map("dingwei_map");  // 创建Map实例
	map.centerAndZoom("上海",15);
	map.enableScrollWheelZoom(true); 
});
function dingwei(lat,lng){
	map.clearOverlays();
	var point = new BMap.Point(lat,lng);
	var marker = new BMap.Marker(point);
	map.addOverlay(marker);
	map.centerAndZoom(point,12); 
	$("#myModal").modal("show");
}
</script>
</html>
