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
	text: 'text/plain',
	js: 'text/javascript',
	rss: 'application/rss+xml',
	atom: 'application/atom+xml',
	css: 'text/css',
	csv: 'text/csv',
	all: '*/*',
	json: ['application/json','text/json'],
	form: 'application/x-www-form-urlencoded',
	multipartForm: 'multipart/form-data'
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']

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
    }
    production {
        grails.logging.jul.usebridge = false
        grails.serverURL = "http://contpub.org"
		log4j.appender.'errors.File'="/tmp/stacktrace.log"
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
}

// Application configuration
appConf.title = 'Continuous Publishing'
appConf.subTitle = 'Now everyone can publish ...'
appConf.cook.exchangeName = ''
appConf.cook.version = 1.0
appConf.cook.routingKey = 'RepoCook'



// Secure Passwords in private config file
grails.config.locations = [
	"file:${userHome}/.grails/${appName}-config.properties",
	"file:${userHome}/.grails/${appName}-config.groovy"
]

// Gravatar
avatarPlugin {
	defaultGravatarUrl='http://contpub.org/static/images/gravatar.jpg'
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
		like.href = 'http://facebook.com/contpub'
	}
}
