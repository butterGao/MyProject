<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../common/public.jsp" %>
<style type="text/css">

</style>
<script type="text/javascript">

function windowClose(){
	window.close();
}
</script>
<title>绩效考核系统</title>
</head>
<body>
	<%@include file="../common/head.jsp" %>
		<!-- Main --> 
		<div  style="float: left;height: 75%;width: 100%;position: absolute;" >
			<h3 id="h3title" style="margin-left: 5%;color: white;">您对自己处室的评分${t.over}</h3>
			<div style="float: left;width: 75%;padding-left: 5%;word-break:break-all;"> 
				<c:if test="${mubiao.title ==null}"><h4 align="center">尚未填写目标</h4>   </c:if>
				<c:if test="${mubiao.title !=null}"> 
					<h3 align="center">${mubiao.title}</h3>      
					<span > ${mubiao.content}</span>  
				</c:if>
			<hr>
			</div>
			<div style="float: left;width: 75%;padding-left: 5%;word-break:break-all;"> 
				<c:if test="${zongjie.title ==null}"><h4 align="center">尚未填写总结</h4>   </c:if>
				<c:if test="${zongjie.title !=null}"> 
					<h3 align="center">${zongjie.title}</h3>     
					<span > ${zongjie.content}</span>  
				</c:if>
			</div>
			<!-- 右边功能键 -->  
			    
			<div style="width: 15%;height: 70%;position:fixed;right: 5%;"> 
				<div style="bottom: 45%;position:absolute;">
					<div style="float: left;width: 40%;padding-top: 5px;padding-left: 5px;">分数：</div> 
					<div style="float: left;width: 50%">
						<form id="zpForm" action="ziping">
							<input type="hidden" name="t_id" value="${t_id}">
							<input id="fensu" readonly name="score" class="form-control" maxlength="3"  value="${score}"> 
						</form> 
					</div> 
				</div>
				<c:if test="${over==0}">
					<script type="text/javascript">
					$("#h3title").html("请为自己的处室评分");
					$("#fensu").removeAttr("readonly"); 
					</script>
					<div onclick="ziping()" class="button buttonimg3" style="bottom: 35%;position:absolute;"> 提交 </div>
				</c:if> 
				<div onclick="goUrl('goQueryAllXq?id=${t_id}')" class="button buttonimg2" style="bottom: 25%;position:absolute;"> 查看所有工作总结</div>
				<div onclick="javascript:history.go(-1)" class="button buttonimg2" style="bottom: 15%;position:absolute;"> 返回 </div>
			</div> 
		</div>  
  </div>
</div>
</body>
<script type="text/javascript">
$("#fensu").keyup(function () {
    //如果输入非数字，则替换为''，如果输入数字，则在每4位之后添加一个空格分隔
    this.value = this.value.replace(/[^\d]/g, '').replace(/(\d{4})(?=\d)/g, "$1 ");
     if( $("#fensu").val()>100)$("#fensu").val(100); 
});
function submit(){
	$.ajax({
				type : "POST",
				url : "ziping",
				async:false,
				data :$("#zpForm").serializeArray(),
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					if(data){ 
						alertWins("goUrl('index')","评分成功");
						$("alertClose").css("display","none");
					}else{
						alertWin("评分异常");
					}
				}
			});
}
function ziping(){
	alertWins("submit","提交后将不能修改!");
}
</script>
<!-- 弹窗 -->

	<div id="bg"></div>
		
</html>
