package org.contpub.simaqian

/**
 * Repository type
 */
public enum UserAndBookLinkType {
	OWNER,
	BUYER;
}

class UserAndBook {

	UserAndBookLinkType linkType = UserAndBookLinkType.BUYER

	static belongsTo = [user: User, book: Book]
    	
    static constraints = {

    }
}
