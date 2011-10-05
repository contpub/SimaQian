package org.contpub.simaqian

class RepoBookController {
	static scaffold = RepoBook

	def cook = {
		// Test for send messages
		rabbitSend 'msgs', 'How are you?'

		println 'test'
	}
}
