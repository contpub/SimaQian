package org.contpub.simaqian

/**
 * User domain object
 */
class User {

	String name				// Full name
	String email			// E-mail address
	String account			// Account name (login)
	String password			// Password
	
	UserProfile profile		// Profile
	
	Date lastLogin			// Last login date time
	String lastUserAgent	// Last Browser User-Agent
	
	Date dateCreated		//建立日期
	Date lastUpdated		//修改日期
	
	static hasMany = [
		books: UserAndBook
	]

	static constraints = {
		name (nullable: false, blank: false)
		email (nullable: false, unique: true, email:true, blank: false)
		account (nullable: false, unique: true, blank: false, size: 4..20, matches: /[a-zA-Z0-9\-\_]+/)
		password (size: 5..15, blank: false)
		profile (nullable: true)
		lastLogin (nullable: true)
		lastUserAgent (nullable: true)
	}
}
