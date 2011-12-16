package org.contpub.simaqian

import org.jets3t.service.*
import org.jets3t.service.model.*
import org.jets3t.service.security.*
import org.jets3t.service.impl.rest.httpclient.*

import groovy.json.JsonBuilder

class SandboxController {

    def index() {
		def sandbox
		
		if (session.sandboxId) {
			sandbox = Sandbox.get(session.sandboxId)
		}
		else {
			sandbox = new Sandbox()

			sandbox.title = '如何製作一本書'
			sandbox.authors = '無名氏'
			sandbox.contents = "標題\n====\n\ntest"
		}

		[
			sandbox: sandbox,
			pdfPaperSizeList: Sandbox.pdfPaperSizeList,
			pdfFontSizeList: Sandbox.pdfFontSizeList
		]
	}

	def show() {
		def sandbox = Sandbox.get(params.id)

		if (!sandbox) {
			response.status = 404
			return
		}

		[
			sandbox: sandbox
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
