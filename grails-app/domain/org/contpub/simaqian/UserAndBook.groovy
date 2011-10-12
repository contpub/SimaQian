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

	Date dateCreated		//建立日期
	Date lastUpdated		//修改日期
	
	static belongsTo = [user: User, book: Book]
    
    static constraints = {

    }
}
