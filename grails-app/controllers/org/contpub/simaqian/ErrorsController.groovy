package org.contpub.simaqian

class ErrorsController {

	def notFound = {
		render (view: '/error')
	}
}
