<!doctype html>
<!--[if lt IE 7 ]><html lang="en" class="no-js ie6"><![endif]-->
<!--[if IE 7 ]><html lang="en" class="no-js ie7"><![endif]-->
<!--[if IE 8 ]><html lang="en" class="no-js ie8"><![endif]-->
<!--[if IE 9 ]><html lang="en" class="no-js ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html lang="en" class="no-js" xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml"><!--<![endif]-->
<head>
<layoutTag:normalMeta />
<socialTag:openGraph title="${layoutTitle(default: 'Page')}" />
<r:require modules="jquery, bootstrap, compass" />
<r:layoutResources />
<g:layoutHead/>
<ga:trackPageview />
</head>
<body>
<socialTag:facebookSDK />
<!--header--><g:applyLayout name="pageHeader"/>
<div class="container">
<!--body--><g:layoutBody/>
<!--footer--><g:applyLayout name="pageFooter"/>
</div>
<r:layoutResources/>
</body>
</html>
