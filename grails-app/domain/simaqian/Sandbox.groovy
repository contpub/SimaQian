package simaqian

class Sandbox {
	String title				//書名
	String authors				//作者
	String contents				//書籍內容
	String password				//密碼保護

	Boolean isSample = false		// in sample catalog

	Boolean isCooking = false		// cooking status
	Date cookUpdated = new Date()	// published datetime

	Date dateCreated				// created datetime
	Date lastUpdated				// modified datetime

	User owner						// owner

	static constraints = {
		title (nullable: false, blank: false)
		authors (nullable: false, blank: false)
		contents (nullable: true, blank: true)
		password (nullable: true, blank: true)
		cookUpdated (nullable: true)
		owner (nullable: true)
	}
	
	static mapping = {
		 contents (type: 'text')
	}
}
