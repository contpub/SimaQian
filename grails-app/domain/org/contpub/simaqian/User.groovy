package org.contpub.simaqian

/**
 * User domain object
 */
class User {

	String name			// Full name
	String email			// E-mail address
	String account		// Account name (login)
	String password		// Password
	
	Date dateCreated		//建立日期
	Date lastUpdated		//修改日期

    static constraints = {
		name (nullable: false, blank: false)
		email (nullable: false, unique: true, email:true, blank: false)
		account (nullable: false, unique: true, blank: false, size: 4..20, matches: /[a-zA-Z0-9\-\_]+/)
		password (size: 5..15, blank: false)
    }
}
