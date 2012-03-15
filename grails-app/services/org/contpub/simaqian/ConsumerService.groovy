package org.contpub.simaqian

import groovy.json.JsonBuilder
import groovy.json.JsonSlurper
import groovyx.net.http.URIBuilder

class ConsumerService {

	def grailsApplication
	
	static rabbitQueue = 'CookBack'
	
	void handleMessage(message) {
		def msgPlain = new String(message)
		
	    println "Received message: ${msgPlain}"
	    
	    try {
	    	def slurper = new JsonSlurper()
	    	def msg = slurper.parseText(msgPlain)

			if (msg.type == 'SANDBOX') {
				if (msg.id) {
					def sandbox = Sandbox.get(msg.id)
					if (sandbox) {
						sandbox.isCooking = false
						sandbox.save(flush: true)
					}
				}
			}
			else {
				// Normal Book
				if (msg.id) {
					def book = Book.get(msg.id)
					if (book) {
						book.isCooking = false
						book.save(flush: true)
					}
				}
			}
		} catch (e) {
			println e
		}
	}

    def serviceMethod() {
		
    }
}
