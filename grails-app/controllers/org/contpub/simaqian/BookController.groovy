package org.contpub.simaqian

import groovy.json.JsonBuilder
import groovy.json.JsonOutput

class BookController {

	def index = {
		[books: RepoBook.findAll()]
	}

	def show = {
		[book: RepoBook.get(params.id)]
	}
	
	def cook = {
		def book = RepoBook.get(params.id)
		def json = new JsonBuilder()
		def version = grailsApplication.config.appConf.cook.version
		
		json url: book.url, type: book.type, name: book.name, version: version
		
		def routingKey = grailsApplication.config.appConf.cook.routingKey
		def msgContent = json?.toString()
		
		// Send msg to RepoCook agents using RabbitMQ
		rabbitSend routingKey, msgContent
		
		[book: book]
	}

	def create = {
		[book: new RepoBook()]
	}
	
	def update = {
		[book: RepoBook.get(params.id)]
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
}
