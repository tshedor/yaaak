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

$(document).ready(function() {

	function notify(content,tags,title, url){
		if(window.webkitNotifications){
				var havePermission = window.webkitNotifications.checkPermission();
				if (havePermission == 0) {
					var notification = window.webkitNotifications.createNotification('/assets/favicon.png',title,content);
					notification.onclick = function () {
						window.open(url);
						notification.close();
   		 		}
   		 		notification.show();
   		 	} else {
   		 		window.webkitNotifications.requestPermission();
   		 	}
   		 } else {
   		 	if (Notification && Notification.permission === "granted") {
   		 		var notification = new Notification(content, {tag: tags });
   		 	} else if (Notification && Notification.permission !== 'denied') {
   		 		Notification.requestPermission(function (permission) {
   		 			if(!('permission' in Notification)) {
   		 				Notification.permission = permission;
   		 			}
   		 			if (permission === "granted") {
   		     			var notification = new Notification(content, {tag: tags});
   		     		}
   		     	});
   		     }
   		};
   	}
    if($('body').hasClass('herds show')) {
    var evtSource;
    evtSource = new EventSource('/herds/1/stream');
    evtSource.onmessage = function(e) {
      var resp;
      resp = JSON.parse(e.data);
      $('.chat-list').append('<li>' + resp.data.message + '</li>');
      notify(resp.data.message,'headerroom1','Yaaak App', window.location.href)
      return console.log(resp);
    };
    evtSource.onopen = function(e) {
      return console.log('open');
    };
    evtSource.onerror = function(e) {
      console.log('error');
      return console.log(e);
      evtSource.close();
    };
	evtSource.onclose = function(e) {
      return console.log('close');
    };
    window.onbeforeunload = function() {
      evtSource.close()
    };
    }
});

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
