package simaqian

import org.nuiton.jrst.*

class HomeController {

    def index() {
    }

    def demo = {
        [book: Book.get(12)]
    }
    
    def login() {
        def users = User.withCriteria {
            or {
                eq ('email', params.loginEmail)
                eq ('account', params.loginEmail)
            }
            eq ('password', params.loginPassword)
        }
        
        def user = users.size() > 0? users[0]: null
    
        if (user) {
            session.userId = user.id
            session.userName = user.name
        }
        else {
            flash.loginError = true
            flash.alertType = 'error'
            flash.alertMessage = 'Login authentication failed. Please enter your correct username and password.'
        }
        if (!params.forwardURI) {
            redirect (action: 'index')
        }
        else {
            redirect (url: params.forwardURI)
        }
    }
    
    def logout() {
        //session.invalidate()
        session.userId = null
        flash.alertType = 'success'
        flash.alertMessage = 'You have already signed out.'
        redirect (action: 'index')
    }
    
    /*
     * Sign-up for new registers
     */
    def signup() {
        def user = new User(params)

        if (params.signup) {
            user = new User(params)

            if (user.save(flush: true)) {
                flash.alertType = 'success'
                flash.alertMessage = 'Your new account has been established.'
                redirect (action: 'index')
            }
        }
        
        [
            user: user,
            usernums: User.count(),
            booknums: Book.count()
        ]
    }
    
    /**
     * User account preferences
     */
    def account() {
        def user = User.get(session.userId)
        
        if (!user) { response.sendError(403); return }

        if (params.save) {
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

            if (user.profile.save(flush: true)
                && user.save(flush: true)) {
                flash.alertType = 'success'
                flash.alertMessage = "${user?.name} account preferences updated. ${new Date()}"
            }
            else {
                flash.alertType = 'error'
                flash.alertMessage = "Unable to save data."
            }
        }

        [user: user]
    }    
}
