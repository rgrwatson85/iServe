//GLOBAL VARIABLES ARE BAAAAAAAD BUT I CANT FIGURE OUT A BETTER WAY RIGHT NOW!!
var table_list = null;
var timerID = 0;

function rebind() {
    //unbind click handler previously assigned
    $('.table_button').unbind('click')
    //bind table buttons to ajax request
    $('.table_button').on('click', function () {
        var data = {"table_id": this.id}
        viewOrders(data);
    });
}

function home() {
    $('#side_bar').html(table_list)
    viewOrders()
}

function statusRefresh() {

    //unbind all the click handlers in view orders so they do not fire multiple times
    $('.edit_order').unbind('click')
    $('.delete_order').unbind('click')
    $('.open_new_order').unbind('click')

    var data = {"table_id": $('.open_new_order').attr('id')}
    viewOrders(data);
}

function viewOrders(data) {
    $.ajax({
        url: 'waitstaff/vieworders',
        method: 'post',
        data: data,
        complete: function (xhr) {

            var table = $($.parseHTML(xhr.responseText)).find('#orders').html()
            if (table == null)
                table = xhr.responseText
            //update table if a change is detected
            if (table != $('#table_info').html()) {
                $('#table_info').html(table)
                $.each($('#table_info tr').prop('hover', false), function () {
                    $(this).find('button').css('opacity', 0)
                })

                rebind();
            }

            $('#table_info tr').hover(
                function () {
                    if (this.id) {
                        $(this).find('button').css('opacity', 1)
                    }
                },
                function () {
                    if (this.id) {
                        $(this).find('button').css('opacity', 0)
                    }

                }
            );

            clearInterval(timerID)
            timerID = setInterval(function () {
                statusRefresh();
            }, 5700);

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
                    complete: function (xhr) {
                        $.jGrowl(xhr.responseText)
                        viewOrders(data)
                    }
                });
            });

            //EDIT EXISTING ORDER
            $('.edit_order').on('click', function () {

                function toggleDelete(row, btn, txt) {
                    if (!row.hasClass('delete')) {
                        btn.removeClass('btn-danger').addClass('btn-success')
                        btn.html('Restore Item')
                        txt.attr('disabled', 'disabled')
                        row.children().not(btn.closest('td')).fadeTo(500, .25)
                        row.addClass('delete')

                    } else {
                        btn.removeClass('btn-success').addClass('btn-danger')
                        btn.html('Remove Item')
                        txt.removeAttr('disabled')
                        row.children().fadeTo(500, 1)
                        row.removeClass('delete')
                    }
                }

                clearInterval(timerID)

                var data2 = {'id': ($(this).closest('tr')).attr('id')}
                $.ajax({
                    url: 'waitstaff/editorder',
                    method: 'post',
                    data: data2,
                    dataType: 'html',
                    success: function (response) {
                        var update_form = $($.parseHTML(response)).find('#update_order').html()
                        var side_bar = $($.parseHTML(response)).find('#menu').html()
                        $('#table_info').html(update_form)
                        $('#sb').html(side_bar)
                    },
                    complete: function () {
                        //fade out the row and then remove from the table when remove clicked
                        $('.item_remove').unbind('click')
                        $('.item_remove').on('click', function () {
                            var row = $(this).closest('tr')
                            var btn = $(this)
                            var txt = row.find('.note')
                            toggleDelete(row, btn, txt)
                        });
                        //add items to the order form (|item name||notes|)
                        //note that the order item will have to be submitted through an ajax call so that it has a valid id
                        //add the item to the table on success
                        $('.item').on('click', function () {
                            //match all characters before < to remove to i-tags from the item names
                            var regex = /^[^<]*/;
                            var item_name = $.trim($(this).html().match(regex)[0])
                            var item = "<tr>" +
                                "<td>" + item_name + "</td>" +
                                "<td><input type='text' class='note' style='width: 96%;' value='' /></td>" +
                                "<td><button class='btn btn-danger btn-small item_remove'>Remove Item</button> </td>" +
                                "</tr>";

                            $('#order_items').append(item);

                            //fade out the row and then remove from the table when remove clicked
                            $('.item_remove').unbind('click')
                            $('.item_remove').on('click', function () {
                                var row = $(this).closest('tr')
                                var btn = $(this)
                                var txt = row.find('.note')
                                toggleDelete(row, btn, txt)
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
                                if ($(this).hasClass('delete')) {
                                    data.push({ 'order_item_id': order_item_id, 'menu_item': menu_item, 'menu_item_note': menu_item_note, 'delete': true })
                                } else {
                                    data.push({ 'order_item_id': order_item_id, 'menu_item': menu_item, 'menu_item_note': menu_item_note, 'delete': false })
                                }

                            });
                            data = {'order': data, 'update': true, 'id': data2.id}
                            $.ajax({
                                url: 'waitstaff/editorder',
                                data: data,
                                method: 'post',
                                complete: function (xhr) {
                                    //console.log(xhr.responseText)
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
    table_list = $('#side_bar').html()
    viewOrders();
});