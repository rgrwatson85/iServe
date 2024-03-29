var global_id = 0;

function setContent(item_id) {
	global_id = item_id
	$.ajax({
		url: 'management/menu_items/' + item_id + '/edit',
		success: function(response) {
			var edit_form = $($.parseHTML(response)).find('.content').html()
			$('#content_area').html(edit_form)
		},
		complete: function() {
			$('#item_cancel').hide()
			$('#item_submit').val('Update Menu Item')
			$("#item_delete").on("click", function(e){
				e.preventDefault()
				callMenuItem('delete', null)
			})
			$('#item_submit').on('click', function(e) {
				e.preventDefault();
				var data = $(this).closest('form').serialize();
				callMenuItem('patch', data)
			});
		}

	});
	
	function callMenuItem(method, data){
		$.ajax({
			url: 'management/menu_items/' + global_id,
			data: data,
			dataType: 'script',
			method: method,
			complete: function(xhr){
				showDialog(xhr.responseText)
				refresh()
			}
		});
	}
	
}

function addItem() {
	$.ajax({
		url: 'management/menu_items/new',
		dataType: 'html',
		method: 'get',
		complete: function(xhr) {
			var new_form = $($.parseHTML(xhr.responseText)).find('.content').html()
			$('#content_area').html(new_form)
			$("#item_submit").val("Create Menu Item")
			$("#item_delete").hide()
			$("#item_cancel").on("click", function(e) {
				e.preventDefault()
				setContent(global_id)
			})
			$("#item_submit").on("click", function(e) {
				e.preventDefault();
				var data = $(this).closest('form').serialize();
				$.ajax({
					url: 'management/menu_items/',
					data: data,
					dataType: 'script',
					method: 'post',
					complete: function(xhr) {
						showDialog(xhr.responseText)
						if (xhr.getResponseHeader('toggle_refresh') == 'true')
							refresh()
					}
				});
			})
		}
	});
}

function refresh() {
	
	$.ajax({
		url: '/management',
		complete: function(xhr) {
			$("#side_bar").html($($.parseHTML(xhr.responseText)).find('#side_bar').html())

			$("#add_menu_item").show();
			
			$("#add_menu_item").on("click", function() {
				addItem();
			});

			$('.item').on('click', function() {
				var item_id = $(this).closest('div').attr('id')
				setContent(item_id);
			});

			$('.accordion-toggle:first').click()
			$('.item:first').click();
		}
	})
}

$(document).ready(refresh);
