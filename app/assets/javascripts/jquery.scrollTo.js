$(document).ready(function() {
  $('a.anchor').click(function(event) {
    var id = $(this).attr("href");
    var height = $("#nav-bar").height();
    var target = $(id).offset().top - height + 1;

    $('html, body').animate({scrollTop:target}, 500);
    event.preventDefault();
  });
});
