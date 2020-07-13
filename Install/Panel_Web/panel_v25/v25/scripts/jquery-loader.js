/*
 * Jquery Loader插件 中文叫菊花插件
 * 使用例子:
 * $.loader.open(arg); 打开屏幕菊花
 * $.loader.close(arg); 关闭菊花
 * $(dom).loader(arg);  打开指定dom的菊花
 * 参数arg可以为菊花后的文字  或者 菊花配置
 */
(function ($) {
    $.loader_ext = {
        // 默认配置
        defaults: {
            autoCheck: 32, //自动检测大容器，并使用的指定size
            css: {}, //自定义样式
            size: 16,  //指定菊花大小
            bgColor: '#FFF',   //背景颜色
            bgOpacity: 0.5,    //背景透明度
            fontColor: false,  //文字颜色
            position: [0, 0, 0, 0],    //偏移设置 上左高宽
            title: '', //文字
            isOnly: true,
            imgUrl: 'images/loading[size].gif',
            onShow: function () {
            },  //打开回调
            onClose: function () {
            }  //关闭回调
        },

        template: function (tmpl, data) {
            $.each(data, function (k, v) {
                tmpl = tmpl.replace('${' + k + '}', v);
            });
            return $(tmpl);
        },

        // 初始化
        init: function (scope, options) {
            this.options = $.extend({}, this.defaults, options);
            this.scope = scope;

            if (this.scope.is(':hidden')) {
                return;
            }
            this.checkScope();
            this.check_position();
            this.check_unique();
            this.create();
            this.set_css();
            this.set_define();
            this.show();

            return this.loading;
        },

        // 容器检测
        checkScope: function () {
            if (!this.options.autoCheck) {
                return;
            }
            if (this.scope.is('body') || this.scope.is('div') || this.scope.is('form')) {
                this.options.size = this.options.autoCheck;
            }
            if (this.scope.is('input') || this.scope.is('button')) {
                this.options.title = '';
            }
        },

        // 位置容错处理
        check_position: function () {
            var pos = this.options.position;
            for (var i = 0; i < 4; i++) {
                if (pos[i] === undefined) {
                    pos[i] = 0;
                }
            }
            this.options.position = pos;
        },

        // 检测唯一性
        check_unique: function () {
            if (this.options.isOnly && this.loading !== undefined) {
                this.close();
            }
        },

        // 创建菊花
        create: function () {
            var ops = this.options;
            ops.imgUrl = ops.imgUrl.replace('[size]', ops.size + 'x' + ops.size);
            this.loading = this.template($.loader.tmpl, {
                Class: 'x' + ops.size,
                Src: ops.imgUrl,
                Title: ops.title
            }).hide();
            this.loading.appendTo($('body'));
        },

        // 设置样式
        set_css: function () {
            var scope = this.scope,
                ops = this.options,
                loading = this.loading,
                height = scope.outerHeight(),
                width = scope.outerWidth(),
                top = scope.offset().top,
                left = scope.offset().left;

            loading.css('top', top);

            if (scope.is('body')) {
                height = $(window).height();
                width = $(window).width();
                loading.css('position', 'fixed');

                this.for_ie6();
            }

            loading.css({
                'height': height + ops.position[2],
                'width': width + ops.position[3],
                'left': left,
                'border-radius': scope.css('border-radius')
            }).css(ops.css);

            var loader = loading.children();
            loader.css({
                'margin-top': (height - ops.size) / 2 + ops.position[0],
                'margin-left': (width - ops.size) / 2 + ops.position[1] - loader.find('span').outerWidth() / 2
            });
        },

        // 自定义设置
        set_define: function () {
            var ops = this.options,
                loading = this.loading;
            if (!ops.bgColor) {
                loading.css('background', 'none');
            } else {
                loading.css({
                    'background-color': ops.bgColor,
                    'opacity': ops.bgOpacity,
                    'filter': 'alpha(opacity=' + ops.bgOpacity * 100 + ')'
                });
            }

            ops.fontColor && loading.find('span').css('color', ops.fontColor);

            var self = this;
            $(window).resize(function () {
                self.loading && self.set_css();
            })
        },

        // IE6兼容
        for_ie6: function () {
            var loading = this.loading;
            if ($.browser && $.browser.msie && $.browser.version == '6.0') {
                loading.css({
                    'position': 'absolute',
                    'top': $(window).scrollTop()
                });

                $(window).scroll(function () {
                    loading.css("top", $(window).scrollTop());
                })
            }
        },

        // 显示菊花
        show: function () {
            var ops = this.options;
            this.loading.show(1, function () {
                var loader = $(this).children();
                var left = loader.css('margin-left').replace('px', '');
                loader.css('margin-left', left - loader.find('span').outerWidth() / 2);
                ops.onShow(this.loading);
            });
        },

        // 关闭菊花
        close: function (all) {
            if (all) {
                var className = $($.loader.tmpl).attr('class');
                $('.' + className).remove();
            } else {
                if (this.loading != undefined) {
                    this.loading.remove();
                    this.loading = undefined;
                }
            }
            this.options != undefined && this.options.onClose();
        }
    };

    // 简单开启关闭以及设置模板
    $.loader = {
        tmpl: '<div class="loading_wrp"><div class="loading ${Class}"><img src="${Src}" /><span>${Title}</span></div></div>',

        open: function (arg) {
            return $('body').loader(arg);
        },
        close: function (all) {
            $.loader_ext.close(all);
        }
    };

    // 指定范围显示
    $.fn.loader = function (arg) {
        if (!$(this).size()) {
            return;
        }
        if ($.type(arg) === "string") {
            arg = {
                title: arg
            }
        }
        var dom = $(this);
        if (dom.size() > 1) {
            dom = dom.parent();
        }
        return $.loader_ext.init(dom, arg);
    };

})(jQuery);