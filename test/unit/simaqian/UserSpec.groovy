package simaqian

import spock.lang.*
import grails.plugin.spock.*
import grails.test.mixin.*

@Mock(User)
class UserSpec extends Specification {

	def "create a user"() {
		setup:
		//mockDomain(User)
		
		when:
		new User(
			name: name,
			email: email,
			account: account,
			password: password
		).save()

		then:
		User.findByName(name) != null

		where:
		name = 'bill'
		email = 'test@test.xxx'
		account = 'john'
		password = 'pwd12345'
	}
	
	def "delete a user"() {
		setup:
		//mockDomain(User)
		
		when:
		new User(
			name: name,
			email: email,
			account: account,
			password: password
		).save()
		User.findByName(name).delete()

		then:
		User.findByName(name) == null

		where:
		name = 'bill'
		email = 'test@test.xxx'
		account = 'john'
		password = 'pwd12345'
	}
}
