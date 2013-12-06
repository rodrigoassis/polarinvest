$(document).ready(function() {
  $('a.anchor').click(function(event) {
    var id = $(this).attr("href");
    var height = $("#nav-bar").height();
    if (isMobile()) {
      height = 0;
    }
    var target = $(id).offset().top - height + 1;

    $('html, body').animate({scrollTop:target}, 500);
    event.preventDefault();
  });
});

function isMobile() {
  if( navigator.userAgent.match(/Android/i)
   || navigator.userAgent.match(/webOS/i)
   || navigator.userAgent.match(/iPhone/i)
   || navigator.userAgent.match(/iPad/i)
   || navigator.userAgent.match(/iPod/i)
   || navigator.userAgent.match(/BlackBerry/i)
   || navigator.userAgent.match(/Windows Phone/i)
   ){
      return true;
    }
   else {
      return false;
    }
  // return (navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i));
}

