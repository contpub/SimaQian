package org.contpub.simaqian

import org.nuiton.jrst.*

class HomeController {

    def index() {
    	[book: Book.get(12)]
    }
    
    def login() {
    	def users = User.withCriteria {
    		or {
    			eq ('email', params.email)
    			eq ('account', params.email)
    		}
    		eq ('password', params.password)
    	}
    	
    	def user = users.size() > 0? users[0]: null
    	
		if (user) {
			session.user = user
			session.userId = user.id
			redirect (action: 'index')
		}
		else {
			flash.loginErrors = 'E-mail or password not correct.'
			redirect (action: 'index')
		}
	}
	
	def logout() {
		//session.invalidate()
		session.user = null
		session.userId = null
		redirect (action: 'index')
	}
    
    /*
     * Sign-up for new registers
     */
    def signup() {
    	def user = new User()
    	
    	[user: user]
	}
	
	/**
	 * Save sign-up form data
	 */
    def signupSave() {
        def user = new User(params)
        if (!user.save(flush: true)) {
            render(view: "signup", model: [user: user])
            return
        }

		//flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])
        //redirect(action: "show", id: user.id)
        
        flash.message = 'Thanks for sign-up.'
        redirect (action: 'welcome')
    }
    
    /**
     * Welcome new registers
     */
    def welcome() {
    	
    }
    
	/**
	 * Personal account management
	 */
	def account() {
		def user = User.get(session.userId)
		
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
		
		if (!user.profile) {
			user.profile = new UserProfile(user: user)
		}
		
		user.profile.description = params.description
		user.profile.homepage = params.homepage
		user.profile.blog = params.blog
		
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
