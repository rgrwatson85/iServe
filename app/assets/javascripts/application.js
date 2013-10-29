// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require twitter/bootstrap

function showDialog(msg){
    $.gritter.add({
					// (string | mandatory) the heading of the notification
					title: 'Notice',
					// (string | mandatory) the text inside the notification
					text: msg,
					// (string | optional) the image to display on the left
					image: '',
					// (bool | optional) if you want it to fade out on its own or just sit there
					sticky: false,
					// (int | optional) the time you want it to be alive for before fading out
					time: ''
				});
}

$(document).ready(function(){
    $('.alert').css('opacity',.75).css('font-size', '24px').delay(1500).fadeOut()
});