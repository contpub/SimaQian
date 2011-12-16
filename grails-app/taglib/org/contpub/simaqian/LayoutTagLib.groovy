package org.contpub.simaqian

class LayoutTagLib {
	
	static namespace = 'layoutTag'
	
	/**
	 * Display Loading image for ajax events or page redirection
	 */
	def ajaxLoaderImage = { attr, body ->
		def fileName = 'ajax-loader'
		
		if (attr.type) {
			fileName += "-${attr.type}"
		}
		
		fileName += ".gif"
		
		def src = createLinkTo(dir: 'images', file: fileName)
		
		out << "<img src=\"${src}\" title=\"loading\" alt=\"ajax-loader\" border=\"0\" class=\"ajax-loader\" />"
	}
	
	/**
	 * Display Login widgets
	 */
	def loginBox = { attr, body ->
		def user = User.get(session.userId)
		out << render (template: '/tagLib/layout/loginBox', model: [user: user])
	}

	/**
	 * Display User widgets
	 */	
	def userBox = { attr, body ->
		def user = User.get(session.userId)
		out << render (template: '/tagLib/layout/userBox', model: [user: user])
	}

	/**
	 * <layoutTag:normalMeta />
	 */
	def normalMeta = { attr, body ->
		out << """<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="author" content="StrongSoft" />
	<meta name="description" content="Now everyone can publish ..." />
	<meta name="keywords" content="keywords, here" />
	<meta name="robots" content="index, follow, noarchive" />
	<meta name="googlebot" content="noarchive" />"""
	}

	/**
	 * <layoutTag:normalHead />
	 */
	def normalHead = { attr, body ->
		out << '<!--Normal Head-->'
		out << """<link rel="stylesheet" type="text/css" media="screen" href="${createLinkTo(dir: 'css', file: 'screen.css')}" />"""
		out << """<link rel="stylesheet" type="text/css" media="screen" href="${createLinkTo(dir: 'css', file: 'layout.css')}" />"""
		//out << """<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">"""
		out << """<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">"""
	}

	/**
	 * <layoutTag:normalIcon />
	 */
	def normalIcon = { attr, body ->
		out << '<!--Normal Icon-->'
		out << """<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">"""
		out << """<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">"""
		out << """<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">"""
	}
	
	/**
	 * <layoutTag:jquery />
	 */
	def jquery = { attr, body ->
		out << '<!--jQuery core-->'
		out << '<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>'
	}

	/**
	 * <layoutTag:jqueryUI />
	 */
	def jqueryUI = { attr, body ->
		out << '<!--jQuery UI-->'
		out << '<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/base/jquery-ui.css" type="text/css" media="all" />'
		out << '<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.js"></script>'
	}

	/**
	 * <layoutTag:jqueryColorbox />
	 */
	def jqueryColorbox = { attr, body ->
		out << '<!--jQuery colorbox-->'
		out << """<link rel="stylesheet" type="text/css" media="screen" href="${createLinkTo(dir: 'css', file: 'colorbox.css')}" />
	<script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'jquery.colorbox-min.js')}"></script>"""
	}
	
	/**
	 * <layoutTag:webFonts family="Droid Sans Mono" />
	 */
	def webFonts = { attr, body ->
		out << """<!-Google Web Fonts--><link href="http://fonts.googleapis.com/css?family=${attr.family?.replace(' ', '+')}" rel="stylesheet" type="text/css" />"""
	}

	/**
	 * <layoutTag:codemirror />
	 */
	def codemirror = { attr, body ->
		out << """<!--Codemirror--><script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'jquery.colorbox-min.js')}"></script>
	<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror/mode/rst', file: 'rst.css')}">
	<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror', file: 'codemirror.css')}">
	<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror/theme', file: 'default.css')}">
	<script src="${createLinkTo(dir: 'codemirror', file: 'codemirror.js')}"></script>
	<script src="${createLinkTo(dir: 'codemirror/mode/rst', file: 'rst.js')}"></script>
	<script src="${createLinkTo(dir: 'codemirror', file: 'runmode.js')}"></script>
	<script src="${createLinkTo(dir: 'js', file: 'jquery.codemirror.js')}"></script>"""
	}

	/**
	 * <layoutTag:reset />
	 */
	def reset = { attr, body ->
		out << '<!--reset--><link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/reset/reset-min.css">'
	}
}
