function rebind() {
    //bind table buttons to ajax request
    $('.table_button').on('click', function () {
        var data = {"table_id": this.id}
        viewOrders(data);
    });

    viewOrders();
}

function home() {
    $.ajax({
        url: 'waitstaff',
        method: 'get',
        complete: function (response) {
            var table_info = $($.parseHTML(response)).find('#table_info').html()
            var side_bar = $($.parseHTML(response)).find('#sb').html()
            $('#table_info').html(table_info)
            $('#side_bar').html(side_bar)
            rebind();
        }
    });
}
function statusRefresh() {
    var data = {"table_id": $('.open_new_order').attr('id')}
    viewOrders(data);
}

var timerID = 0;


function viewOrders(data) {
    $.ajax({
        url: 'waitstaff/vieworders',
        method: 'post',
        data: data,
        success: function (response) {
            var table = $($.parseHTML(response)).find('#orders').html()
            //update table if a change is detected
            if(table != $('#table_info').html())
                $('#table_info').html(table)
        },
        complete: function () {

            clearInterval(timerID)
            timerID = setInterval(function () {
                statusRefresh();
            }, 5000);

            $('.open_new_order').on('click', function () {
                clearInterval(timerID)
                newOrder({'table_id': this.id})
            });

            //remove order
            $('.delete_order').on('click', function () {
                var data2 = {'id': ($(this).closest('tr')).attr('id')}

                $.ajax({
                    url: 'waitstaff/deleteorder',
                    method: 'post',
                    data: data2,
                    dataType: 'js',
                    complete: function () {
                        viewOrders(data)
                    }
                });
            });

            //EDIT EXISTING ORDER
            $('.edit_order').on('click', function () {

                clearInterval(timerID)

                var data2 = {'id': ($(this).closest('tr')).attr('id')}
                $.ajax({
                    url: 'waitstaff/editorder',
                    method: 'post',
                    data: data2,
                    dataType: 'html',
                    success: function (response) {
                        var update_form = $($.parseHTML(response)).find('#update_order').html()
                        $('#table_info').html(update_form)
                    },
                    complete: function () {
                        //fade out the row and then remove from the table when remove clicked
                        $('.item_remove').on('click', function () {
                            $(this).closest('tr').fadeOut({
                                complete: function () {
                                    $(this).remove();
                                }
                            });
                        });

                        //update the order
                        $('#submit_update').on('click', function () {
                            var rows = $('#order_items tr')
                            var data = []
                            $.each(rows, function () {
                                var menu_item = $(this.cells[0]).html()
                                var order_item_id = $(this.cells[0]).attr('id')
                                var menu_item_note = $(this).find('.note').val()
                                data.push({ 'order_item_id': order_item_id, 'menu_item': menu_item, 'menu_item_note': menu_item_note })
                            });
                            data = {'order': data, 'update': true, 'id': data2.id}
                            $.ajax({
                                url: 'waitstaff/editorder',
                                data: data,
                                method: 'post',
                                complete: function (xhr) {
                                    $.jGrowl(xhr.responseText);
                                    home();
                                }
                            });
                        });
                    }
                });
            });
        }
    });
}

function newOrder(data) {
    $.ajax({
        url: 'waitstaff/neworder',
        method: 'post',
        data: data,
        success: function (response) {
            var order_form = $($.parseHTML(response)).find('#new_order').html()
            var side_bar = $($.parseHTML(response)).find('#menu').html()
            $('#table_info').html(order_form)
            $('#side_bar').html(side_bar)
        },
        complete: function () {
            //add items to the order form (|item name||notes|)
            $('.item').on('click', function () {
                //match all characters before < to remove to i-tags from the item names
                var regex = /^[^<]*/;
                var item_name = $.trim($(this).html().match(regex)[0])
                var item = "<tr>" +
                    "<td>" + item_name + "</td>" +
                    "<td><input type='text' class='note' style='width: 96%;' value='' /></td>" +
                    "<td><button class='btn btn-danger btn-small order_remove'>Remove</button> </td>" +
                    "</tr>";

                $('#order_items').append(item);

                //fade out the row and then remove from the table when remove clicked
                $('.order_remove').on('click', function () {
                    $(this).closest('tr').fadeOut({
                        complete: function () {
                            $(this).remove();
                        }
                    });
                });
            });
            $('#submit_order').on('click', function () {
                var rows = $('#order_items tr')
                var data = []
                $.each(rows, function () {
                    var menu_item = $(this.cells[0]).html()
                    var menu_item_note = $(this).find('.note').val()
                    data.push({ 'menu_item': menu_item, 'menu_item_note': menu_item_note })
                });

                data = {'orders': data}

                $.ajax({
                    url: 'waitstaff/saveorder',
                    data: data,
                    method: 'post',
                    complete: function (xhr) {
                        $.jGrowl(xhr.responseText);
                        home();
                    }
                });

            });
        }
    });
}

$('document').ready(function () {

    rebind();

});