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
	
	def lookup = {
		def bookName = params.bookName
		
		//bookName = bookName?.substring(5)
		def book = RepoBook.findByName(bookName)
		
		if (book) {
			render (view: 'show', model: [book: book])
		}
		else {
			redirect (action: 'index')
		}
	}
	
	def download = {
		def bookName = params.bookName
		
		bookName = bookName.replaceFirst(~/\.[^\.]+$/, '')
		
		def book = RepoBook.findByName(bookName)
		
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
		}
		else {
			render (controller: 'errors', action: 'notFound')
		}
	}
}
