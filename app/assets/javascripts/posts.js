// Set up FB api for sharing
$.ajaxSetup({ cache: true });
  $.getScript('//connect.facebook.net/en_US/sdk.js', function(){
    FB.init({
      appId: '1679784358956206',
      version: 'v2.5' // or v2.0, v2.1, v2.2, v2.3
    });
  });

$(function(){

  // Functionality for post preview
  $(document).on( "click", '#preview-post-button', function() {
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
  $(document).on( "click",'.like-button', function() {
    if ($(this).hasClass('already-liked')) {
      console.log('unliked');

      var postID = $(this).attr('post_id');

      $(this).removeClass('already-liked');

      var score = $(this).closest('.meta-bar').find('.score-number')
      score.text(decrementVote(score.text()))

      var delete_route = "posts/" + postID + "/votes"

      $.ajax({
            url: delete_route,
            type: 'DELETE',
            success: function(result) {
              console.log(result)
            }
        });

    } else {
      console.log('like');
      var postID = $(this).attr('post_id');
      that = $(this)
      $(this).addClass('already-liked');

      var score = $(this).closest('.meta-bar').find('.score-number')
      score.text(incrementVote(score.text()))

      var new_vote_route = "posts/" + postID + "/votes"

      $.post( new_vote_route, function(res) {
        console.log(res)
        if (res == "login") {

          // Rollback DOM changes
          that.removeClass('already-liked');
          score.text(decrementVote(score.text()))

          // Prompt login with modal
          $('#loginModal').modal('toggle')

        }


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

  //  FB API Listeners

  $(document).on( "click",'.glyphicon-share-alt', function() {

    var linkToShare = $(this).closest('.thumbnail').find('h3').find('a').attr('href')

    FB.ui({
      method: 'share',
      href: linkToShare,
    }, function(response){});

  });

})