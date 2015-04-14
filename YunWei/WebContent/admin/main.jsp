<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<link rel="stylesheet" type="text/css" href="../js/easyui.css">
<link rel="stylesheet" type="text/css" href="../js/icon.css">
<script type="text/javascript" src="../js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="../js/ChineseCalendar.js"></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
<style type="text/css">
a {
	text-decoration: none;
	color: blue;

}

body {
	background-color: #DDD;
}
</style>
<script>
	$(function() {
		var _tabPanel = $("#main");
		freshAD();
		$(".easyui-accordion")
				.find("a[link]")
				.each(
						function() {
							$(this)
									.click(
											function() {
												var url = $(this).attr("link");
												var title = $(this).html();
												if (url !== "#" && url !== "") {
													if (!_tabPanel.tabs(
															'exists', title)) {
														_tabPanel
																.tabs(
																		'add',
																		{
																			title : title,
																			content : '<iframe src="'
																					+ url
																					+ '" style="padding:0;margin:0;border:0;width:100%;height:100%;"></iframe>',
																			closable : true
																		});
														bindfresh(title);
													} else {
														_tabPanel
																.tabs('select',
																		title);
													}
												}
											});
						});//end each
		window.document.addTab = function(url, title) {
			var _tabPanel = $("#main");
			if (!_tabPanel.tabs('exists', title)) {
				_tabPanel
						.tabs(
								'add',
								{
									title : title,
									content : '<iframe src="'
											+ url
											+ '" style="padding:0;margin:0;border:0;width:100%;height:100%;"></iframe>',
									closable : true
								});
				bindfresh(title);
			} else {
				_tabPanel.tabs('select', title);
			}
		}//end window.document.addTab

	});//end ready
	
	
	function freshAD() {
		var AdHtml = "<font color='red'>现在时间：" + new Date().format("hh:mm:ss")
				+ "&nbsp;&nbsp;今天：" + getChineseCalendar() + "</font>";
		$("#opt_info").panel({
			title : AdHtml
		});
		$("#fooottitle").text = AdHtml;
		setTimeout("freshAD()", 500);
	}
	function goHome() {
		$("#main").tabs('select', "后台首页");
	}
	function wopen(url) {
		window
				.open(
						url,
						'newwindow',
						'height=800,width=1100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no')
	}
	function bindfresh(title) {
		/*双击刷新TAB选项卡*/
		$(".tabs-inner").dblclick(function() {
			var _ctab = $('#main').tabs('getTab', title);
			var html = _ctab.html();
			_ctab.html(html);
		});//end $(".tabs-inner").dblclick
	}
	function over() {
		alert("尚未开发完");
	}
