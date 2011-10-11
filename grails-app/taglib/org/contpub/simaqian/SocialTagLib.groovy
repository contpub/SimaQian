package org.contpub.simaqian

class SocialTagLib {
	def socialDisqus = { attr, body ->
		out << render (
			template: '/_social/disqus',
			model: [shortname: grailsApplication.config.social.disqus.shortname]
		)
	}
	
	def socialTwitterFollow = { attr, body ->
		out << render (
			template: '/_social/twitterFollow',
			model: [screen_name: grailsApplication.config.social.twitter.screen_name]
		)
	}
	
	def socialFacebookLike = { attr, body ->
		out << render (
			template: '/_social/facebookLike',
			model: [
				href: grailsApplication.config.social.facebook.like.href,
				width: attr.width?attr.width:292,
				height: attr.height?attr.height:590,
				header: attr.header?attr.header:true,
				stream: attr.stream?attr.stream:true,
				show_faces: attr.show_faces?attr.show_faces:true,
				colorscheme: attr.colorscheme?attr.colorscheme:'light',
				border_color: attr.border_color?attr.border_color:''
			]
		)
	}
}
