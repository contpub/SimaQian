package org.contpub.simaqian

import org.springframework.dao.DataIntegrityViolationException

class UserController {

    //static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def reset = {
		session.invalidate()
		redirect (controller: 'home')
	}

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }
}
