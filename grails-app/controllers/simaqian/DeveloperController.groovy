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
                [id: 2, label: '軟體開發', size: 2]
            ]
        }
    }

    def catalog = {
        def books = []
        
        switch (params.id) {
            case '1':
                books << Book.findByName('PUB000003')
            break
            case '2':
                books << Book.findByName('kalvar-20120324')
            break
        }

        if (!params.id) {
            books << Book.findByName('PUB000001')
            books << Book.findByName('PUB000002')
            books << Book.findByName('PUB000003')
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
            books << Book.findByName('PUB000003')
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

    def favorite = {
        render (contentType: 'text/json') {
            [
                success: true
            ]
        }
    }
}
