function viewOrders(data) {
    $.ajax({
        url: 'waitstaff/vieworders',
        data: data,
        dataType: 'js',
        method: 'post',
        complete: function (xhr){
            var table = $($.parseHTML(xhr.responseText)).find('#orders').html()
            //update table if a change is detected
            if(table != $('#table_info').html()){
                $('#table_info').html(table)
                rebind();
            }
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

    //bind table buttons to ajax request
    $('.table_button').on('click', function () {
        var data = {"table_id": this.id}
        viewOrders(data)
    });

    $('.process').on('click', function(){
        if ($(this).hasClass('process_all_payment'))
            var data = {'table_id': this.id}
        else
            var data = {'order_id': $(this).closest('tr').attr('id')}

        $.ajax({
            url: 'cashier/processpayment',
            data: data,
            method: 'post',
            complete: function(xhr){
                $.jGrowl(xhr.responseText)
                viewOrders()
            }
        });
    });
}

$(document).ready(function(){
    viewOrders()
});