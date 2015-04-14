<%@ page language="java" contentType="text/html; charset=utf8" pageEncoding="utf8"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../common/public.jsp" %>
<link rel="stylesheet" type="text/css" href="../js/datepicker3.css">
<script type="text/javascript" src="../js/bootstrap-datepicker.js"></script> 
<script type="text/javascript" charset="utf-8" src="../ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript">
function yulan(){
	$("#taskForm").submit();  
}
</script>
<title>绩效考核系统</title>
</head>
<body>
		<%@include file="../common/head.jsp" %>
		<!-- Main --> 
		<div  style="float: left;height: 90%;width: 100%">
			<h3 id="atitle" style="margin-left: 5%;color: white;">新增考核任务</h3>
		<div style="float: left;height: 90%;width: 70%;padding-left: 3%"> 
			<form class="form-horizontal" style="height: 100%" action="yulan" method="post"  id ="taskForm"  target="_blank">
			<div style="display: none;">
				<input type="hidden" id="file_content" name="file_content" value="${task.file_content}">
			</div>
			<input type="hidden" id="target_id" name="target_id" value="${task.target_id}">
			<input type="hidden" id="task_id" name="id" value="${task.id}">
			<input type="hidden" id="taskSubmit" name="commit" >
			<input type="hidden" id="orgs_id" name="orgs_id"  value="${task.orgs_id}">
			<input type="hidden" id="mbstart" name="mbstart" value="${task.mbstart}">
			<input type="hidden" id="mbend" name="mbend" value="${task.mbend}">
			<input type="hidden" id="zjstart" name="zjstart" value="${task.zjstart}">
			<input type="hidden" id="zjend" name="zjend" value="${task.zjend}">
			<input type="hidden" id="khstart" name="khstart" value="${task.khstart}">
			<input type="hidden" id="khend" name="khend" value="${task.khend}">
				<div class="form-group" style="height: 7%">  
				  	<label  class="col-sm-2 control-label">任务名称</label>
				    <div class="col-sm-10" style="height: 100%">
      					<input style="height: 100%" type="text" name="title" id="title" value="${task.title}" class="form-control"  placeholder="请输入新增考核任务的名称">
    				</div>
				  </div>
				  <div class="form-group" style="height: 7%">
				  	<label  class="col-sm-2 control-label">通知文件</label>
				    <div class="col-sm-10 " style="height: 100%">
      					<input style="height: 100%" onclick="showdiv('tzWin')" type="text" class="form-control" id="file_title" name="file_title" value="${task.file_title}" readonly placeholder="单击填写通知文件">
    				</div> 
				  </div>     
				  <div class="form-group" style="height: 75%">       
				  	<label class="col-sm-2 control-label">具体内容</label> 
				  	 <div class="col-sm-10" style="height:100%">   
				  	 
      					<script id="editor" name="content" type="text/plain" style="width:100%;height:89%;"><c:if test="${task.content==null}">再此填写或粘贴考核任务的相关文件正文</c:if>${task.content}</script>
    				</div>
				  </div>
				 
			</form> 
		</div>  
		<div style="width: 15%;height: 80%;position:fixed;right: 5%;"> 
			<div onclick="showdiv('zbWin')" class="button buttonimg2" style=""> 选择考评指标 </div>  
			<div onclick="showdiv('sxWin')" class="button buttonimg2" style="margin-top: 3%;"> 选择被考核的处室 </div>  
			<div onclick="showdiv('timeWin')" class="button buttonimg2" style="margin-top: 3%;"> 设置任务周期 </div> 
			<div onclick="yulan()" class="button buttonimg2" style="margin-top: 3%;"> 预览 </div> 
			<div onclick="save(0)" class="button buttonimg2" style="margin-top: 3%;"> 保存 </div> 
			<div onclick="save(1)" class="button buttonimg3" style="position: absolute;bottom: 23%"> 提交 </div>   
			<div onclick="javascript:history.go(-1)" class="button buttonimg2" style="position: absolute;bottom: 15%"> 返回 </div>   
		</div>
		 
		 
	</div>
	</div>
