<!DOCTYPE html>
<html>
<head>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
        $('#myModal').on('show', function() {
       		var id = $(this).data('id'),
            removeBtn = $(this).find('.danger');
        });
		$('.confirm-delete').on('click', function(e) {
   			e.preventDefault();
			console.log("Clicked");
    		var id = $(this).data('id');
    		$('#myModal').data('id', id).modal('show');
		});
		$('#btnYes').click(function() {
		    // handle deletion here
		  	var id = $('#myModal').data('id');
		  	$('[data-id='+id+']').remove();
  			$('#myModal').modal('hide');
		});
	}
</script>
</head>
<body>
	<div class="container">
		<a href="#" class="confirm-delete" data-id="1">Delete</a><br> <a
			href="#" class="confirm-delete" data-id="2">Delete</a><br> <a
			href="#" class="confirm-delete" data-id="3">Delete</a><br> <a
			href="#" class="confirm-delete" data-id="4">Delete</a><br>
	</div>

	<div id="myModal" class="modal hide">
		<div class="modal-header">
			<a href="#" data-dismiss="modal" aria-hidden="true" class="close">×</a>
			<h3>Delete</h3>
		</div>
		<div class="modal-body">
			<p>You are about to delete.</p>
			<p>Do you want to proceed?</p>
		</div>
		<div class="modal-footer">
			<a href="#" id="btnYes" class="btn danger">Yes</a> <a href="#"
				data-dismiss="modal" aria-hidden="true" class="btn secondary">No</a>
		</div>
	</div>
</body>
</html>
