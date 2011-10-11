package org.contpub.simaqian

import org.nuiton.jrst.*

class HomeController {

    def index() { }
    
    def login() {
    	def user = User.findByEmailAndPassword(params.email, params.password)
		if (user) {
			session['user'] = user
			redirect (action: 'index')
			return
		}
		else {
			redirect (action: 'index')
			return
		}
	}
	
	def logout() {
		session.invalidate()
		redirect (action: 'index')
	}
    
    def signup() {
    	def user = new User()
    	
    	[user: user]
	}
	
    def signupSave() {
        def user = new User(params)
        if (!user.save(flush: true)) {
            render(view: "signup", model: [user: user])
            return
        }

		//flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])
        //redirect(action: "show", id: user.id)
        
        flash.message = 'Thanks for sign-up.'
        redirect (action: 'index')
    }
    
	/**
	 * Personal account management
	 */
	def account() {
		def user = User.get(session['user']?.id)
		
		if (!user) {
			response.sendError(403)
			return
		}
		
		[user: user]		
	}
	
	/**
	 * Save account modifications
	 */
	def accountSave() {
		def user = User.get(params.id)
		
		if (!user) {
			response.sendError(403)
			return
		}
		
		def descReader = new StringReader(params.description)
		
		user.name = params.name
		user.description = params.description
		user.htmlDescription = JRST.generateString(
			JRST.TYPE_HTML_INNER_BODY,
			descReader
		)
		user.homepage = params.homepage
		user.blog = params.blog
		
		if (params.password) {
			user.password = params.password
		}
						
		if (user.save(flush: true)) {
			
		}
		else {
			
		}
		
		render(view: 'account', model: [user: user])
	}
}
