 //查询列表
function queryinit(urlst,params){
	$('#student_list').datagrid({
		title:"临时卡信息列表",
		iconCls:'icon-search', 
		pageSize:10,
        pageList:[5,10,15,20,25,30,35,40,45,50],
		nowrap: true,
		striped: true,
		collapsible:true,
		url:urlst,
		queryParams: params,
		loadMsg:'数据装载中......',
		// singleSelect: true,
		remoteSort: false,
		fitColumns:true,
		// 设置CHECKBOX的值
		frozenColumns:[[{field:'tempId',checkbox:true}]],
		columns:[
			[
				{field:'xjh',title:'学籍号',width:80,sortable:'true',align:'center'},
				{field:'realName',title:'学生姓名',width:50,sortable:'true',align:'center'},
				{field:'cardNo',title:'临时卡号',width:80,sortable:'true',align:'center',hidden: true},
				{field:'status',title:'状态',width:80,sortable:'true',align:'center',
					formatter: function(value,row){
						if(value==0){
							return '使用中';
						}else if(value=='1'){
							return '未使用';
						}
					}
				},
				{field:'state',title:'报名状态',width:80,sortable:'true',align:'center',
					formatter: function(value,row){
						if(value==0){
							return '初始化';
						}else if(value=='1'){
							return '已经报名';
						}
					}
				},
				{field:'sex',title:'性别',width:20,sortable:'true',align:'center'},
				{field:'birthday',title:'出生日期',width:50,sortable:'true',align:'center'},
				{field:'school',title:'学校',width:50,sortable:'true',align:'center'},
				{field:'grade',title:'年级',width:50,sortable:'true',align:'center'},
				{field:'banji',title:'班级',width:80,sortable:'true',align:'center'},
				{field:'address',title:'家庭住址',width:80,sortable:'true',align:'center',hidden: true}
			]
		],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'新增',
			disabled: false,
			iconCls:'icon-add',
			handler:function(){
				open1('addwindow');
			} 
		},'-',{
			id:'btnedit',
			text:'修改',
			iconCls:'icon-edit',
			handler:function(){
				var rows = $('#student_list').datagrid('getSelections');
				if(rows.length==0){
				  $.messager.alert('提示','请选择要使用的学生卡!');
				}else if(rows.length>1){
				   $.messager.alert('提示','只能选择一条信息!');
				}else{
				   var paths=$("#paths").val();
				   var cardNo=rows[0].cardNo;
				   $("#updateform :input[name='xjh']").val(rows[0].xjh);
				   $("#updateform :input[name='tempId']").val(rows[0].tempId);
				   $("#updateform :input[name='cardNo']").val(cardNo);
				   $('#updateform #grade').combogrid({ 
						panelWidth:460, 
						value:'', 
						idField:'name', 
						textField:'name', 
						url: paths+'/baseinfo.do?dispatch=queryGradeByPage', 
						fitColumns: true,   
		                striped: true,   
		                editable:true,   
		                pagination : true,// 是否分页
		                rownumbers:true,// 序号
		                collapsible:false,// 是否可折叠的
		                fit: true,// 自动大小
		                pageSize: 10,// 每页显示的记录条数，默认为10
						columns:[[ 
							{field:'name',title:'名称',width:60, align: 'center'}, 
							{field:'sort',title:'序号',width:30, align: 'center'} 
						]]
					});
					queryObjectbyID(paths+"/tempCard.do?dispatch=queryTempCardByCardNo",'updatewindow',rows[0].tempId);
				}
			}
		},'-',{
			id:'btnuse',
			text:'使用',
			iconCls:'icon-add',
			handler:function(){
				var rows = $('#student_list').datagrid('getSelections');
				if(rows.length==0){
				  $.messager.alert('提示','请选择要使用的学生卡!');
				}else if(rows.length>1){
				   $.messager.alert('提示','只能选择一条信息!');
				}else{
				   open1("usewindow");
				   var paths=$("#paths").val();
				   $("#useform :input[name='tempId']").val(rows[0].tempId);
				   $("#useform :input[name='cardNo']").val(rows[0].cardNo);
				   $("#useform :input[name='xjh']").val(rows[0].xjh);
				   $('#useform #grade').combogrid({ 
						panelWidth:460, 
						value:'', 
						idField:'name', 
						textField:'name', 
						url: paths+'/baseinfo.do?dispatch=queryGradeByPage', 
						fitColumns: true,   
		                striped: true,   
		                editable:true,   
		                pagination : true,// 是否分页
		                rownumbers:true,// 序号
		                collapsible:false,// 是否可折叠的
		                fit: true,// 自动大小
		                pageSize: 10,// 每页显示的记录条数，默认为10
						columns:[[ 
							{field:'name',title:'名称',width:60, align: 'center'}, 
							{field:'sort',title:'序号',width:30, align: 'center'} 
						]]
					});
				}
			}
		},'-',{
			id:'btnsignup',
			text:'报名',
			iconCls:'icon-add',
			handler:function(){
				var rows = $('#student_list').datagrid('getSelections');
				if(rows.length==0){
				    $.messager.alert('提示','请选择临时卡号!');
				}else if(rows.length>1){
				    $.messager.alert('提示','只能选择一行!');
				}else{
				    var paths=$("#paths").val();
				    // $("#signupqueryform #tempId").val(rows[0].tempId);
				    // $("#signupqueryform #cardNo").val(rows[0].cardNo);
				    // $("#signupqueryform #xjh").val(rows[0].xjh);
				    open1('signupwindow');
				    $('#signupqueryform #courseType').combobox({url:paths+'/baseinfo.do?dispatch=queryctlistByCombo', valueField:'id',textField:'name'});
					$('#signupqueryform #schoolYear').combobox({url:paths+'/baseinfo.do?dispatch=querysylistByCombo', valueField:'id',textField:'name'});
					$('#signupqueryform #teacher').combogrid({ 
						panelWidth:480, 
						value:'', 
						idField:'tid', 
						textField:'realName', 
						url: paths+'/teacher.do?dispatch=queryteacherlist', 
						fitColumns: true,   
		                striped: true,   
		                editable:true,   
		                pagination : true,// 是否分页
		                rownumbers:true,// 序号
		                collapsible:false,// 是否可折叠的
		                fit: true,// 自动大小
		                pageSize: 10,// 每页显示的记录条数，默认为10
						columns:[[ 
							{field:'tid',title:'ID',width:30,hidden:true}, 
							{field:'teaNo',title:'编号',width:50}, 
							{field:'realName',title:'姓名',width:50}
						]]
					}); 
				   querySignUpCourse(paths+"/course.do?dispatch=querySignupCourse",{});
				}
			}
		},'-',{
			id:'btnzx',
			text:'注销',
			iconCls:'icon-add',
			handler:function(){
				var rows = $('#student_list').datagrid('getSelections');
				var cardNos=[];
				var tempIds=[];
				for(var i=0;i<rows.length;i++){
					var status=rows[i].status;
					if(status!=0){
						$.messager.alert('提示','请选择要使用中的临时卡!');
						return ;
					}
					cardNos.push(rows[i].cardNo);
					tempIds.push(rows[i].tempId);
				}
				if(rows.length==0){
				  $.messager.alert('提示','请选择要注销的临时卡号!');
				}else{
				   $.messager.confirm('提示', '确认注销?', function(r){
				   		if(r){
				   			var url=$('#paths').val()+'/tempCard.do?dispatch=logoutTempCard';
				   			$.ajax({
								type: 'POST',
								url: url,
								data: {cardNos: cardNos.join(":"),tempIds:tempIds.join(":")},
								success: function(data){
									var result=eval('('+data+')');
									if(result.success){
										$.messager.alert('提示',"注销成功！");
       									queryinit(urlst,params); // 刷新列表
									}else{
										$.messager.alert('提示',"注销失败！");
									}
								}
							});
				   		}
				   });
				}
			}
		},'-',{
			id:'btncancel',
			text:'取消报名',
			iconCls:'icon-add',
			handler:function(){
				open1('cancelsignupwindow');
				var rows = $('#student_list').datagrid('getSelections');
				var xjh=rows[0].xjh;
				var url=$("#paths").val()+"/course.do?dispatch=queryStudentSignUpCourse";
				queryStudentSignUpCourse(url,{'xjh':xjh});
			}
		}],
		onLoadSuccess:function(data){
			$('#btnedit').linkbutton('disable');
			$('#btnuse').linkbutton('disable');
	        $('#btnsignup').linkbutton('disable');
	        $('#btnzx').linkbutton('disable');
	        $('#btncancel').linkbutton('disable');
		},
		onSelect: function(rowIndex, rowData){
			var rows=$('#student_list').datagrid('getSelections');
			var status=rowData.status;
			if(rows.length==1){
				if(status=='0'){
					$('#btnuse').linkbutton('disable');
			        $('#btnsignup').linkbutton('enable');
			        $('#btnzx').linkbutton('enable');
			        $('#btnedit').linkbutton('enable');
			        $('#btncancel').linkbutton('enable');
				}else if(status=='1'){
					$('#btnuse').linkbutton('enable');
			        $('#btnsignup').linkbutton('disable');
			        $('#btnzx').linkbutton('disable');
			        $('#btnedit').linkbutton('disable');
			        $('#btncancel').linkbutton('disable');
				}
			}else if(rows.length>1){
				$('#btnuse').linkbutton('disable');
		        $('#btnsignup').linkbutton('disable');
		        $('#btnzx').linkbutton('enable');
		        $('#btnedit').linkbutton('disable');
		        $('#btncancel').linkbutton('disable');
			}
		},
		onUnselect: function(rowIndex, rowData){
			var rows=$('#student_list').datagrid('getSelections');
			var status=rowData.status;
			if(rows.length==1){
				if(status=='0'){
					$('#btnuse').linkbutton('disable');
			        $('#btnsignup').linkbutton('enable');
			        $('#btnzx').linkbutton('enable');
			        $('#btnedit').linkbutton('enable');
			        $('#btncancel').linkbutton('enable');
				}else if(status=='1'){
					$('#btnuse').linkbutton('enable');
			        $('#btnsignup').linkbutton('disable');
			        $('#btnzx').linkbutton('disable');
			        $('#btnedit').linkbutton('disable');
			        $('#btncancel').linkbutton('disable');
				}
			}else if (rows.length>1){
				$('#btnuse').linkbutton('disable');
		        $('#btnsignup').linkbutton('disable');
		        $('#btnzx').linkbutton('enable');
		        $('#btnedit').linkbutton('disable');
		        $('#btncancel').linkbutton('disable');
			}
		}
	});
	$('#student_list').datagrid('getPager').pagination({
displayMsg:'当前显示从 {from} 到 {to}条记录  共{total}条记录',
	  onBeforeRefresh:function(pageNumber, pageSize){
		 	$(this).pagination('loading');
		  $(this).pagination('loaded');
 }
	});
}
		
	
		
