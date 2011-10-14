<html>
<head>
	<title>Explore</title>
	<style type="text/css">
	#bookshelf {
		margin: 0 auto;
		width: 100%;
		padding: 0;
	}
	#bookshelf .inner {
		border: 0;
		margin: 0;
	}
	#bookshelf a {
		border: 0;
		padding: 0;
		margin: 0;
	}
	#bookshelf .book {
		clear: both;
	}
	#bookshelf h3 {
		font-size: 1.2em;
		font-weight: bold;
		color: #888888;
	}
	div.book-coverImage {
		float: left;
		margin: 15px;
	}
	</style>
</head>
<body>
	<div id="bookshelf"><div class="inner">
		<g:each in="${books}" var="book">
			<div class="book">
				<bookTag:link book="${book}">
					<bookTag:coverImage book="${book}" />
				</bookTag:link>
				<div class="book-info">
					<h3 class="title">${book?.title}</h3>
					<p class="description">${book?.description}</p>
				</div>
			</div>
		</g:each>
		<div style="clear:both"></div>
	</div></div>
</body>
</html>
