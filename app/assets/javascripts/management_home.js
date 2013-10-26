function refresh(item_id) {
    $.ajax({
        url: '/menu_items/' + item_id + '/edit',
        success: function (response) {
            var edit_form = $($.parseHTML(response)).find('.content').html()
            console.log(edit_form)
            $('#content_area').html(edit_form)
        },
        complete: function () {
            $('.item_cancel').hide()
            $('#item_submit').on('click', function (e) {
                e.preventDefault();
                var data = $(this).closest('form').serialize();
                $.ajax({
                    url: '/menu_items/' + item_id + '.js',
                    data: data,
                    dataType: 'js',
                    method: 'patch',
                    complete: function (xhr) {
                        if (xhr.statusText == "OK ") {
                            showDialog(xhr.responseText)
                        }
                    }
                });
                refresh(item_id)
            });
        }

    });
}

$(document).ready(function () {

    $('.item').on('click', function () {
        var item_id = $(this).closest('div').attr('id')
        refresh(item_id);
    });
    $('.accordion-toggle:first').click()
    $('.item:first').click();

});