class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		'/' (controller: 'home')
		'/publish' (controller: 'book', action: 'create')
		
		//'500' (view: '/error')
		"403"(controller: "errors", action: "forbidden")
		"404"(controller: "errors", action: "notFound")
		"500"(controller: "errors", action: "serverError")

		"/$bookName" {
			controller = "book"
			action = "lookup"
			constraints {
				bookName (matches:/^book:[a-zA-Z0-9]+$/)
			}
		}
	}
}
