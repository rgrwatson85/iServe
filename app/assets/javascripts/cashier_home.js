var timerID = 0;

function statusRefresh() {

    var data = {"from_cashier": "true","table_id": $('.process_all_payment').attr('id')}
    viewOrders(data);
}

function viewOrders(data) {
    $.ajax({
        url: 'waitstaff/vieworders',
        data: data,
        dataType: 'script',
        method: 'post',
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
        }
    });
}


function rebind() {

    //alter formatting of the view orders view to work for cashiers
    var proc_a_btn = $('.open_new_order')
    $(proc_a_btn).html('Process All Orders').addClass('process').addClass('process_all_payment').removeClass('open_new_order')
    var proc_o_btn = $('.edit_order')
    $(proc_o_btn).html('Process Order').addClass('process').addClass('process_order_payment').removeClass('edit_order')

    $('.delete_order').hide()

    //unbind click handlers in view orders so they do not fire multiple times
    $('.table_button').unbind('click')
    //bind table buttons to ajax request
    $('.table_button').on('click', function () {
        var data = {"from_cashier":"true","table_id": this.id}
        viewOrders(data)
    });

    $('.process').on('click', function () {
        if ($(this).hasClass('process_all_payment'))
            var data = {'table_id': this.id}
        else
            var data = {'order_id': $(this).closest('tr').attr('id')}

        $.ajax({
            url: 'cashier/calculatetotal',
            data: data,
            method: 'post',
            complete: function (xhr) {
                $('#receipt_table').html(null)
                $('#receipt_table').append($($.parseHTML(xhr.responseText)))
                $('#myModal').modal('show')
                $('#btn_print').unbind('click')
                $('#btn_print').on('click', function(){
                    showDialog("Receipt sent to printer...")
                    $('#myModal').modal('hide')

                    $.ajax({
                        url: 'cashier/processpayment',
                        data: data,
                        method: 'post',
                        complete: function (xhr) {
                            showDialog(xhr.responseText)
                            viewOrders()
                        }
                    });
                });
            }
        });

    });
}

$(document).ready(function () {
    var data = {"from_cashier": "true","table_id": $('.open_new_order').attr('id')}
    viewOrders(data);
});