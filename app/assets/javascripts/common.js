  $(document).ready(function() {
    
    $('select').selectpicker();

    $('#show-hdr').click(function(e) {
      e.preventDefault();
      $(this).toggleClass('i-close-active').toggleClass('i-settings');
      $('.hdr').toggleClass('hdr-out');
      return $('.hdr-controls').toggle().toggleClass('flipInY animated');
    });
    
    $('body.herds').backstretch(['/assets/herds-bg.jpg']);

/**********************/
/******* HERDS ********/
/**********************/

    var evtSource, isEmpty;
    evtSource = new EventSource('/herds/1/stream');
    isEmpty = function(str) {
      return !str || 0 === str.length;
    };
    evtSource.onmessage = function(e) {
      var resp;
      resp = JSON.parse(e.data);
      $('.chat-list').append('<li>' + e.data + '</li>');
      return console.log(resp);
    };
    evtSource.onopen = function(e) {
      return console.log('open');
    };
    evtSource.onerror = function(e) {
      console.log('error');
      return console.log(e);
    };
	evtSource.onclose = function(e) {
      return console.log('close');
    };

/**********************/
/******* GRUNTS *******/
/**********************/

    $("#new_grunt").submit(function(e) {
      e.preventDefault();
      $.ajax({
        url: $('#new_grunt').attr('action'),
        type: "POST",
        dataType: "json",
        data: $('#new_grunt').serialize(),
        success: function(msg) {},
        error: function(xhr, status) {
          return $('body').html(xhr.responseText);
        }
      });
    });
  });
