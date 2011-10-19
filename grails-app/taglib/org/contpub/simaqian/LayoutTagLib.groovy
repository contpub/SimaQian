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
		out << render (template: '/tagLib/layout/loginBox', model: [])
	}

	/**
	 * Display User widgets
	 */	
	def userBox = { attr, body ->
		out << render (template: '/tagLib/layout/userBox', model: [])
	}
}
