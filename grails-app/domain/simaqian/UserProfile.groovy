package simaqian

class UserProfile {

	String description	// User's self introduction
	String homepage		// Homepage URL (About)
	String blog			// Blog URL

	static belongsTo = [user: User]

    static constraints = {
		description (nullable: true)
		homepage (nullable: true, url: true)
		blog (nullable: true, url: true)
    }
}
