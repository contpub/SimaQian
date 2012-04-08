package simaqian

import org.jets3t.service.*
import org.jets3t.service.model.*
import org.jets3t.service.security.*
import org.jets3t.service.impl.rest.httpclient.*

import groovy.json.JsonBuilder

class SandboxController {

	def index = {
		redirect(action: 'publish')
	}

	def list = {
		def user = User.get(session.userId)
		def sandboxList = Sandbox.findAll()

		if (params.user) {
			def owner = User.get(params.user)
			if (owner) {
				sandboxList = Sandbox.findAllByOwner(owner)
			}
		}

		[
			sandboxList: sandboxList,
			user: user
		]
	}

    def publish = {
		def user = User.get(session.userId)
		def sandbox = Sandbox.get(params.id)

		//process params.create=true
		//process params.id

		if (!user) {
			response.sendError 403
			return
		}

		if (sandbox && sandbox.owner != user) {
			response.sendError 403
			return
		}

		if (!sandbox) {
			sandbox = Sandbox.findByOwner(user)
		}

		if (!sandbox || params.create) {
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
		
		[
			sandbox: sandbox,
			sampleList: Sandbox.findAllByIsSample(true)
		]
	}

	/**
	 * delete sandbox
	 */
	def delete = {
		def user = User.get(session.userId)
		def sandbox = Sandbox.get(params.id)

		if (!user) { response.sendError 403; return }
		if (!sandbox) { response.sendError 404; return }
		if (sandbox.owner != user) { response.sendError 403; return }

		sandbox.delete(flush: true)
		redirect(action: 'user')
	}

	/**
	 * Show User's Sandboxes
	 */
	def user = {
		def user = User.get(session.userId)
		redirect(action: 'list', params: [user: user.id])
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
		
		if (params.id) {
			sandbox = Sandbox.get(params.id)
			sandbox.properties = params
		}
		else {
			sandbox = new Sandbox(params)
		}
	
		sandbox.owner = User.get(session.userId)
		sandbox.isCooking = true //set cooking

		def saveResult = sandbox.save(flush: true)
		
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
				redirectUrl = createLink(action: 'show', id: sandbox?.id)
				resultUrl = createLink(action: 'result', id: sandbox?.id, params: ['_t':new Date().time])
				htmlText = g.render (template: 'result', model: [sandbox: sandbox])
				message = "發佈時間 ${new Date().format('yyyy/MM/dd')}"
		}
	}

	/* Ajax Checker for Publishing Status */
	def ajaxCheck = {
		def sandbox = Sandbox.get(params.id)

		//long polling (wait for 90 secs)
		def c = 0
		while (sandbox.isCooking) {
			if (c++ >= 18) break
			sleep(5000)
			sandbox.refresh()
		}

		if (sandbox.isCooking) {
			render (template: 'timeout', model: [sandbox: sandbox])
		}
		else {
			render (template: 'success', model: [sandbox: sandbox])
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
