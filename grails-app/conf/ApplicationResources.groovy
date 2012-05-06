modules = {
    application {
        resource url: 'js/application.js'
    }

    compass {
        resource url: [dir: '/ie6', file: 'ie6.1.0.css'],
            attrs: [media: 'screen'],
            wrapper: { s -> "<!--[if IE 6]>$s<![endif]-->" }
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

    bootstrap {
        resource url: [dir: '/bootstrap/css', file: 'bootstrap.min.css'],
            attrs: [media: 'screen']
        resource url: [dir: '/bootstrap/css', file: 'bootstrap-responsive.min.css'],
            attrs: [media: 'screen']
        resource url: [dir: '/bootstrap/js', file: 'bootstrap.min.js']        
    }

    reset {
        resource url: [dir: '/stylesheets', file: 'reset.css'],
            attrs: [media: 'screen']
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
        resource url: [dir: '/codemirror/lib/util', file: 'runmode.js']
        resource url: [dir: '/codemirror/lib/util', file: 'jquery.codemirror.js']
    }

    prettify {
        resource url: [dir: '/google-code-prettify', file: 'prettify.css']
        resource url: [dir: '/google-code-prettify', file: 'prettify.js']
    }

    tinymce {
        //resource url: [dir: '/tiny_mce', file: 'tiny_mce.js']
        resource url: [dir: '/tiny_mce', file: 'jquery.tinymce.js']
    }

    overrides {
        'jquery-theme' {
            resource id:'theme', url: '/css/jquery-ui/cupertino/jquery-ui-1.8.17.custom.css'
        }
    }
}