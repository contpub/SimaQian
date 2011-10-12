package org.contpub.simaqian

class DebugController {

	def index() {
		render (contentType: 'text/xml', encoding: 'UTF-8') {
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
	}
}
