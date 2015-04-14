
<%
	pageContext.setAttribute("ctx", request.getContextPath());
%>
<script type="text/javascript" src="js/Calendar3.js"></script>
<script src="js/jquery-1.7.1.js" type="text/javascript"
	language="javascript"></script>
<style type="text/css">
#Layer1 {
	position: absolute;
	width: 843px;
	height: 493px;
	z-index: 1;
	left: 331px;
	top: 146px;
}

#Layer2 {
	position: absolute;
	left: 90px;
}

table {
	border: 1px solid #B1CDE3;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
	text-overflow: ellipsis;
	table-layout: fixed;
}

tr {
	border: 1px solid #B1CDE3;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #000000;
}
.Cspan {

}
.Cspan td {
white-space:nowrap;
overflow: hidden;
text-overflow: ellipsis;
-o-text-overflow: ellipsis;
border: 1px solid #B1CDE3;
	font-size: 12px;
	padding: 2px 2px 2px 6px;
	color: #000000;
}
.autocut:hover
 {
     overflow:visible;
     white-space:normal;
     word-wrap: break-word;
 }

</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("tr:even").addClass("s_oushuhang");//偶数行的背景色
		$("tr:odd").addClass("s_jishuhang");//奇数行的背景色
		$(".table_gehang").delegate("tr", "hover", function() {
			$(this).toggleClass("s_mouseover");
		});
	});
</script>
<style type="text/css">
* {
	margin: 0;
	padding: 0
}

.s_oushuhang {
	background-color: #f5f5f7;
} /*偶数行的背景色*/
.s_jishuhang {
	background-color: #FFFFFF;
} /*奇数行的背景色*/
.table_gehang tr {
	width: 300px;
	line-height: 30px;
}

.STYLE1 {
	color: black;
}

.table_gehang tr td {
	text-align: left;
	padding-left: 5%;
	_padding-left: 4%;
}

.table_gehang .s_mouseover {
	background-color: #f6f6f5;
	color: #ff4200;
} /*鼠标移动改变背景色*/
</style>
</head>
<body>
	<img id="Layer2" usemap="#Layer2Map" src="${ctx}/images/gj.jpg" />
	<map name="Layer2Map">
		<area shape="rect" id="Recordlist" coords="5,204,184,252"
			href="${ctx}/Record_list">
		<area shape="rect" coords="5,258,181,296" href="${ctx}/Route_list">
		<area shape="rect" coords="7,303,168,339" href="${ctx}/Record_list1">
		<area shape="rect" coords="517,67,623,100"
			href="${ctx}/Record_add.jsp">
		<area shape="rect" coords="627,65,721,99" href="${ctx}/Route_add.jsp">
		<area shape="rect" coords="728,66,826,98"
			href="${ctx}/Record_listToday">
	</map>