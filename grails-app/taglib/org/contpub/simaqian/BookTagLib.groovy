package org.contpub.simaqian

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
		out << body()
		out << "</a>"
	}
	
	def createCoverLink = { attr, body ->
		out << grailsApplication.config.aws.href
		if (attr.book) {
			out << attr.book.name
		}
		out << '.png'
	}
	
	/**
	 * <bookTag:createDownloadLink book=${book} />
	 */
	def createDownloadLink = { attr, body ->
		out << _basehref()
		if (attr.book) {
			out << attr.book.getDownloadLink(attr.type)
		}
	}
	
	/**
	 * <bookTag:downloadLink book=${book} />
	 */
	def downloadLink = { attr, body ->
		out << "<a href=\"${attr.book?createDownloadLink(book: attr.book, type: attr.type):'#'}\" title=\"${attr.book?.title}\">"
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
