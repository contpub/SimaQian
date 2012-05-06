package simaqian

import groovy.xml.MarkupBuilder
import groovy.json.JsonBuilder
import groovyx.net.http.URIBuilder

/**
 * Publish Controller
 */
class PublishController {

	BookService bookService
	UserService userService

	static defaultAction = 'create'

	/**
	 * Homepage, redirect to create a book
	 */
    def index() {
    	redirect (action: 'create')
    }
    
    /**
     * Create a new book.
     */
	def create = {
		def book = new Book(params)
		def user = User.get(session.userId)

        if (!user) { response.sendError 403; return }

        if (params.create) {
			book.name = params.name
			book.title = params.title
			book.isPublic = (params.isPublic=='on')

			// Save Book!!!
			if (book.save(flush: true)) {
				
				// Create book profile
				book.profile = new BookProfile(book: book)
				book.profile.save(flush: true)

				/* Connect User and Book association */
				def link1 = new UserAndBook(user: user, book: book, linkType: UserAndBookLinkType.OWNER)			
				link1.save(flush: true)

				user.addToBooks(link1)
				book.addToUsers(link1)

				user.save(flush: true)
				book.save(flush: true)

				flash.alertType = 'success'
				flash.alertMessage = "Saved. ${new Date()}"        		
        		redirect(controller: 'publish', action: 'editor', id: book?.id)
			}
		}
		else {
			book.name = "${user?.account}-${new Date().format('yyyyMMdd')}"
		}
		
		[
			book: book,
			booknums: Book.count()
		]
	}
	
	/**
	 * Update a book by id.
	 */
	def update = {
		def book = Book.get(params.id)
		def user = User.get(session.userId)
		def link = UserAndBook.findByBookAndUser(book, user)

		if (!user) { response.sendError 403; return }
		if (!book) { response.sendError 404; return }
		if (link?.linkType != UserAndBookLinkType.OWNER) {
			response.sendError 403
			return
		}

		if (params.update) {
			book.title = params.title
			book.subtitle = params.subtitle
			book.authors = params.authors

			if (book.profile) {
				book.profile.description = params.description
				book.profile.save(flush: true)
			}
			
			if (book.save(flush: true)) {
				//flash messages
				flash.message = 'common.flash.message.saved'
				flash.args = [new Date(), book.title]
				flash.default = '{1} saved {0}'
				flash.type = 'success'
			}
		}

		[
			book: book
		]
	}

	/**
	 * permanent remove book contents
	 */
	def delete = {
		def book = Book.get(params.id)
		def user = User.get(session.userId)
		def link = UserAndBook.findByBookAndUser(book, user)

		if (!user) { response.sendError 403; return }
		if (!book) { response.sendError 404; return }

		if (link?.linkType != UserAndBookLinkType.OWNER) {
			response.sendError 403
			return
		}

		if (params.confirm=='yes') {
			//book.isDeleted = true
			//book.save(flush: true)
			book.delete(flush: true)
			redirect(controller: 'book', action: 'user', id: user?.id)
			return
		}

		[
			book: book
		]
	}

	/**
	 * legacyToXml transfer plain text to xml files structure
	 */
	def legacyToXml = {
		Book.findAll().each {
			book ->
			//println book
			if (book.profile) {
				println "${book} process"
				
				def contents = book.profile.contents

				if (contents) {
					def contentsArray = contents.split("\n.. end-of-file\n")

					def writer = new StringWriter()
					def xml = new MarkupBuilder(writer)
					xml.files() {
						contentsArray.each {
							c->
							file(c)
						}
					}

					book.profile.contents = writer.toString()
					book.profile.save(flush: true)

					println "-xml-created-" 
				}

			}
			else {
				println "${book} no profile"
			}
		}
		render('-end-')
	}

