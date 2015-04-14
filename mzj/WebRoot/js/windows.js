var height=$(window).height();
$(function() {
	if(height<580){ 
		height=580; 
	}  
	$("#backgroud").height(height);
}); 

function windowClose(){
	window.close();
}

function goUrl(url){
	location.href=encodeURI(encodeURI(url));
}
function fanhui(){
	history.go(-1);
}


function getval(id){
	return $("#"+id).val();
}
function showClose(id){
	$("#bg").hide();
	$("#"+id).hide("normal");
}
function closeWin(){
	$(".show").hide("normal");
	$(".bigshow").hide("normal");
	$(".bigshows").hide("normal");
	$("#bg").hide();
}
function showCloseA(id){
	$("#"+id).hide("normal");	
}
function showWinA(id){
	$("#"+id).show("normal");
}
function showWin(id){
	closeWin();
	$("#"+id).show("normal");
}

function checkd(id){  

	$("#che"+id).attr("checked", true);
}
function cheRadio(id){ 
	$("#che"+id).attr("checked", true);
	$("input[id^=cge]").attr("checked", false);
	
}

function addInfos(id,msg){
	("#"+id).addClass("has-error");
	$("#"+id).append('<label name="infos" class="control-label" >'+msg+'</label>');
}
function removeInfos(){
	$("label[name='infos']").remove();
}

function showdiv(id) {
	$("#bg").toggle();
	$("#"+id).toggle("normal");
}
//填出消息框
function alertClose(){
	$("#alertWin").hide("normal");
	$("#bg").hide();
}

function alertWins(method,msg){
	$("#alertWin").remove();
	var html='<div id="alertWin" class="show"> <div  style="margin-top: 65%;text-align: center;">'
		+msg+'</div><div style="margin-top: 25%">' 
		+' <div onclick="'+method+'()" class="button buttonimg2" style="float: left;width: 30%;margin-left: 15%;"> 确 定 </div>'
		+'<div id="alertClose" onclick="alertClose()" class="button buttonimg2" style="float: right;width: 30%;margin-right: 15%;"> 取 消 </div> </div></div> ';  
	$("body").append(html);
	$("#bg").show();
	$("#alertWin").show("normal");
} 
function alertWin(msg){
	$("#alertWin").remove();
	var html='<div id="alertWin" class="show"> <div  style="margin-top: 65%;text-align: center;">'+msg+'</div><div style="margin-top: 25%"> <div id="alertClose" onclick="alertClose()" class="button buttonimg2" style="float: right;width: 30%;margin-right: 15%;"> 取 消 </div> </div></div> ';  
	$("body").append(html);
	$("#bg").show(); 
	$("#alertWin").show("normal");
}
