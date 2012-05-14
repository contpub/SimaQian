package simaqian

class PageController {

    def index() { }

    def show() {
    	[
    		category: params.category,
    		name: params.name
    	]
    }
}
