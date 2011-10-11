package org.contpub.simaqian

/**
 * Explore for new books
 */
class ExploreController {

    def index() {
	    [books: Book.findAll()]
    }
}
