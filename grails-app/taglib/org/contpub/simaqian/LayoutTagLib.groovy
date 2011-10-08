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
	
	def createBookLink = { attr, body ->
		out << baseURL()
		if (attr.book) {
			out << '/read/' << attr.book.name
		}
	}
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
}
