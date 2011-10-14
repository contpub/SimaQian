package org.contpub.simaqian

class CommonTagLib {

	def fullURL = { a ->
		a.base = "${baseURL()}${request.contextPath}"
		out << resource(a)
	}
	
	def baseURL = {
		out << "${request.scheme}://${request.serverName}"
		
		if (request.serverPort != 80) {
			out << ":${request.serverPort}"
		}
	}

	def isUser = { attr, body ->
		if (session['user']) {
			out << body()
		}
	}
	
	def isNotUser = { attr, body ->
		if (!session['user']) {
			out << body()
		}
	}
	
	/**
	 * @Deprecated
	 */
	def layoutLoginBox = { attr, body ->
		out << render (template: '/tagLib/layout/loginBox', model: [])
	}

	/**
	 * @Deprecated
	 */	
	def layoutUserBox = { attr, body ->
		out << render (template: '/tagLib/layout/userBox', model: [])
	}

	/**
	 * @Deprecated
	 */	
	def layoutAjaxLoaderImage = { attr, body ->
		def fileName = 'ajax-loader'
		if (attr.type) {
			fileName += "-${attr.type}"
		}
		fileName += ".gif"
		def src = createLinkTo(dir: 'images', file: fileName)
		out << "<img src=\"${src}\" title=\"loading\" alt=\"ajax-loader\" border=\"0\" class=\"ajax-loader\" />"
	}
}