</script>
</head>
<body class="easyui-layout" style="text-align: left">
	<div region="north" style="height: 72px;">
		<div class="easyui-layout" style="height: 70px;">
		<div 
				style="background:url(${ctx}/images/toph.png);  height: 88px;  padding: 0; margin: 0;"
				>
			</div>
			<div region="center" align="right"
				style="background:url(${ctx}/images/header.png); background-repeat:no-repeat; height: 48px;  padding: 0; margin: 0;"
				border="false">
				<br>
				<br>
				<a href="../" class="easyui-linkbutton" plain="true"
					icon="icon-next" target="_blank">网站首页</a> <a onclick="window.close()"
					class="easyui-linkbutton" plain="true" icon="icon-undo">退出系统</a> <br />
			</div>
		</div>
	</div>

	<div region="west" split="false" icon="icon-info" title="后台系统菜单"
		style="width: 208px;">
		<div class="easyui-accordion" border="false">
			<div title="栏目管理" iconCls="icon-folder" style="padding: 10px;">
				<ul class="easyui-tree">
					<li><span><a link="cpolicy_list">编辑栏目</a></span></li>
					<li><span><a link="floatw_show">幻灯管理</a></span></li>
					<li state="open"><span>模块管理</span>
						<ul>
						<li><span><a link="entry_indst?cid=1">政策流程模块</a></span></li>
						<li><span><a link="entry_indst?cid=2">工作推进模块</a></span></li>
						<li><span><a link="entry_indst?cid=3">公告通知模块</a></span></li>
						</ul></li>
					
					<!-- <li><span><a link="#" onclick="over()">首页信息</a></span></li> -->
				</ul>
			</div>
			<div title="信息管理" iconCls="icon-folder" style="padding: 10px;">
				<ul class="easyui-tree">
					<li state="open"><span>政策流程</span>
						<ul>
							<li><span><a link="entry_list?cid=11&ccid=1">国家部门政策</a></span></li>
							<li><span><a link="entry_edit?id=3">职责方针</a></span></li>
							<li><span><a link="entry_list?cid=14&ccid=1">制度</a></span></li>
							<li><span><a link="entry_list?cid=15&ccid=1">工作流程</a></span></li>
						</ul></li>
					<li state="closed"><span>工作推进</span>
						<ul>
							<li><span><a link="entry_list?cid=21&ccid=2">阶段性工作情况通报</a></span></li>
							<li><span><a link="entry_list?cid=22&ccid=2">巡检工作计划</a></span></li>
							<li><span><a link="entry_list?cid=23&ccid=2">季度工作汇报及相关报表</a></span></li>
							<li><span><a link="entry_list?cid=24&ccid=2">活动保障</a></span></li>
							<li><span><a link="entry_list?cid=25&ccid=2">运维服务培训</a></span></li>
							<li><span><a link="entry_list?cid=26&ccid=2">运维设备清洗保养工作</a></span></li>
						</ul></li>
					<li state="closed"><span>宣传展示</span>
						<ul>
							<li><span><a link="entry_listc?id=31">总包介绍</a></span></li>
							<li><span><a link="entry_list?cid=32&ccid=3">分包介绍</a></span></li>
							<li><span><a link="entry_list?cid=33&ccid=3">运维信息</a></span></li>
							<li><span><a link="entry_listc?id=34">成果展示</a></span></li>
							<li><span><a link="entry_list?cid=35&ccid=3">活动花絮</a></span></li>
							<li><span><a link="entry_list?cid=36&ccid=3">故障案例</a></span></li>
								<li><span><a link="entry_list?cid=37&ccid=3">经验分享</a></span></li>
						</ul></li>
					<li state="closed"><span>意见反馈</span>
						<ul>
							<li><span><a link="entry_list?cid=41&ccid=4">考核评价</a></span></li>
							<li><span><a link="entry_list?cid=42&ccid=4">统计成功</a></span></li>
							<li><span><a link="entry_list?cid=43&ccid=4">投诉</a></span></li>
						</ul></li>
					<li state="closed"><span>网上报修</span>
						<ul>
							<li><span><a link="entry_list?cid=51">网上报修</a></span></li>
							<li><span><a link="entry_list?cid=52">网上预约</a></span></li>
							<li><span><a link="entry_list?cid=53">预约保障</a></span></li>
							<li><span><a link="entry_list?cid=54">网上咨询</a></span></li>
						</ul></li>
					<li state="closed"><span>电子地图</span>
						<ul>



						</ul></li>
					<li state="closed"><span>客户查询</span>
						<ul>
 
 						</ul></li>
				</ul>
			</div>
			<div title="页面管理" iconCls="icon-folder" style="padding: 10px;">
				<ul class="easyui-tree">
					<!-- <li><span><a link="floatw_show">浮动窗口管理</a></span></li> -->
					<li><span><a link="#">连接管理</a></span></li>
				</ul>
			</div>
			<div title="数据对接" iconCls="icon-folder" style="padding: 10px;">
				<ul class="easyui-tree">
					<li><span><a link="#" onclick="over()">数据管理</a></span></li>
					<li><span><a link="#" onclick="over()">数据显示</a></span></li> 
				</ul>
			</div>
			<!-- <div title="日志记录" iconCls="icon-folder" style="padding: 10px;">
				<ul class="easyui-tree">
					<li><span><a link="#">记录管理</a></span></li>
					<li><span><a link="#">记录信息</a></span></li>
				</ul>
			</div>
			<div title="安全管理" iconCls="icon-folder" style="padding: 10px;">
				<ul class="easyui-tree">
					<li><span><a link="#">权限管理</a></span></li>
					<li><span><a link="#">字段过滤</a></span></li>
					<li><span><a link="#">限制访问IP</a></span></li>
				</ul>
			</div> -->
		</div>
	</div>

	<div id="opt_info" border="false" region="center">
		<div id="main" class="easyui-tabs" fit="true" border="false"
			plain="true">
		</div>
	</div>
	<script type="text/javascript">
$(function(){window.document.addTab("floatw_show","幻灯管理");});
</script>
</body>
</html>
