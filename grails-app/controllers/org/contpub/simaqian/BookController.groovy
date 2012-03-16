package org.contpub.simaqian

import groovy.json.JsonBuilder

import org.jets3t.service.*
import org.jets3t.service.model.*
import org.jets3t.service.security.*
import org.jets3t.service.impl.rest.httpclient.*

import org.nuiton.jrst.*

/**
 * Book Controller
 */
class BookController {

	// Grails S3 Services is not working
	//S3AssetService s3AssetService
	//S3ClientService s3ClientService

	def index = {
		def user = User.get(session.userId)
		def books = []

		(user?.books*.book).each {
			book ->
			if (!book.isDeleted) {
				books << book
			}
		}

		[
			books: books
		]
	}
	
	/**
	 * Read a book
	 */
	def read = {
		def bookName = params.bookName
		
		//bookName = bookName?.substring(5)
		def book = Book.findByName(bookName)
		def user = User.get(session.userId)
		
		if (!book || book.isDeleted) {
			response.sendError 404
		}
		
		def link = UserAndBook.findByUserAndBook(user, book)
		def userBuyBook = link?.linkType?.equals(UserAndBookLinkType.BUYER)
		def userOwnBook = link?.linkType?.equals(UserAndBookLinkType.OWNER)
	
		render (view: 'read', model: [
			book: book,
			userBuyBook: userBuyBook,
			userOwnBook: userOwnBook
		])
	}
	
	/**
	 * Permalinks for Download Books, redirect to Amazon S3 Signed URL
	 */
	def download = {
		def bookNameSrc = params.bookName
		
		def dotPos = bookNameSrc.lastIndexOf('.')

		def fileExt = bookNameSrc.substring(dotPos+1)

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
			
			//def filepath = "${book.name.substring(0,1).toLowerCase()}/${book.name}.${fileExt}"
			def filePath = "book/${book.name}.${fileExt}"
			
			def signedUrl = s3Service.createSignedGetUrl(bucketName, filePath, awsCredentials, expiryDate, false)
			
			//dirty hack for https(ssl) auth failed
			signedUrl = signedUrl.replace('https://', 'http://')

			//render(filepath)
			redirect (url: signedUrl)
			//render ("${bucketName}/${book.name}.pdf")
		}
		else {
			render (controller: 'errors', action: 'notFound')
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
		def user = User.get(session.userId)
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
			
			redirect (action: 'read', id: book.name)
		}
		else {
			redirect (action: 'index')
		}
	}
	
	/**
	 * Get embedded contents
	 */
	def embed = {

		def contentType = 'text/plain'

		//Implement SecretKey here!!!
		def book = Book.get(params.id)
		
		if (params.index != null) {
			return renderIndex(book)
		}
		else if (params.syntax != null) {
			return renderSyntax(book)
		}
		
		render (contentType: contentType, encoding: 'UTF-8', text: book.profile?.contents)
	}

	def renderIndex(book) {
		def contents = """.. ${book.name}
   @project: ${book.name}
   @title: ${book.title}
   @copyright: 2011, ContPub
   @authors: 2011, ContPub
   @language: zh_TW
   @epub_theme: epub_simple

####
${book.title}
####

.. toctree::
   :maxdepth: 1

   contents
"""
		render (contentType: 'text/plain', encoding: 'UTF-8', text: contents)
	}

	//using codemirror layout
	def renderSyntax(book) {
		return render (template: 'codemirror', model: [contents: book.profile?.contents])
	}

	//using pygments layout
	def renderSyntax2(book) {
		try {
			def pygmentize = grailsApplication.config.executable?.pygmentize

			if (!pygmentize) {
				pygmentize = "pygmentize"
			}

			//def options = "full,style=trac,linenos=1,encoding=utf-8"
			def options = "linenos=1,encoding=utf-8"
			def command = "${pygmentize} -O ${options} -l rst -f html"
			def proc = command.execute()

			proc.withWriter { writer ->
				writer << book.profile?.contents
			}

			proc.waitForOrKill(3000)

			return render (template: 'pygments', model: [contents: proc.text])
		}
		catch (e) {
			return render (contentType: 'text/plain', encoding: 'UTF-8', text: e.message)
		}
	}
}
