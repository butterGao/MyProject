var treeObj;
$(function(){
	var list = new Array();
	function getTreeData(id, pId, name,iconOpen,iconClose) {
		this.id = id;
		this.pId = pId;
		this.name = name;
		this.iconOpen=iconOpen;
		this.iconClose=iconClose;
	}
	
	var setting = {
			check: {
				enable: true,
				chkboxType:{ "Y" : "ps", "N" : "ps" }
			},
			data: {
				simpleData: {
					enable: true,
				}
			}
};
$.ajax({
		type : "POST",
		url :getval('root')+"/au/queryUserForTree",
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		success : function(data) {
				var list = new Array();
			$.each(data,function(i,o) {
				list.push(new getTreeData(o.ID,o.PID,o.NAME));
			});
			treeObj=$.fn.zTree.init($("#treeDemo"), setting,list);
		}
	});
});
function getOtherid(){
	 var data="";
	 var nodes = treeObj.getCheckedNodes(true);
		$.each(nodes,function(i,o) {   
			if(o.level==2){
				data+=o.id+",";
			}
		});
		return data;
}
function getNameAndId(){
	 var data="";
	 var nodes = treeObj.getCheckedNodes(true);
		$.each(nodes,function(i,o) {   
			if(o.level==2){
				data+=o.id+","+o.name+";";
			}
		});
		return data;
}