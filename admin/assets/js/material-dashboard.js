(function () {
	isWindows = navigator.platform.indexOf("Win") > -1 ? true : false;
	if (isWindows) {
		$(".sidebar .sidebar-wrapper, .main-panel").perfectScrollbar();
		$("html").addClass("perfect-scrollbar-on")
	} else {
		$("html").addClass("perfect-scrollbar-off")
	}
})();
var breakCards = true;
var searchVisible = 0;
var transparent = true;
var transparentDemo = true;
var fixedTop = false;
var mobile_menu_visible = 0,
	mobile_menu_initialized = false,
	toggle_initialized = false,
	bootstrap_nav_initialized = false;
var seq = 0,
	delays = 80,
	durations = 500;
var seq2 = 0,
	delays2 = 80,
	durations2 = 500;
$(document).ready(function () {
	$("body").bootstrapMaterialDesign();
	$sidebar = $(".sidebar");
	md.initSidebarsCheck();
	window_width = $(window).width();
	md.checkSidebarImage();
	if ($(".selectpicker").length != 0) {
		$(".selectpicker").selectpicker()
	}
	$('[rel="tooltip"]').tooltip();
	$(".form-control").on("focus", function () {
		$(this).parent(".input-group").addClass("input-group-focus")
	}).on("blur", function () {
		$(this).parent(".input-group").removeClass("input-group-focus")
	});
	$('input[type="checkbox"][required="true"], input[type="radio"][required="true"]').on("click", function () {
		if ($(this).hasClass("error")) {
			$(this).closest("div").removeClass("has-error")
		}
	})
});
$(document).on("click", ".navbar-toggler", function () {
	$toggle = $(this);
	if (mobile_menu_visible == 1) {
		$("html").removeClass("nav-open");
		$(".close-layer").remove();
		setTimeout(function () {
			$toggle.removeClass("toggled")
		}, 400);
		mobile_menu_visible = 0
	} else {
		setTimeout(function () {
			$toggle.addClass("toggled")
		}, 430);
		var a = $('<div class="close-layer"></div>');
		if ($("body").find(".main-panel").length != 0) {
			a.appendTo(".main-panel")
		} else {
			if (($("body").hasClass("off-canvas-sidebar"))) {
				a.appendTo(".wrapper-full-page")
			}
		}
		setTimeout(function () {
			a.addClass("visible")
		}, 100);
		a.click(function () {
			$("html").removeClass("nav-open");
			mobile_menu_visible = 0;
			a.removeClass("visible");
			setTimeout(function () {
				a.remove();
				$toggle.removeClass("toggled")
			}, 400)
		});
		$("html").addClass("nav-open");
		mobile_menu_visible = 1
	}
});
$(window).resize(function () {
	md.initSidebarsCheck();
	seq = seq2 = 0;
	setTimeout(function () {
		md.initDashboardPageCharts()
	}, 500)
});
md = {
	misc: {
		navbar_menu_visible: 0,
		active_collapse: true,
		disabled_collapse_init: 0,
	},
	checkSidebarImage: function () {
		$sidebar = $(".sidebar");
		image_src = $sidebar.data("image");
		if (image_src !== undefined) {
			sidebar_container = '<div class="sidebar-background" style="background-image: url(' + image_src + ') "/>';
			$sidebar.append(sidebar_container)
		}
	},
	initFormExtendedDatetimepickers: function () {
		$(".datetimepicker").datetimepicker({
			icons: {
				time: "fa fa-clock-o",
				date: "fa fa-calendar",
				up: "fa fa-chevron-up",
				down: "fa fa-chevron-down",
				previous: "fa fa-chevron-left",
				next: "fa fa-chevron-right",
				today: "fa fa-screenshot",
				clear: "fa fa-trash",
				close: "fa fa-remove"
			}
		});
		$(".datepicker").datetimepicker({
			format: "MM/DD/YYYY",
			icons: {
				time: "fa fa-clock-o",
				date: "fa fa-calendar",
				up: "fa fa-chevron-up",
				down: "fa fa-chevron-down",
				previous: "fa fa-chevron-left",
				next: "fa fa-chevron-right",
				today: "fa fa-screenshot",
				clear: "fa fa-trash",
				close: "fa fa-remove"
			}
		});
		$(".timepicker").datetimepicker({
			format: "h:mm A",
			icons: {
				time: "fa fa-clock-o",
				date: "fa fa-calendar",
				up: "fa fa-chevron-up",
				down: "fa fa-chevron-down",
				previous: "fa fa-chevron-left",
				next: "fa fa-chevron-right",
				today: "fa fa-screenshot",
				clear: "fa fa-trash",
				close: "fa fa-remove"
			}
		})
	},
	initSliders: function () {
		var b = document.getElementById("sliderRegular");
		noUiSlider.create(b, {
			start: 40,
			connect: [true, false],
			range: {
				min: 0,
				max: 100
			}
		});
		var a = document.getElementById("sliderDouble");
		noUiSlider.create(a, {
			start: [20, 60],
			connect: true,
			range: {
				min: 0,
				max: 100
			}
		})
	},
	initSidebarsCheck: function () {
		if ($(window).width() <= 991) {
			if ($sidebar.length != 0) {
				md.initRightMenu()
			}
		}
	},
	initDashboardPageCharts: function () {
		if ($("#dailySalesChart").length != 0 || $("#completedTasksChart").length != 0 || $("#websiteViewsChart").length != 0) {
			dataDailySalesChart = {
				labels: ["M", "T", "W", "T", "F", "S", "S"],
				series: [
					[12, 17, 7, 17, 23, 18, 38]
				]
			};
			optionsDailySalesChart = {
				lineSmooth: Chartist.Interpolation.cardinal({
					tension: 0
				}),
				low: 0,
				high: 50,
				chartPadding: {
					top: 0,
					right: 0,
					bottom: 0,
					left: 0
				},
			};
			var c = new Chartist.Line("#dailySalesChart", dataDailySalesChart, optionsDailySalesChart);
			md.startAnimationForLineChart(c);
			dataCompletedTasksChart = {
				labels: ["12p", "3p", "6p", "9p", "12p", "3a", "6a", "9a"],
				series: [
					[230, 750, 450, 300, 280, 240, 200, 190]
				]
			};
			optionsCompletedTasksChart = {
				lineSmooth: Chartist.Interpolation.cardinal({
					tension: 0
				}),
				low: 0,
				high: 1000,
				chartPadding: {
					top: 0,
					right: 0,
					bottom: 0,
					left: 0
				}
			};
			var b = new Chartist.Line("#completedTasksChart", dataCompletedTasksChart, optionsCompletedTasksChart);
			md.startAnimationForLineChart(b);
			var a = {
				labels: ["J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"],
				series: [
					[542, 443, 320, 780, 553, 453, 326, 434, 568, 610, 756, 895]
				]
			};
			var e = {
				axisX: {
					showGrid: false
				},
				low: 0,
				high: 1000,
				chartPadding: {
					top: 0,
					right: 5,
					bottom: 0,
					left: 0
				}
			};
			var f = [
				["screen and (max-width: 640px)", {
					seriesBarDistance: 5,
					axisX: {
						labelInterpolationFnc: function (g) {
							return g[0]
						}
					}
				}]
			];
			var d = Chartist.Bar("#websiteViewsChart", a, e, f);
			md.startAnimationForBarChart(d)
		}
	},
	initMinimizeSidebar: function () {
		$("#minimizeSidebar").click(function () {
			var b = $(this);
			if (md.misc.sidebar_mini_active == true) {
				$("body").removeClass("sidebar-mini");
				md.misc.sidebar_mini_active = false
			} else {
				$("body").addClass("sidebar-mini");
				md.misc.sidebar_mini_active = true
			}
			var a = setInterval(function () {
				window.dispatchEvent(new Event("resize"))
			}, 180);
			setTimeout(function () {
				clearInterval(a)
			}, 1000)
		})
	},
	checkScrollForTransparentNavbar: debounce(function () {
		if ($(document).scrollTop() > 260) {
			if (transparent) {
				transparent = false;
				$(".navbar-color-on-scroll").removeClass("navbar-transparent")
			}
		} else {
			if (!transparent) {
				transparent = true;
				$(".navbar-color-on-scroll").addClass("navbar-transparent")
			}
		}
	}, 17),
	initRightMenu: debounce(function () {
		$sidebar_wrapper = $(".sidebar-wrapper");
		if (!mobile_menu_initialized) {
			$navbar = $("nav").find(".navbar-collapse").children(".navbar-nav");
			mobile_menu_content = "";
			nav_content = $navbar.html();
			nav_content = '<ul class="nav navbar-nav nav-mobile-menu">' + nav_content + "</ul>";
			navbar_form = $("nav").find(".navbar-form").get(0).outerHTML;
			$sidebar_nav = $sidebar_wrapper.find(" > .nav");
			$nav_content = $(nav_content);
			$navbar_form = $(navbar_form);
			$nav_content.insertBefore($sidebar_nav);
			$navbar_form.insertBefore($nav_content);
			$(".sidebar-wrapper .dropdown .dropdown-menu > li > a").click(function (a) {
				a.stopPropagation()
			});
			window.dispatchEvent(new Event("resize"));
			mobile_menu_initialized = true
		} else {
			if ($(window).width() > 991) {
				$sidebar_wrapper.find(".navbar-form").remove();
				$sidebar_wrapper.find(".nav-mobile-menu").remove();
				mobile_menu_initialized = false
			}
		}
	}, 200),
	startAnimationForLineChart: function (a) {
		a.on("draw", function (b) {
			if (b.type === "line" || b.type === "area") {
				b.element.animate({
					d: {
						begin: 600,
						dur: 700,
						from: b.path.clone().scale(1, 0).translate(0, b.chartRect.height()).stringify(),
						to: b.path.clone().stringify(),
						easing: Chartist.Svg.Easing.easeOutQuint
					}
				})
			} else {
				if (b.type === "point") {
					seq++;
					b.element.animate({
						opacity: {
							begin: seq * delays,
							dur: durations,
							from: 0,
							to: 1,
							easing: "ease"
						}
					})
				}
			}
		});
		seq = 0
	},
	startAnimationForBarChart: function (a) {
		a.on("draw", function (b) {
			if (b.type === "bar") {
				seq2++;
				b.element.animate({
					opacity: {
						begin: seq2 * delays2,
						dur: durations2,
						from: 0,
						to: 1,
						easing: "ease"
					}
				})
			}
		});
		seq2 = 0
	}
};

function debounce(b, d, a) {
	var c;
	return function () {
		var f = this,
			e = arguments;
		clearTimeout(c);
		c = setTimeout(function () {
			c = null;
			if (!a) {
				b.apply(f, e)
			}
		}, d);
		if (a && !c) {
			b.apply(f, e)
		}
	}
};