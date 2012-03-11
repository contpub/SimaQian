package org.contpub.simaqian

import groovy.json.JsonBuilder
import groovy.json.JsonSlurper
import groovyx.net.http.URIBuilder

class ConsumerService {
	
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

					// generate contents for virtual host
					if (book.cname) {
						//re-generate cname contents
						log.info "generate contents for ${book.cname}"

						def url = new URIBuilder(grailsApplication.config.appConf.vhost.href)
							.setQuery([h: book.cname, f:bookTag.createDownloadLink(book: book, type: 'zip')])

						log.info "access url ${url}"

						log.info new URL(url.toString()).text
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
