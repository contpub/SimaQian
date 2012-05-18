package simaqian

/**
 * http://contpub.org/api/login?user=guest&pwd=guest
 * => 取得 SESSION 790d108bdf1f9f728643ed4519a2ce06
 * http://contpub.org/api/category/790d108bdf1f9f728643ed4519a2ce06
 * => 傳入 SESSION 取回 (category)id, label
 * http://contpub.org/api/catalog/790d108bdf1f9f728643ed4519a2ce06/1
 * => 傳入 SESSION, (category)id 取回 書籍清單
 */
class DeveloperController {

    def index = {

    }
    
    def login = {
        render (contentType: 'text/json') {
            [
                success: true,
                session: new Date().toString().encodeAsMD5()
            ]
        }
    }
    
    def category = {
        render (contentType: 'text/json') {
            [
                [id: 1, label: '公版書', size: 3],
                [id: 2, label: '軟體開發', size: 3],
                [id: 3, label: '信仰', size: 3],
                [id: 4, label: '旅遊文化', size: 3],
                [id: 5, label: '新進書', size: 3],
                [id: 6, label: '最新發佈', size: 3]
            ]
        }
    }

    def catalog = {
        def books = []
        
        switch (params.id) {
            case '1':
                def rows = Book.withCriteria {
                    like('name', 'PUB%')
                }
                rows.each { books << it }
            break
            case '2':
                books << Book.findByName('kalvar-20120324')
                books << Book.findByName('JavaSteps')
                books << Book.findByName('nodejs-wiki-book')
                books << Book.findByName('the-little-mongodb-book-zh-tw')
                books << Book.findByName('android-certification-book')
            break
            case '3':
                books << Book.findByName('normal-christan-life')
            break
            case '4':
                books << Book.findByName('margolliu-20120508')
            break
            case '5':
                Book.findAll(sort: 'dateCreated', max: 5).each {
                    books << it
                }
            break
            case '6':
                Book.findAll(sort: 'lastUpdated', max: 5).each {
                    books << it
                }
            break
        }

        if (!params.id) {
            def rows = Book.withCriteria {
                like('name', 'PUB%')
            }
            rows.each { books << it }
            books << Book.findByName('normal-christan-life')
            books << Book.findByName('kalvar-20120324')
        }

        def results = []

        books.each {
            book->
            if (book) {
                results << [
                    name: book.name,
                    title: book.title,
                    subtitle: book.subtitle,
                    authors: book.authors,
                    favorite: true,
                    cover: bookTag.createCoverLink(book: book),
                    pdf: bookTag.createDownloadLink(book: book, type: 'pdf'),
                    epub: bookTag.createDownloadLink(book: book, type: 'epub'),
                    mobi: bookTag.createDownloadLink(book: book, type: 'mobi')]
            }
        }

        render (contentType: 'text/json') {
            results
        }
    }

    def search = {
        def books = []
        
        if (params.q) {
            def rows = Book.withCriteria {
                or {
                    like('name', "%${params.q}%")
                    like('title', "%${params.q}%")
                    like('subtitle', "%${params.q}%")
                    like('authors', "%${params.q}%")
                }
            }
            rows.each { books << it }
        }

        def results = []

        books.each {
            book->
            if (book) {
                results << [
                    name: book.name,
                    title: book.title,
                    subtitle: book.subtitle,
                    authors: book.authors,
                    favorite: true,
                    cover: bookTag.createCoverLink(book: book),
                    pdf: bookTag.createDownloadLink(book: book, type: 'pdf'),
                    epub: bookTag.createDownloadLink(book: book, type: 'epub'),
                    mobi: bookTag.createDownloadLink(book: book, type: 'mobi')]
            }
        }

        render (contentType: 'text/json') {
            results
        }
    }

    def favorite = {
        render (contentType: 'text/json') {
            [
                success: true
            ]
        }
    }
}
