$(document).ready(function() {
  function e() {
    var e = $(window).width();
    768 > e ? $("#filter-items .item").addClass("width-100") : $("#filter-items .item").removeClass("width-100")
  }

  function t() {
    function e() {
      t && clearTimeout(t), t = setTimeout(function() {
        var e = 442,
          t = .95;
        jQuery("#cboxOverlay").is(":visible") && ($.colorbox.resize({
          width: $(window).width() > e + 20 ? e : Math.round($(window).width() * t)
        }), $(".cboxPhoto").css({
          width: $("#cboxLoadedContent").innerWidth(),
          height: "auto"
        }), $("#cboxLoadedContent").height($(".cboxPhoto").height()), $.colorbox.resize())
      }, 300)
    }
    $(".colorbox-button").colorbox({
      rel: "colorbox-button",
      maxWidth: "95%",
      maxHeight: "95%"
    });
    var t;
    jQuery(window).resize(e), window.addEventListener("orientationchange", e, !1)
  }
  var i = $(window);
  $('section[data-type="background"]').each(function() {
    var e = $(this);
    $(window).scroll(function() {
      var t = -(i.scrollTop() / e.data("speed")),
        n = "50% " + t + "px";
      e.css({
        backgroundPosition: n
      })
    })
  }), jQuery(window).resize(function() {});
  var n = "down";
  jQuery(window).bind("scroll", function() {
    var e = jQuery(window).scrollTop();
    e > jQuery("#features").offset().top - 60 && "down" == n ? (n = "up", jQuery("#nav-bar").stop().animate({
      top: "0"
    }, 300)) : e < jQuery("#features").offset().top - 60 && "up" == n && (n = "down", jQuery("#nav-bar").stop().animate({
      top: "-75px"
    }, 300)), jQuery("section").each(function() {
      if (e > jQuery(this).offset().top - 60) {
        var t = jQuery(this).attr("id");
        $("#top-navigation ul li").each(function() {
          t == jQuery(this).find("a").attr("href").replace("#", "") && jQuery(this).not(".active") && ($("#top-navigation ul li").removeClass("active"), jQuery(this).addClass("active"))
        })
      }
    })
  }), $(".feature-1").waypoint(function() {
    $(".feature-1 .feature-img").addClass("animate"), $(".feature-1 .feature-content").addClass("animate")
  }, {
    triggerOnce: !0,
    offset: function() {
      return $(window).height() - $(this).outerHeight() + 200
    }
  }), $(".feature-2").waypoint(function() {
    $(".feature-2 .feature-img").addClass("animate"), $(".feature-2 .feature-content").addClass("animate")
  }, {
    triggerOnce: !0,
    offset: function() {
      return $(window).height() - $(this).outerHeight() + 200
    }
  }), $(".heronav").onePageNav({
    filter: ":not(.external)",
    scrollOffset: 80
  }), $("#fixed-top-navigation").onePageNav({
    filter: ":not(.external)",
    scrollOffset: 80
  }), $(".showcase").onePageNav({
    filter: ":not(.external)",
    scrollOffset: 20
  });
  var s = $("#filter-items");
  s.imagesLoaded(function() {
    s.isotope({}), $("#filters a").click(function() {
      var e = $(this).attr("data-filter");
      return s.isotope({
        filter: e
      }), $("#filters a").removeClass("active"), $(this).addClass("active"), !1
    }), $("#e1").change(function() {
      var e = $(this).find(":selected").val();
      return s.isotope({
        filter: e
      }), !1
    })
  }), e(), jQuery(window).resize(function() {
    e()
  }), t(), $(".projects").click(function() {
    var e = $(this).attr("data-slide");
    return $("#project-slide-" + e).addClass("animated fadeInUpBig").show(), !1
  }), $(".sidebar-collapse > i").click(function() {
    $("#mobile-menu").slideToggle(200, "linear").toggleClass("collapse")
  })
});