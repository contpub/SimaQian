package simaqian

class Sandbox {
	String title				//書名
	String authors				//作者
	String contents				//書籍內容
	String password				//密碼保護

	String epubTheme = "epub_simple"	// ePub 佈景主題
	String pdfPaperSize = "b5"			// pdf paper size
	String pdfFontSize = "12pt"			// pdf font size

	Boolean isCooking = false	//是否正在處理轉換中
	Boolean isSample = false	// in sample catalog

	Date dateCreated				// Created Datetime
	Date lastUpdated				// Modified Datetime
	Date cookUpdated = new Date()	// Publish Record Datetime

	User owner						// who own this?

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

	static getPdfPaperSizeList() {
		['a4', 'b5']
	}

	static getPdfFontSizeList() {
		['10pt', '11pt', '12pt']
	}
}
