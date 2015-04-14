<script type="text/javascript" src="../js/jquery.pagination.js"></script>
<link rel="stylesheet" href="../js/pagination.css" />
function dd(index,title,id){
		$("#Pagination").pagination(index, {
			num_edge_entries: 1, //边缘页数
			num_display_entries: 4, //主体页数
			callback: pageselectCallback,
			items_per_page:10, //每页显示1项
			prev_text: "前一页",
			next_text: "后一页"
		});
		function pageselectCallback(p, jq){
			showList(id,title,p+1);
			return false;
		}
	}
	function init(id,title){
		var url="ajax_showlist";
		$.ajax({
			   type: "POST",
			   url: url,
			   data: "id="+id,
			   success: function(msg){
				   var data=eval('('+msg+')');
				   dd(data.one.totalRecords,title,id);
			   }
			});
	}
	<br>
		<div id="Pagination" class="pagination"></div>