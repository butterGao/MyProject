<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@include file="../common/public.jsp" %>
<script type="text/javascript" charset="utf-8" src="../ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../ueditor/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="../js/json2.js"> </script>
<script type="text/javascript" src="${cp}/js/bootstrap3-validation.js"></script> 
<style type="text/css">

</style>
<script type="text/javascript">
function save(){
	var boo=true;
	var msg="";
	if($("#title").val()==""){
		boo=false;
		msg="请填写考核指标的名称";
	}else if(ue.getContentTxt()==""||ue.getContentTxt()=="再此填写或粘贴指标的相关文件正文"){
		boo=false;
		msg="请填写指标正文";
	}else if($("#allCode").text()<100){
		boo=false;
		msg="请创建权重";
	}
	
	if(boo){
		$.ajax({
			type : "POST",
			url : "save",
			async:false,
			data :$("#targetForm").serializeArray(),
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			success : function(data) {
				if(data){
					window.location.href="index";
				}else{
					alertWin("保存时出现异常");
				}
			}
		});	
	}else{ 
		alertWin(msg);
	}
}
function yulan(){ 
	$("#targetForm").attr("action","yulan");
	$("#targetForm").submit();
}
</script>
<title>绩效考核系统</title>
</head>
<body>
		<%@include file="../common/head.jsp" %>
		<!-- Main --> 
		<div  style="float: left;height: 75%;width: 100%;position: relative;">
			<h4 id="atitle" style="margin-left: 5%;;color: white;">新增考核指标:</h4>
			<div style="float: left;height: 90%;width: 70%;padding-left: 9%">   
				<form role="form" class="form-horizontal" method="post" style="width: 100%;height: 100%"  id ="targetForm" action="" target="_blank">
					<input type="hidden" id="weighter" name="weighter">  
					<input type="hidden" id="" name="id">  
					<div id="divtitle"  class=""> 
						<input type="text" class="form-control" id="title" name="title" placeholder="请输入新增考核指标的名称">
					</div>
						<hr>    
					<div id="divtitle"  class="" style="height: 80%"> 
						<script id="editor" name="content" type="text/plain" style="width:100%;height:100%;">再此填写或粘贴指标的相关文件正文</script>					
					</div>
				</form> 
				 
			</div>
			<div style="width: 15%;height: 80%;position:fixed;right: 5%;"> 
				<div onclick="showdiv('qzWin')" class="button buttonimg2" > 创建权重 </div>  
				<div onclick="yulan()"class="button buttonimg2" style="margin-top: 3%;"> 预览 </div>  
				<div onclick="save()" class="button buttonimg3" style="position: absolute;bottom: 23%"> 提交</div>  
				<div onclick="javascritp:history.go(-1)" class="button buttonimg2" style="position: absolute;bottom:15%"> 返回 </div>  
			</div>
		</div>	
		
		
		
	</div>
	</div>
