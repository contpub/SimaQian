// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.app.context = '/'

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
	html: ['text/html','application/xhtml+xml'],
	xml: ['text/xml', 'application/xml'],
	zip: ['application/zip', 'application/x-zip', 'application/x-zip-compressed', 'application/octet-stream', 'application/x-compress', 'application/x-compressed', 'multipart/x-zip'],
	pdf: ['application/pdf', 'application/x-pdf', 'application/acrobat', 'applications/vnd.pdf', 'text/pdf', 'text/x-pdf'],
	epub: ['application/epub+zip'],
	mobi: ['application/x-mobipocket-ebook'],
	text: 'text/plain',
	js: 'text/javascript',
	rss: 'application/rss+xml',
	atom: 'application/atom+xml',
	css: 'text/css',
	csv: 'text/csv',
	png: ['image/png', 'image/x-png', 'application/png', 'application/x-png'],
	all: '*/*',
	json: ['application/json','text/json'],
	form: 'application/x-www-form-urlencoded',
	multipartForm: 'multipart/form-data'
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = [
	'/images/*',
	'/icons/*',
	'/css/*',
	'/stylesheets/*',
	'/js/*',
	'/plugins/*',
	'/bootstrap/*'
]

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// set per-environment serverURL stem for creating absolute links
environments {
    development {
        grails.logging.jul.usebridge = true

		// disable cdn-resources plugin
		grails.resources.cdn.enabled = false

		// disable yui-minify-resources plugin
		grails.resources.mappers.yuicssminify.disable=true
		grails.resources.mappers.yuijsminify.disable=true

		// enable resources debugging mode
		grails.resources.debug = true

		recaptcha {
			enabled = true
			useSecureAPI = true
		}

		log4j = {
			info "grails.app"
		}
	}
    production {
        grails.logging.jul.usebridge = false
        grails.serverURL = "http://contpub.org"

		// Grails cdn-resources plugin
		grails.resources.cdn.enabled = false
		grails.resources.cdn.url = "http://static.contpub.org/"

		recaptcha {
			enabled = true
			useSecureAPI = true
		}

		//log4j.appender.'errors.File'="/tmp/stacktrace.log"
		log4j = {
			'null' name:'stacktrace'
		}
	}
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
           'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}

//richui
richui.serve.resource.files.remote=true

// RabbitMQ configuration
rabbitmq {
	connectionfactory {
		username = 'guest'
		password = 'guest'
		hostname = 'localhost'
		consumers = 5
	}
	queues = {
		CookBack()		//CookBack is a "RoutingKey" for RepoCook callback
	}
}

// Amazon S3
aws {
	domain = 's3.amazonaws.com'
	accessKey = 'accessKey'			//Change this!!!
	secretKey = 'secretKey'			//Change this!!!
	bucketName = 'bucketName'
	href = 'http://bucketName.s3.amazonaws.com/'
}

// Application configuration
appConf {
	baseUrl = 'http://contpub.org/'
	sysId = 'contpub'
	title = 'Continuous Publishing'
	subTitle = 'Now everyone can publish ...'
	cook.exchangeName = ''
	cook.version = 1.0
	cook.routingKey = 'RepoCook'
	cdn.href = 'http://cdn.contpub.org/'
	vhost.host = 'vhost.contpub.org'
	vhost.href = 'http://vhost.contpub.org/'
}

// Secure Passwords in private config file
grails.config.locations = [
	//"file:${userHome}/.grails/${appName}-config.properties",
	"file:${userHome}/.grails/${appName}-config.groovy"
]

// Gravatar
avatarPlugin {
	defaultGravatarUrl='http://cdn.contpub.org/images/gravatar.png'
	gravatarRating="G"
}

// Social features
social {
	// websnapr
	websnapr {
		API_KEY = 'qSm102nbhm1e'
	}

	// Disqus: discover your community
	disqus {
		shortname = 'contpub'
	}	
	
	twitter {
		screenName = 'FollowContpub'
	}

	facebook {
		admins = '584879432'
		appId = '175500369215845'
		pageId = '210042899063054'
		appSecret = ''
		channelUrl = 'contpub.org'
		like.href = 'http://facebook.com/contpub'
	}

	google {
		like.href = 'https://plus.google.com/103047737274652189634'
	}
}

// Executable Bin Path
executable {
	pygmentize = "/usr/local/bin/pygmentize"
}

// Tomcat
tomcat.deploy.username = "manager"
tomcat.deploy.password = "secret"
tomcat.deploy.url = "http://myserver.com/manager"

// Google Analytics
google.analytics.webPropertyID = "UA-xxxxxx-x"
google.analytics.enabled = true
//google.analytics.traditional = true

// reCaptcha
recaptcha {
	// These keys are generated by the ReCaptcha service
	publicKey = ""
	privateKey = ""
	// Include the noscript tags in the generated captcha
	includeNoScript = true
}

// mailhide
mailhide {
	publicKey = ""
	privateKey = ""
}


