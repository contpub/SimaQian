<html>
<head>
<!--<meta HTTP-EQUIV="REFRESH" content="15; url=${createLink(controller: 'home')}">-->
<title>Page not found</title>
</head>
<body>
<h2>Error 404: page not found</h2>
<p>Oops, something wrong... ${exception}</p>
<div style="text-align:center"><img src="${createLinkTo(dir:'images', file:'error-404.png')}" alt="error-404" /></div>
<p><g:link controller="home" action="index">Go Home</g:link></p>
</body>
</html>
