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
	String title				//書籍標題
	String homepage			//書籍網站（如有外部網站則可設定）
	String icon				//縮圖（小圖示）
	String cover				//書籍的封面圖片（使用外部相簿位址）

	String description		//簡述書籍內容
	String htmlDescription	//簡述書籍內容

	String contents			//embedded content
	String htmlContents		//embedded content to HTML
	
	String urlToPdf			// pdf url (amazon s3)
	String urlToEpub			// epub url (amazon s3)
	
	Boolean isCooking = false	//是否正在處理轉換中
	Integer countCook = 0		//計算處理次數

	RepoType type		// Repository Type (ex. GIT, SVN)
	String url			// Repository URL (ex. git@github.com:user/project)

	Date dateCreated		//建立日期
	Date lastUpdated		//修改日期

	static constraints = {
		name (nullable: false, blank: false, size: 5..30, unique: true, matches: /[a-zA-Z0-9\-\_]+/)
		title (nullable: false, blank: false)
		homepage (url: true)
		description (nullable: false, blank: true)
		icon (url: true)
		cover (url: true)
		urlToPdf (nullable: true)
		urlToEpub (nullable: true)
		url (url: true)
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
