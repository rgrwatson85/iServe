/*
 *rebind form to events after an ajax request changes the table
 */
function rebind() {
    $('.ajax').on('click', function () {
        var btn = $(this)
        var data = {'id': btn.closest('tr').attr('id')}

        $.ajax({
            url: 'kitchenstaff/itemcomplete',
            data: data,
            method: 'post',
            dataType: 'script',
            complete: function (xhr) {
                showDialog(xhr.responseText)
            }
        });
        if (btn.hasClass("btn-success")) {
            btn.removeClass("btn-success")
            btn.addClass("btn-danger")
        } else {
            btn.removeClass("btn-danger")
            btn.addClass("btn-success")
        }

    });

    //setup get order notes ajax call
    $('.order_row').on('click', function () {
        var data = {"id": this.id}
        $.ajax({
            url: 'kitchenstaff/getnote',
            data: data,
            method: 'POST',
            dataType: 'html',
            success: function (response) {
                console.log(response)
                $('#order_note').html(response)
            }
        });
    });
}

$(document).ready(function () {

    //poll database to get most recent data for open orders table
    setInterval(function () {
        $.ajax({
            type: "get",
            url: '/kitchenstaff',
            dataType: 'html',
            success: function (response) {
                var table = $($.parseHTML(response)).find("#open_orders");
                if( table.html() != $('#open_orders').html()){
                    $('#open_orders').replaceWith(table)
                }
            },
            complete: function () {
                rebind();
            }
        });
    }, 60000);

    //initial binding of buttons to ajax success
    rebind();

});
