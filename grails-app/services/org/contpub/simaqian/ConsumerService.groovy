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
					if (msg.pdf) {
						book.urlToPdf = msg.pdf
					}
					if (msg.epub) {
						book.urlToEpub = msg.epub
					}
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
