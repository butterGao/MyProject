<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8" isELIgnored="false" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../common/public.jsp" %>
<style type="text/css">
	.plan{
		margin-left:1%;
		float: left;
		cursor: pointer;opacity: 0.7;
	 	height: 32%;
	 	width: 49%;
	}
	.plan:HOVER{
	opacity:1;
	}
	
	.plan.b{
		height: 33%;
		width: 24%;
	}      
    
    .left td{
        padding-left:5px;
        padding-right:5px;
        cursor: pointer;
        color:white;
          opacity: 0.8;
    }
     .left td:HOVER{
     		opacity: 1;
     }
    .small-square{
        width:16px;
        
        height:16px;
        
        margin-left:20px;
        
        float:left;
        
        cursor: pointer;
        
        background-image: url("${cp}/images/elip_2.png");
    }
    
    .sel{
        background-image: url("${cp}/images/elip_1.png");
    }

</style>
<script type="text/javascript">
var index = 0;

var cur = 0;

var max = 3;
function scrollNext(){
    if(cur < max - 1){
        cur ++ ;
        scrollDiv();            
    }
    
}

function scrollPrev(){
    if(cur > 0){
        cur -- ;
        scrollDiv();
    }
}

function scrollDiv(){
    $("#scrollDiv").animate({scrollLeft: cur *$("#plan1").width()},"slow");
}

function selP(i){
    $(".small-square").removeClass("sel").eq(i).addClass("sel");
    
    cur = i;
    
    scrollDiv();
}

$(function(){
    selP(0);
});

function tiaozhuan(id){
	if($("#type").val()=='null'){
		location.href="show?id="+id;
	}else{
		location.href=$("#url").val()+"/"+$("#type").val()+"/index?type="+id+"&id="+id;
	}
}

</script>


<title>绩效考核系统</title>
</head>
<body>
    <%@include file="../common/head.jsp" %>
        <!-- Main -->   
        <div style="padding-top:5%; width: 880px; height: 450px;overflow: hidden;;margin: auto;position: relative;" id="scrollDiv">
            <div id="scrollContainer" style="width:300%;height: 90%">
            <input id="type" type="hidden" value="${type}">
            <input id="url" type="hidden" value="${cp}"> 
            	
               <c:forEach  items="${lists}" var="t" varStatus="s">
               	<c:if test="${(s.index)%8==0}">
               	<!--width:calc(100%/3)  -->
               		<div  id="plan1" style="width:33.333333333333%;height:90%;float: left;">  
         			<div style="float: left;width: 84%;height: 100%">
         			
               	</c:if>
              
               	<div onclick="goUrl('show?id=${t.id}')" class="plan <c:if test="${(s.index%8)>3}">b</c:if>" style="
               	background-color: <c:if test="${(s.index%8)==0}">#2b94f0</c:if><c:if test="${(s.index%8)==1}">#e89504</c:if><c:if test="${(s.index%8)==2}">#3eaa09</c:if><c:if test="${(s.index%8)==3}">#06a8db</c:if>
               	 				  <c:if test="${(s.index%8)==4}">#ad50d9</c:if><c:if test="${(s.index%8)==5}">#2b94f0</c:if><c:if test="${(s.index%8)==6}">#3eaa09</c:if><c:if test="${(s.index%8)==7}">#06a8db</c:if>
               	;margin-bottom: 1%;color: white;"> 
               			<div style="height: 10%"></div>
             	    	<div id="title1" style="font-size:large; ;width: 100%;overflow: hidden;height: 40%;text-indent:2px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"> 
             	    		${t.title}
             	    	</div> 
             	    	<div style="height: 30%"></div>
             	    	<div id="time1" style="width: 100%;overflow: hidden;height: 20%;text-align: right;">${fn:substring(t.create_time,0,10)}</div>
             	</div>
               	
               	
               	<c:if test="${(s.index)%8==7}">
               		</div>
               		<div onclick="goUrl('edit')" class="button" style="float: right;width:15%;height: 99%;background-image: url('${cp}/images/tb1.png');"> <p style="font-size: 20px;">新建</p></div>
       	    		</div>
               	</c:if>
                </c:forEach>
                <c:if test="${size%8!=0}"> 
               		 </div>
               			<div onclick="goUrl('edit')" class="button" style="float: right;width:15%;height: 99%;background-image: url('${cp}/images/tb1.png');"><p style="font-size: 20px;">新建</p> </div>
       	    		</div>
                </c:if>
                  <c:if test="${size==0}"> 
                  <div  id="plan1" style="width:33.333333333333%;height:90%;float: left;">  
         			<div style="float: left;width: 84%;height: 100%">
               		 </div>
               			<div onclick="goUrl('edit')" class="button" style="float: right;width:15%;height: 99%;background-image: url('${cp}/images/tb1.png');"><p style="font-size: 20px;">新建</p> </div>
       	    		</div>
                </c:if>
            </div>
        </div>
    	<div style="margin-left:45%;position: relative;">
          	<div class="small-square" onclick="selP(0)"></div>
           <c:if test="${size>8}">
      			 <div class="small-square" onclick="selP(1)"></div>
           </c:if>	
           <c:if test="${size>16}">
            	<div class="small-square" onclick="selP(2)"></div>
           </c:if>
        </div>
         <%-- <div style="margin-left:80%;">          
         <div title="返回" onclick="goUrl('${cp}')" class="button" style="width:50%;height:50px;background-image: url('${cp}/images/back.png');filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${cp}/images/back.png', sizingMethod='scale');">
         	 
         </div>
        </div> --%>
        <div style="width: 880px;margin: auto;position: relative;" >     
         <div onclick="goUrl('${cp}')" class="button buttonimg2" style="width:15%;float:right;"> 返回 </div>        
        </div>
   </div>
</div>
</body>
</html>