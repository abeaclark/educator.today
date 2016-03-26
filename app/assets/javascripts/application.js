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

  // Functionality for post preview
  $('#preview-post-button').on( "click", function() {
    console.log('click')
    var link = $('#link-input').val();
    $('#share-link-main-group').toggle();
    $('#second-nav-container').append("<div id='spinner-gif-container'><img id='spinner-gif' src='ajax-loader.gif'><span class='generating-post'> Generating Post</span></div>");

    $.get( "/posts/preview", { link: link}, function(response){
      $('#spinner-gif-container').remove();
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

  // Functionality for like button
  $('.like-button').on( "click", function() {
    console.log('like')
    var postID = $(this).attr('post_id');
    var score = $(this).closest('.meta-bar').find('.score-number')
    console.log(score.text())
    score.text(incrementVote(score.text()))

    $.post( "/posts/like", {post_id: postID}, function(res) {
      console.log(res)
    });

  });

  var incrementVote = function(voteCountAsString){
    currentCount = parseInt(voteCountAsString)
    return String(currentCount + 1);
  }
})