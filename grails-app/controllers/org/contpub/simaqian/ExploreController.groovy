package org.contpub.simaqian

/**
 * Explore for new books
 */
class ExploreController {

	def index() {
		[
			books: Book.findAll([max: params.max?params.max:5, offset: params.offset]),
			totalBooks: Book.count()
		]
	}
}
