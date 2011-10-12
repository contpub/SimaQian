package org.contpub.simaqian

import groovy.json.JsonBuilder

class PublishController {

    def index() {
    	redirect (action: 'create')
    }
    
	def create = {
		[book: new Book()]
	}
	
	def save = {
		def book = new Book(params)
		
		book.validate()

		if (book.save(flush: true)) {
			redirect (action: 'write', id: book.id)
		}
		else {
			render (view: 'create', model: [book: book])
		}
	}
	
	def update = {
		[book: Book.get(params.id)]
	}

	def saveUpdate = {
		def book = Book.get(params.id)
		
		//println params.description
		def descReader = new StringReader(params.description)
		
		book.title = params.title
		book.description = params.description
		book.homepage = params.homepage
		book.icon = params.icon
		book.cover = params.cover
		book.isPublic = (params.isPublic!=null)
		
		descReader.close()
		
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
		
		book.contents = params.contents
		
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
			def embed = createLink(controller: 'book', action: 'embed', id: book.id, absolute: true)

			json (
				id: book.id,
				url: "${book.url}",
				type: "${book.type}",
				name: "${book.name}",
				embed: "${embed}",
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
}
