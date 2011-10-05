package org.contpub.simaqian



import grails.test.mixin.*
import org.junit.*

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(User)
class UserTests {

	void testCreateAndDelete() {
		def user = new User()

		user.email = 'test@test.xxx'
		user.account = 'john'
		user.password = 'pwd12345'

		assertNotNull user.save()
		assertNotNull user.id

		user.delete()
	}

	void testCreateAndDelete2() {
		def user = new User(
			email: 'test2@test.xxx',
			account: 'joe',
			password: 'xxx12345'
		)

		assertNotNull user.save()
		assertNotNull user.id

		user.delete()
	}
}
