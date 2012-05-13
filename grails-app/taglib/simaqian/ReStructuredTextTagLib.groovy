package simaqian

class ReStructuredTextTagLib {
	static namespace = 'reStructuredText'

	/**
	 * Print out document heading title
	 * 
	 * document style:
	 *
	 * =============
	 * Heading Title
	 * =============
	 *
	 * section style:
	 *
	 * Heading Title
	 * =============
	 */
	def title = { attr, body ->
		def title = attr.title?attr.title:''
		def title_size = title.size()
		def title_bytes_size = title.bytes.size()
		def adornment = attr.adornment?attr.adornment:'='
		def isDocument = (attr.style=='document'?true:false)

		def adornment_line = "${adornment.multiply(title_size+(title_bytes_size-title_size)/2)}"

		if (isDocument) {
			out << "${adornment_line}\n${title}\n${adornment_line}\n"
		}
		else {
			out << "${title}\n${adornment_line}\n"
		}
	}
}
