<html>
<head>
    <meta property="og:title" content="${book?.title}"/>
    <meta property="og:type" content="book"/>
    <meta property="og:url" content="${bookTag.createLink(book: book)}"/>
    <meta property="og:image" content="${book?.hasCover?bookTag.createCoverLink(book: book):'http://contpub.org/static/images/book_icon.png'}"/>
    <meta property="og:site_name" content="ContPub"/>
    <meta property="fb:admins" content="contpub"/>
    <meta property="og:description" content="${book?.profile?.simpleDescription}"/>
	<title>${book?.title}</title>
	<style type="text/css">
	table {
		clear:both;
	}
	p.icon {
		text-align: right;
		padding: 10px;
		margin: 0;
	}
	img.book-icon {
		border: 0;
		margin: 0;
		padding: 5px;
		width: 64px;
		height: 64px;
	}
	div.advanced {
		display: none;
	}
	div.download-link {
		text-align: center;
		width: 200px;
		display: inline-block;
	}
	.comments {
		clear: both;
		width: 80%;
		margin: 15px auto;
	}
	.description pre, .description code {
		width: 98%;
		height: 100%;
		background: none;
		border: 0;
	}
	.fb-like {
		margin: 10px 25px;
	}
	</style>
	<socialTag:facebookSDK />
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
			<h2>${book?.title}</h2>
			
			<p class="description">
				${book?.profile?.description?.replace("\n", "<br />")}
			</p>
			
			<socialTag:facebookLikeButton />
			
			<g:if test="${userOwnBook||userBuyBook||book.isPublic}">
				<h3>下載</h3>
				<a name="download"></a>
				<g:if test="${book?.isCooking}">
					<p><strong>無法下載</strong>. 電子書正在製作中 ...</p>
				</g:if>
				<g:else>
					<div style="text-align: center">
						<div class="download-link">
							<bookTag:downloadLink book="${book}" type="pdf">
								<img src="${createLinkTo(dir: 'icons', file: 'mime-pdf-64.png')}" alt="pdf-icon" border="0" /><br/>
								${book?.name}.pdf
							</bookTag:downloadLink>
							<br/>
							<a href="http://docs.google.com/viewer?url=${bookTag.createDownloadLink(book: book, type: 'pdf').encodeAsURL()}&embedded=true" target="_blank">線上預覽</a>
						</div>
						<div class="download-link">
							<bookTag:downloadLink book="${book}" type="epub">
								<img src="${createLinkTo(dir: 'icons', file: 'mime-epub-64.png')}" alt="epub-icon" border="0" /><br/>${book?.name}.epub
							</bookTag:downloadLink>
							<br/>
							無法預覽
						</div>
					</div>
				</g:else>
			</g:if>

			<div class="advanced">
				<h3>Repository</h3>
				<table width="400">
					<tr>
						<th width="120">Repository Type</th>
						<td>${book?.type}</td>
					</tr>
					<tr>
						<th>Repository URL</th>
						<td>${book?.url}</td>
					</tr>
				</table>
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
	
		<a name="comment"></a>
		<div class="comments"></div>
	</div>

	<content tag="sidebar">
	</content>

</body>
</html>
