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
}
