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
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .


$(function(){

  $('#preview-post-button').on( "click", function() {
    console.log('click')
    var link = $('#link-input').val()
    $.get( "/posts/preview", { link: link}, function(response){
      console.log(response)
      $('#share-link-main-group').toggle()
      $('#second-nav-container').append(response)
      // Add x button at top of new post to cancel
      $('#new-post-form').append('<span id="cancel-post" class="fa fa-times-circle-o"></span>')
      // Add listener to x button to revert back to standard view
      $('#cancel-post').on('click', function(){
        $('#share-link-main-group').toggle();
        $("#new-post-form").remove();
      });
    });

  });


})