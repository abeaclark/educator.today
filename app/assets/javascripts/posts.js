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
    if ($(this).hasClass('already-liked')) {
      console.log('unliked');
      var postID = $(this).attr('post_id');

      $(this).removeClass('already-liked');

      var score = $(this).closest('.meta-bar').find('.score-number')
      score.text(decrementVote(score.text()))

      $.post( "/votes/delete", {post_id: postID}, function(res) {
        console.log(res)
      });

    } else {
      console.log('like');
      var postID = $(this).attr('post_id');

      $(this).addClass('already-liked');

      var score = $(this).closest('.meta-bar').find('.score-number')
      score.text(incrementVote(score.text()))

      $.post( "/posts/like", {post_id: postID}, function(res) {
        console.log(res)
      });
    }

  });

  var incrementVote = function(voteCountAsString){
    currentCount = parseInt(voteCountAsString)
    return String(currentCount + 1);
  }

  var decrementVote = function(voteCountAsString){
    currentCount = parseInt(voteCountAsString)
    return String(currentCount - 1);
  }
})