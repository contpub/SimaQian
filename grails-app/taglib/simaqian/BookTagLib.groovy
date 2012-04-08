package simaqian

class BookTagLib {

	static namespace = 'bookTag'
	
	private _basehref() {
		request.serverPort == 80 ?
		"${request.scheme}://${request.serverName}${request.contextPath}" :
		"${request.scheme}://${request.serverName}:${request.serverPort}${request.contextPath}"
	}
	
	/**
	 * <bookTag:createLink book=${book} />
	 */
	def createLink = { attr, body ->
		out << _basehref()
		if (attr.book) {
			out << attr.book.link
		}
	}
	
	/**
	 * <bookTag:link book=${book}>Text</bookTag:link>
	 */
	def link = { attr, body ->
		out << "<a href=\"${attr.book?createLink(book: attr.book):'#'}\" title=\"${attr.book?.title}\">"
		if (body()) {
			out << body()
		}
		else {
			out << attr.book?.title
		}
		out << "</a>"
	}
	
	def createCoverLink = { attr, body ->
		if (attr.book) {
			//out << grailsApplication.config.aws.href
			//out << attr.book.name.substring(0,1).toLowerCase()
			//out << '/'
			//out << attr.book.name
			//out << '.png'

			out << _basehref()
			out << "/cover/${attr.book?.name}.png"
		}
	}
	
	/**
	 * <bookTag:createDownloadLink book=${book} type="pdf" />
	 */
	def createDownloadLink = { attr, body ->
		def book = attr.book

		if (book) {
			if (attr.type=='cdn') {
				if (book.vhost) {
					out << "http://${book.vhost}/"
				}
				else {
					out << grailsApplication.config.appConf.cdn.href
					out << "public/"
					out << book.name //cdn link
					out << "/index.html"
				}
			}
			else {
				out << _basehref()
				out << attr.book.getDownloadLink(attr.type)
			}
		}
		else {
			out << _basehref()
		}
	}
	
	/**
	 * <bookTag:downloadLink book=${book} type="pdf" />
	 */
	def downloadLink = { attr, body ->
		out << "<a"
		out << " href=\"${attr.book?createDownloadLink(book: attr.book, type: attr.type):'#'}\""
		out << " title=\"${attr.book?.title}\""
		out << " class=\"${attr.class}\""
		out << ">"
		out << body()
		out << "</a>"
	}
	
	/**
	 * <bookTag:coverImage book=${} />
	 */
	def coverImage = { attr, body ->
		if (attr.book) {
			out << render (
				template: '/tagLib/book/coverImage',
				model: [book: attr.book]
			)
		}
	}
}
