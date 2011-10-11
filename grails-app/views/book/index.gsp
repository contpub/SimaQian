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
	#bookshelf a .box {
		background: transparent;
		border: 0;
		float: left;
		margin-bottom: 28px;
		margin-right: 12px;
		width: 100px;
		height: 115px;
		text-align: center;
	}
	#bookshelf a:hover .box {
	}
	#bookshelf a .empty {
		display: block;
		border: 0;
		background: #ffffff;
		text-align: center;
		font-size: 11px;
		color: black;
		width: 95px;
		height: 115px;
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
	</style>
</head>
<body>

<div id="bookshelf"><div class="inner">
	<g:each in="${books}" var="book">
		<a href="<g:createBookLink book='${book}' />" title="${book.title}">
		<div class="box">
		<g:if test="${book.cover==null||book.cover.equals('')}">
			<span class="embedded-title">${book.title}</span>
			<img src="${createLinkTo(dir: 'images', file: 'book_cover.png')}" />
		</g:if>
		<g:else>
			<img src="${book.cover}" alt="${book.title}" />
		</g:else>
		</div>
		</a>
	</g:each>
	<div style="clear:both"></div>
</div></div>

</body>
</html>
