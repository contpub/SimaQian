package org.contpub.simaqian

import groovy.json.*
import org.grails.s3.S3Asset
import org.grails.s3.S3AssetService
import org.grails.s3.S3ClientService
import org.jets3t.service.security.AWSCredentials

class BookController {

	S3AssetService s3AssetService
	S3ClientService s3ClientService

	def index = {
		[books: Book.findAll()]
	}

	def show = {
		[book: Book.get(params.id)]
	}
	
	def cook = {
		def book = Book.get(params.id)
		
		book.isCooking = true
		book.countCook ++
		book.save()
		
		def json = new JsonBuilder()
		def version = grailsApplication.config.appConf.cook.version
		
		def contents = """
.. ${book.title}
   @project: ${book.title}
   @copyright: 2011, ContPub
   @version: 1.0
   @release: 1.0
   @epub_basename: ${book.name}
   @latex_paper_size: a4
   @latex_font_size: 12pt
   @latex_documents_target_name: ${book.name}.tex
   @latex_documents_title: ${book.title}
   @latex_documents_author: ContPub
   
${book.contents}
"""

		json id: book.id, url: book.url, type: book.type, name: book.name, contents: contents, version: version
		
		def routingKey = grailsApplication.config.appConf.cook.routingKey
		def msgContent = json?.toString()
		
		// Send msg to RepoCook agents using RabbitMQ
		rabbitSend routingKey, msgContent
		
		[book: book]
	}

	def create = {
		[book: new Book()]
	}
	
	def save = {
		def book = new Book(params)

		if (book.save()) {
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
	
	def lookup = {
		def bookName = params.bookName
		
		//bookName = bookName?.substring(5)
		def book = Book.findByName(bookName)
		
		if (book) {
			render (view: 'show', model: [book: book])
		}
		else {
			redirect (action: 'index')
		}
	}
	
	def download = {
		def bookNameSrc = params.bookName
		
		def dotPos = bookNameSrc.lastIndexOf('.')

		def fileExt = bookNameSrc.substring(dotPos)

		def bookName = bookNameSrc.substring(0, dotPos)
		
		//bookName = bookName.replaceFirst(~/\.[^\.]+$/, '')
		
		def book = Book.findByName(bookName)
		
		if (book) {
			def s3Service = s3ClientService.getS3(
				grailsApplication.config.aws.accessKey,
				grailsApplication.config.aws.secretKey
			)
			def awsCredentials = new AWSCredentials(
				grailsApplication.config.aws.accessKey,
				grailsApplication.config.aws.secretKey
			)
			def bucket = s3Service.getBucket(grailsApplication.config.aws.bucketName)
			def bucketName = grailsApplication.config.aws.bucketName
		
			def cal = Calendar.instance
			cal.add(Calendar.MINUTE, 5)
			def expiryDate = cal.time
		
			def signedUrl = s3Service.createSignedGetUrl(bucketName, "${book.name}.pdf", awsCredentials, expiryDate, false);
			
			redirect (url: signedUrl)
			//render ("${bucketName}/${book.name}.pdf")
		}
		else {
			render (controller: 'errors', action: 'notFound')
		}
	}
	
	def write = {
		[book: Book.get(params.id)]
	}
	
	def saveWrite = {
		def book = Book.get(params.id)
		
		book.contents = params.contents
		
		if (book.save(flush: true)) {
			redirect (action: 'write', id: book.id)
		}
		else {
			render (view: 'write', model: [book: book])
		}
	}
}
