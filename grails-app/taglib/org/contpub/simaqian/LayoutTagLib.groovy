package org.contpub.simaqian

class LayoutTagLib {
	
	static namespace = 'layoutTag'
	
	def loginBox = { attr, body ->
		out << render (template: '/_layout/loginBox', model: [])
	}
	
	def userBox = { attr, body ->
		out << render (template: '/_layout/userBox', model: [])
	}
	
	def ajaxLoaderImage = { attr, body ->
		def fileName = 'ajax-loader'
		
		if (attr.type) {
			fileName += "-${attr.type}"
		}
		
		fileName += ".gif"
		
		def src = createLinkTo(dir: 'images', file: fileName)
		
		out << "<img src=\"${src}\" title=\"loading\" alt=\"ajax-loader\" border=\"0\" class=\"ajax-loader\" />"
	}
	
}
