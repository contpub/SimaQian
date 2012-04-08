package simaqian

import groovy.json.JsonBuilder
import groovyx.net.http.URIBuilder

/**
 * Publish Controller
 */
class PublishController {

	BookService bookService
	UserService userService

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
		def book = new Book()
		def user = User.get(session.userId)

		def userAccount = user?.account
		def dateString = new Date().format('yyyyMMdd')
		
		book.name = "${userAccount}-${dateString}"
		
		[book: book]
	}
	
	/**
	 * Save a new book.
	 */
	def save = {
		def user = User.get(session.userId)

		def book = new Book()
		
		book.name = params.name
		book.title = params.title
		book.isPublic = params.isPublic=='on'

		// Save Book!!!
		if (book.validate() && book.save(flush: true)) {
			
			// Create book profile
			book.profile = new BookProfile(book: book)

			// Save BookProfile first!!!
			if (book.profile.validate()) {
				book.profile.save(flush: true)
			}

			/* Connect User and Book association */
			def link1 = new UserAndBook()

			link1.user = user
			link1.book = book
			link1.linkType = UserAndBookLinkType.OWNER
			
			link1.save(flush: true)

			user.addToBooks(link1)
			book.addToUsers(link1)

			user.save(flush: true)
			book.save(flush: true)

			redirect (action: 'editor', id: book.id)
		}
		else {
			render (view: 'create', model: [book: book])
		}
	}
	
	/**
	 * Update a book by id.
	 */
	def update = {
		def book = Book.get(params.id)
		def user = User.get(session.userId)
		def link = UserAndBook.findByBookAndUser(book, user)

		if (!book) {
			response.sendError 404
			return
		}
		if (link?.linkType != UserAndBookLinkType.OWNER) {
			response.sendError 403
			return
		}

		[book: book]
	}

	/**
	 * permanent remove book contents
	 */
	def delete = {
		def book = Book.get(params.id)
		def user = User.get(session.userId)
		def link = UserAndBook.findByBookAndUser(book, user)

		if (!book) { response.sendError 404; return }

		if (link?.linkType != UserAndBookLinkType.OWNER) {
			response.sendError 403
			return
		}

		if (params.confirm=='yes') {
			//book.isDeleted = true
			//book.save(flush: true)
			book.delete(flush: true)
			redirect(action: 'deleted')
		}

		[book: book]
	}

	def deleted = {
	}

	/**
	 * Save a updated book.
	 */
	def updateSave = {
		def book = Book.get(params.id)
		
		if (!book) { response.sendError 404; return }

		book.title = params.title
		book.subtitle = params.subtitle
		book.authors = params.authors
		book.url = params.url

		if (!book.profile) {
			book.profile = new BookProfile(book: book)
		}
		book.profile.description = params.description

		if (book.profile.save(flush: true)
			&& book.save(flush: true)) {

			//flash messages
			flash.message = 'common.flash.message.saved'
			flash.args = [new Date(), book.title]
			flash.default = '{1} saved {0}'
			flash.type = 'notes'

			redirect(action: 'update', id: book?.id)
		}
		else {
			render(view: 'update', model: [book: book])
		}
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

		def contents = book?.profile?.contents

		if (contents == null) contents = ""

		def contents_array = contents.split("\n.. end-of-file\n")

		def total = contents_array.size()

		def part_of_contents = ""

		def offset = params.offset

		if (offset == null) {
			offset = 0
		}
		else {
			offset = Integer.valueOf(offset)
		}

		if (offset >= 0 && offset < contents_array.size()) {
			part_of_contents = "${contents_array[offset]?.trim()}\n"
		}

		[book: book, contents: part_of_contents, offset: offset, total: total]
	}

	def insertContent = {
		def book = Book.get(params.id)
		def user = User.get(session.userId)
		def link = UserAndBook.findByBookAndUser(book, user)

		if (!book) { response.sendError 404; return }
		if (!user) { response.sendError 403; return }
		if (link?.linkType != UserAndBookLinkType.OWNER) { response.sendError 403; return }

		def offset = params.offset

		if (!book.profile) { book.profile = new BookProfile(book: book) }

		def contents = book.profile.contents

		if (contents == null) { contents = "" }

		if (offset == null) {
			offset = contents.split("\n.. end-of-file\n").size()
			contents = "${contents}\n\n.. end-of-file\n\n..."
		}
		else {
			def contents_array = contents.split("\n.. end-of-file\n")
			offset = Integer.valueOf(offset)
			for (def i=0; i<contents_array.size(); i++) {
				contents_array[i] = "${contents_array[i]}".trim()
			}
			if (offset >= 0 && offset < contents_array.size()) {
				contents_array[offset] = contents_array[offset] + "\n\n.. end-of-file\n\n"
			}
			contents = contents_array.join("\n\n.. end-of-file\n\n")
			offset = offset + 1
		}
		book.profile.contents = contents		
		book.profile.save(flush: true)
		book.save(flush: true)

		redirect(action: 'editor', id: book.id, params: [offset: offset])
	}

	def cleanupContents = {
		def book = Book.get(params.id)
		def user = User.get(session.userId)
		def link = UserAndBook.findByBookAndUser(book, user)

		if (!book) { response.sendError 404; return }
		if (!user) { response.sendError 403; return }
		if (link?.linkType != UserAndBookLinkType.OWNER) { response.sendError 403; return }

		def contents = book.profile.contents

		if (contents == null) { contents = "" }

		def contents_array = contents.split("\n.. end-of-file\n")
		def contents_cleanup = []
		for (def i=0; i<contents_array.size(); i++) {
			contents_array[i] = "${contents_array[i]}".trim()
			if (contents_array[i].length() > 0) {
				contents_cleanup << contents_array[i]
			}
		}

		contents = contents_cleanup.join("\n\n.. end-of-file\n\n")

		book.profile.contents = contents		
		book.profile.save(flush: true)
		book.save(flush: true)

		redirect(action: 'editor', id: book.id)
	}
	
	/**
	 * Change book contents (EMBED)
	 */
	def write = {
		[book: Book.get(params.id)]
	}
	
	/**
	 * Save contents changes
	 */
	def saveWrite = {
		def book = Book.get(params.id)
		
		def profile = book.profile
		
		if (!profile) {
			profile = new BookProfile(book: book)
			book.profile = profile
		}
		
		profile.contents = params.contents
		
		if (book.save(flush: true)) {
			flash.message = "Contents saved. ${new Date().format('yyyy-MM-dd HH:mm:ss')}"
			redirect (action: 'write', id: book.id, fragment: 'editing')
		}
		else {
			render (view: 'write', model: [book: book])
		}
	}
	
	/**
	 * Preview before cooking
	 */
	def preview = {
		[book: Book.get(params.id)]
	}
		
	/**
	 * Check for cooking status
	 */
	def checkCook = {
		def book = Book.get(params.id)
		
		if (book?.isCooking) {
			render (view: 'cook', model: [book: book])
		}
		else {
			redirect (url: book.link)
		}
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
		[book: book]
	}

	def mediaSave = {
		def book = Book.get(params.id)

		book.vhost = params.vhost
		book.save(flush: true)

		if (book.vhost && params.generate=='on') {
			//re-generate vhost contents
			log.info "generate contents for ${book.vhost}"

			def url = new URIBuilder(grailsApplication.config.appConf.vhost.href)
				.setQuery([h: book.vhost, f:bookTag.createDownloadLink(book: book, type: 'zip')])

			log.info "access url ${url}"

			log.info new URL(url.toString()).text
		}

		//flash messages
		flash.message = 'common.flash.message.saved'
		flash.args = [new Date(), book.title]
		flash.default = '{1} saved {0}'
		flash.type = 'notes'

		redirect (action: 'media', id: book?.id)
	}

	/**
	 * Reader Management
	 */
	def reader = {
		def book = Book.get(params.id)
		[book: book]
	}

	def readerSave = {
		def book = Book.get(params.id)

		if (params.email) {
			def user = User.findByEmail(params.email)

			if (user) {
				def link1 = new UserAndBook()

				link1.user = user
				link1.book = book
				link1.linkType = UserAndBookLinkType.BUYER				
				link1.save(flush: true)

				user.addToBooks(link1)
				book.addToUsers(link1)

				user.save(flush: true)
				book.save(flush: true)
			}
		}

		redirect (action: 'reader', id: book?.id)
	}

	/**
	 * Mode Setup Tool
	 */
	def mode = {
		def book = Book.get(params.id)
		[book: book]
	}

	/**
	 * Change Mode Request
	 */
	def modeChange = {
		def book = Book.get(params.id)

		if (book) {
			def newType = null
			switch (params.type) {
				case 'EMBED':
					newType = RepoType.EMBED
				break

				case 'DROPBOX':
					newType = RepoType.DROPBOX
				break

				case 'GIT':
					newType = RepoType.GIT
				break

				case 'SVN':
					newType = RepoType.SVN
				break
			}
			if (newType) {
				book.type = newType
				book.save(flush: true)
			}
		}

		redirect(action: 'mode', id: book?.id)
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
		[book: book]
	}

	/**
	 * Change Mode Request
	 */
	def permissionSave = {
		def book = Book.get(params.id)

		if (!book) {
			response.sendError 404
			return
		}

		book.isPublic = params.isPublic=='on'
		book.save(flush: true)

		//flash messages
		flash.message = 'common.flash.message.saved'
		flash.args = [new Date(), book.title]
		flash.default = '{1} saved {0}'
		flash.type = 'notes'

		redirect (action: 'permission', id: book?.id)
	}

	/**
	 * Save Contents (Ajax)
	 */
	def ajaxSaveContents = {
		def book = Book.get(params.id)
		def user = User.get(session.userId)
		def link = UserAndBook.findByBookAndUser(book, user)

		if (!book) { response.sendError 404; return }
		if (!user) { response.sendError 403; return }
		if (link?.linkType != UserAndBookLinkType.OWNER) { response.sendError 403; return }

		def successed = false
		def message = ''

		if (params.contents != null) {
			if (!book.profile) { book.profile = new BookProfile(book: book) }

			def contents = book.profile.contents
			
			if (contents == null) { contents = "" }

			def contents_array = contents.split("\n.. end-of-file\n")
			def offset = params.offset
			
			if (offset == null) {
				offset = 0
			}
			else {
				offset = Integer.valueOf(offset)
			}

			if (offset >= 0 && offset < contents_array.size()) {
				contents_array[offset] = params.contents
			}

			for (def i=0; i<contents_array.size(); i++) {
				contents_array[i] = "${contents_array[i]}".trim()
			}

			contents = contents_array.join("\n\n.. end-of-file\n\n")

			book.profile.contents = contents
			
			book.profile.save(flush: true)
			successed = book.save(flush: true)

			if (successed) {
				message = "Saved! ${new Date().format('HH:mm:ss')}"
			}
			else {
				message = "Unable to save. ${new Date().format('HH:mm:ss')}"
			}
		}

		if (params.publish=="true") {
			sendCookMessage(book)
			message = "E-book is being published. ${new Date().format('HH:mm:ss')}"
		}

		render (contentType: 'text/json') {
			result (successed: successed, message: message)
		}
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
