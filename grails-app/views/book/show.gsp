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
	p.download-link {
		text-align: center;
		width: 120px;
		display: inline-block;
	}
	p.download-link img {
		width: 64px;
		height: 64px;
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
		<g:link action="index">Books</g:link>
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
				<a name="download"></a>
				<g:if test="${book?.isCooking}">
					<p><strong>無法下載</strong>. 電子書正在製作中 ...</p>
				</g:if>
				<g:else>
					<div style="text-align: center">
						<p class="download-link">
							<bookTag:downloadLink book="${book}" type="pdf">
								<img src="${createLinkTo(dir: 'icons', file: 'mime-pdf.png')}" alt="pdf-icon" border="0" /><br/>
								${book?.name}.pdf
							</bookTag:downloadLink>
						</p>
						<p class="download-link">
							<bookTag:downloadLink book="${book}" type="epub">
								<img src="${createLinkTo(dir: 'icons', file: 'mime-epub.png')}" alt="epub-icon" border="0" /><br/>${book?.name}.epub
							</bookTag:downloadLink>
						</p>
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
					<g:if test="${userBuyBook||book.isPublic}">
						<li class="permalink"><a href="#download">電子書下載</a></li>
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
