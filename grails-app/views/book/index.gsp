<html>
<head>
	<style type="text/css">
	#bookshelf {
		margin: 0 auto;
		width: 600px;
		height: 616px;
		padding: 0;
		border: 1px solid black;
		background: url(${createLinkTo(dir: 'images', file: 'bookshelf_600px.png')})
	}
	#bookshelf .inner {
		border: 0;
		margin: 55px 0 0 27px;
		padding: 0 auto;
	}
	#bookshelf a {
		border: 0;
		padding: 0;
		margin: 0;
	}
	#bookshelf div.book-coverImage {
		float: left;
		margin-bottom: 28px;
		margin-right: 12px;
	}
	</style>
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
