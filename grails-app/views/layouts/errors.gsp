<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="author" content="Erwin Aligam - styleshout.com" />
	<meta name="description" content="Site Description Here" />
	<meta name="keywords" content="keywords, here" />
	<meta name="robots" content="index, follow, noarchive" />
	<meta name="googlebot" content="noarchive" />
	<title><g:layoutTitle default="Errors" /> - ${grailsApplication.config.appConf.title}</title>
	<link rel="stylesheet" type="text/css" media="screen" href="${createLinkTo(dir: 'css', file: 'screen.css')}" />
	<!--<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">-->
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
	<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
	<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
	<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
	<g:layoutHead/>
</head>
<body>
	<g:applyLayout name="pageHeader"></g:applyLayout>
	<g:applyLayout name="pageContent">
		<g:layoutBody/>
		<!--Sidebar define by each view-->
		<content tag="sidebar">
			<g:pageProperty name="page.sidebar" />
		</content>
	</g:applyLayout>
	<g:applyLayout name="pageFooter"></g:applyLayout>
	<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
	<g:javascript library="application"/>
</body>
</html>
