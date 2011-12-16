<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>發佈成功</title>
</head>
<body>
下載電子書...
<ul>
	<li>
		<g:link action="download" id="sandbox${sandbox?.id}.pdf" target="_blank">PDF</g:link>
		（<a href="http://docs.google.com/viewer?url=${createLink(action: 'download', id: 'sandbox'+sandbox?.id+'.pdf', absolute: true).encodeAsURL()}&embedded=true" target="_blank">線上預覽</a>）
	</li>
	<li><g:link action="download" id="sandbox${sandbox?.id}.epub" target="_blank">EPUB</g:link></li>
</ul>
分享這本電子書...
<ul>
	<li><g:link action="show" id="${sandbox?.id}" target="_top">電子書專頁</g:link></li>
</ul>
</body>
</html>
