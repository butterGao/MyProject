<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String url = request.getRequestURI();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>临时卡管理</title>

<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/icon.css">
<script type="text/javascript" src="<%=path%>/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.easyui.min.js"></script>
<script charset="utf-8" src="<%=path%>/js/kindeditor-min.js"></script>
<script charset="utf-8" src="<%=path%>/js/zh_CN.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path%>/js/tempcard_list.js"></script>


<script type="text/javascript">
$("#addwindow").window("open");
		var listurl='<%=path%>/tempCard.do?dispatch=queryTempCardByPage'
		//初始化调用
		function init(){
		  queryinit(listurl,{});
		}
		//查询方法
		function query(){
			var params={};
			params['cardNo']=$('#queryform #cardNo').val();
			params['xjh']=$('#queryform #xjh').val();
			params['realName']=$('#queryform #stuName').val();
			params['status']=$("#queryform #status").val();
		    queryinit(listurl,params);
		}
		
		//关闭窗体
		function closeWindow(wid){
    		window.location.href="<%=url%>";
		//$("#"+wid).window("close");
	}

	//关闭报名窗口
	function closeSignCourse(wid) {
		close1(wid);
		query();
	}

	//关闭取消报名的窗口
	function closeCancelSignUpWindow(wid) {
		close1(wid);
		query();
	}
