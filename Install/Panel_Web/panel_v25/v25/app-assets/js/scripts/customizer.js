/*=========================================================================================
  File Name: customizer.js
  Description: Template customizer js.
  ----------------------------------------------------------------------------------------
  Item Name: Vuesax HTML Admin Template
  Version: 1.0
  Author: Pixinvent
  Author URL: hhttp://www.themeforest.net/user/pixinvent
==========================================================================================*/

(function (window, document, $) {
  'use strict';
  // main menu active gradient colors object
  var themeColor = {
    "theme-primary": "linear-gradient(118deg, #7367f0, rgba(115, 103, 240, 0.7))",
    "theme-success": "linear-gradient(118deg, #28c76f, rgba(40, 199, 111  , 0.7))",
    "theme-danger": "linear-gradient(118deg, #ea5455, rgba(234, 84, 85, 0.7))",
    "theme-info": "linear-gradient(118deg, #00cfe8, rgba(0, 207, 232, 0.7))",
    "theme-warning": "linear-gradient(118deg, #ff9f43, rgba(255, 159, 67, 0.7))",
    "theme-dark": "linear-gradient(118deg, #1e1e1e, rgba(30, 30, 30, 0.7))"
  }
  // main menu active box shadow object
  var themeBoxShadow = {
    "theme-primary": "0 0 10px 1px rgba(115, 103, 240, 0.7)",
    "theme-success": "0 0 10px 1px rgba(40, 199, 111  , 0.7)",
    "theme-danger": "0 0 10px 1px rgba(234, 84, 85, 0.7)",
    "theme-info": "0 0 10px 1px rgba(0, 207, 232, 0.7)",
    "theme-warning": "0 0 10px 1px rgba(255, 159, 67, 0.7)",
    "theme-dark": "0 0 10px 1px rgba(30, 30, 30, 0.7)"
  }
  // colors for navbar header text of main menu
  var currentColor = {
    "theme-default": "#fff",
    "theme-primary": "#7367f0",
    "theme-success": "#28c76f",
    "theme-danger": "#ea5455",
    "theme-info": "#00cfe8",
    "theme-warning": "#ff9f43",
    "theme-dark": "#adb5bd"
  }
  // Brand Logo Poisitons
  var LogoPosition = {
    "theme-primary": "-65px -54px",
    "theme-success": "-120px -10px",
    "theme-danger": "-10px -10px",
    "theme-info": "-10px -54px",
    "theme-warning": "-120px -54px",
    "theme-dark": "-65px -10px"
  }

  var body = $("body"),
    appContent = $(".app-content"),
    mainMenu = $(".main-menu"),
    mainMenuContent = $(".menu-content"),
    menuCollapsed = $(".menu-collapsed"),
    menuExpanded = $(".menu-expanded"),
    footer = $(".footer"),
    navbar = $(".header-navbar"),
    navBarShadow = $(".header-navbar-shadow"),
    toggleIcon = $(".toggle-icon"),
    collapseSidebar = $("#collapse-sidebar-switch"),
    customizer = $(".customizer"),
    brandLogo = $(".brand-logo");

  // Customizer toggle & close button click events  [Remove customizer code from production]
  $('.customizer-toggle').on('click', function (e) {
    e.preventDefault();
    $(customizer).toggleClass('open');
  });
  $('.customizer-close').on('click', function () {
    $(customizer).removeClass('open');
  });

  // perfect scrollbar for customizer
  if ($('.customizer-content').length > 0) {
    var customizer_content = new PerfectScrollbar('.customizer-content');
  }

  /***** Theme Colors Options *****/
  $(document).on("click", "#customizer-theme-colors .color-box", function () {
    var $this = $(this);
    $this.siblings().removeClass('selected');
    $this.addClass("selected");
    var selectedColor = $(this).data("color"),
      changeColor = themeColor[selectedColor],
      selectedShadow = themeBoxShadow[selectedColor],
      selectedTextColor = currentColor[selectedColor],
      selectedLogo = LogoPosition[selectedColor];

    // main-menu
    if (mainMenuContent.find("li.active").length) {
      mainMenuContent.find("li.active").css(
        {
          "background": changeColor,
          "box-shadow": selectedShadow
        }
      );

    }
    else {
      mainMenu.find(".nav-item.active a").css(
        {
          "background": changeColor,
          "box-shadow": selectedShadow
        }
      );
    }
    // Text with logo
    $(".brand-text").css("color", selectedTextColor);
    // toggle icon
    toggleIcon.removeClass("primary").css("color", selectedTextColor);
    // Changes logo color
    brandLogo.css("background-position", selectedLogo);
  });

  /***** Theme Layout Options *****/
  $(".layout-name").on("click", function () {
    var $this = $(this);
    var currentLayout = $this.data("layout");
    body.removeClass("dark-layout semi-dark-layout").addClass(currentLayout);
    if (currentLayout === "") {
      mainMenu.removeClass("menu-dark").addClass("menu-light");
      navbar.removeClass("navbar-dark").addClass("navbar-light");
    }
  })

  // checks right radio if layout type matches
  var layout = body.data("layout");
  $(".layout-name[data-layout='" + layout + "']").prop('checked', true);

  /***** Collapse menu switch *****/
  collapseSidebar.on("click", function () {
    if ($(body).hasClass("menu-expanded")) {
      body.removeClass("menu-expanded").addClass("menu-collapsed");
      mainMenu.find(".sidebar-group-active").removeClass("open").addClass("menu-collapsed-open");
      toggleIcon.removeClass("feather icon-disc").addClass("feather icon-circle");

    }
    else {
      body.removeClass("menu-collapsed").addClass("menu-expanded");
      mainMenu.find(".sidebar-group-active").addClass("open");
      toggleIcon.removeClass("feather icon-circle").addClass("feather icon-disc");
    }
  })
  // connects toggle icon with collapse sidebar switch
  toggleIcon.on("click", function () {
    collapseSidebar.prop("checked", !collapseSidebar.prop("checked"));
  })

  // checks if main menu is collapsed by default
  if (body.hasClass("menu-collapsed")) {
    collapseSidebar.prop("checked", true);
  }
  else {
    collapseSidebar.prop("checked", false);
  }

  /***** Navbar Color Options *****/
  $("#customizer-navbar-colors .color-box").on("click", function () {
    var $this = $(this);
    $this.siblings().removeClass('selected');
    $this.addClass("selected");
    var navbarColor = $this.data("navbar-color");
    // changes navbar colors
    if (navbarColor) {
      appContent
        .find(navbar)
        .removeClass("bg-primary bg-success bg-danger bg-info bg-warning bg-dark")
        .addClass(navbarColor + " navbar-dark");
    }
    else {
      appContent
        .find(navbar)
        .removeClass("bg-primary bg-success bg-danger bg-info bg-warning bg-dark navbar-dark");
    }
    if (body.hasClass("dark-layout")) {
      navbar.addClass("navbar-dark")
    }
  })

  /***** Navbar Type *****/
  // Hides Navbar
  $("#navbar-hidden").on("click", function () {
    navbar.addClass("d-none");
    navBarShadow.addClass("d-none");
    body.removeClass("navbar-static navbar-floating navbar-sticky").addClass("navbar-hidden");
  });
  // changes to Static navbar
  $("#navbar-static").on("click", function () {
    navBarShadow.addClass("d-none");
    navbar
      .removeClass("d-none floating-nav fixed-top")
      .addClass("navbar-static-top");
    body.removeClass("navbar-hidden navbar-floating navbar-sticky").addClass("navbar-static");
  });
  // change to floating navbar
  $("#navbar-floating").on("click", function () {
    navBarShadow.removeClass("d-none");
    navbar
      .removeClass("d-none fixed-top navbar-static-top fixed-top")
      .addClass("floating-nav");
    body.removeClass("navbar-static navbar-hidden navbar-sticky").addClass("navbar-floating");
  });
  // changes to Static navbar
  $("#navbar-sticky").on("click", function () {
    navBarShadow.addClass("d-none");
    navbar
      .removeClass("d-none floating-nav navbar-static-top")
      .addClass("fixed-top");
    body.removeClass("navbar-static navbar-floating navbar-hidden").addClass("navbar-sticky");
  });

  /***** Footer Type *****/
  // Hides footer
  $("#footer-hidden").on("click", function () {
    footer.addClass("d-none");
    body.removeClass("footer-static fixed-footer").addClass("footer-hidden");
  });
  // changes to Static footer
  $("#footer-static").on("click", function () {
    body.removeClass("fixed-footer");
    footer.removeClass("d-none").addClass("footer-static");
    body.removeClass("footer-hidden fixed-footer").addClass("footer-static");
  });
  // changes to Sticky footer
  $("#footer-sticky").on("click", function () {
    body.removeClass("footer-static fixed-hidden").addClass("fixed-footer");
    footer.removeClass("d-none footer-static");
  });

  /***** Hide Scroll To Top *****/
  $("#hide-scroll-top-switch").on("click", function () {
    var scrollTopBtn = $(".scroll-top")
    if ($(this).prop("checked")) {
      scrollTopBtn.addClass("d-none");
    }
    else {
      scrollTopBtn.removeClass("d-none");
    }
  });
})(window, document, jQuery);
