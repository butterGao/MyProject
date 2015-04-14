<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
<meta charset="utf-8" />
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<%@include file="../common/public.jsp"%>
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
               		随机生成小蜜蜂
            </h4>
         </div>
         <div class="modal-body">
         <div class="form-horizontal">
      	<form id="addForm">
  				<div class="form-group">
   						<label  class="col-sm-2 control-label">数量</label>
    					<div class="col-sm-10">
     						 <input id="number" name="number" class="form-control"  placeholder="请输入数量">
    					</div>
  				</div>
  				<div class="form-group">
   						<label  class="col-sm-2 control-label">项目</label>
    					<div class="col-sm-10">
     						 	<select id="xmf_pid" name="pid" onclick="change(this)" class="form-control" placeholder="请选择类型"> 
								   <c:forEach var="t" items="${project}">
								    <option  value="${t.id}"> ${t.name}</option> 
								   </c:forEach>
								</select>
    					</div>
  				</div>
  				<div class="form-group">
   						<label  class="col-sm-2 control-label">组</label>
    					<div class="col-sm-10">
    						<select id="gid" name="gid"  class="form-control" placeholder="请选择类型"> 
								  
							</select>
    					</div>
  				</div>
  				</form>
           	   <br>
	        </div>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <button type="button" onclick="addAccount()" class="btn btn-primary">
            	创建
            </button>
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
</div>

<div class="modal fade" id="mangeModal" tabindex="-1" style="z-index: 99999" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close"  data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               		添加管理员
            </h4>
         </div>
         <div class="modal-body">
         <div class="form-horizontal">
      		<form id="manaForm">
  				<div class="form-group">
   						<label  class="col-sm-2 control-label">用户名</label>
    					<div class="col-sm-10">
     						 <input id="uname" name="uname" class="form-control"   placeholder="请输入">
    					</div>
  				</div>
  				<div class="form-group">
   						<label  class="col-sm-2 control-label">登陆账号</label>
    					<div class="col-sm-10">
     						 <input id="lname" name="lname" class="form-control"  placeholder="请输入">
    					</div>
  				</div>
  				<div class="form-group">
   						<label  class="col-sm-2 control-label">密码</label>
    					<div class="col-sm-10">
     						 <input id="pwd" name="pwd" class="form-control"  placeholder="请输入">
    					</div>
  				</div>
  				<div class="form-group">
   						<label  class="col-sm-2 control-label">电话</label>
    					<div class="col-sm-10">
     						 <input type="text" id="phone" name="phone" class="form-control"  placeholder="请输入">
    					</div>
  				</div>
  				<div class="form-group">
   						<label  class="col-sm-2 control-label">公司</label>
    					<div class="col-sm-10">
    						<select id="company" name="cid"  class="form-control" placeholder="请选择类型"> 
								  
							</select>
    					</div>
  				</div>
  				</form>
           	   <br>
	        </div>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <button type="button" onclick="addManager()" class="btn btn-primary">
            	生成
            </button>
         </div>
      </div><!-- /.modal-content -->
</div>
</div>
<!-- 修改管理员密码 -->
<div class="modal fade" id="passModal" tabindex="-1" style="z-index: 99999" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close"  data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               		修改管理员密码
            </h4>
         </div>
         <div class="modal-body">
         <div class="form-horizontal">
      		<form id="manaUpdateForm">
  				<div class="form-group">
   						<label  class="col-sm-2 control-label">密码</label>
    					<div class="col-sm-10">
     						 <input id="pwd_n" name="pwd" class="form-control"  placeholder="请输入">
    					</div>
  				</div>
  				</form>
           	   <br>
	        </div>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <button type="button" onclick="updateManager()" class="btn btn-primary">
            	修改
            </button>
         </div>
      </div><!-- /.modal-content -->
</div>
</div>



 		<input type="hidden" id="cid" value='${user.cid}'>

							<table id="grid-table"></table>

							<div id="grid-pager"></div>

								
</body>
<script src="page/account_manager.js"></script>
<script type="text/javascript">
$(function (){
	//初始化组
	ajaxHtmlToSelect("au/zhu", {pid:$("#xmf_pid").val()}, 'gid');
	//添加管理员
	if(getval("cid")==0){
		jQuery("#grid-table").jqGrid().jqGrid('navButtonAdd',"#grid-pager",{
			caption:"添加管理员",
			buttonicon:"icon-plus-sign blue",
			onClickButton: function(){
				$("#mangeModal").modal("show");
			}
		});
		$("#add_grid-table").remove();
		$("#edit_grid-table").remove();
		ajaxHtmlToSelect('ac/queryCompany',null,'company');
	}else{
		jQuery("#grid-table").jqGrid().jqGrid('navButtonAdd',"#grid-pager",{
			caption:"添加小蜜蜂账号",
			buttonicon:"icon-plus-sign blue",
			onClickButton: function(){
				$("#myModal").modal("show");
			}
		}).jqGrid('navButtonAdd',"#grid-pager",{
			caption:"修改管理员密码",
			buttonicon:"icon-plus-sign blue",
			onClickButton: function(){
				$("#passModal").modal("show");
			}
		});
	}
	$("#phone").keyup(function () {
	    //如果输入非数字，则替换为''，如果输入数字，则在每4位之后添加一个空格分隔
	    this.value = this.value.replace(/[^\d]/g, '').replace(/(\d{4})(?=\d)/g, "$1 ");
	  
	});
	$("#number").keyup(function () {
	    //如果输入非数字，则替换为''，如果输入数字，则在每4位之后添加一个空格分隔
	    this.value = this.value.replace(/[^\d]/g, '').replace(/(\d{4})(?=\d)/g, "$1 ");
	  
	});

});

function updateManager(){
	if($("#pwd_n").val()==""){
		alert("密码必须填写");
	}else{
		ajaxFunction("au/updateManger",$("#manaUpdateForm").serialize(),function(data){
			if(data){
				alert("成功");
				$("#passModal").modal('toggle');
			}else{
				alert("修改密码错误");
			}
		});
	}
}

function addManager(){
	if($("#uname").val()==""){
		alert("用户名必须填写");
	}else if($("#lname").val()==""){
		alert("登陆账号必须填写");
	}else if($("#pwd").val()==""){
		alert("密码必须填写");
	}else if($("#company").val()==""){
		alert("请选择一个公司");
	}
	else{
			var s=true;
			$.ajax({
				type : "POST",
				url :$("#root").val()+"/au/isExist",
				async:false, 
				data :{lname:$("#lname").val()},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					s=!data;
				}
			});
		if(!s){
			alert("登陆名称重复");
		}else{
			ajaxFunction("au/addManger",$("#manaForm").serialize(),function(data){
				if(data){
					$("#mangeModal").modal('toggle');
					jQuery("#grid_id").trigger("reloadGrid");
				}else{
					alert("该公司已经存在管理员");
				}
			});
		}
	}
}
function addAccount(){	
	if($("#number").val()<1){
		alert("小蜜蜂数量请大于0");
	}else if($("#gid").val()==""){
		alert("请先创建组");
	}else{
		$.ajax({
			type : "POST",
			url : getval("root")+"/au/addAccount",
			async:false,
			data :$(addForm).serialize(),
			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
			success : function(data) {
				if(data.success){
					$("#grid-table").jqGrid().trigger('reloadGrid');
					$("#myModal").modal('toggle');
				}else{
					alert(data.info);
				}
			}
		});
	}
	
}
function change(o){
	ajaxHtmlToSelect("au/zhu", {pid:$(o).val()}, 'gid');
}
</script>
</html>
