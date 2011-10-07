package org.contpub.simaqian



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Book)
class BookTests {

	void testNewBook() {
		def book = new Book()
		assertNotNull book
	}

	void testBookLink() {
		def book = new Book()
		book.name = 'hello'
		assertEquals '/book:hello', book.link
	}
}
