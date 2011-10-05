package org.contpub.simaqian

class ConsumerService {
	
	static rabbitQueue = "msgs"
	
	void handleMessage(msg) {
	    println "Received message: $msg"
	}

    def serviceMethod() {

    }
}
