package org.contpub.simaqian

/**
 * Repository type
 */
public enum RepoType {
	EMBED,
	GIT,
	SVN;
}

/**
 * Book domain object
 */
class Book {
	String name				//書籍名稱（代碼，例：MyBook1）
	String title			//書籍標題
	
	BookProfile profile		//Profile
	
	Boolean isCooking		= false		//是否正在處理轉換中
	Integer countCook		= 0			//計算處理次數
	
	Boolean isAvailable		= false		// Default is not available
	Boolean isVisible		= true		// Default is visible
	Boolean isPublic		= true		// Public Book => 公版書/免費書

	RepoType type = RepoType.GIT	// Repository Type (ex. GIT, SVN)
	String url						// Repository URL (ex. git@github.com:user/project)

	Date dateCreated				//建立日期
	Date lastUpdated				//修改日期
	
	static hasMany = [
		users: UserAndBook
	]

	static constraints = {
		name (nullable: false, blank: false, size: 5..30, unique: true, matches: /[a-zA-Z0-9\-\_]+/)
		title (nullable: false, blank: false)
		type (nullable: true)
		url (nullable: true, url: true)
		profile (nullable: true)
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
