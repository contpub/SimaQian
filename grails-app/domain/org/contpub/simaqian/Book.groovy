package org.contpub.simaqian

/**
 * Repository type
 */
public enum RepoType {
	EMBED,
	GIT,
	SVN,
	DROPBOX;
}

/**
 * Book domain object
 */
class Book {
	String name				//book name (code, eg. MyBook1)
	String title			//book title
	String subtitle			//book sub-title
	String authors			//book authors
	
	BookProfile profile		//Profile
	
	Boolean isCooking		= false		//是否正在處理轉換中
	Integer countCook		= 0			//計算處理次數
	
	Boolean isAvailable		= false		// Default is not available
	Boolean isVisible		= true		// Default is visible
	Boolean isPublic		= true		// Public Book => 公版書/免費書
	
	Boolean hasCover		= false		// Has cover or not

	RepoType type = RepoType.EMBED	// Repository Type (ex. GIT, SVN)
	String url						// Repository URL (ex. git@github.com:user/project)
	String cname

	Date dateCreated				// Created Datetime
	Date lastUpdated				// Modified Datetime
	Date cookUpdated				// Publish Record Datetime

	static hasMany = [
		users: UserAndBook
	]

	static constraints = {
		name (nullable: false, blank: false, size: 5..30, unique: true, matches: /[a-zA-Z0-9\-\_]+/)
		title (nullable: false, blank: false)
		subtitle (nullable: true, blank: true)
		authors (nullable: true, blank: true)
		type (nullable: true)
		url (nullable: true, url: true)
		cname (nullable: true, blank: true)
		profile (nullable: true)
		cookUpdated (nullable: true)
	}

	/**
	 * Repository type (enum to list)
	 */	
	def getTypeList() {
		RepoType.values()
	}
	
	/**
	 * Generate permalinks for a book
	 */
	def getLink() {
		new String("/read/${name}")
	}
	
	/**
	 * Generate download links for a book
	 */
	def getDownloadLink(type = 'pdf') {
		new String("/download/${name}.${type}")
	}
}
