package simaqian

import org.jets3t.service.*
import org.jets3t.service.model.*
import org.jets3t.service.security.*
import org.jets3t.service.impl.rest.httpclient.*

import groovy.json.JsonBuilder

class SandboxController {

	//static defaultAction = 'index'

	def index = {
		def user = User.get(session.userId)
		def sandboxList = []

		if (params.all) {
			sandboxList = Sandbox.findAll()
		}
		else if (user) {
			sandboxList = Sandbox.findAllByOwner(user)
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

		if (!user) { response.sendError 403; return }
		if (sandbox && sandbox.owner != user) { response.sendError 403; return }

		if (!sandbox) {
			sandbox = Sandbox.findByOwner(user)
		}

		if (!sandbox || params.create) {
			sandbox = new Sandbox()

			def template

			if (params.template) {
				template = Sandbox.get(params.template)
			}
			else {
				// random load from templates
				def samples = Sandbox.findAllByIsSample(true)
				def random = new Random(new Date().time)

				if (samples) {
					template = samples[random.nextInt(samples.size())]
				}
			}

			sandbox.title		= template.title
			sandbox.authors		= template.authors
			sandbox.contents	= template.contents
		}

		if (params.publish) {
			
			sandbox.title = params.title
			sandbox.authors = params.authors
			sandbox.contents = params.contents

			sandbox.owner = User.get(session.userId)
			sandbox.isCooking = true //set cooking

			if (sandbox.save(flush: true)) {
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
			
				flash.alertType = 'success'
				flash.alertMessage = "Sandbox is publishing. ${new Date()}"

				redirect(action: 'show', id: sandbox?.id)
				return
			}
			else {
				flash.alertType = 'error'
				flash.alertMessage = 'Could not publish.'
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

        def filePath = "sandbox/${params.id}"
        
        if (params.redirect) {
            def signedUrl = s3Service.createSignedGetUrl(bucketName, filePath, awsCredentials, expiryDate, false)        
            //dirty hack for https(ssl) auth failed
            signedUrl = signedUrl.replace('https://', 'http://')
            redirect (url: signedUrl)
        }
        else {
            try {
                def object = s3Service.getObject(bucket, filePath)
                response.contentType = object.contentType
                response.setHeader "Content-length", "${object.contentLength}"
                response.setHeader "Content-Disposition", "inline; filename=\"${params.id}\""
                response.outputStream << object.dataInputStream
            }
            catch (ex) {
                response.sendError 404
                return
            }
        }
	}

}
