package org.contpub.simaqian

import groovy.json.JsonBuilder

import org.jets3t.service.*
import org.jets3t.service.model.S3Object
import org.jets3t.service.security.AWSCredentials
import org.jets3t.service.impl.rest.httpclient.RestS3Service

import org.nuiton.jrst.*

/**
 * Book Controller
 */
class BookController {

	// Grails S3 Services is not working
	//S3AssetService s3AssetService
	//S3ClientService s3ClientService

	def index = {
		def user = User.get(session['user']?.id)

		[
			books: user?.books*.book
		]
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
	
	def lookup = {
		def bookName = params.bookName
		
		//bookName = bookName?.substring(5)
		def book = Book.findByName(bookName)
		
		if (book) {
		
			def user = User.get(session['user']?.id)
			def userBuyBook = false
			def userOwnBook = false
	
			def link = UserAndBook.findByUserAndBook(user, book)
	
			if (link) {
				userBuyBook = link.linkType.equals(UserAndBookLinkType.BUYER)
				userOwnBook = link.linkType.equals(UserAndBookLinkType.OWNER)
			}
		
			render (view: 'show', model: [
				book: book,
				userBuyBook: userBuyBook,
				userOwnBook: userOwnBook
			])
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
			def filepath = "${book.name}.${fileExt}"
			
			def signedUrl = s3Service.createSignedGetUrl(bucketName, filepath, awsCredentials, expiryDate, false)
			
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
	
	/**
	 * Get embedded contents
	 */
	def embed = {
		//Implement SecretKey here!!!
		def book = Book.get(params.id)
		def contents = ''
		
		if (params.index != null) {

			contents = """.. ${book.name}
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
		}
		else {
			contents = book.profile?.contents
		}
		
		render (contentType: 'text/plain', encoding: 'UTF-8', text: contents?contents:'')
	}
}
