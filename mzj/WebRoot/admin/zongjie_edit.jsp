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
function del(){
	if(confirm("确认删除吗") == true){
		$.ajax({
					type : "POST",
					url : "del?id="+getval("id"),
					async:false,
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) {
						if(data){
							alert("删除成功");
							location.href="index";
						}else{
							alert("删除异常");
						}
					}
				});
	}
}
function update(){
	
}
function gomubiao(id){
	if(id==""){
		alertWin("您尚未提交工作目标");
	}else{ 
		window.open("../mubiao/show?id="+id);
		 
	}
}
function submit(){
	$.ajax({
		type : "POST",
		url : "save",
		async:false,
		data :$("#zhongjieForm").serializeArray(),
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			if(data.judge){
				window.location.href="index";
			}else{
				alertWin("保存异常");
			}
		}
	});	
}
function save(type){
	if(type==0){
		$("#zjSubmit").val(0);
		$.ajax({
					type : "POST",
					url : "../taskid",
					async:false,
					data :{id:$("#taskid").val()},
					contentType : 'application/x-www-form-urlencoded;charset=utf-8',
					success : function(data) {
						var time=data.ZJEND.replace("-", "年").replace("-", "月").replace(" ", "日").substring(0,11); 
						alertWins("submit","将临时保存为草稿，<br>请在"+time+"前提交。"); 
					}
				});
		
	}else{
		var b=true;
		var msg=""
		if(ue.getContentTxt()==""||ue.getContentTxt()=="请输入或粘贴工作总结正文"){
			b=false;
			msg="请填写工作总结的正文";
		}
		if($("#title").val()==""){
			b=false;
			msg="请填写工作总结的标题";
		}
		if(b){
			$("#zjSubmit").val(1);
			alertWins("submit","确定提交吗?提交后将不能修改。");
		}else{
			alertWin(msg);
		}
		
	}
		
	
}
function yulan(){
	$("#zhongjieForm").attr("action","yulan");
	$("#zhongjieForm").submit();  
}
</script>
<title>绩效考核系统</title>
</head>
<body>
	<%@include file="../common/head.jsp" %>
		<!-- Main --> 
		<div  style="float: left;height: 75%;width: 100%;position: relative;">
			<h4 id="atitle" style="margin-left: 5%;color: white;">为  <a href="${cp}/task/show?id=${task.id}">${task.title}新任务</a>填写任务总结:</h4>
			<div style="float: left;height: 90%;width: 70%;padding-left: 9%">   
				<form id="zhongjieForm" class="form-horizontal"  method="post" style="width: 100%;height: 100%" target="_blank"   action="update">
					<input type="hidden" id="taskid" name="t_id" value="${task.id}">
					<input type="hidden" name="id" value="${zongjie.id}">
					<input type="hidden" name="o_id" value="${org.id}">
					<input type="hidden" id="zjSubmit" name="commit" value="0">
					<input type="text" class="form-control" id="title" value="${zongjie.title}" name="title" placeholder="请输入工作总结标题">
						<hr>
					<script id="editor" type="text/plain" name="content"   style="width:100%;height:80%;"><c:if test="${zongjie.content==''||zongjie.content==null}">请输入或粘贴工作总结正文</c:if>${zongjie.content}</script>					

				</form> 
				  
			</div>
			<div style="width: 15%;height: 80%;position:fixed;right: 5%;"> 
				<div onclick="gomubiao('${mubiao.t_id}')" class="button buttonimg2 ">查看工作目标 </div>  
				<div onclick="yulan()" class="button buttonimg2 marginTop"> 预览 </div>  
				<div onclick="save(0)" class="button buttonimg2 marginTop"> 保存 </div>  
				<div onclick="save(1)" class="button buttonimg3" style="position: absolute;bottom: 23%"> 提交 </div>  
				<div onclick="javascritp:history.go(-1)" class="button buttonimg2" style="position: absolute;bottom:15%"> 返回 </div>  
			</div>
		</div>	
   </div>
</div>	
</body>
<!-- 弹窗 --> 
	<c:if test="${zongjie.content==''||zongjie.content==null}">
			<script type="text/javascript">
				var ue = UE.getEditor('editor',{
					autoClearinitialContent :true,
					autoHeightEnabled:false
				}); 
			</script>
	</c:if>
	<c:if test="${zongjie.content!=''}">
		<script type="text/javascript">
			$('input, textarea').placeholder();
				var ue = UE.getEditor('editor',{
					autoHeightEnabled:false
					}); 
		</script>
	</c:if>
	<div id="bg"></div>
</html>
