modules = {
    application {
        resource url: 'js/application.js'
    }

    compass {
        resource url: [dir: '/stylesheets', file: 'screen.css'],
            attrs: [media: 'screen, projection']
        resource url: [dir: '/stylesheets', file: 'print.css'],
            attrs: [media: 'print']
        resource url: [dir: '/stylesheets', file: 'ie.css'],
            attrs: [media: 'screen'],
            wrapper: { s -> "<!--[if IE]>$s<![endif]-->" }
        resource url: [dir: '/stylesheets', file: 'ie6.css'],
            attrs: [media: 'screen'],
            wrapper: { s -> "<!--[if lt IE 7]>$s<![endif]-->" }
    }

    reset {
        resource url: [
            dir: '/stylesheets',
            file: 'reset.css'],
            attrs: [media: 'screen'
        ]
    }

    colorbox {
        resource url: [dir: '/css', file: 'colorbox.css'], attrs: [media: 'screen']
        resource url: [dir: '/js', file: 'jquery.colorbox.min.js']
    }

    codemirror {
        resource url: [dir: '/codemirror/lib', file: 'codemirror.css'],
            attrs: [media: 'screen']
        resource url: [dir: '/codemirror/lib', file: 'codemirror.js']
        resource url: [dir: '/codemirror/mode/rst', file: 'rst.js']
        resource url: [dir: '/js', file: 'jquery.codemirror.js']
        resource url: [dir: '/codemirror/lib/util', file: 'runmode.js']
    }

    overrides {
        'jquery-theme' {
            resource id:'theme', url: '/css/jquery-ui/cupertino/jquery-ui-1.8.17.custom.css'
        }
    }
}