package org.contpub.simaqian

import spock.lang.*
import grails.plugin.spock.*
import grails.test.mixin.*

@Mock(Book)
class BookSpec extends Specification {
    
	def "create a new book"() {
		setup:
		
		when:
		new Book(
			name: name,
			title: title
		).save()

		then:
		Book.findByName(name)

		where:
		name = 'testbook'
		title = 'Test Book'
	}

	def "generate book permalinks"() {
		setup:
		//mockDomain(Book)
		
		when:
		book.name = 'hello'
				
		then:
		'/read/hello' == book.link
		
		where:
		book = new Book()
	}
	
	def "generate book download links"() {
		setup:
		
		when:
		book.name = 'hello'
				
		then:
		'/download/hello.pdf' == book.downloadLink
		'/download/hello.epub' == book.getDownloadLink('epub')
		
		where:
		book = new Book()
	}
}

