<html>
<head>
</head>
<body>
<div id="bookshelf"><div class="inner">
	<g:each in="${books}" var="book">
		<bookTag:link book="${book}">
			<bookTag:coverImage book="${book}" />
		</bookTag:link>
	</g:each>
	<div style="clear:both"></div>
</div></div>
</body>
</html>