	/**
	 * Editor
	 */
	def editor = {
		def book = Book.get(params.id)
		def user = User.get(session.userId)
		def link = UserAndBook.findByBookAndUser(book, user)

		if (!book) { response.sendError 404; return }
		if (!user) { response.sendError 403; return }
		if (link?.linkType != UserAndBookLinkType.OWNER) { response.sendError 403; return }

		def offset = params.offset?Integer.valueOf(params.offset):0

		def contents = book?.profile?.contents

		def catalog = []
		def contents_array = []

		if (contents) {
			def xml = new XmlParser().parseText(contents)
			def files = xml.file
			if (files) {
				files.each { file ->
					def text = file.text()
					contents_array << text

					def shorttext = text.replace('*', '').replace('=', '').replace('-', '').trim().split("\n")[0]
					catalog << (shorttext?shorttext:'untitled')
				}
			}
		}

		// contents_array at least one row
		if (contents_array.size() == 0) {
			contents_array << ''
		}

		if (contents_array.size() > 0 && offset >= contents_array.size()) {
			redirect(action: 'editor', id: book?.id)
			return
		}

		// update, insert or remove
		if (params.update || params.insert || params.remove) {

			def contents_array_expand = []

			def i = 0
			contents_array.each { text ->
				if (offset != i || params.insert) {
					contents_array_expand << text
				}
				if (offset == i && params.update) {
					contents_array_expand << params.contents
				}
				if (offset == i && params.insert) {
					contents_array_expand << ''
				}
				i++
			}

			def writer = new StringWriter()
			def xml = new MarkupBuilder(writer)

			xml.files() {
				contents_array_expand.each { text ->
					file(text)
				}
			}

			if (book.profile) {
				book.profile.contents = writer.toString()
				if (book.profile.save(flush: true)) {
					flash.alertType = 'success'
					flash.alertMessage = "Saved. ${new Date()}"
				}
			}

			if (params.update == 'publish') {
				sendCookMessage(book)
			}

			def newoffset = offset + (params.insert?1:0)

			redirect(action: 'editor', id: book?.id, params: [offset: newoffset])
		}

		if (!catalog) {
			catalog << 'untitled'
		}

		def total = contents_array.size()

		def part_of_contents = ""

		if (offset >= 0 && offset < contents_array.size()) {
			part_of_contents = contents_array[offset]
		}

		[
			book: book,
			contents: part_of_contents,
			catalog: catalog,
			offset: offset,
			total: total
		]
	}
	
	/**
	 * Upload a cover image for a book
	 */
	def cover = {
		def book = Book.get(params.id)
		[book: book]
	}
	
	/**
	 * Save a cover image
	 */
	def saveCover = {
		def book = Book.get(params.id)
		//println book
		
		def coverFile = request.getFile('coverFile')
		if (!coverFile.isEmpty()) {
			//println coverFile
			def result = bookService.uploadCoverImage(coverFile, book.name)
			if (result) {
				book.hasCover = true
				book.save(flush: true)
			}
		}
		
		redirect(action: 'cover', id: book?.id)
	}

	/**
	 * Media types
	 */
	def media = {
		def book = Book.get(params.id)
		def user = User.get(session.userId)
		def link = UserAndBook.findByBookAndUser(book, user)

		if (!book) { response.sendError 404; return }
		if (!user) { response.sendError 403; return }
		if (link?.linkType != UserAndBookLinkType.OWNER) { response.sendError 403; return }

		if (params.update) {
			def formats = []

			if (params.pdf=='on') {
				formats << 'pdf'
			}		
			if (params.epub=='on') {
				formats << 'epub'
			}
			if (params.mobi=='on') {
				formats << 'mobi'
			}
			if (params.html=='on') {
				formats << 'html'
			}
				
			book.formats = formats.join(',')
			book.vhost = params.vhost
			
			if (book.save(flush: true)) {
				flash.alertType = 'success'
				flash.alertMessage = "Saved ${new Date()}"
			}
		}

		[
			book: book
		]
	}

	/**
	 * Reader Management
	 */
	def reader = {
		def book = Book.get(params.id)
		def user = User.get(session.userId)
		def link = UserAndBook.findByBookAndUser(book, user)

		if (!book) { response.sendError 404; return }
		if (!user) { response.sendError 403; return }
		if (link?.linkType != UserAndBookLinkType.OWNER) { response.sendError 403; return }

		if (params.add) {
			def newUser = User.findByEmail(params.email)
			if (newUser) {
				def link1 = new UserAndBook()
				
				link1.user = newUser
				link1.book = book
				link1.linkType = UserAndBookLinkType.BUYER				
				link1.save(flush: true)

				newUser.addToBooks(link1)
				book.addToUsers(link1)

				newUser.save(flush: true)
				book.save(flush: true)
			}
		}

		[
			book: book
		]
	}

