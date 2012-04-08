<html>
<head>
<!--<meta HTTP-EQUIV="REFRESH" content="15; url=${createLink(controller: 'home')}">-->
<title>Server Error</title>
</head>
<body>
<h2>Error 500: server error</h2>
<p>Oops, something wrong... ${exception}</p>
<div style="text-align:center"><img src="${createLinkTo(dir:'images', file:'error-403.png')}" alt="error-403" /></div>
<p><g:link controller="home" action="index">Go Home</g:link></p>
</body>
</html>
