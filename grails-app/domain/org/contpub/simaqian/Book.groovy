package org.contpub.simaqian

class Book {

	String name = ''		//書籍名稱（代碼，例：MyBook1）
	String title = ''		//書籍標題
	String homepage			//書籍網站（如有外部網站則可設定）
	String description		//簡述書籍內容
	String icon				//縮圖（小圖示）
	String cover			//書籍的封面圖片（使用外部相簿位址）
	
	String urlToPdf
	String urlToEpub

	Date dateCreated		//建立日期
	Date lastUpdated		//修改日期

	static constraints = {
		homepage (url: true)
		icon (url: true)
		cover (url: true)
		urlToPdf (nullable: true)
		urlToEpub (nullable: true)
	}
}
