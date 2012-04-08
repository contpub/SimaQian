package simaqian

import spock.lang.*
import grails.plugin.spock.*
import grails.test.mixin.*

@Mock([Book, BookProfile])
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

	def "create book profile"() {
		setup:

		when:
		
		book.profile = profile
		profile.book = book
		profile.save()
		book.save()

		then:
		Book.findByName('book-with-profile').profile != null

		where:
		book = new Book(
			name: 'book-with-profile',
			title: 'Book With Profile'
		)
		profile = new BookProfile()
	}
}

