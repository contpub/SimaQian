package org.contpub.simaqian

import groovy.xml.MarkupBuilder

class DebugController {

	def index() {
		def writer = new StringWriter()
		def xml = new MarkupBuilder(writer)
		xml.debug() {
			Runtime () {
				TotalMemory {
					bytes (Runtime.runtime.totalMemory())
					kb (Runtime.runtime.totalMemory()/1024)
					mb (Runtime.runtime.totalMemory()/1024/1024)
				}
				MaxMemory {
					bytes (Runtime.runtime.maxMemory())
					kb (Runtime.runtime.maxMemory()/1024)
					mb (Runtime.runtime.maxMemory()/1024/1024)
				}
				FreeMemory {
					bytes (Runtime.runtime.freeMemory())
					kb (Runtime.runtime.freeMemory()/1024)
					mb (Runtime.runtime.freeMemory()/1024/1024)
				}
			}
		}
		render (
			text: writer.toString(),
			contentType: 'text/xml',
			encoding: 'UTF-8'
		)
	}
}
