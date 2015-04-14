$(function(){
		 var grid_selector = "#grid-table";
			var pager_selector = "#grid-pager";
			var path=$("#root").val();
			
		jQuery("#grid-table").jqGrid({
			//direction: "rtl",
			url:path+"/qiandao/show",
			datatype: "json",
			height:$('#iframe', parent.document).height()-140,
			jsonReader : {
				id: "ID",
				root: "list",
				page: "pageNumber",
				total: "totalPage",
				records: "totalRow",
				repeatitems: false,
				},
			colNames:['用户名','电话','签到时间','定位'],
			colModel:[
				{name:'UNAME',index:'UNAME', width:60,},
				{name:'PHONE',index:'PHONE',width:60,},
				{name:'CREATETIME',index:'CREATETIME', width:60},
				{name:'ID',index:'ID',width:20,formatter: function(cellvalue, options, cell){
					return "<button class='btn btn-default' onclick=\"dingwei('"+cell.LAT+"','"+cell.LNG+"')\">签到位置</button>";
				}},
			], 
			viewrecords : true,
			rowNum:10,
			rowList:[10,20,30],
			pager : pager_selector,
			altRows: true,
			//toppager: true,
			
			multiselect: true,
			//multikey: "ctrlKey",
	        multiboxonly: true,

			loadComplete : function() {
				var table = this;
				setTimeout(function(){
					styleCheckbox(table);
					updateActionIcons(table);
					updatePagerIcons(table);
					enableTooltips(table);
				}, 0);
			},
			editurl: path+"/task/col",//nothing is saved 
			caption: "签到管理",
			autowidth: true,
		});
		
		jQuery(grid_selector).jqGrid('navGrid',pager_selector,
				{ 	//navbar options
					edit: false,
					editicon : 'icon-pencil blue',
					edittext:'编辑',
					add: false,
					addicon : 'icon-plus-sign purple',
					addtext:'添加',
					del: false,
					delicon : 'icon-trash red',
					deltext:'删除',
					search: false,
					searchicon : 'icon-search orange', 
					refresh: true,
					refreshicon : 'icon-refresh green',
					refreshtext:'刷新',
					view: false,
					viewicon : 'icon-zoom-in grey',
					viewtext:'查看',
				},
				{
					//edit record form
					closeAfterEdit: true,
					recreateForm: true,
					beforeShowForm : function(e) {
						var form = $(e[0]);
						form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
						style_edit_form(form);
					}
				,beforeSubmit:function(){
						return jqCheckTime($("#STARTTIME").val(), $("#ENDTIME").val());
					}
				},
				{
					//new record form
					closeAfterAdd: true,
					recreateForm: true,
					viewPagerButtons: false,
					beforeShowForm : function(e) {
						var form = $(e[0]);
						form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
						style_edit_form(form);
					},
					beforeSubmit:function(){
						return jqCheckTime($("#STARTTIME").val(), $("#ENDTIME").val());
					}
				},
				{
					//delete record form
					recreateForm: true,
					beforeShowForm : function(e) {
						var form = $(e[0]);
						if(form.data('styled')) return false;
						
						form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
						style_delete_form(form);
						 
						form.data('styled', true);
					},
				},

				{
					//view record form
					recreateForm: true,
					beforeShowForm: function(e){
						var form = $(e[0]);
						form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
					}
				}
			);
}); 
