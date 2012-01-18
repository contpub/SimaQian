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
		//out << """<link rel="stylesheet" type="text/css" media="screen" href="${createLinkTo(dir: 'css', file: 'screen.css')}" />"""
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
	 * <layoutTag:webFonts family="Droid Sans Mono" />
	 */
	def webFonts = { attr, body ->
		out << """<!-Google Web Fonts--><link href="http://fonts.googleapis.com/css?family=${attr.family?.replace(' ', '+')}" rel="stylesheet" type="text/css" />"""
	}

	/**
	 * <layoutTag:flashMessage />
	 */
	 def flashMessage = { attr, body ->
		out << render (template: '/tagLib/layout/flashMessage', model: [])
	 }
}