// 修改前查询返回 JSON
function queryObjectbyID(urls,windowid,tempId){
   $.ajax({
	  type:'POST',
	  url:urls,
	  data:{tempId:tempId},
	  success:function(msg){
	     if(msg !=''){
	     	   open1(windowid);
			   $("#updateform :input[name='cardNo']").val(msg.cardNo);
			   $("#updateform :input[name='stuNo']").val(msg.stuNo);
			   $("#updateform :input[name='realName']").val(msg.realName);
			   $("#updateform :input[name='sex']").each(function() { 
			   		if (this.value == msg.sex) { 
			   			this.checked = true;
					} 
			   });
			   // alert(msg.birthday);
			   $("#updateform #qBirthday").datebox("setValue",msg.birthday);
			   $("#updateform :input[name='schoolName']").val(msg.schoolName);
			   $("#updateform #qGrade").combobox('setValue',msg.grade);
			   $("#updateform :input[name='banji']").val(msg.banji);
			   $("#updateform :input[name='fatherName']").val(msg.fatherName);
			   $("#updateform :input[name='motherName']").val(msg.motherName);
			   $("#updateform :input[name='telephone']").val(msg.telephone);
			   $("#updateform :input[name='phone']").val(msg.phone);
			   $("#updateform :input[name='address']").val(msg.address);
	     }else{
	       $.messager.alert('提示','信息不存在！');
	     }
	      
	  }
   });
}
		
