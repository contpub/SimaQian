package org.contpub.simaqian

import groovy.json.*

import org.jets3t.service.*
import org.jets3t.service.model.S3Object
import org.jets3t.service.security.AWSCredentials
import org.jets3t.service.impl.rest.httpclient.RestS3Service

import org.nuiton.jrst.*

class BookController {

	// Grails S3 Services is not working
	//S3AssetService s3AssetService
	//S3ClientService s3ClientService

	def index = {
		def user = User.get(session['user']?.id)
		
		[books: user?.books*.book]
	}

	def show = {
		def user = User.get(session['user']?.id)
		def book = Book.get(params.id)
		
		def userBuyBook = false
		def userOwnBook = false
		
		def link = UserAndBook.findByUserAndBook(user, book)
		
		if (link) {
			userBuyBook = link.linkType.equals(UserAndBookLinkType.BUYER)
			userOwnBook = link.linkType.equals(UserAndBookLinkType.OWNER)
		}

		[
			book: book,
			userBuyBook: userBuyBook,
			userOwnBook: userOwnBook
		]
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
		
		//println params.description
		def descReader = new StringReader(params.description)
		
		book.title = params.title
		book.description = params.description
		book.htmlDescription = JRST.generateString(
			JRST.TYPE_HTML_INNER_BODY,
			descReader
		)
		book.homepage = params.homepage
		book.icon = params.icon
		book.cover = params.cover
		
		descReader.close()
		
		if (book.save(flush: true)) {
			//redirect (action: 'show', id: book.id)
			redirect (uri: "/read/${book.name}")
			return
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
	
	/**
	 * Permalinks for Download Books, redirect to Amazon S3 Signed URL
	 */
	def download = {
		def bookNameSrc = params.bookName
		
		def dotPos = bookNameSrc.lastIndexOf('.')

		def fileExt = bookNameSrc.substring(dotPos)

		def bookName = bookNameSrc.substring(0, dotPos)
		
		//bookName = bookName.replaceFirst(~/\.[^\.]+$/, '')
		
		def book = Book.findByName(bookName)
		
		if (book) {
			def awsCredentials = new AWSCredentials(
				grailsApplication.config.aws.accessKey,
				grailsApplication.config.aws.secretKey
			)
			
			def s3Service = new RestS3Service(awsCredentials)

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
			
			switch (params.save) {
				case 'Save':
					flash.message = "Contents saved. ${new Date().format('yyyy-MM-dd HH:mm:ss')}"
					redirect (action: 'write', id: book.id)
				break;
				case 'Done':
					redirect (action: 'show', id: book.id)
				break;
				case 'Publish':
					redirect (action: 'cook', id: book.id)				
				break;
			}
		}
		else {
			render (view: 'write', model: [book: book])
		}
	}
	
	/**
	 * Add a book to shopping cart
	 */
	def addToCart = {
		def book = Book.get(params.id)
		
		if (book) {
			//checkout
			redirect (action: 'checkout', id: params.id)
		}
		else {
			redirect (action: 'index')
		}
	}
	
	/**
	 * Checkout
	 */
	def checkout = {
		def book = Book.get(params.id)
		[book: book]
	}
	
	/**
	 * Checkout Save
	 */
	def checkoutSave = {
		def user = User.get(session['user']?.id)
		def book = Book.get(params.id)
		
		if (book) {
			def link = new UserAndBook(
				user: user,
				book: book
			)
			link.save(flush: true)
			user.addToBooks(link)
			book.addToUsers(link)
			user.save(flush: true)
			book.save(flush: true)
			
			redirect (action: 'show', id: book.id)
		}
		else {
			redirect (action: 'index')
		}
	}
}
