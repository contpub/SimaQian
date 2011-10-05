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
	    	title: 'book1',
	    	homepage: 'http://contpub.org/book1',
	    	type: RepoType.GitHub,
	    	url: 'git://test'
	    )
	    
	    book.save()

		assertNotNull book.id
		
		book.delete()
    }
}