// 新增临时卡号
function addTempCard(id,windowid,urls){
  $('#'+id).form('submit', {   
      url:urls,   
      onSubmit: function(){ 
         return $(this).form("validate");
      },   
      success:function(data){
      	var result=eval('('+data+')');
      	if(result.success){
      		$.messager.alert('提示',"成功新增临时卡！");
            resetForm(id);
            close1(windowid);  // 根据窗体ID 关闭窗体
            queryinit(listurl,{}); // 刷新列表
      	}else{
      		$.messager.alert('提示',"新增临时卡号失败！");
      	}
  	 }   
  });  
}	

// 使用临时卡
function useTempCard(id,windowid,urls){
  $('#'+id).form('submit', {   
      url:urls,   
      onSubmit: function(){ 
         return $(this).form("validate");
      },   
      success:function(data){
      	var result=eval('('+data+')');
      	if(result.success){
      		$.messager.alert('提示',"成功使用临时卡！");
            resetForm(id);
            close1(windowid);  // 根据窗体ID 关闭窗体
            queryinit(listurl,{}); // 刷新列表
      	}else{
      		$.messager.alert('提示',"使用临时卡！");
      	}
  	 }   
  });  
}		

// 更新临时卡信息
function updateTempCard(id,windowid,urls){
  $('#'+id).form('submit', {   
      url:urls,   
      onSubmit: function(){ 
         return $(this).form("validate");
      },   
      success:function(data){
      	var result=eval('('+data+')');
      	if(result.success){
      		$.messager.alert('提示',"成功修改临时卡信息！");
            resetForm(id);
            close1(windowid);  // 根据窗体ID 关闭窗体
            queryinit(listurl,{}); // 刷新列表
      	}else{
      		$.messager.alert('提示',"修改临时卡信息失败！");
      	}
  	 }   
  });  
}	

