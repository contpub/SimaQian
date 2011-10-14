package org.contpub.simaqian

import spock.lang.*
import grails.plugin.spock.*
import grails.test.mixin.*

@TestFor(BookTagLib)
@TestMixin(CommonTagLib)
@Mock(Book)
class BookTagLibSpec extends Specification {

    def "test "() {
		setup:
		
		when:
		book.name = 'test123'

		then:
		bookTag.createLink(book: book)		| '/read/test123'

		where:
		bookTag = new BookTagLib()
		commonTag = new CommonTagLib()
		book = new Book()
    }
}
