<html>
<head>
<meta http-equiv="refresh" content="10; url=${createLink(action: 'resultCheck', id: sandbox?.id)}" />
</head>
<body>
success, download from ....
<g:link action="download" id="sandbox${sandbox?.id}.pdf">PDF</g:link>
<g:link action="download" id="sandbox${sandbox?.id}.epub">EPUB</g:link>
</body>
</html>
