<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../common/public.jsp" %>
<script type="text/javascript" charset="utf-8" src="../ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" src="${cp}/js/bootstrap3-validation.js"></script> 
<style type="text/css">

</style>
<script type="text/javascript">

function submit(){
	$.ajax({
		type : "POST",
		url : "save",
		async:false,
		data :$("#mubiaoForm").serializeArray(),
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			if(data.judge){
				window.location.href="index";
			}else{
				alert("保存时出现异常");
			}
		}
	});	
}

function save(type){
	if(type==0){
		$("#mbSubmit").val(0);
		$.ajax({
					type : "POST",
					url : "../taskid",
					async:false,
					data :{id:$("#taskid").val()},
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) {
						var time=data.MBEND.replace("-", "年").replace("-", "月").replace(" ", "日").substring(0,11); 
						alertWins("submit","将临时保存为草稿，<br>请在"+time+"前提交。"); 
					}
				});
		
	}else{
		var b=true;
		var msg="";
		if(ue.getContentTxt()==""||ue.getContentTxt()=="请输入或粘贴工作目标正文"){
			b=false;
			msg="请填写工作目标的正文";
		}
		if($("#title").val()==""){
			b=false;
			msg="请填写工作目标的标题";
		}
		if(b){
			$("#mbSubmit").val(1);
			alertWins("submit","确定提交吗?提交后将不能修改。");
		}else{
			alertWin(msg);
		}
		
	}
}
</script>
<title>绩效考核系统</title>
</head>
<body>
	<%@include file="../common/head.jsp" %>
		<!-- Main --> 
		<div  style="float: left;height: 75%;width: 100%;position: relative;">
		
			<h4 id="atitle" style="margin-left: 5%;color: white;">为  <a href="${cp}/task/show?id=${task.id}">${task.title}</a>填写工作目标:</h4>
			<div style="float: left;height: 90%;width: 70%;padding-left: 9%">   
				<form id="mubiaoForm"  class="form-horizontal" method="post" style="width: 100%;height: 100%" target="_blank">
					<input type="hidden" id="taskid" name="t_id" value="${task.id}"> 
					<input type="hidden" name="id" value="${mubiao.id}">
					<input type="hidden" name="o_id" value="${org.id}">
					<input type="hidden" id="mbSubmit" name="commit" value="0">
					<input type="text" class="form-control" id="title" name="title" value="${mubiao.title}" placeholder="请输工作目标的标题">
						<hr>
						
					<script id="editor" type="text/plain" name="content" style="width:100%;height:80%;"><c:if test="${mubiao.content==''||mubiao.content==null}">请输入或粘贴工作目标正文</c:if>${mubiao.content}</script>					
				</form> 
				   
			</div>
			<div style="width: 15%;height: 80%;position:fixed;right: 5%;"> 
				<div onclick="yulan()" class="button buttonimg2"> 预览 </div>  
				<div onclick="save(0)" class="button buttonimg2 marginTop"> 保存 </div>  
				<div onclick="save(1)" class="button buttonimg3" style="position: absolute;bottom: 23%"> 提交 </div>  
				<div onclick="javascritp:history.go(-1)" class="button buttonimg2" style="position: absolute;bottom:15%"> 返回 </div>  
			</div>
		</div>	
	</div>
</div>
</body>
<!-- 弹窗 --> 
	<c:if test="${mubiao.content==''||mubiao.content==null}">
			<script type="text/javascript">
				var ue = UE.getEditor('editor',{
					autoClearinitialContent :true,
					autoHeightEnabled:false
				}); 
			</script>
	</c:if>
	<c:if test="${mubiao.content!=''}">
		<script type="text/javascript">
				var ue = UE.getEditor('editor',{
					autoHeightEnabled:false
					}); 
		</script>
	</c:if>
	<div id="bg"></div>
	<script type="text/javascript">
	$('input, textarea').placeholder();
	function yulan(){
		$("#mubiaoForm").attr("action","yulan");
		$("#mubiaoForm").submit();  
	}
	</script>
</html>
