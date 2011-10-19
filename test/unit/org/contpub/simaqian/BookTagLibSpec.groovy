package org.contpub.simaqian

import spock.lang.*
import grails.plugin.spock.*
import grails.test.mixin.*

@TestFor(BookTagLib)
@TestMixin(CommonTagLib)
@Mock(Book)
class BookTagLibSpec extends Specification {
	def bookTag = new BookTagLib()
	def commonTag = new CommonTagLib()
	
    def "test createLink"() {
		setup:
		
		when:
		new Book(name: name, title: title).save()

		then:
		bookTag.createLink(book: Book.findByName(name)).toString().endsWith('/read/'+name)

		where:
		name = 'test123'
		title = 'test 123'
    }
}
