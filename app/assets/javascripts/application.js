// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


var MoviePopup = {
    setup: function() {
      // add hidden 'div' to end of page to display popup:
      var popupDiv = $('<div id="movieInfo"></div>');
      popupDiv.hide().appendTo($('body'));
      $(document).on('click', '#movies a', MoviePopup.getMovieInfo);
    }
    ,getMovieInfo: function() {
      $.ajax({type: 'GET',
              url: $(this).attr('href'),
              timeout: 5000,
              success: MoviePopup.showMovieInfo,
              error: function(xhrObj, textStatus, exception) { alert('Frror!'); }
              // 'success' and 'error' functions will be passed 3 args
             });
      return(false);
    }
    ,showMovieInfo: function(data, requestStatus, xhrObject) {
      // center a floater 1/2 as wide and 1/4 as tall as screen
      var oneFourth = Math.ceil($(window).width() / 4);
      $('#movieInfo').
        css({'left': oneFourth,  'width': 2*oneFourth, 'top': 250}).
        html(data).
        show();
      // make the Close link in the hidden element work
      $('#closeLink').click(MoviePopup.hideMovieInfo);
      return(false);  // prevent default link action
    }
    ,hideMovieInfo: function() {
      $('#movieInfo').hide();
      return(false);
    }
  };
  $(MoviePopup.setup);
