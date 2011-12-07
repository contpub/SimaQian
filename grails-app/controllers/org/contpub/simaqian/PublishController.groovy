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
		
		def userAccount = session['user']?.account
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

			def user = User.get(session['user'].id)
			def link1 = new UserAndBook()

			link1.user = user
			link1.book = book
			link1.linkType = UserAndBookLinkType.OWNER
			
			link1.save(flush: true)
			link1.save()

			user.addToBooks(link1)
			book.addToUsers(link1)

			user.save(flush: true)
			book.save(flush: true)

			redirect (action: 'write', id: book.id)
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
}
