package org.contpub.simaqian

class LayoutTagLib {
	def absLink = { a ->
		a.base = "${baseURL()}${request.contextPath}"
		out << resource(a)
	}
	def baseURL = {
		out << "${request.scheme}://${request.serverName}"
		
		if (request.serverPort != 80) {
			out << ":${request.serverPort}"
		}
	}
	
	/**
	 * <g:createBookLink book=${book} />
	 */
	def createBookLink = { attr, body ->
		out << baseURL()
		if (attr.book) {
			out << '/read/' << attr.book.name
		}
	}
	
	/**
	 * <g:createLinkToBook book=${book}>Text</g:createLinkToBook>
	 */
	def createLinkToBook = { attr, body ->
		def href = baseURL()
		def title = ''
		if (attr.book) {
			href = "${href}/read/${attr.book.name}"
			title = attr.book.title
		}
		out << "<a href=\"${href}\" title=\"${title}\">"
		out << body()
		out << "</a>"
	}
	
	/**
	 * <g:createBookDownloadLink book=${book} />
	 */
	def createBookDownloadLink = { attr, body ->
		out << baseURL()
		if (attr.book) {
			out << '/download/' << attr.book.name
			
			if (attr.ext) {
				out << '.' << attr.ext
			}
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
	
	def layoutLoginBox = { attr, body ->
		out << render (template: '/_layout/loginBox', model: [])
	}
	
	def layoutUserBox = { attr, body ->
		out << render (template: '/_layout/userBox', model: [])
	}
	
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