// 查询报名课程列表
function querySignUpCourse(queryurl,params){
	$("#signupCourse").datagrid({
   		// title:"报名课程列表",
		iconCls:'icon-search',
		pageSize:5,
        pageList:[5,10,15,20,25,30,35,40,45,50],
		nowrap: true,
		striped: true,
		collapsible:true,
		url: queryurl,
		queryParams: params,
		loadMsg:'数据装载中......',
		singleSelect: true,
		remoteSort: false,
		fitColumns:true,
		frozenColumns:[[{field:'cid',checkbox:true}]],
		columns:[
			[
				{field:'cno',title:'课程编号',width:80,sortable:'true',align:'center'},
				{field:'cname',title:'课程名称',width:80,sortable:'true',align:'center'},
				{field:'courseType',title:'课程类别',width:50,sortable:'true',align:'center'},
				{field:'schoolYear',title:'学年',width:50,sortable:'true',align:'center'},
				{field:'term',title:'学期',width:40,sortable:'true',align:'center'},
				{field:'teacher',title:'授课老师',width:50,sortable:'true',align:'center'},
				{field:'classTime',title:'上课时间',width:100,sortable:'true',align:'center'},
				{field:'planPreNum',title:'计划人数',width:50,sortable:'true',align:'center'},
				{field:'actPreNum',title:'实际人数',width:50,sortable:'true',align:'center'},
				{field:'remainedNum',title:'剩余人数',width:50,sortable:'true',align:'center'}
			]
		],
		pagination:true,
		rownumbers:true
   });
   $('#signupCourse').datagrid('getPager').pagination({displayMsg:'当前显示从 {from} 到 {to}条记录  共{total}条记录', onBeforeRefresh:function(pageNumber, pageSize){	$(this).pagination('loading');$(this).pagination('loaded'); }
	});
}
			
// 查询报名的课程
function querySignupCourse(){
	var cno=$("#signupqueryform #cno").val();
	var cname=$("#signupqueryform #cname").val();
	var schoolYear=$("#signupqueryform #schoolYear").combobox("getValue");
	var term=$("#signupqueryform #term").combobox("getValue");
	var courseType=$("#signupqueryform #courseType").combobox("getValue");
	var tname=$("#signupqueryform #tname").val();
	
	var params={};
	params['cno']=cno;
	params['cname']=cname;
	params['schoolYear']=schoolYear;
	params['term']=term;
	params['courseType']=courseType;
	params['tname']=tname;
	// params['term']=2;
	
	var paths=$("#paths").val();
	var queryurl=paths+"/course.do?dispatch=querySignupCourse";
	querySignUpCourse(queryurl,params);
}

