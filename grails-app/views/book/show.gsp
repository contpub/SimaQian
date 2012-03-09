<html>
<head>
	<socialTag:openGraph title="${book?.title}" type="book" url="${bookTag.createLink(book: book)}" image="${book?.hasCover?bookTag.createCoverLink(book: book):createLinkTo(dir: 'icons', file: 'book.png', absolute: true)}" description="${book?.subtitle}" />
	<title>${book?.title}</title>
</head>
<body>
	<div class="breadcrumbs">
		<userTag:isLogin>
			<g:link action="index">Books</g:link>
		</userTag:isLogin>
		<userTag:isNotLogin>
			Books
		</userTag:isNotLogin>
		&gt;
		${book.title}
	</div>

	<div class="post">
		<div class="right">
			<h2 class="title">${book?.title}</h2>
			<p class="subtitle">${book?.subtitle}</p>

			<p>By ${book?.authors}<br/>
			Released: ${book?.cookUpdated?.format('MMM yyyy')}</p>

			<div class="description">
				${book?.profile?.description}
			</div>
			
			<socialTag:facebookLikeButton />


			<div class="downloads">
				<g:if test="${userOwnBook||userBuyBook||book.isPublic}">
					<h3><g:message code="common.download.ebook" default="Download eBook"/></h3>
					<a name="download"></a>
					<g:if test="${book?.isCooking}">
						<p><strong>無法下載</strong>. 電子書正在製作中 ...</p>
					</g:if>
					<g:else>
						<div class="download-links">
							<bookTag:downloadLink book="${book}" type="epub">ePub</bookTag:downloadLink>

							<bookTag:downloadLink book="${book}" type="mobi">Kindle</bookTag:downloadLink>

							<bookTag:downloadLink book="${book}" type="pdf">PDF</bookTag:downloadLink>

							<a href="http://docs.google.com/viewer?url=${bookTag.createDownloadLink(book: book, type: 'pdf').encodeAsURL()}&embedded=true" target="_blank"><g:message code="common.preview" default="Preview"/></a>

							<br/>
							<br/>

							<bookTag:downloadLink book="${book}" type="zip">HTML</bookTag:downloadLink>

							<bookTag:downloadLink book="${book}" type="cdn">On-Line</bookTag:downloadLink>
						</div>
					</g:else>
				</g:if>
			</div>


			<div class="comments">
				<socialTag:disqus identifier="book-${book?.name}" url="${bookTag.createLink(book: book)}" />
			</div>
		</div>
		
		<div class="left">
			<!--<p class="icon">
				<img src="${createLinkTo(dir: 'images', file: 'book_icon.png')}" class="book-icon" />
			</p>-->
			
			<p>
				<bookTag:coverImage book="${book}" />
			</p>
			
			<div class="post-meta">
				<!--<h4>Book Info</h4>-->
				<ul>
					<!--<g:if test="${!userBuyBook&&!book?.isPublic}">
						<li><g:link action="addToCart" id="${book.id}">Buy This Book</g:link></li>
					</g:if>-->
					<!--<g:if test="${userBuyBook||book.isPublic}">
						<li class="permalink"><a href="#download">電子書下載</a></li>
					</g:if>-->
					<g:if test="${book?.cookUpdated}">
						<li class="time">${book?.cookUpdated?.format('yyyy/MM/dd')}</li>
					</g:if>
				</ul>
			</div>
			
			<g:if test="${userOwnBook}">
				<userTag:isLogin>
					<div style="text-align:right">
						<g:link controller="publish" action="update" id="${book?.id}" class="clickable">設定</g:link>
						<g:link controller="publish" action="editor" id="${book?.id}" class="clickable">編輯室</g:link>
					</div>
				</userTag:isLogin>
			</g:if>
		</div>
	</div>

	<content tag="sidebar">
	</content>

</body>
</html>
