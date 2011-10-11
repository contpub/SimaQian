package org.contpub.simaqian

import spock.lang.*
import grails.plugin.spock.*
import grails.test.mixin.*

@Mock([User, Book, UserAndBook])
class UserAndBookSpec extends Specification {

    def "add books to a user"() {
		setup:
		//mockDomain(User)
		//mockDomain(Book)
		//mockDomain(UserAndBook)
		
		when:
		user1 = new User(user_params)
		user1.save()
		book1 = new Book(book_params).save()
		book1.save()
		link1 = new UserAndBook()
		link1.user = user1
		link1.book = book1
		link1.save()
		user1.addToBooks(link1)
		book1.addToUsers(link1)
		user1.save()
		book1.save()

		then:
		User.findByName(user_params.name) != null
		Book.findByName(book_params.name) != null
		user1 != null
		book1 != null
		user1.name == user_params.name
		link1 != null
		user1.books != null
		book1.users != null
		User.findByName(user_params.name).books != null
		Book.findByName(book_params.name).users != null
		link1.linkType == UserAndBookLinkType.BUYER		// make sure default is BUYER
		
		where:
		user1 = null
		book1 = null
		link1 = null
		user_params = [
			name: 'John Lin',
			email: 'test@test.xxx',
			account: 'john12345',
			password: 'pwd12345'
		]
		book_params = [
			name: 'testbook',
			title: 'Test Book',
			description: 'desc'
		]
    }
}
