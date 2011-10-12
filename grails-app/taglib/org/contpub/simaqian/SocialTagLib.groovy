package org.contpub.simaqian

class SocialTagLib {
	def socialDisqus = { attr, body ->
		out << render (
			template: '/_social/disqus',
			model: [
				shortname: grailsApplication.config.social.disqus.shortname,
				identifier: attr.identifier?attr.identifier:'',
				url: attr.url?attr.url:''
			]
		)
	}
	
	def socialTwitterFollow = { attr, body ->
		out << render (
			template: '/_social/twitterFollow',
			model: [screenName: grailsApplication.config.social.twitter.screenName]
		)
	}

	def socialFacebookSDK = { attr, body ->
		out << render (
			template: '/_social/facebookSDK',
			model: []
		)
	}
	
	def socialFacebookLikeBox = { attr, body ->
		out << render (
			template: '/_social/facebookLikeBox',
			model: [
				href: grailsApplication.config.social.facebook.like.href,
				width: attr.width?attr.width:292,
				height: attr.height?attr.height:590,
				header: attr.header?attr.header:true,
				stream: attr.stream?attr.stream:true,
				showFaces: attr.showFaces?attr.showFaces:true,
				colorscheme: attr.colorscheme?attr.colorscheme:'light',
				borderColor: attr.borderColor?attr.borderColor:''
			]
		)
	}
	
	def socialFacebookLikeButton = { attr, body ->
		out << render (
			template: '/_social/facebookLikeButton',
			model: [
				href: attr.href?attr.href:'',
				send: attr.send?attr.send:true,
				layout: attr.layout?attr.layout:'standard',
				width: attr.width?attr.width:450,
				showFaces: attr.showFaces?attr.showFaces:true
			]
		)
	}
}
