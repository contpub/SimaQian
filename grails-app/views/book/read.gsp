<html>
<head>
<socialTag:openGraph title="${book?.title}" type="book" url="${bookTag.createLink(book: book)}" image="${bookTag.createCoverLink(book: book)}" description="${book?.subtitle}" />
<title>${book?.title}</title>
</head>
<body>
<ul class="breadcrumb">
	<userTag:isLogin>
		<li>
			<g:link action="index">Books</g:link>
			<span class="divider">/</span>
		</li>
	</userTag:isLogin>
	<userTag:isNotLogin>
		<li>
			<g:link controller="explore" action="index">Books</g:link>
			<span class="divider">/</span>
		</li>
	</userTag:isNotLogin>
	<li class="active">${book.title}</li>
</ul>

<div class="row">
	<div class="span3">
		<div class="well">
			<div style="height:120px;text-align:center">
				<bookTag:coverImage book="${book}" />
			</div>
			<ul class="nav nav-list">
				<g:if test="${userOwnBook||userBuyBook||book.isPublic}">
					<li class="nav-header"><g:message code="common.download.ebook" default="Download" /></li>
					<!--pdf-->
					<g:if test="${book?.formats?.contains('pdf')}"><li><bookTag:downloadLink book="${book}" type="pdf" title="${book?.name}.pdf"><i class="icon-book"></i> PDF</bookTag:downloadLink></li></g:if>
					<!--epub-->
					<g:if test="${book?.formats?.contains('epub')}"><li><bookTag:downloadLink book="${book}" type="epub" title="${book?.name}.epub"><i class="icon-book"></i> EPUB</bookTag:downloadLink></li></g:if>
					<!--mobi-->
					<g:if test="${book?.formats?.contains('mobi')}"><li><bookTag:downloadLink book="${book}" type="mobi" title="${book?.name}.mobi"><i class="icon-book"></i> MOBI</bookTag:downloadLink></li></g:if>
					<!--html-->
					<g:if test="${book?.formats?.contains('html')}"><li><bookTag:downloadLink book="${book}" type="zip" title="${book?.name}.zip"><i class="icon-book"></i> HTML</bookTag:downloadLink></li></g:if>
					<!--preview-->
					<g:if test="${book?.formats?.contains('pdf')&&book?.isPublic}"><li><a href="http://docs.google.com/viewer?url=${bookTag.createDownloadLink(book: book, type: 'pdf').encodeAsURL()}&embedded=true" target="_blank" class="fancy-button"><i class="icon-share"></i> <g:message code="common.preview" default="Preview"/></a></li></g:if>
					<!--vhost-->
					<g:if test="${book?.formats?.contains('html')||book?.vhost}"><li><bookTag:downloadLink book="${book}" type="cdn"><i class="icon-share"></i> Online</bookTag:downloadLink></li></g:if>
				</g:if>
				<g:else>
					<li><i class="icon-info-sign"></i> You don't have permissions to download.</li>
				</g:else>
				<!--actions-->
				<userTag:isLogin><g:if test="${userOwnBook}">
					<li class="nav-header">Actions</li>
					<li>
						<g:link controller="publish" action="update" id="${book?.id}">
							<i class="icon-cog"></i>
							<g:message code="button.publish.update" default="Settings" />
						</g:link>
					</li>
					<li>
						<g:link controller="publish" action="editor" id="${book?.id}">
							<i class="icon-edit"></i>
							<g:message code="button.publish.editor" default="Editor" />
						</g:link>
					</li>
				</g:if></userTag:isLogin>
			</ul>
		</div>
	</div>
	<div class="span9">
		<!--book-->
		<h1 class="title">${book?.title}</h1>
		<g:if test="${book?.subtitle}"><p class="subtitle">${book?.subtitle}</p></g:if>
		<g:if test="${book?.authors}"><p>By ${book?.authors}</p></g:if>
		<g:if test="${book?.cookUpdated}"><p>Released: ${book?.cookUpdated?.format('MMM yyyy')}</p></g:if>

		<div style="height:50px;overflow:hidden"><socialTag:facebookLikeButton /></div>

		<g:if test="${book?.isCooking}">
			<div class="alert alert-info"><a class="close" data-dismiss="alert" href="#">×</a><strong>Notice</strong>: publishing in progress...</div>
		</g:if>

		<div class="well">
			${book?.profile?.description}
		</div>
	</div>
</div>

<div class="comments" style="min-height:380px">
	<socialTag:disqus identifier="book-${book?.name}" url="${bookTag.createLink(book: book)}" />
</div>

</body>
</html>
