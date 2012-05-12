package simaqian

class BaseTagLib {
	def basehref = { attr, body ->
		if (request.serverPort == 80) {
			out << "${request.scheme}://${request.serverName}${request.contextPath}"
		}
		else {
			out << "${request.scheme}://${request.serverName}:${request.serverPort}${request.contextPath}"
		}
	}
}
