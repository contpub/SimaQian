package org.contpub.simaqian

class UserTagLib {

	static namespace = 'userTag'
	
	/**
	 * If user is login, output body text
	 */
	def isLogin = { attr, body ->
		if (session['user']) {
			out << body()
		}
	}
	
	/**
	 * If user is not login, output body text
	 */
	def isNotLogin = { attr, body ->
		if (!session['user']) {
			out << body()
		}
	}
	
}
