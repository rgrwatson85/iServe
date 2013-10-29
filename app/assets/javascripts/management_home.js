var global_id = 0;

function refresh(item_id) {
	global_id = item_id
	$.ajax({
		url: '/menu_items/' + item_id + '/edit',
		success: function(response) {
			var edit_form = $($.parseHTML(response)).find('.content').html()
			$('#content_area').html(edit_form)
		},
		complete: function() {
			$('#item_cancel').hide()
			$('#item_submit').val('Update Menu Item')
			$("#item_delete").on("click", function(e){
				e.preventDefault()
				console.log(item_id)
				$.ajax({
					url: '/menu_items/' + item_id + '.js',
					dataType: 'js',
					method: 'delete',
					complete: function(xhr){
						showDialog(xhr.responseText)
						$.ajax({
							url: '/management',
							complete: function(xhr) {
								$("#side_bar").html($($.parseHTML(xhr.responseText)).find('#side_bar').html())
								setSidebar()
							}
						})
					}
				});
			})
			$('#item_submit').on('click', function(e) {
				e.preventDefault();
				var data = $(this).closest('form').serialize();
				$.ajax({
					url: '/menu_items/' + item_id + '.js',
					data: data,
					dataType: 'js',
					method: 'patch',
					complete: function(xhr) {
						showDialog(xhr.responseText)
						refresh(item_id)
					}
				});
			});
		}

	});
}

function addItem() {
	$.ajax({
		url: 'menu_items/new',
		dataType: 'html',
		method: 'get',
		complete: function(xhr) {
			var new_form = $($.parseHTML(xhr.responseText)).find('.content').html()
			$('#content_area').html(new_form)
			$("#item_submit").val("Create Menu Item")
			$("#item_delete").hide()
			$("#item_cancel").on("click", function(e) {
				e.preventDefault()
				refresh(global_id)
			})
			$("#item_submit").on("click", function(e) {
				e.preventDefault();
				var data = $(this).closest('form').serialize();
				$.ajax({
					url: '/menu_items',
					data: data,
					dataType: 'js',
					method: 'post',
					complete: function(xhr) {
						showDialog(xhr.responseText)
						$.ajax({
							url: '/management',
							complete: function(xhr) {
								$("#side_bar").html($($.parseHTML(xhr.responseText)).find('#side_bar').html())
								refresh(global_id)
								setSidebar()
							}
						})
					}
				});
			})
		}
	});
}

function setSidebar() {
	$("#add_menu_item").show();
	$("#add_menu_item").on("click", function() {
		addItem();
	});

	$('.item').on('click', function() {
		var item_id = $(this).closest('div').attr('id')
		refresh(item_id);
	});

	$('.accordion-toggle:first').click()
	$('.item:first').click();
}

$(document).ready(setSidebar);