</body>
<!-- 弹窗 --> 
<div id="sxWin" style="padding-left: 1.5%;padding-top: 1%;" class="show">  
	<!-- <div style="padding-left: 3%;" class=" has-feedback">
		  <input type="text" class="form-control"  placeholder="搜索">
		  <span class="glyphicon glyphicon-search form-control-feedback"></span> 
	</div> -->  
	<div style="height: 88%;overflow: auto;">  
		<table style=""> 
			<c:forEach items="${orgs}" var="o" >
			<tr>
				<td> <input  type="checkbox"  <c:if test="${o.checked==1}"> checked="checked" </c:if>   name="sxChecked" id="che${o.id}" value="${o.id}">${o.short_name}</td>
			</tr>
			
			</c:forEach>
		</table>    
	</div>
		  <div onclick="check('0')" id="allc" class="button buttonimg1" style="float: left;width: 25%;position: absolute;bottom: 3%;left: 5%"> 全选 </div> 
		  <div onclick="showClose('sxWin')" class="button buttonimg1" style="float: left;width: 25%;position: absolute;bottom: 3%;left: 40%"> 确 定 </div> 
		  <div onclick="check('1')" class="button buttonimg1" style="float: left;width: 25%;position: absolute;bottom: 3%;left: 70%; "> 取 消 </div>  
</div>
<div id="zbWin"  class="show">
	<div style="height: 10%"></div>
	<div style="height: 78%;overflow: auto;">
	<table style="margin-left: 8%;">
		<c:forEach items="${targets}" var="t">
			<tr>
			
				<td> <input type="radio" <c:if test="${task.target_id== t.id}"> checked="checked" </c:if>  name="targetRadio" value="${t.id}"><span onclick="goUrl('${cp}/target/show?id=${t.id}')" style="cursor: pointer;"> ${t.title} </span></td>
			</tr>
		</c:forEach>
	</table>  
	
	</div>
	<!-- 确定按钮 -->
	<div> 
		 <div onclick="saveZb()" class="button buttonimg2" style="float: left;width: 30%;margin-left: 15%;)"> 确 定 </div> 
		  <div onclick="showClose('zbWin')" class="button buttonimg2" style="float: right;width: 30%;margin-right: 15%;"> 取 消 </div>  
	</div>	
</div>
<div id="tzWin" style="width:55%" class="bigshow">
	<div style="width: 95%;height: 91%;padding-left: 3%;padding-top: 3%">  
	 		<div class="form-group" style="height: 7%"> 
				<input type="text" style="height:100%" class="form-control " value="${task.file_title}" id="tzTile" placeholder="请输入通知文件标题">
			</div>  
			<div class="form-group" style="height: 86%">          
				<script id="editor2" type="text/plain" charset="form-control" placeholder="请输入通知文件标题" style="width:100%;height:85%;"><c:if test="${task.file_content==null}">再此填写或粘贴通知文件正文</c:if>${task.file_content}</script>     
			</div> 
	</div>
	<div  style="width: 100%;"> 
		    <div onclick="showClose('tzWin')" class="button buttonimg2" style="float: right;width: 15%;margin-right: 5%;"> 取 消 </div>  
		  <div onclick="saveTz()" class="button button buttonimg2" style="float: right;width: 15%;margin-right: 3%"> 确 定 </div>  
		  
	</div>
</div>		
<div id="timeWin" style="" class="show">   
<div style="height: 88%">   
	<div style="width: 95%;height: 91%;padding-left: 6%;padding-top: 35%">  
		<h4>目标周期</h4>
		 <div class="input-daterange input-group" id="datepicker1"> 
	    	<input type="text" class=" form-control" id="mbstart_" name="mbstart_" value="${task.mbstart}""/> 
	    	<span class="input-group-addon">to</span>   
	    	<input type="text" class=" form-control" id="mbend_" name="mbend_" value="${task.mbend}"/>
	    </div>
	    <br>
	    <h4> 总结周期</h4>
	    <div  class="input-daterange input-group" id="datepicker2">
	    	<input type="text" class=" form-control" id="zjstart_" name="zjstart_" value="${task.zjstart}"/>
	    	<span class="input-group-addon">to</span>
	    	<input type="text" class=" form-control" id="zjend_" name="zjend_" value="${task.zjend}"/>
	    </div>
	      <div id="divZj_" class="has-error" id="datepicker3"> 
	    </div>
	     <br>
	    <h4> 评分周期</h4>
	    <div class="input-daterange input-group" id="datepicker3">
	    	<input type="text" class=" form-control" id="khstart_" name="khstart_" value="${task.khstart}"/>
	    	<span class="input-group-addon">to</span>
	    	<input type="text" class=" form-control" id="khend_" name="khend_" value="${task.khend}"/>
	    </div>
	     <div id="divKh_" class="has-error" id="datepicker3">
	    </div>
	   
	</div>
</div>
	
	
	<div  style="width: 100%;">  
		    <div onclick="showClose('timeWin')" class="button buttonimg2" style="float: right;width: 25%;margin-right: 5%;"> 取 消 </div>  
		  	<div onclick="timeCheck()" class="button buttonimg2" style="float: right;width: 25%;margin-right: 3%"> 确 定 </div>  
	</div>
</div>		
		
	<div id="bg"></div>
