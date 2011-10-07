package org.contpub.simaqian

class HomeController {

    def index() { }
    
    def login() {
    	def user = User.findByEmailAndPassword(params.email, params.password)
		if (user) {
			session['user'] = user
			redirect (action: 'index')
		}
		else {
			redirect (action: 'index')
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
}
