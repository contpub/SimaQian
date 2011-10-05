package org.contpub.simaqian

import groovy.json.*

class BookController {

	def index = {
		[books: RepoBook.findAll()]
	}

	def show = {
		[book: RepoBook.get(params.id)]
	}
	
	def cook = {
		def book = RepoBook.get(params.id)
		
		book.isCooking = true
		book.countCook ++
		book.save()
		
		def json = new JsonBuilder()
		def version = grailsApplication.config.appConf.cook.version
		
		json id: book.id, url: book.url, type: book.type, name: book.name, version: version
		
		def routingKey = grailsApplication.config.appConf.cook.routingKey
		def msgContent = json?.toString()
		
		// Send msg to RepoCook agents using RabbitMQ
		rabbitSend routingKey, msgContent
		
		[book: book]
	}

	def create = {
		[book: new RepoBook()]
	}
	
	def save = {
		def book = new RepoBook(params)

		if (book.save()) {
			redirect (action: 'show', id: book.id)
		}
		else {
			render (view: 'create', model: [book: book])
		}
	}
	
	def update = {
		[book: RepoBook.get(params.id)]
	}

	def saveUpdate = {
		def book = RepoBook.get(params.id)
		
		book.title = params.title
		book.description = params.description
		book.homepage = params.homepage
		book.icon = params.icon
		book.cover = params.cover
		
		if (book.save()) {
			redirect (action: 'show', id: book.id)
		}
		else {
			render (view: 'update', model: [book: book])
		}
	}

}
