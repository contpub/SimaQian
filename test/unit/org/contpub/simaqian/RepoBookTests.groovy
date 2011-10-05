package org.contpub.simaqian



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(RepoBook)
class RepoBookTests {

	/**
	 * Create a RepoBook
	 */
    void testCreate() {
    	RepoBook book = new RepoBook(
			name: 'BookName',
			title: 'book1',
			description: 'test',
	    	homepage: 'http://contpub.org/book1',
	    	type: RepoType.GitHub,
	    	url: 'git://test.com'
	    )
	    book.save()

		assertNotNull book.id
		
		book.delete()
    }
}
