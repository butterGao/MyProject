<!DOCTYPE HTML>
<html>
  <head>
  	<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
	<script type="text/javascript" src="../js/jquery1.11.js"></script> 
	<script type="text/javascript" src="../js/bootstrap.js"></script> 
  	<link rel="stylesheet" type="text/css" href="../js/datepicker3.css">
	<script type="text/javascript" src="../js/bootstrap-datepicker.js"></script> 
  </head>
  <body>
         <div class="input-daterange input-group" id="datepicker">
    	<input id="aa" type="text" class="input-sm form-control" name="start" />
    	<span class="input-group-addon">to</span>
    	<input id="bb" type="text" class="input-sm form-control" name="end" />
    </div>
  </body>
  <script type="text/javascript">
		   $("#aa").datepicker({
			    autoclose: true,
			    todayHighlight: true
			    });
		   $("#bb").datepicker({
			    autoclose: true,
			    todayHighlight: true
			    });
</script> 
</html>