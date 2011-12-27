package org.contpub.simaqian

import org.jets3t.service.*
import org.jets3t.service.model.*
import org.jets3t.service.security.*
import org.jets3t.service.impl.rest.httpclient.*

import groovy.json.JsonBuilder

class SandboxController {

	/**
	 * Set session sandbox to new one
	 */
	def renew = {
		session.sandboxId = null
		redirect (action: 'index')
	}

	/**
	 * Set session sandbox to sepcify one
	 */
	def update = {
		def sandbox = Sandbox.get(params.id)
		def user = User.get(session.userId)

		if (sandbox && sandbox.owner==user) {
			session.sandboxId = sandbox.id
		}
		redirect (action: 'index')
	}

    def index = {
		def sandbox = new Sandbox()
		def mySandboxList

		def user = User.get(session.userId)
		
		if (session.sandboxId) {
			sandbox = Sandbox.get(session.sandboxId)
		}
		else {
			sandbox = new Sandbox()

			def samples = Sandbox.findAllByIsSample(true)
			def random = new Random(new Date().time)

			if (samples) {
				def sample = samples[random.nextInt(samples.size())]

				sandbox.title = sample.title
				sandbox.authors = sample.authors
				sandbox.contents = sample.contents
			}
		}

		//儲存到session
		session.sandboxId = sandbox?.id
		
		if (user) {
			mySandboxList = Sandbox.findAllByOwner(user)
		}

		[
			sandbox: sandbox,
			mySandboxList: mySandboxList,
			sampleList: Sandbox.findAllByIsSample(true),
			pdfPaperSizeList: Sandbox.pdfPaperSizeList,
			pdfFontSizeList: Sandbox.pdfFontSizeList
		]
	}

	/**
	 * Show User's Sandboxes
	 */
	def user = {
		def user = User.get(session.userId)

		[
			sandboxList: user?Sandbox.findAllByOwner(user):[]
		]
	}

	/**
	 * Show Sandbox
	 */
	def show = {
		def sandbox = Sandbox.get(params.id)
		def user = User.get(session.userId)

		if (!sandbox) {
			response.status = 404
			return
		}

		[
			sandbox: sandbox,
			user: user
		]
	}

	def empty = {
		render (template: 'empty')
	}

	def result = {
		def sandbox = Sandbox.get(params.id)
		render (template: 'result', model: [sandbox: sandbox])
	}

	def resultCheck = {
		def sandbox = Sandbox.get(params.id)

		//long polling
		def c = 0
		while (sandbox.isCooking) {
			if (c++ >= 6) break
			sleep(5000)
			sandbox.refresh()
		}

		if (sandbox.isCooking) {
			//still in cooking
			redirect (action: 'result', id: sandbox.id, params: ['_t':new Date().time])
		}
		else {
			//available
			redirect (action: 'success', id: sandbox.id, params: ['_t':new Date().time])
		}
	}

	def success = {
		def sandbox = Sandbox.get(params.id)
		render (template: 'success', model: [sandbox: sandbox])
	}

	/**
	 * Sample (Ajax), Read sample sandbox
	 */
	def ajaxSample = {
		def sandbox = Sandbox.get(params.id)
		
		render (contentType: 'text/json') {
			title = sandbox?.title
			authors = sandbox?.authors
			contents = sandbox?.contents
		}
	}

	/**
	 * Publish (Ajax), Send event to RabbitMQ for book publishing
	 */
	def ajaxPublish = {
		def sandbox
		
		if (session.sandboxId) {
			sandbox = Sandbox.get(session.sandboxId)
			sandbox.properties = params
		}
		else {
			sandbox = new Sandbox(params)
		}
	
		sandbox.owner = User.get(session.userId)
		sandbox.isCooking = true //set cooking

		def saveResult = sandbox.save(flush: true)
		
		if (sandbox) {
			session.sandboxId = sandbox.id
		}

		def url = createLink(action: 'embed', id: sandbox.id, absolute: true)
		
		def json = new JsonBuilder()
		json (
			id: sandbox.id,
			url: "${url}",
			type: "SANDBOX",
			name: "sandbox${sandbox.id}",
			version: grailsApplication.config.appConf.cook.version
		)
		
		// Send msg to RepoCook agents using RabbitMQ
		rabbitSend grailsApplication.config.appConf.cook.routingKey, json?.toString()

		render (contentType: 'text/json') {
				successed = saveResult?true:false
				sandboxId = sandbox?.id
				resultUrl = createLink(action: 'result', id: sandbox?.id, params: ['_t':new Date().time])
				message = "發佈時間 ${new Date().format('yyyy/MM/dd')}"
		}
	}

	/**
	 * Get embedded contents
	 */
	def embed = {
		def contentType = 'text/plain'

		//Implement SecretKey here!!!
		def sandbox = Sandbox.get(params.id)
		
		if (params.index != null) {
			return renderIndex(sandbox)
		}
		render (contentType: contentType, encoding: 'UTF-8', text: sandbox?.contents)
	}

	def renderIndex(sandbox) {
		def contents = """.. sandbox${sandbox.id}
   @project: sandbox${sandbox.id}
   @title: ${sandbox.title}
   @copyright: ContPub Sandbox
   @authors: ${sandbox.authors}
   @language: zh_TW
   @latex_paper_size: ${sandbox.pdfPaperSize}
   @latex_font_size: ${sandbox.pdfFontSize}
   @epub_theme: ${sandbox.epubTheme}

${'#'.multiply(sandbox.title.size()+(sandbox.title.bytes.size()-sandbox.title.size())/2)}
${sandbox.title}
${'#'.multiply(sandbox.title.size()+(sandbox.title.bytes.size()-sandbox.title.size())/2)}

.. toctree::
   :maxdepth: 1

   contents
"""
		render (contentType: 'text/plain', encoding: 'UTF-8', text: contents)
	}

	def download = {
		def awsCredentials = new AWSCredentials(
			grailsApplication.config.aws.accessKey,
			grailsApplication.config.aws.secretKey
		)
		def s3Service = new RestS3Service(awsCredentials)

		def bucket = s3Service.getBucket(grailsApplication.config.aws.bucketName)
		def bucketName = grailsApplication.config.aws.bucketName
		
		//set expired time
		def cal = Calendar.instance
		cal.add(Calendar.MINUTE, 30)
		def expiryDate = cal.time

		//def filepath = "${book.name.substring(0,1).toLowerCase()}/${book.name}.${fileExt}"
		def key = "sandbox/${params.id}"

		def signedUrl = s3Service.createSignedGetUrl(bucketName, key, awsCredentials, expiryDate, false)
		//dirty hack for https(ssl) auth failed
		signedUrl = signedUrl.replace('https://', 'http://')

		if (signedUrl) {
			redirect (url: signedUrl)
		}
		else {
			response.status = 404;
		}
	}

}
