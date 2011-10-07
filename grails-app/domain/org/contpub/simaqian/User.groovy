package org.contpub.simaqian

class User {

	String name
	String email
	String account
	String password

    static constraints = {
    	name (nullable: false, blank: false)
    	email (nullable: false, email:true, blank: false)
    	account (nullable: false, unique: true, blank: false, size: 4..20, matches: /[a-zA-Z0-9\-\_]+/)
    	password (size: 5..15, blank: false)
    }
}
