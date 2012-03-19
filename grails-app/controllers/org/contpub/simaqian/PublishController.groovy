package org.contpub.simaqian

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
		}
		if (link?.linkType != UserAndBookLinkType.OWNER) {
			response.sendError 403
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

		if (!book) {
			response.sendError 404
		}

		if (link?.linkType != UserAndBookLinkType.OWNER) {
			response.sendError 403
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
		
		if (!book) {
			response.sendError 404
			return
		}

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
		[book: Book.get(params.id)]
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
	 * Send event to RabbitMQ for book publishing
	 */
	def cook = {
		def book = Book.get(params.id)
		
		sendCookMessage(book)

		[book: book]
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

		book.cname = params.cname
		book.save(flush: true)

		if (book.cname && params.generate=='on') {
			//re-generate cname contents
			log.info "generate contents for ${book.cname}"

			def url = new URIBuilder(grailsApplication.config.appConf.vhost.href)
				.setQuery([h: book.cname, f:bookTag.createDownloadLink(book: book, type: 'zip')])

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
		def successed = false

		if (params.contents) {
			if (!book.profile) {
				book.profile = new BookProfile(book: book)
			}
			book.profile.contents = params.contents
			book.profile.save(flush: true)
			successed = book.save(flush: true)
		}

		render (contentType: 'text/json') {
			result (successed: successed, message: "儲存成功 ${new Date().format('HH:mm:ss')}")
		}
	}

	/**
	 * Query Status (Ajax)
	 */
	def ajaxStatus = {
		def book = Book.get(params.id)

		render (contentType: 'text/json') {
			result (
				isCooking: book?.isCooking?'正在製作中':'已完成',
				lastUpdated: book?.lastUpdated?.format('yyyy-MM-dd HH:mm:ss'),
				cookUpdated: book?.cookUpdated?.format('yyyy-MM-dd HH:mm:ss'),
				message: new Date().format('HH:mm:ss')
			)
		}
	}

	/**
	 * Publish (Ajax), Send event to RabbitMQ for book publishing
	 */
	def ajaxPublish = {
		def successed = false
		def message = ''

		def book = Book.get(params.id)
		
		def cookExpired = false

		if (!book.cookUpdated) {
			cookExpired = true
		}
		else {
			def diff = new Date().time - book.cookUpdated.time
			if (diff >= 60*1000) {
				cookExpired = true
			}
		}

		if (book.isCooking == false || cookExpired) {
			book.isCooking = true
			book.countCook ++
			book.cookUpdated = new Date()
			book.save(flush: true)
		
			def json = new JsonBuilder()
			def version = grailsApplication.config.appConf.cook.version

			def contentUrl = null

			switch (book.type) {
				case RepoType.EMBED:
					contentUrl = createLink(
						controller: 'book',
						action: 'embed',
						id: book.id,
						absolute: true
					)
				break

				case RepoType.DROPBOX:
					contentUrl = "${grailsApplication.config.appConf.sysId}-${book.name}"
				break

				default:
					contentUrl = book.url
			}
						
			json (
				id: book.id,
				url: "${contentUrl}",
				type: "${book.type}",
				name: "${book.name}",
				version: version
			)

			println json
			
			def routingKey = grailsApplication.config.appConf.cook.routingKey
			def msgContent = json?.toString()
		
			// Send msg to RepoCook agents using RabbitMQ
			rabbitSend routingKey, msgContent

			successed = true
			message = "電子書已開始製作 ${new Date().format('hh:mm:ss')}"
		}
		else {
			successed = false
			message = "前次發佈尚未完成 ${new Date().format('hh:mm:ss')}"
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
		if (book.isCooking == false) {
			book.isCooking = true
			book.countCook ++
			book.save()
		
			def json = new JsonBuilder()
			def version = grailsApplication.config.appConf.cook.version

			def contentUrl
			
			if (book.type.equals(RepoType.EMBED)) {
				contentUrl = createLink(controller: 'book', action: 'embed', id: book.id, absolute: true)
			}
			else {
				contentUrl = book.url
			}

			def vhost

			// generate contents for virtual host
			if (book.cname) {
				def baseUrl = grailsApplication.config.appConf.baseUrl
				def vhostUrl = grailsApplication.config.appConf.vhost.href
				def options = [
					h: book.cname,
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
