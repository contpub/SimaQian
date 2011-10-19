package org.contpub.simaqian

import groovy.json.*

class ConsumerService {
	
	static rabbitQueue = 'CookBack'
	
	void handleMessage(message) {
		def msgPlain = new String(message)
		
	    println "Received message: ${msgPlain}"
	    
	    try {
	    	def slurper = new JsonSlurper()
	    	def msg = slurper.parseText(msgPlain)
			if (msg.id) {
				def book = Book.get(msg.id)
				if (book) {
					book.isCooking = false
					book.save(flush: true)
				}
			}
		} catch (e) {
			println e
		}
	}

    def serviceMethod() {
		
    }
}
