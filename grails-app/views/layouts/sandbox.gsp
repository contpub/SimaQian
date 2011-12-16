<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
	<layoutTag:normalMeta />
	<title><g:layoutTitle default="Book" /> - ${grailsApplication.config.appConf.title}</title>
	<layoutTag:normalHead />
	<layoutTag:normalIcon />
	<layoutTag:jquery />
	<layoutTag:jqueryUI />
	<g:layoutHead/>
	<style type="text/css">
	.steps {
		font-size: 1.25em;
	}
	.steps strong {
		color: blue;
	}
	p.icon {
		text-align: right;
		padding: 10px;
		margin: 0;
	}
	img.book-icon {
		border: 0;
		margin: 0;
		padding: 5px;
		width: 64px;
		height: 64px;
	}
	</style>
	<ga:trackPageview />
	<g:woopraTrackingScript />
</head>
<body>
	<g:applyLayout name="pageHeader" params="[currentAction: controllerName]" />
	<g:applyLayout name="pageContent">
		<g:layoutBody/>
		
		<!--Sidebar define by each view-->
		<content tag="sidebar">
			<div class="sidemenu usermenu">
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
