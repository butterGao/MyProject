function queryUserx(url, params) {
	$('#elist')
			.datagrid(
					{
						pageSize : 10,
						pageList : [ 5, 10, 15, 20, 25, 30, 35, 40, 45, 50 ],
						nowrap : true,
						striped : true,
						collapsible : true,
						url : url,
						queryParams : params,
						loadMsg : '数据装载中......',
						remoteSort : false,
						fitColumns : true,
						singleSelect : true,
						frozenColumns : [ [ {
							field : 'id',
							checkbox : true
						} ] ],
						columns : [ [
								{
									field : 'title',
									title : '标题',
									width : 100,
									align : 'center'
								},
								{
									field : 'creatTime',
									title : '时间',
									width : 100,
									align : 'center',
									formatter : function(value, row) {
										return row.creatTime.substring(0, 11);
									}
								},
								{
									field : 'opt',
									title : '操作',
									width : 50,
									align : 'center',
									formatter : function(value, rec) {
										var btn = '<a class="editcls" onclick="editRow(\''
												+ rec.projectname
												+ '\',\''
												+ rec.projectpackage
												+ '\')" href="javascript:void(0)">编辑</a>';
										return btn;
									}
								}

						] ],
						pagination : true,
						rownumbers : true,
						onLoadSuccess : function(data) {
							$('.editcls').linkbutton({
								text : '编辑',
								plain : true,
								iconCls : 'icon-edit'
							});
							
						}
					});
	$('#elist').datagrid('getPager').pagination({
		beforePageText : '第',// 页数文本框前显示的汉字
		afterPageText : '页    共 {pages} 页',
		displayMsg : '当前显示{to}条记录   共{total}条记录',
		onBeforeRefresh : function(pageNumber, pageSize) {
			$(this).pagination('loading');
			$(this).pagination('loaded');
		}
	});
}
// 关闭绑定窗体
function closeBindWindow(wid) {
	$("#" + wid).window("close");
}