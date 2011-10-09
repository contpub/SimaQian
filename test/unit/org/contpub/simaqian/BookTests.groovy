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
		assertEquals '/read/hello', book.link
	}
	
	void testBookDownloadLink() {
		def book = new Book()
		book.name = 'hello'
		assertEquals '/download/hello.pdf', book.downloadLink
		assertEquals '/download/hello.pdf', book.getDownloadLink('epub')
	}
}
