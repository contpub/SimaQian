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
		<g:if test="${book?.subtitle}"><p class="subtitle">${book?.subtitle}</p></g:if>
		<g:if test="${book?.authors}"><p>By ${book?.authors}</p></g:if>
		<g:if test="${book?.cookUpdated}"><p>Released: ${book?.cookUpdated?.format('MMM yyyy')}</p></g:if>

		<div class="description">
			${book?.profile?.description}
		</div>
		
		<h3><g:message code="common.download.ebook" default="Download eBooks"/></h3>
		<div class="downloads">
			<g:if test="${userOwnBook||userBuyBook||book.isPublic}">
				<a name="download"></a>
				<g:if test="${book?.isCooking}">
					<p><strong>Notice</strong> eBooks are publishing...</p>
				</g:if>
				<div class="download-links">
					<bookTag:downloadLink book="${book}" type="epub" class="fancy-button">ePub</bookTag:downloadLink>

					<bookTag:downloadLink book="${book}" type="mobi" class="fancy-button">Kindle</bookTag:downloadLink>

					<bookTag:downloadLink book="${book}" type="pdf" class="fancy-button">PDF</bookTag:downloadLink>

					<a href="http://docs.google.com/viewer?url=${bookTag.createDownloadLink(book: book, type: 'pdf').encodeAsURL()}&embedded=true" target="_blank" class="fancy-button"><g:message code="common.preview" default="Preview"/></a>

					<br/>
					<br/>

					<bookTag:downloadLink book="${book}" type="zip" class="fancy-button">HTML</bookTag:downloadLink>

					<bookTag:downloadLink book="${book}" type="cdn" class="fancy-button">On-Line</bookTag:downloadLink>
				</div>
			</g:if>
			<g:else>
				<p>You don't have permission to download files for this book.</p>
			</g:else>
		</div>

		<h3>Reader services</h3>
		<ul>
			<li>Send email to contact@contpub.org, we'll reply a-s-a-p.</li>
		</ul>
		<!--<p>
		<select>
			<option value="0"></option>
			<option value="1">I want to report a problem.</option>
			<option value="2">I can't download this book.</option>
			<option value="3">This book contains illegal contents.</option>
		</select><br/>
		<g:textArea name="feedback" /><br/>
		<g:submitButton name="submit" value="Send" class="fancy-button" />
		</p>-->

		<h3>Share with friends</h3>
		<div style="height:50px;overflow:hidden">
			<socialTag:facebookLikeButton />
		</div>

		<div class="comments" style="min-height:250px">
			<socialTag:disqus identifier="book-${book?.name}" url="${bookTag.createLink(book: book)}" />
		</div>
	</div>
	
	<div class="left">
		<!--<p class="icon">
			<img src="${createLinkTo(dir: 'images', file: 'book_icon.png')}" class="book-icon" />
		</p>-->
		
		<div style="height:120px;text-align:center">
			<img src="${bookTag.createCoverLink(book: book)}" alt="${book?.title}" />
		</div>
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
				<!--<li class=""><a id="appeal" href="#appeal"><g:message code="common.appeal" default="Appeal" /></a></li>-->
				<g:if test="${userOwnBook}"><userTag:isLogin>
					<li><g:link controller="publish" action="update" id="${book?.id}"><g:message code="button.publish.update" default="Settings" /></g:link></li>
					<li><g:link controller="publish" action="editor" id="${book?.id}"><g:message code="button.publish.editor" default="Editor" /></g:link></li>
				</userTag:isLogin></g:if>
			</ul>
		</div>			
	</div>
</div>
<content tag="sidebar">
</content>
</body>
</html>
