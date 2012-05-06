package simaqian

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
		out << render (template: '/tagLib/layout/normalMeta', model: [])
	}

	/**
	 * <layoutTag:webFonts family="Droid Sans Mono" />
	 */
	def webFonts = { attr, body ->
		/*
		def fontstring = attr.family
		if (fontstring) {
			def items = []
			fontstring.split(',').each {
				items << it?.trim().replace(' ', '+')
			}
			fontstring = items.join('|')
		}
		*/
		def fontstring = attr.family
		out << """<!-Google Web Fonts-->\n<link href="http://fonts.googleapis.com/css?family=${fontstring}" rel="stylesheet" type="text/css" />"""
	}

	/**
	 * <layoutTag:flashMessage />
	 */
	 def flashMessage = { attr, body ->
		out << render (template: '/tagLib/layout/flashMessage', model: [])
	 }
}
