<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<script type="text/javascript" src="js/jquery-1.7.1.js"></script>
</head>
<style type="text/css">
body {
    margin:0 auto;
	 background-color:#CCCCCC;
	background-image: url(images/bg0.png);
	background-repeat: repeat-x;
	text-align:center;
}
.loginbg{
    position:relative;
    background:url(images/12.png) no-repeat;
	width:770px;
	height:430px;
	margin:0 auto;
	margin-top:92px;
	
}
.dlbg{
   position:relative;
   background:url(images/12.png) no-repeat;
   width:366px;
   height:219px;
   margin:0 auto;
   margin-top:118px;
   clear:both;
   
}
.input1{
    
    background:url(images/input.png) no-repeat;
	width:189px;
	height:27px;
	
	padding-left:8px;
	padding-top:3px;
	border:0px;
	
}

.input3{
     
    background:url(images/input1.png) no-repeat;
	
	width:93px;
	height:27px;
	
	padding-left:8px;
	padding-top:3px;
	border:0px;
}
.button{
   position:relative;
   margin-left:222px;
   clear:both;
}
.code{
background-image:url(code.jpg);
font-family:Arial;
font-style:italic;
color:Red;
border:0;
padding:2px 3px;
letter-spacing:3px;
font-weight:bolder;
}
.unchanged {
border:0;
}
</style>
<script type="text/javascript">
function check_f(){
    var name=$("#use").val();
    var pwd=$("#pwd").val();
    if(name==""||pwd==""){
   	 alert("用户密码不能为空");
   	 return false;
   	 }
    $.ajax({
				type : "POST",
				url : "loginuser",
				async:false,
				data :{user:$("#use").val(),pass:$("#pwd").val()},
				contentType : 'application/x-www-form-urlencoded;charset=utf-8',
				success : function(data) {
					var value=eval("("+data+")");
					if(value.b){
						window.location="page/init";
					}else{
						alert("用户名 或者密码错误");
					}
				}
			});
    /* document.login_f.submit(); */
  
    }
</script>
</head>
<body >
<div class="loginbg" >
  <table width="366" border="0" align="center" cellpadding="0" cellspacing="0" height="337" style="margin-left: 220px;">
    <tr>
      <td height="140">&nbsp;</td>
    </tr>
    <tr>
      <td height="220" valign="top" style="background:url(images/bg11.png) no-repeat">
					<!-- 	<form action="iappuser.do?dispatch=login" method="post"
							onSubmit="return validate();"> -->
							<table width="80%" border="0" align="center" cellpadding="0"
								cellspacing="0">
								<tr>
									<td width="24%" height="55">
										&nbsp;
									</td>
									<td width="76%">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
									<td align="left">
										<input name="uses" id="use" type="text" class="input1" />
									</td>
								</tr>
								<tr>
									<td height="45">
										&nbsp;
									</td>
									<td align="left">
										<input name="psw" id="pwd" type="password" class="input1"
											 />
									</td>
								</tr>
								<tr>
									<td height="30">
										&nbsp;
									</td>
								</tr>

								<tr>
									<td height="40">
										&nbsp;
									</td>
									<td align="right">
										<input onclick="check_f()" type="image" src="images/denglu.png"
											style="cursor: pointer;" width="99" height="33" border="0" />
									</td>
								</tr>
							</table>
					<!-- 	</form> -->
					</td>
    </tr>
  </table>
</div>
</body>
</html>