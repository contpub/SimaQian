package org.contpub.simaqian

class SocialTagLib {
	
	static namespace = 'socialTag'
	
	/**
	 * <socialTag:disqus identifier="book-${book?.name}" url="${bookTag.createLink(book: book)}" />
	 */
	def disqus = { attr, body ->
		out << render (
			template: '/tagLib/social/disqus',
			model: [
				shortname: grailsApplication.config.social.disqus.shortname,
				identifier: attr.identifier?attr.identifier:'',
				url: attr.url?attr.url:''
			]
		)
	}
	
	def twitterFollow = { attr, body ->
		out << render (
			template: '/tagLib/social/twitterFollow',
			model: [screenName: grailsApplication.config.social.twitter.screenName]
		)
	}

	def facebookSDK = { attr, body ->
		out << render (
			template: '/tagLib/social/facebookSDK',
			model: [
				appId: grailsApplication.config.social.facebook.appId,
				channelUrl: grailsApplication.config.social.facebook.channelUrl
			]
		)
	}
	
	def facebookLikeBox = { attr, body ->
		out << render (
			template: '/tagLib/social/facebookLikeBox',
			model: [
				href: grailsApplication.config.social.facebook.like.href,
				width: attr.width?attr.width:292,
				height: attr.height?attr.height:590,
				header: attr.header?attr.header:true,
				stream: attr.stream?attr.stream:true,
				showFaces: attr.showFaces?attr.showFaces:true,
				colorscheme: attr.colorscheme?attr.colorscheme:'light',
				borderColor: attr.borderColor?attr.borderColor:'#ffffff'
			]
		)
	}
	
	def facebookLikeButton = { attr, body ->
		out << render (
			template: '/tagLib/social/facebookLikeButton',
			model: [
				href: attr.href?attr.href:null,
				send: attr.send?attr.send:true,
				layout: attr.layout?attr.layout:'standard',
				width: attr.width?attr.width:450,
				showFaces: attr.showFaces?attr.showFaces:true
			]
		)
	}
	
	/**
	 * <socialTag:websnapr href="${url}" size="t|s" />
	 */
	def websnapr = { attr, body ->
		if (attr.href) {
			out << render (
				template: '/tagLib/social/websnapr',
				model: [
					apiKey: grailsApplication.config.social.websnapr.API_KEY,
					href: attr.href,
					size: attr.size?attr.size:'s'
				]
			)
		}
	}
	
	/**
	 * <socialTag:websnaprSDK />
	 */
	def websnaprSDK = { attr, body ->
		out << render (
			template: '/tagLib/social/websnaprSDK',
			model: []
		)
	}

	/**
	 * <socialTag:openGraph title="" type="" url="" image="" description="" />
	 */
	def openGraph = { attr, body ->
		if (request.getAttribute('_hasog')=='1') {
			return
		}
		request.setAttribute('_hasog', '1')

		if (!attr.title) attr.title = grailsApplication.config.appConf.title
		if (!attr.description) attr.description = grailsApplication.config.appConf.subTitle
		if (!attr.type) attr.type = 'website'
		if (!attr.url) attr.url = "${baseURL()}${request.forwardURI}"
		if (!attr.image) attr.image = createLinkTo(dir: 'icons', file: 'book.png', absolute: true)

		out << """<!--Open Graph-->
	<meta property="og:title" content="${attr.title}"/>
	<meta property="og:description" content="${attr.description}"/>	
	<meta property="og:type" content="${attr.type}"/>
	<meta property="og:url" content="${attr.url}"/>
	<meta property="og:image" content="${attr.image}"/>
	<meta property="og:site_name" content="${grailsApplication.config.appConf.sysId}"/>
	<meta property="fb:app_id" content="${grailsApplication.config.social.facebook.appId}"/>
	<meta property="fb:admins" content="${grailsApplication.config.social.facebook.admins}"/>
	<meta property="fb:page_id" content="${grailsApplication.config.social.facebook.pageId}"/>"""
	}

	/**
	 * <socialTag:userecho />
	 */
	def userecho = { attr, body ->
		out << render (
			template: '/tagLib/social/userecho',
			model: []
		)
	}
}
