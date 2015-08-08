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

var PingProcessor = PingProcessor || {};


PingProcessor.ping_success = function(event, data, status, xhr){
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
};

PingProcessor.ping_error = function(event, data, status, xhr){
      var message =  '<div class="alert alert-danger" role="alert">' +
        '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
        '<strong>Error</strong> the server encountered a problem, please try again later.';
    $("#flash-box").html( message ).show().delay(10000).fadeOut('slow');
};

PingProcessor.generate_pie_chart = function( total_reachable, total_unreachable, percentage_reachable, percentage_unreachable ) {
    var options = {
      legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\" style=\"list-style-type:none\"><% for (var i=0; i<segments.length; i++){%><li><i class=\"fa fa-circle\" style=\"color:<%=segments[i].fillColor%>\"></i><span class=\"legend-label\" style=\"padding: 5px\"><%if(segments[i].label){%><%=segments[i].label%><%}%></span></li><%}%></ul>"

    };
    var pieData = [
      { 
        value: total_unreachable,
        color: "#F63333",
        highlight: "#FF5A5A",
        fillColor: "#F63333",
        label: "Unreachable hosts (%" + percentage_unreachable + ")"
      },
      { 
        value: total_reachable,
        color: "#33F633",
        highlight: "#5AFF5A",
        fillColor: "#33F633",
        label: "Reachable hosts (%" + percentage_reachable + ")"
      }
    ];
    var canvas = $("#chart-area")[0];
    var ctx = $("#chart-area")[0].getContext("2d");
    var pieChart = new Chart(ctx).Pie(pieData, options);

    var legend = pieChart.generateLegend();

    $('#canvas-holder').append(legend);

    canvas.onclick = function(evt){
      var activePoints = pieChart.getSegmentsAtEvent(evt);
      console.log("activepoints: %O", activePoints);
      console.log("Section clicked: %o", activePoints[0].label);
    };

};

$(document).on('ready page:load', function(){
  $(".ping-button").on("ajax:success", PingProcessor.ping_success );

  $(".ping-button").on("ajax:error", PingProcessor.ping_error );
}); 