</body>
<!-- 弹窗 -->
    <div id="qzWin"  class="bigshow"> 
         	     	<div style="height: 90%;width: 100%;overflow: auto;">
         	     	<table id="table" class="table" width="100%">
		         	<tr>	 
		         		<td width="20%">评测者</td>   
		         		<td width="10%">权重</td>   
		         		<td >计分方式</td>    
		         		<td  width="10%">  </td>
		         	</tr> 
		         	<tr>
		         		<td>全部处室  <span  title="机关各处室互评" class="glyphicon glyphicon-question-sign"></span>  </td> 
		         		<td>  
		         			<div style="position: relative;" >  
		         				<input id="inputa"  class="form-control" maxlength="2"  type="text"> <span class="form-control-feedback">%</span>
		         			</div>
		         		</td>
		         		<td><select id="selecta"  class="form-control"> 
		         			<option value="1">平均分,未打分计满分</option> 
		         			<option value="2">平均分,未打分计0分</option>
		         			<option value="3">最高分</option>
		         			<option value="4">最低分</option>
		         			</select>
		         		</td>
		         		<td> </td>
		         	</tr> 
		         	<tr>	
		         		<td>处室自评 <span  title="处室工作人员自评" class="glyphicon glyphicon-question-sign"></span></td>  
		         		<td>  
		         			<div style="position: relative; " >   
		         				<input id="inputb" class="form-control "  maxlength="2"   type="text"> <span class="form-control-feedback">%</span>
		         			</div>
		         		</td>
		         		<td><select id="selectb" class="form-control"> 
		         		    <option value="1">平均分,未打分计满分</option> 
		         			<option value="2">平均分,未打分计0分</option>
		         			<!-- <option value="3">最高分</option>
		         			<option value="4">最低分</option> -->
		         			</select>
		         		</td> 
		         		<td> </td>
		         	</tr>      
		         	<tr>	
		         		<td>分(协)管领导 <span  title="只有一位局领导时计个人分。" class="glyphicon glyphicon-question-sign"></span></td>  
		         		<td>  
		         			<div style="position: relative; " >   
		         				<input id="inputc" class="form-control "  maxlength="2"   type="text"> <span class="form-control-feedback">%</span>
		         			</div>
		         		</td>
		         		<td><select id="selectc" class="form-control"> 
		         		    <option value="1">平均分,未打分计满分</option> 
		         			<option value="2">平均分,未打分计0分</option>
		         			<!-- <option value="3">最高分</option>
		         			<option value="4">最低分</option> -->
		         			</select>
		         		</td> 
		         		<td> </td>
		         	</tr>      
	         	</table>  
         	     	</div>
	         	 <div style="position:absolute;bottom:10%;width: 98%;left: 2%;font-size: 18px;">
	         	 		合计：<a  id="allCode" >0</a>% <a id="info" style="color: red;display:none;"> 权重合计要为100%</a>
	         	 </div>
	        <div style="position:absolute;bottom:3%;width: 98%;left: 2%;">
	         	<div  onclick="showCs()" class="button buttonimg2" style="float:left;width: 20%;">添加评测者 </div> 
	         	<div  onclick="showClose('qzWin')" class="button buttonimg2" style="float: right;margin-right:2%;width: 20%;"> 取消 </div> 
	         	<div  onclick="saveQz()" class="button buttonimg3" style="float: right;margin-right:2%;width: 20%;"> 保存 </div> 
         	</div>
	</div>
	<!-- 所有处室 -->
	<div id="csWin" style="overflow: auto;width:400px;padding-top: 1%" class="show">  
         	<div style="height: 90%;width: 100%;overflow: auto;">
         	   <table style="margin-left: 8%;"> 
			<c:forEach items="${orgs}" var="o" >
			<tr >
				<td > <input type="radio" name="radioCs" id="cs${o.id}" value="${o.id}"> <label class="" for="cs${o.id}">${o.short_name}</label>  </td>
				<td > 
					<c:if test="${o.id eq 'c504c59b8a9fd8c1129dc62cdb51ef41'}">
						<div onclick="showPerson('${o.id}')" style="height: 26px;width: 80px;padding-top: 4px;" class='button buttonimg1'> 选择人员 </div>  
					</c:if>
				</td>
			</tr>
			
			</c:forEach>
		</table>
         	</div>
	        <div style="position:absolute;bottom:3%;width: 98%;left: 2%;">
	         	<div  onclick="closeCs()" class="button buttonimg2" style="float: right;margin-right:2%;width: 20%;"> 取消 </div> 
	         	<div  onclick="addOrganization()" class="button buttonimg3" style="float: right;margin-right:2%;width: 20%;"> 确定 </div> 
         	</div>
	</div>
	<!-- 处室人员 -->
	<div id="peWin" style="overflow: auto;padding-top: 1%" class="show"> 
         	<div style="height: 90%;width: 100%;overflow: auto;">
         	   <table id="peTable" style="margin-left: 8%;"> 
			   </table>
         	</div>
	        <div style="position:absolute;bottom:3%;width: 98%;left: 2%;">
	         	<div  onclick="closePe()" class="button buttonimg2" style="float: right;margin-right:2%;width: 20%;"> 取消 </div> 
	         	<div  onclick="addPerson()" class="button buttonimg3" style="float: right;margin-right:2%;width: 20%;"> 确定 </div> 
         	</div>
	</div>