	/**
	 * Mode Setup Tool
	 */
	def mode = {
		def book = Book.get(params.id)
		def user = User.get(session.userId)
		def link = UserAndBook.findByBookAndUser(book, user)

		if (!book) { response.sendError 404; return }
		if (!user) { response.sendError 403; return }
		if (link?.linkType != UserAndBookLinkType.OWNER) { response.sendError 403; return }

		if (params.type) {
			switch (params.type) {
				case 'EMBED':
					book.type = RepoType.EMBED
				break
				case 'DROPBOX':
					book.type = RepoType.DROPBOX
				break
				case 'GIT':
					book.type = RepoType.GIT
				break
				case 'SVN':
					book.type = RepoType.SVN
				break
				default:
					book.type = RepoType.EMBED
			}
			if (book.save(flush: true)) {
				flash.alertType = 'success'
				flash.alertMessage = "Mode changed. ${new Date()}"
			}
		}

		[
			book: book
		]
	}

	/**
	 * Setup GIT
	 */
	def setupGit = {
		def book = Book.get(params.id)
		[book: book]
	}

	/**
	 * Change Mode Request
	 */
	def setupGitSave = {
		def book = Book.get(params.id)

		if (!book) {
			response.sendError 404
			return
		}

		book.url = params.url
		book.save(flush: true)

		//flash messages
		flash.message = 'common.flash.message.saved'
		flash.args = [new Date(), book.title]
		flash.default = '{1} saved {0}'
		flash.type = 'notes'

		redirect (action: 'setupGit', id: book?.id)
	}

	/**
	 * Setup SVN
	 */
	def setupSvn = {
		def book = Book.get(params.id)
		[book: book]
	}
	
	/**
	 * Save SVN Setting
	 */
	def setupSvnSave = {
		def book = Book.get(params.id)

		if (!book) {
			response.sendError 404
			return
		}

		book.url = params.url
		book.save(flush: true)

		//flash messages
		flash.message = 'common.flash.message.saved'
		flash.args = [new Date(), book.title]
		flash.default = '{1} saved {0}'
		flash.type = 'notes'

		redirect (action: 'setupSvn', id: book?.id)
	}

	/**
	 * Permissions
	 */
	def permission = {
		def book = Book.get(params.id)
		def user = User.get(session.userId)
		def link = UserAndBook.findByBookAndUser(book, user)

		if (!book) { response.sendError 404; return }
		if (!user) { response.sendError 403; return }
		if (link?.linkType != UserAndBookLinkType.OWNER) { response.sendError 403; return }

		if (params.update) {
			book.isPublic = params.isPublic=='on'

			if (book.save(flush: true)) {
				flash.message = 'common.flash.message.saved'
				flash.args = [new Date(), book.title]
				flash.default = '{1} saved {0}'
				flash.type = 'success'
			}
		}

		[
			book: book
		]
	}

	def ping = {
		def book = Book.findByName(params.bookName)
		
		if (book) {
			sendCookMessage(book)
		}

		render (contentType: 'text/json') {
			result (id: book?.id, name: book?.name, message: 'ok', date: new Date().format('yyyy-MM-dd HH:mm:ss'))
		}
	}

	private boolean sendCookMessage(book) {
		def cookExpired = false

		if (!book.cookUpdated) {
			cookExpired = true
		}
		else {
			def diff = new Date().time - book.cookUpdated.time
			if (diff >= 30*1000) {
				cookExpired = true
			}
		}

		if (book.isCooking == false || cookExpired) {
			book.isCooking = true
			book.countCook ++
			book.save()
		
			def json = new JsonBuilder()
			def version = grailsApplication.config.appConf.cook.version

			def contentType = book.type
			def contentUrl = book.url
			
			// check type settings
			if (contentType.equals(RepoType.GIT) || contentType.equals(RepoType.SVN)) {

				// repositories must have url
				if (contentUrl == null || contentUrl == '') {
					contentType = RepoType.EMBED
				}
			}

			// auto-generate url if type is EMBED
			if (book.type.equals(RepoType.EMBED)) {
				contentUrl = createLink(controller: 'book', action: 'embed', id: book.id, absolute: true)
			}

			def vhost

			// generate contents for virtual host
			if (book.vhost) {
				def baseUrl = grailsApplication.config.appConf.baseUrl
				def vhostUrl = grailsApplication.config.appConf.vhost.href
				def options = [
					h: book.vhost,
					f: "${baseUrl}download/${book.name}.zip",
					t: new Date().time
				]
				vhost = new URIBuilder(vhostUrl).setQuery(options).toString()
			}

			json (
				id: book.id,
				url: "${contentUrl}",
				type: "${book.type}",
				name: "${book.name}",
				vhost: "${vhost}",
				version: version
			)
			
			def routingKey = grailsApplication.config.appConf.cook.routingKey
			def msgContent = json?.toString()
		
			// Send msg to RepoCook agents using RabbitMQ
			rabbitSend routingKey, msgContent

			return true
		}

		return false
	}
}
