package simaqian

/**
 * Explore for new books
 */
class ExploreController {

	def index() {

		def books = Book.withCriteria {
			eq ('isPublic', true)
			eq ('isDeleted', false)
			order ('lastUpdated', 'desc')
			//maxResults (params.max?params.max:5)
			//firstResult (params.offset?params.offset:0)
		}

		/*def totalBooks = Book.executeQuery(
			'select count(b) from Book b where isPublic = true'
		)*/

		[
			books: books
		]
	}
}