</script>
</head>
<body onload="query()">
	<div class="easyui-layout" style="width: 100%; height: 100%">
		<div region="north" style="height: 100px" class="easyui-panel"
			title="查询条件" collapsible="false">
			<form id="queryform">
				<table width="100%" border="0"
					style="padding: 5px 10px 0px 10px; font-size: 12px; font-family: 微软雅黑;">
					<tr>
						<td style="width: 80px;">学生姓名：</td>
						<td style="width: 180px;"><input type="text" id="stuName"
							name="stuName" value="" style="width: 180px;" /></td>
						<td style="width: 80px;">学籍号：</td>
						<td style="width: 180px;"><input type="text" id="xjh"
							name="xjh" value="" style="width: 180px;" /></td>
						<td style="width: 80px;">临时卡号：</td>
						<td style="width: 180px;"><input type="text" id="cardNo"
							name="cardNo" value="" style="width: 180px;" /></td>
						<td style="width: 80px;">状态：</td>
						<td style="width: 180px;"><select id="statue" name="status"
							style="width: 180px;">
								<option value="">全部</option>
								<option value="0">使用中</option>
								<option value="1">未使用</option>
						</select></td>
					</tr>
					<tr>
						<td colspan="8" style="text-align: center;"><a
							class="easyui-linkbutton" href="javascript:void(0)"
							onclick="query();">查询</a> <a class="easyui-linkbutton"
							href="javascript:void(0)" onclick="resetForm('queryform');">重置</a>
						</td>
					</tr>
				</table>
			</form>

		</div>
		<div region="center">
			<table id="student_list">

			</table>
		</div>
	</div>


	<!-- 新增 -->
	<div id="addwindow" class="easyui-window" title="新增临时卡"
		collapsible="false" minimizable="false" maximizable="false"
		iconCls="icon-add" style="width: 300px; height: 150px; top: 100px;"
		closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false"
				style="padding: 10px; background: #fff; border: 1px solid #ccc;">
				<form action="<%=path%>/tempCard.do?dispatch=addTempCard"
					method="post" id="saveform">
					<table width="100%" border="0" style="font-size: 13">
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">临时卡号：</td>
							<td style="width: 60%;"><input class="easyui-validatebox"
								type="text" name="cardNo" id="cardNo" value="" required="true"
								missingMessage="临时卡号不能为空!" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div region="south" border="false"
				style="text-align: center; height: 30px; line-height: 30px;">
				<a class="easyui-linkbutton" href="javascript:void(0)"
					onclick="resetForm('saveform');">重置</a> <a 
					class="easyui-linkbutton" href="javascript:void(0)"
					onclick="addTempCard('saveform','addwindow','<%=path%>/tempCard.do?dispatch=addTempCard');">提交</a>
				<a class="easyui-linkbutton" href="javascript:void(0)"
					onclick="close1('addwindow');">取消</a>
			</div>
		</div>
	</div>

	<!-- 使用 -->
	<div id="usewindow" class="easyui-window" title="使用临时卡"
		collapsible="false" minimizable="false" maximizable="false"
		iconCls="icon-add" style="width: 400px; height: 400px; top: 10px;"
		closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false"
				style="padding: 10px; background: #fff; border: 1px solid #ccc;">
				<form action="<%=path%>/tempCard.do?dispatch=useTempCard"
					method="post" id="useform">
					<table width="100%" border="0" style="font-size: 13">
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">临时卡号：</td>
							<td style="width: 60%;"><input type="hidden" name="tempId"
								id="tempId" value="" /> <input type="hidden" name="xjh"
								id="xjh" value="" /> <input type="text" name="cardNo"
								id="cardNo" value="" readonly="readonly" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">学生姓名：</td>
							<td style="width: 60%;"><input class="easyui-validatebox"
								type="text" name="realName" id="realName" required="true"
								missingMessage="学生姓名不能为空" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">性别：</td>
							<td style="width: 60%;"><input type="radio" id="sex"
								name="sex" checked="checked" value="男">男 <input
								type="radio" id="sex" name="sex" value="女">女</td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">出生日期：</td>
							<td style="width: 60%;"><input type="text"
								class="easyui-datebox" id="birthday" name="birthday"
								required="true" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">学校：</td>
							<td style="width: 60%;"><input type="text" name="schoolName"
								id="schoolName" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">年级：</td>
							<td style="width: 60%;"><input name="grade" id="grade"
								value="" class="easyui-combobox" style="width: 130px;" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">班级：</td>
							<td style="width: 60%;"><input type="text" name="banji"
								id="banji" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">父亲姓名：</td>
							<td style="width: 60%;"><input type="text" name="fatherName"
								id="fatherName" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">母亲姓名：</td>
							<td style="width: 60%;"><input type="text" name="motherName"
								id="motherName" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">家庭电话：</td>
							<td style="width: 60%;"><input type="text" name="telephone"
								id="telephone" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">移动电话：</td>
							<td style="width: 60%;"><input type="text" name="phone"
								id="phone" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">家庭地址：</td>
							<td style="width: 60%;"><input style="width: 100%;"
								type="text" name="address" id="address" value="" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div region="south" border="false"
				style="text-align: center; height: 30px; line-height: 30px;">
				<a class="easyui-linkbutton" href="javascript:void(0)"
					onclick="useTempCard('useform','usewindow','<%=path%>/tempCard.do?dispatch=useTempCard');">使用</a>
				<a class="easyui-linkbutton" href="javascript:void(0)"
					onclick="close1('usewindow');">取消</a>
			</div>
		</div>
	</div>

	<!--修改 -->
	<div id="updatewindow" class="easyui-window" title="修改临时卡信息"
		collapsible="false" minimizable="false" maximizable="false"
		iconCls="icon-add" style="width: 400px; height: 400px; top: 10px;"
		closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false"
				style="padding: 10px; background: #fff; border: 1px solid #ccc;">
				<form action="<%=path%>/tempCard.do?dispatch=updateTempCard"
					method="post" id="updateform">
					<table width="100%" border="0" style="font-size: 13">
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">临时卡号：</td>
							<td style="width: 60%;"><input type="text" name="cardNo"
								id="cardNo" value="" readonly="readonly" /> <input
								type="hidden" name="tempId" id="tempId" value="" /> <input
								type="hidden" name="xjh" id="xjh" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">学生姓名：</td>
							<td style="width: 60%;"><input class="easyui-validatebox"
								type="text" name="realName" id="realName" required="true"
								missingMessage="学生姓名不能为空" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">性别：</td>
							<td style="width: 60%;"><input type="radio" id="sex"
								name="sex" checked="checked" value="男">男 <input
								type="radio" id="sex" name="sex" value="女">女</td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">出生日期：</td>
							<td style="width: 60%;"><input class="easyui-datebox"
								id="qBirthday" name="birthday" required="true" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">学校：</td>
							<td style="width: 60%;"><input type="text" name="schoolName"
								id="schoolName" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">年级：</td>
							<td style="width: 60%;"><input name="grade" id="qGrade"
								value="" class="easyui-combobox" style="width: 130px;" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">班级：</td>
							<td style="width: 60%;"><input type="text" name="banji"
								id="banji" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">父亲姓名：</td>
							<td style="width: 60%;"><input type="text" name="fatherName"
								id="fatherName" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">母亲姓名：</td>
							<td style="width: 60%;"><input type="text" name="motherName"
								id="motherName" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">家庭电话：</td>
							<td style="width: 60%;"><input type="text" name="telephone"
								id="telephone" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">移动电话：</td>
							<td style="width: 60%;"><input type="text" name="phone"
								id="phone" value="" /></td>
						</tr>
						<tr>
							<td style="width: 30%; margin-left: 10px; text-align: left">家庭地址：</td>
							<td style="width: 60%;"><input style="width: 100%;"
								type="text" name="address" id="address" value="" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div region="south" border="false"
				style="text-align: center; height: 30px; line-height: 30px;">
				<a class="easyui-linkbutton" href="javascript:void(0)"
					onclick="updateTempCard('updateform','updatewindow','<%=path%>/tempCard.do?dispatch=updateTempCard');">提交</a>
				<a class="easyui-linkbutton" href="javascript:void(0)"
					onclick="close1('updatewindow');">取消</a>
			</div>
		</div>
	</div>

	<!-- 报名 -->
	<div id="signupwindow" class="easyui-window" title="课程报名"
		collapsible="false" minimizable="false" maximizable="false"
		iconCls="icon-add" style="width: 816px; height: 400px; top: 10px;"
		closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false"
				style="background: #fff; border: 0px solid #ccc;">
				<div style="width: 800px; height: 120px; margin-top: 5px;"
					class="easyui-panel" title="查询条件">
					<form id="signupqueryform">
						<table
							style="width: 100%; font-size: 12px; font-family: 微软雅黑; padding-left: 10px;"
							border="0" cellpadding="0" cellspacing="0">
							<tr height="30px">
								<td style="width: 60px;">课程编号</td>
								<td style="width: 120px;"><input type="text" id="cno"
									name="cno" style="width: 120px;"></td>
								<td style="width: 60px;">课程名称</td>
								<td style="width: 120px;"><input type="text" id="cname"
									name="cname" style="width: 120px;"></td>
								<td style="width: 60px;">学年</td>
								<td style="width: 120px;"><input class="easyui-combobox"
									id="schoolYear" name="schoolYear" style="width: 120px;">
								</td>
								<td style="width: 60px;">学期</td>
								<td style="width: 120px;"><select id="term" name="term"
									class="easyui-combobox" style="width: 120px;">
										<option value=""></option>
										<option value="1">1</option>
										<option value="2">2</option>
								</select></td>
							</tr>
							<tr height="30px">
								<td style="width: 60px;">课程类别</td>
								<td style="width: 120px;"><input class="easyui-combobox"
									id="courseType" name="courseType" style="width: 120px;">
								</td>
								<td style="width: 60px;">授课老师</td>
								<td style="width: 120px;"><input type="text" id="tname"
									name="tname" style="width: 120px;"></td>
							</tr>
							<tr height="30px">
								<td colspan="8" style="text-align: center"><a
									class="easyui-linkbutton" href="javascript:void(0)"
									onclick="querySignupCourse();">查询</a> <a
									class="easyui-linkbutton" href="javascript:void(0)"
									onclick="resetForm('signupqueryform');">重置</a></td>
							</tr>
						</table>
					</form>
				</div>
				<div style="width: 800px; overflow: hidden;" class="easyui-panel"
					title="查询结果">
					<table id="signupCourse" style="width: 800px;">

					</table>
				</div>
			</div>
			<div region="south" border="false"
				style="text-align: center; height: 30px; line-height: 30px;">
				<a class="easyui-linkbutton" href="javascript:void(0)"
					id="btnSignUp"
					onclick="signupCourse('<%=path%>/tempCard.do?dispatch=signupCourse');">报名</a>
				<a class="easyui-linkbutton" href="javascript:void(0)"
					onclick="closeSignCourse('signupwindow');">关闭</a>
			</div>
		</div>
	</div>

	<!-- 取消报名 -->
	<div id="cancelsignupwindow" class="easyui-window" title="取消课程报名"
		collapsible="false" minimizable="false" maximizable="false"
		iconCls="icon-add" style="width: 816px; height: 400px; top: 10px;"
		closed="true">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false"
				style="background: #fff; border: 0px solid #ccc;">
				<table id="cancelsignup_list" style="width: 800px;">

				</table>
			</div>
			<div region="south" border="false"
				style="text-align: center; height: 30px; line-height: 30px;">
				<a class="easyui-linkbutton" href="javascript:void(0)"
					id="btnCancelSignUp"
					onclick="cancelsignupCourse('<%=path%>/tempCard.do?dispatch=cancelSignupCourse');">取消报名</a>
				<a class="easyui-linkbutton" href="javascript:void(0)"
					onclick="closeCancelSignUpWindow('cancelsignupwindow');">关闭</a>
			</div>
		</div>
	</div>

	<div style="display: none">
		<input type="hidden" id="paths" name="paths" value="<%=path%>" />
	</div>

</body>
</html>