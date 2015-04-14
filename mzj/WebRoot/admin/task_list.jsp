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

</script>


<title>绩效考核系统</title>
</head>
<body>
    <%@include file="../common/head.jsp" %> 
        <!-- Main -->     
        <div style="height: 6%;"></div>    
        <div style="width: 880px; height: 450px;;overflow: hidden;;margin: auto;position: relative;padding-top: 30px;" id="scrollDiv">
            <div id="scrollContainer" style="width:300%;height: 400px">  
            <input id="type" type="hidden" value="${type}">
            <input id="url" type="hidden" value="${cp}"> 
            	<!-- 框 -->
<%--              	<div  id="plan1" style="width:calc(100%/3);height:90%;float: left;">   
             	<!-- 所有任务 -->
             		<div style="float: left;width: 85%;height: 100%">
             		       <div class="plan a" style="background-color: #2b94f0;">
             	    	   			<div id="title1" style="width: 100%;overflow: hidden;height: 20%">${task[0].title}</div>
             	    	   			<div id="content1" style="width: 100%;overflow: hidden;height: 60%;margin-left: 10%"> &nbsp nbsp</div>
             	    	   			<div id="time1" style="width: 100%;overflow: hidden;height: 20%;text-align: right;">a</div>
             	    	   </div>
             	    	   <div class="plan a" style="background-color: #e89504;">
             	    	   
             	    	   </div>
             	    	   <div class="plan a" style="background-color: #06a8db;margin-top: 1%">
             	    	   
             	    	   </div>
             	    	   <div class="plan a" style="background-color: #2b94f0;margin-top: 1%">
             	    	   
             	    	   </div>
             	    	   <div class="plan b" style="background-color: #ad50d9;margin-top: 1%">
             	    	   
             	    	   </div>
             	    	   <div class="plan b" style="background-color: #2b94f0;margin-top: 1%">
             	    	   
             	    	   </div>
             	    	   <div class="plan b" style="background-color: #3eaa09;margin-top: 1%">
             	    	   
             	    	   </div>
             	    	   <div class="plan b" style="background-color: #06a8db;margin-top: 1%">
             	    	   
             	    	   </div>
             	    </div>
             		<div class="button" style="float: right;width:14%;height: 99%;background-image: url('${cp}/images/tb1.png');"> </div>
                </div> --%>
               <c:forEach  items="${task}" var="t" varStatus="s">
               	<c:if test="${(s.index)%8==0}">
               	<!--width:calc(100%/3)  -->
               		<div  id="plan1" style="width:33.333333333333%;height:90%;float: left;">  
         			<div style="float: left;width: 84%;height: 100%">
         			
               	</c:if>
              
               	<div onclick="goUrl('show?id=${t.id}&over=${t.over}')" class="plan <c:if test="${(s.index%8)>3}">b</c:if>" style="
               	background-color: <c:if test="${(s.index%8)==0}">#2b94f0</c:if><c:if test="${(s.index%8)==1}">#e89504</c:if><c:if test="${(s.index%8)==2}">#3eaa09</c:if><c:if test="${(s.index%8)==3}">#06a8db</c:if>
               	 				  <c:if test="${(s.index%8)==4}">#ad50d9</c:if><c:if test="${(s.index%8)==5}">#2b94f0</c:if><c:if test="${(s.index%8)==6}">#3eaa09</c:if><c:if test="${(s.index%8)==7}">#06a8db</c:if>
               	;margin-bottom: 1%;color: white;">      
               	<c:if test="${t.over==0}"><div class="tubiao chang" style="height:21%;background-color: red;" >新</div></c:if>
               			<div style="height: 10%"></div>  
             	    	<div id="title1" style="font-size:large; ;width: 100%;overflow: hidden;height: 40%;text-indent:2px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"> 
             	    		${t.title}
             	    	</div>  
             	    	<div style="height: 20%"></div>
             	  		  <c:if test="${t.over==1}"><div style="height: 10%"></div></c:if>
             	    	<div id="time1" style="width: 100%;height: 20%;text-align: right;">${fn:substring(t.create_time,0,10)}</div>
             	</div>
               	
               	
               	<c:if test="${(s.index)%8==7}">
               		</div>
               		<c:if test="${type=='null'}"><div onclick="goUrl('edit')" class="button" style="float: right;width:15%;height: 99%;background-image: url('${cp}/images/tb1.png');"><p style="font-size: 20px;">新建</p>  </div></c:if>
       	    		</div>
               	</c:if>
                </c:forEach>
                <c:if test="${size%8!=0}"> 
               		 </div>
               			<c:if test="${type=='null'}"><div onclick="goUrl('edit')" class="button" style="float: right;width:15%;height: 99%;background-image: url('${cp}/images/tb1.png');"><p style="font-size: 20px;">新建</p> </div></c:if>
       	    		</div>
                </c:if>
                <c:if test="${size==0}">
		         <c:if test="${type=='null'}">      
		         			<div  id="plan1" style="width:33.333333333333%;height:90%;float: left;">  
		         			<div style="float: left;width: 84%;height: 100%">
		                 	</div>
		               			<c:if test="${type=='null'}"><div onclick="goUrl('edit')" class="button" style="float: right;width:15%;height: 99%;background-image: url('${cp}/images/tb1.png');"><p style="font-size: 20px;">新建</p>  </div></c:if>
		       	    		</div>
		       	  </c:if>
		       	   <c:if test="${type!='null'}"> 
		       				<c:choose>
								<c:when test="${type=='count'}">  
									<h3 style="color: white;">暂无考评结果公布</h3>
								</c:when>
							   <c:otherwise> 
							   <h3 style="color: white;"> 您现在没有要处理的任务>></h3>
							   </c:otherwise>
  							</c:choose>
		       	   		  
		       	   </c:if>
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
        <div style="margin: auto;position:absolute;top: 80%;right: 22%;" >    
         	<div onclick="goUrl('${cp}')" class="button buttonimg2" style="width:150px;float:right;"> 返回 </div>        
        </div>
   </div>    
</div>
</body>
</html>