// 报名课程
function signupCourse(signupurl){
	$("#btnSignUp").linkbutton({"disabled":true});
	var rows = $('#signupCourse').datagrid('getSelections');
	var tempRows = $('#student_list').datagrid('getSelections');
	var cardNo=tempRows[0].cardNo;
	var tempId=tempRows[0].tempId;
	var paths=$("#paths").val();
	var cids=[];
	var cnames=[];
	for(var i=0;i<rows.length;i++){
		cids.push(rows[i].cid);
		cnames.push(rows[i].cname);
	}
	if(rows.length==0){
		$.messager.alert("提示","请选择一门课程！");
	}else{
		$.ajax({
			type: 'POST',
			url: paths+"/tempCard.do?dispatch=signupCourse",
			data: {tempId:tempId,cids:cids.join(":")},
			success: function(data){
				// alert(data);
				var data=eval('('+data+')');
				if(data.success){
					$.messager.alert("提示","课程【"+cnames.join(",")+"】报名成功！");
					var sid=data.sid;
					var cid=cids[0];
					// window.target="_blank";
					// window.location.href=$("#paths").val()+'/print.jsp?sid='+sid+"&cid="+cid;
					window.open($("#paths").val()+'/course.do?dispatch=printCourse&sid='+sid+"&cid="+cid);					
				}else{
					$.messager.alert("报名失败",data.msg);
				}
				$("#btnSignUp").linkbutton({"disabled":false});
			}
		});
		// open1('showwindow');
		
	}
}


// 查询学生已报名课程列表
function queryStudentSignUpCourse(queryurl,params){
	// alert("ddd");
	$("#cancelsignup_list").datagrid({
   		// title:"学生已报名的课程列表",
		iconCls:'icon-search',
		pageSize:10,
        pageList:[5,10,15,20,25,30,35,40,45,50],
		nowrap: true,
		striped: true,
		collapsible:true,
		url: queryurl,
		queryParams: params,
		loadMsg:'数据装载中......',
		singleSelect: false,
		remoteSort: false,
		fitColumns:false,
		frozenColumns:[
			[
				{field:'cid',checkbox:true},
				{field:'pid',title:'报名ID',width:80,sortable:'true',align:'center', hidden:true},
				{field:'sid',title:'学生ID',width:80,sortable:'true',align:'center', hidden:true},
				{field:'cno',title:'课程编号',width:100,sortable:'true',align:'center'},
				{field:'cname',title:'课程名称',width:100,sortable:'true',align:'center'},
				{field:'xjh',title:'学籍号',width:150,sortable:'true',align:'center'},
				{field:'stuName',title:'姓名',width:80,sortable:'true',align:'center'}
			]
		],
		columns:[
			[
				{field:'tname',title:'授课老师',width:80,sortable:'true',align:'center'},
				{field:'place',title:'上课地点',width:100,sortable:'true',align:'center'},
				{field:'classTime',title:'上课时间',width:150,sortable:'true',align:'center'},
				{field:'ctName',title:'课程类别',width:80,sortable:'true',align:'center'},
				{field:'syName',title:'学年',width:50,sortable:'true',align:'center'},
				{field:'term',title:'学期',width:40,sortable:'true',align:'center'}
				
			]
		],
		pagination:true,
		rownumbers:true
   });
   $('#cancelsignup_list').datagrid('getPager').pagination({displayMsg:'当前显示从 {from} 到 {to}条记录  共{total}条记录', onBeforeRefresh:function(pageNumber, pageSize){	$(this).pagination('loading');$(this).pagination('loaded'); }
	});
}

// 取消报名的课程
function cancelsignupCourse(url){
	$("#btnCancelSignUp").linkbutton({"disabled":true});
	var rows=$("#cancelsignup_list").datagrid("getSelections");
	if(rows.length==0){
		$.messager.alert("提示","请选择取消报名的课程");
	}else{
		var pids=[];
		var cnames=[];
		for(var i=0;i<rows.length;i++){
			pids.push(rows[i].pid);
			cnames.push(rows[i].cname);
		}
		$.messager.confirm('提示', '确认取消课程【'+cnames.join(",")+'】的报名?', function(r){
			if (r){
				var sid=rows[0].sid;
				$.ajax({
					type: 'POST',
					url: url,
					data: {pids: pids.join(":"),sid:sid},
					success: function(data){
						var data=eval('('+data+')');
						if(data.success){
							$.messager.alert("提示","成功取消课程【"+cnames.join("，")+"】的报名!");
							var rows = $('#student_list').datagrid('getSelections');
							var xjh=rows[0].xjh;
							var url=$("#paths").val()+"/course.do?dispatch=queryStudentSignUpCourse";
							queryStudentSignUpCourse(url,{'xjh':xjh});
						}else{
							$.messager.alert("提示","取消课程失败!");
						}
						$("#btnCancelSignUp").linkbutton({"disabled":false});
					}
				});
			}
		});
	}
	
}
		
		
		

 
