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
	#bookshelf a .box {
		background: transparent;
		border: 0;
		float: left;
		width: 100px;
		height: 115px;
		text-align: center;
		margin: 15px;
	}
	#bookshelf a:hover .box {
	}
	#bookshelf a img {
		border: 0;
		padding: 0;
		margin: 0;
		height: 115px;
		border-radius: 0;
		background: none;
	}
	#bookshelf a .embedded-title {
		width: 80px;
		height: 105px;
		position: absolute;
		margin-left: 15px;
		margin-top: 10px;
		color: white;
		text-shadow: 2px 2px 2px #000;
		overflow: hidden;
	}
	#bookshelf .book {
		clear: both;
		width: 48%;
		display: inline-block;
	}
	#bookshelf h3 {
		font-size: 1.2em;
		font-weight: bold;
		color: #888888;
	}
	</style>
</head>
<body>
	<div id="bookshelf"><div class="inner">
		<g:each in="${books}" var="book">
			<div class="book">
				<a href="<g:createBookLink book='${book}' />" title="${book?.title}">
					<div class="box">
						<g:if test="${book.cover==null||book.cover.equals('')}">
							<span class="embedded-title">${book?.title}</span>
							<img src="${createLinkTo(dir: 'images', file: 'book_cover.png')}" />
						</g:if>
						<g:else>
							<img src="${book?.cover}" alt="${book?.title}" />
						</g:else>
					</div>
				</a>
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
