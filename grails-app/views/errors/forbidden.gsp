<html>
<head>
<!--<meta HTTP-EQUIV="REFRESH" content="15; url=${createLink(controller: 'home')}">-->
<title>Forbidden</title>
</head>
<body>
<h2>Forbidden</h2>
<p>Oops, something wrong...</p>
<p><g:link controller="home" action="index">Go Home</g:link></p>
<p><g:renderException exception="${exception}" /></p>
</body>
</html>