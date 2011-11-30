package org.contpub.simaqian

/**
 * Explore for new books
 */
class ExploreController {

	def index() {
		[
			books: Book.withCriteria {
				eq('isPublic', true)
				order('lastUpdated')
				maxResults(params.max?params.max:5)
				firstResult(params.offset?params.offset:0)
			},
			//Book.findAll([max: params.max?params.max:5, offset: params.offset]),
			totalBooks: Book.count()
		]
	}
}
