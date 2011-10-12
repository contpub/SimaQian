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
	String name					//書籍名稱（代碼，例：MyBook1）
	String title					//書籍標題
	String homepage				//書籍網站（如有外部網站則可設定）
	String icon					//縮圖（小圖示）
	String cover					//書籍的封面圖片（使用外部相簿位址）

	String description			//簡述書籍內容
	String htmlDescription		//簡述書籍內容

	String contents				//embedded content
	String htmlContents			//embedded content to HTML
	
	String urlToPdf				// pdf url (amazon s3)
	String urlToEpub			// epub url (amazon s3)
	
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
		description (nullable: true, blank: true)
		htmlDescription (nullable: true, blank: true)
		contents (nullable: true, blank: true)
		htmlContents (nullable: true, blank: true)
		homepage (nullable: true, url: true)
		icon (nullable: true, url: true)
		cover (nullable: true, url: true)
		urlToPdf (nullable: true)
		urlToEpub (nullable: true)
		type (nullable: true)
		url (nullable: true, url: true)
	}

	/**
	 * Repository type (enum to list)
	 */	
	def getTypeList() {
		RepoType.values()
	}
	
	/**
	 * Generate Permalinks for Books
	 */
	def getLink() {
		new String("/read/${name}")
	}
	
	/**
	 * Generate Download Links for Books
	 */
	def getDownloadLink(ext = 'pdf') {
		new String("/download/${name}.${ext}")
	}
}