<script type="text/javascript">
$('input, textarea').placeholder();
  var acode=0;
  function addKeyup(){
	  $("input[id^=input]").keyup(function () {
          //如果输入非数字，则替换为''，如果输入数字，则在每4位之后添加一个空格分隔
          this.value = this.value.replace(/[^\d]/g, '').replace(/(\d{4})(?=\d)/g, "$1 ");
          var count=0;
          $.each($("input[id^=input]"),function(i,o) {   
          	count+=$(o).val()*1;
		}); 
          acode=count*1;
          if(count==100){
        	  $("#allCode").css("color","");
        	  $("#info").css("display","none");
          }else{
        	  $("#allCode").css("color","red");
        	  $("#info").css("display","inline");
          }
          $("#allCode").html(count);
      });
  }
        $(function () {
        	addKeyup();
 });
        //显示处室层
        function showCs(){
        	$("#qzWin").hide("normal");
        	$("#csWin").show("normal");
        }
        //关闭处室层
        function closeCs(){
        	$("#csWin").hide("normal");
        	$("#qzWin").show("normal");
        }
        function closePe(){
        	$("#peWin").hide("normal");
        	$("#qzWin").show("normal");
        }
        //显示处室成员
        function showPerson(id){
        	$("#csWin").hide("normal");
        	$.ajax({
						type : "POST",
						url : "../person",
						async:false,
						data :{id:id},
						contentType : 'application/x-www-form-urlencoded;charset=utf-8',
						success : function(data) {
							var html="";
							$.each(data,function(i,o) {
								html+="<tr>"+"<td>";
								html+='<input type="radio" name="radioPe" id="pe'+o.ID+'" value="'+o.ID+'"> <label class="" for="pe'+o.ID+'">'+o.USER_NAME+'</label>';
								html+="</td></tr>";
							});
							$("#peTable").html(html);
						}
					});
        	
        	$("#peWin").show("normal");
        }
        
        //以下绘制权重DIV 
        function addDel(id){
        	return '<div onclick="delTr('+'\''+id+'\''+')" class="button buttonimg1"> 删除 </div>';
        }
        function addQz(num){
        	return '<div style="position: relative; " > <input id="input'+num+'"   class="form-control myinputs"  maxlength="2"   type="text"> <span class="form-control-feedback">%</span> </div>'
        }
        function addSelect(id){
        return '<select id="select'+id+'" class="form-control"> <option value="1">未评分计满分</option> <option value="2">未评分计0分</option>'
       // +'<option value="3">最高分</option><option value="4">最低分</option>'
        +'</select>';
        }
        function addNameId(id,str){
        	return '<input type="text" class="form-control" id="name'+id+'" value="'+str+'">'; 
        }
        function addTd(str){
        	return "<td>"+str+"</td>";
        }
        function delTr(id){
        	$("#tr"+id).remove();
        }
        //添加评测者（个人）
        function addPerson(){
        	$("#peWin").hide("normal");
        	$("#qzWin").show("normal");
        	var id="u_"+$("input[id^=pe]:checked").val();
        	var name=$("input[id^=pe]:checked").next().html();
        	var tr="<tr id='tr"+id+"'>";
        	var tr_="</tr>";
        	var html=tr+addTd(addNameId(id,name))+addTd(addQz(id))+addTd("<label class='form-control'>计个人分</label>")+addTd(addDel(id))+tr_;
        	$("#table").append(html);
        	addKeyup();
        }
        //添加评测者（处室）
        function addOrganization(){
        	$("#csWin").hide("normal");
        	$("#qzWin").show("normal");
        	var id="o_"+$("input[id^=cs]:checked").val();
        	var name=$("input[id^=cs]:checked").next().html();
        	var tr="<tr id='tr"+id+"'>";
        	var tr_="</tr>";
        	var html=tr+addTd(addNameId(id,name))+addTd(addQz(id))+addTd(addSelect(id))+addTd(addDel(id))+tr_;
        	$("#table").append(html);
        	addKeyup();
        }
 function saveQz(){
	 if(acode==100){
		/* var list=new Array();
		function getWei(name,id,code,type){
			this.name=name;
			this.id=id;
			this.code=code;
			this.type=type;
		} 
		list.push(new getWei("全部处室","001",$("#inputa").val(),$("#selecta").val()));
		list.push(new getWei("处室自评","002",$("#inputb").val(),$("#selectb").val())); */
		 var weight="全部处室,001,"+$("#inputa").val()+","+$("#selecta").val()+";";
			weight+="处室自评,002,"+$("#inputb").val()+","+$("#selectb").val()+";";
			weight+="分(协)管领导,003,"+$("#inputc").val()+","+$("#selectc").val()+";";
			$.each($("input[id^=inputo_]"),function(i,o) {  
				var id=$(o).attr("id").substring(7,$(o).attr("id").length);
				weight+=$("#nameo_"+id).val()+","+id+","+$(o).val()+","+$("#selecto_"+id).val()+";";
				//list.push(new getWei($("#nameo_"+id).html(),id,$(o).val(),$("#selecto_"+id).val()));
			});
			$.each($("input[id^=inputu_]"),function(i,o) {  
				var id=$(o).attr("id").substring(7,$(o).attr("id").length);
				weight+=$("#nameu_"+id).val()+","+id+","+$(o).val()+","+$("#selectu_"+id).val()+";";
				//list.push(new getWei($("#nameu_"+id).html(),id,$(o).val(),$("#selectu_"+id).val()));
			});
			$("#weighter").val(weight); 
			//alert(JSON.stringify(list));
			showClose('qzWin');
	 }
 }       
        
</script>
	<!-- 编辑器 -->	
	<script type="text/javascript">
	var ue = UE.getEditor('editor',{
		autoClearinitialContent :true
	}); 
	
	</script>
	<div id="bg"></div>
		
</html>
