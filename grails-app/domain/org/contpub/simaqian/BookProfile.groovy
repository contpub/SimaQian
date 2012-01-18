package org.contpub.simaqian

class BookProfile {
	String description		//簡述書籍內容
	String contents			//embedded content

	String homepage			//書籍網站（如有外部網站則可設定）
	String icon				//縮圖（小圖示）

	static belongsTo = [book: Book]

    static constraints = {
		description (nullable: true, blank: true)
		contents (nullable: true, blank: true)
		homepage (nullable: true, blank: true, url: true)
		icon (nullable: true, blank: true, url: true)
    }
}
