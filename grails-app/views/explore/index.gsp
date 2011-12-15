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
	#bookshelf .description {
		/*max-height: 110px;
		overflow: hidden;*/
	}
	#bookshelf .book {
		border-bottom: 1px solid #dadada;
		width: 95%;
	}
	#bookshelf .book-command {
		clear: both;
		text-align: right;
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
					<bookTag:link book="${book}"><h3 class="title">${book?.title}</h3></bookTag:link>
					<p class="description">${book?.profile?.simpleDescription}</p>
				</div>
				<div class="book-command">
					<bookTag:link book="${book}">Read more ...</bookTag:link>
				</div>
			</div>
		</g:each>
		<div style="clear:both"></div>
	</div></div>
</body>
</html>
