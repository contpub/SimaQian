package simaqian

class BookBuyer {
	Book book			//書籍連結
	String email		//電子郵件
	String name			//購買者
	String method		//購買方式
	String serial		//購買單號
	String password		//密碼
	String memo			//備註
	String message		//程式原始資料註記

	Date dateCreated		//建立日期
	Date lastUpdated		//修改日期
	
    static constraints = {
    	message(nullable: true)
    }
}
