package org.contpub.simaqian

class DeveloperController {

    def index() { }

    def catalog() {
    	def books = []
    	books << Book.findByName('PUB000003')
    	books << Book.findByName('kalvar-20120324')

    	def results = []

    	books.each {
    		book->
    		if (book) {
    			results << [name: book.name, title: book.title, pdf: bookTag.createDownloadLink(book: book, type: 'pdf')]
    		}
    	}

	    render (contentType: 'text/json') {
			results
		}
	}
}
