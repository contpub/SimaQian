package simaqian

/**
 * Repository type
 */
public enum UserAndBookLinkType {
	OWNER,				//書籍擁有者（可以刪除、修改設定）
	AUTHOR,				//書籍作者（可以修改文字內容）
	BUYER,				//書籍買家（可以閱讀非開放內容）
	WATCHER;			//對書籍感興趣的使用者（顯示在書櫃內）
}

class UserAndBook {

	UserAndBookLinkType linkType = UserAndBookLinkType.BUYER

	Date dateCreated		//建立日期
	Date lastUpdated		//修改日期
	
	static belongsTo = [user: User, book: Book]
    
    static constraints = {

    }
}
