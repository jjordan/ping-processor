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
//= require Chart
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$(document).on('ready page:load', function(){
  $(".tablesorter").tablesorter(); 

  $(".ping-button").on("ajax:success", function(event, data, status, xhr){
      var message;
      var reachable_td = $(this).parent().siblings('.reachable');
      var last_up_td = $(this).parent().siblings('.last_up');
      if( data.reachable ){
        message =  '<div class="alert alert-success" role="alert">' +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
                            '<strong>A response</strong> from the remote server, it is reachable.';
        if( reachable_td ){
          reachable_td.html('<span class="label label-success">' + data.reachable + '</span>');
        }
        if( last_up_td ){
          last_up_td.html( data.last_up );
        }
      } else {
        message =  '<div class="alert alert-info" role="info">' +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
                            '<strong>No response</strong> from the remote server, it is unreachable.';
        if( reachable_td ){
          reachable_td.html('<span class="label label-danger">' + data.reachable + '</span>');
        }
      }
      $("#flash-box").html( message ).show().delay(10000).fadeOut('slow');
  });

  $(".ping-button").on("ajax:error", function(event, data, status, xhr){
      var message =  '<div class="alert alert-danger" role="alert">' +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
                            '<strong>Error</strong> the server encountered a problem, please try again later.';
      $("#flash-box").html( message ).show().delay(10000).fadeOut('slow');
  });
}); 