<script type="text/javascript"> 
$('input, textarea').placeholder();
$(function() {
    $('[id^=datepicker]').datepicker({ 
        format: "yyyy-mm-dd",
        language: "zh-CN", 
        multidate: false,
        autoclose: true,
        todayHighlight: true
        });      
  }); 
function save(type){
	saixuan();
	if(type==0){
		$("#taskSubmit").val(0);
		sumbit();
	}else{
		if(getval("title")==""){
			alertWin("请填写任务标题。");
		}else if(getval("file_title")==""){
			alertWin("请填写通知文件标题。");
		}else if(ue.getContentTxt()==""||ue.getContentTxt()=="再此填写或粘贴考核任务的相关文件正文"){
			alertWin("请填写任务的正文。");
		}else if(ur.getContentTxt()==""||ur.getContentTxt()=="再此填写或粘贴通知文件正文"){
			alertWin("请填写通知文件正文。");
		}else if(getval("target_id")==""){
			alertWin("请选择考评指标");
		}else if(getval("orgs_id")==""){
			alertWin("请选择被考核处室");
		}else if(getval("mbstart")==""){
			alertWin("请设置任务周期");
		}
		else{
			$.ajax({
						type : "POST",
						url : "../exitsTarget",
						async:false,
						data :{target:getval("target_id"),orgs_id:getval("orgs_id")},
						contentType : 'application/x-www-form-urlencoded;charset=utf-8',
						success : function(data) {
							if(!data){
								alertWin("指标中指定的评测处室<br>未在被考核处室中选取");
							}else{
								$("#taskSubmit").val(1);
								alertWins("sumbit","确定提交吗?提交后将不能修改。");
							}
						}
					});
			
		}
	}
}

function sumbit(){
	$.ajax({
		type : "POST",
		url : "save",
		async:false,
		data:$("#taskForm").serialize(),
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
			if(data){
				location.href="index?type=null";
			}else{
				alert("异常");
			}
		}
	});
}

function saveTz(){
	showClose('tzWin');
	$("#file_content").val(ur.getContent());
	$("#file_title").val($("#tzTile").val());
}
function saveZb(){
	$("#target_id").val($("input[name=targetRadio]:checked").val());;
	showClose('zbWin');
}
function timeCheck(){
	var b=true;
	removeInfos(); 
	$("#datepicker2").removeClass("error");
	$("#datepicker3").removeClass("error");
	if(strToTime($("#zjstart_").val())<strToTime($("#mbstart_").val())){
		$("#datepicker2").addClass("has-error");
		$("#divZj_").append('<label name="infos" class="control-label" >开始时间请大于或等于填写目标时间</label>');
		b=false;
	}
	if(strToTime($("#khstart_").val())<strToTime($("#zjstart_").val())){
		$("#datepicker3").addClass("has-error");
		$("#divKh_").append('<label name="infos" class="control-label" >开始时间请大于或等于填写总结时间</label>');
		b=false;
	}
	if(b){
		$("#mbstart").val($("#mbstart_").val());
		$("#mbend").val($("#mbend_").val());
		$("#zjstart").val($("#zjstart_").val());
		$("#zjend").val($("#zjend_").val());
		$("#khstart").val($("#khstart_").val());
		$("#khend").val($("#khend_").val());
		showClose('timeWin');
	}
}

function strToTime(time){
	return time.replace("-","").replace("-","")*1;
}

function saixuan(){
	var orgs="";
	$.each($("input[id^=che]:checked"),function(i,o) {   
		orgs+=$(o).val()+",";
	});
	$("#orgs_id").val(orgs);
}

function checkd(id){  
	$("#che"+id).attr("checked", true);
}
function check(id){
	if(id==1){  
		$("input[name=sxChecked]").each(function (){
			this.checked=false;
			});
		showClose('sxWin');
	}else{ 
		$("input[name=sxChecked]").each(function (){
			this.checked=true;
		});
	}
}	  
	  
</script>
	<c:if test="${task.content==''||task.content==null}">
	<script type="text/javascript">
				var ue = UE.getEditor('editor',{
					autoClearinitialContent :true,
					autoHeightEnabled:false
				}); 
				var ur = UE.getEditor('editor2',{
					autoClearinitialContent :true,
					autoHeightEnabled:false
				});
	</script>
	</c:if>
	<c:if test="${task.content!=''}">
		<script type="text/javascript">
				var ue = UE.getEditor('editor',{
					autoClearinitialContent :false,
					autoHeightEnabled:false
				}); 
				var ur = UE.getEditor('editor2',{
					autoClearinitialContent :false,
					autoHeightEnabled:false
				});
		</script>
	</c:if>
</html>
