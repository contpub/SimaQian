<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js" xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml"><!--<![endif]-->
<head>
<socialTag:openGraph title="${layoutTitle(default: 'Explorer')}" />
<layoutTag:normalMeta />
<title><g:layoutTitle default="Explorer" /> - ${grailsApplication.config.appConf.title}</title>
<layoutTag:normalHead />
<layoutTag:normalIcon />
<r:require modules="jquery, jquery-ui, codemirror, compass" />
<r:layoutResources />
<g:layoutHead/>
<ga:trackPageview />
</head>
<style type="text/css">
.steps {
	font-size: 1.25em;
}
.steps strong {
	color: blue;
}
</style>
</head>
<body>
	<socialTag:facebookSDK />
	<g:applyLayout name="pageHeader" params="[currentAction: controllerName]" />
	<g:applyLayout name="pageContent">
		<g:layoutBody/>
		
		<!--Sidebar define by each view-->
		<content tag="sidebar">
			<div class="sidemenu">
				<h3>User</h3>
				<layoutTag:userBox />
			</div>

			<g:pageProperty name="page.sidebar" />
		</content>
	</g:applyLayout>
	<g:applyLayout name="pageFooter"></g:applyLayout>
	<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
	<g:javascript library="application"/>
</body>
</html>
