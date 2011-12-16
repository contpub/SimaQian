package org.contpub.simaqian

import groovy.json.JsonBuilder

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
		def book = new Book()
		
		book.name = params.name
		book.title = params.title

		if (book.validate() && book.save(flush: true)) {

			/* Connect User and Book association */

			def user = User.get(session.userId)
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
		[book: Book.get(params.id)]
	}

	/**
	 * Editor
	 */
	def editor = {
		[book: Book.get(params.id)]
	}

	/**
	 * Save a updated book.
	 */
	def saveUpdate = {
		def book = Book.get(params.id)
		
		book.title = params.title
		book.isPublic = (params.isPublic!=null)
		
		def profile = book.profile
		
		if (!profile) {
			profile = new BookProfile(book: book)
			profile.save(flush: true)
			book.profile = profile
		}
		
		profile.description = params.description
		profile.homepage = params.homepage
		profile.icon = params.icon
		
		if (book.save(flush: true)) {
			//redirect (action: 'show', id: book.id)
			//redirect (uri: "/read/${book.name}")
		}
		
		render (view: 'update', model: [book: book])
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
			
			json (
				id: book.id,
				url: "${contentUrl}",
				type: "${book.type}",
				name: "${book.name}",
				version: version
			)
			
			def routingKey = grailsApplication.config.appConf.cook.routingKey
			def msgContent = json?.toString()
		
			// Send msg to RepoCook agents using RabbitMQ
			rabbitSend routingKey, msgContent
		}
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
}
