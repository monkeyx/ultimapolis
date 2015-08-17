// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var infoTop;
var infoTitle;
var infoBody;

function showInfoPanel() {
    if(infoTop){
        id = 'infoTop';
        glyph = 'glyphicon-arrow-down';
    } else {
        id = 'infoBottom';
        glyph = 'glyphicon-arrow-up';
    }
    div = $('#' + id);
    div.html('<div class="panel panel-info"><div class="panel-heading"><h3 class="panel-title">' +
        infoTitle + 
        '<span id="switchInfoButton" class="glyphicon ' + 
        glyph +
        '"></span></h3></div><div class="panel-body">' +
        infoBody +
        '</div></div>');
    $('#switchInfoButton').click(function ($) {
        switchInfoPanelLocation();
    });
}

function switchInfoPanelLocation() {
    $('#infoTop').empty();
    $('#infoBottom').empty();
    infoTop = !infoTop;
    showInfoPanel();
}

function turnTimer(duration, display) {
    var timer = duration, minutes, seconds;
    setInterval(function () {
    	hours = parseInt(timer / 3600, 10);
        minutes = parseInt((timer - (hours * 3600)) / 60, 10);
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        if(hours > 0){
        	display.text("for another " + hours + ":" + minutes + ":" + seconds + " hours");
        }
        else if (minutes < 1 && seconds < 1){
        	display.text("has past. Please refresh.")
        }
        else {
        	display.text("for another " + minutes + ":" + seconds + " minutes");
        }

        if (--timer < 0) {
            timer = duration;
        }
    }, 1000);
}