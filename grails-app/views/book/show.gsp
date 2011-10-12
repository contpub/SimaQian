<html>
<head>
    <meta property="og:title" content="${book?.title}"/>
    <meta property="og:type" content="book"/>
    <meta property="og:url" content="http://contpub.org${book.link}"/>
    <meta property="og:image" content="http://contpub.org/static/images/book_icon.png"/>
    <meta property="og:site_name" content="ContPub"/>
    <meta property="fb:admins" content="contpub"/>
    <meta property="og:description" content="${book?.description}"/>
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
		width: 40%;
		display: inline-block;
	}
	p.download-link img {
		width: 64px;
		height: 64px;
	}
	p.cover-image {
		text-align: center;
	}
	p.cover-image img {
		width: 150px;
	}
	.sidemenu.usermenu {
		display: none;
	}
	.comments {
		clear: both;
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
	<g:socialFacebookSDK />
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
			<p class="post-info">
				Updated: ${book.lastUpdated.format('yyyy-MM-dd')}
			</p>
			
			<p class="description">
				${book?.description?.replace("\n", "<br />")}
			</p>
			
			<g:socialFacebookLikeButton />

			
			<g:isUser>
				<div style="text-align:right">
					<g:link controller="publish" action="update" id="${book?.id}" class="clickable">Modify</g:link>
				</div>
			</g:isUser>
			
			<g:if test="${userBuyBook||book.isPublic}">
				<a name="download"></a>
				<g:if test="${book?.isCooking}">
					<h3>Downloads</h3>
					<p><strong>Unavailable</strong>. This book is printing, please wait ...</p>
				</g:if>
				<g:else>
					<h3>Downloads</h3>
					<g:if test="${book?.urlToPdf!=null}">
						<p class="download-link">
							<a href="<g:createBookDownloadLink book='${book}' ext='pdf' />">
								<img src="${createLinkTo(dir: 'icons', file: 'mime-pdf.png')}" alt="pdf-icon" border="0" /><br/>
								${book?.name}.pdf
							</a>
						</p>
					</g:if>	
					<g:if test="${book?.urlToEpub!=null}">
						<p class="download-link">
							<a href="<g:createBookDownloadLink book='${book}' ext='epub' />">
								<img src="${createLinkTo(dir: 'icons', file: 'mime-epub.png')}" alt="epub-icon" border="0" /><br/>${book?.name}.epub
							</a>
						</p>
					</g:if>
				</g:else>
			</g:if>
			
			<a name="permalink"></a>			
			<h3>Permalinks</h3>
			<p><a href="<g:createBookLink book='${book}' />"><g:createBookLink book="${book}" /></a></p>

			<div class="share-box clear">
				<h4>Share This</h4>
				<ul>
					<li><a title="RSS" href="index.html" rel="nofollow">
					<img alt="RSS" title="RSS" src="${createLinkTo(dir: 'images', file: 'rss_32.png')}" /></a>
					</li>
					<li><a title="del.icio.us" href="index.html" rel="nofollow">
					<img alt="del.icio.us" title="del.icio.us" src="${createLinkTo(dir: 'images', file: 'delicious_32.png')}" /></a>
					</li>
					<li><a title="StumbleUpon" href="index.html" rel="nofollow">
					<img alt="StumbleUpon" title="StumbleUpon" src="${createLinkTo(dir: 'images', file: 'stumbleupon_32.png')}" /></a>
					</li>
					<li><a title="Digg" href="index.html" rel="nofollow">
					<img alt="Digg" title="Digg" src="${createLinkTo(dir: 'images', file: 'digg_32.png')}" /></a>
					</li>
					<li><a title="Facebook" href="index.html" rel="nofollow">
					<img alt="Facebook" title="Facebook" src="${createLinkTo(dir: 'images', file: 'facebook_32.png')}" /></a>
					</li>
					<li><a title="Twitter" href="index.html" rel="nofollow">
					<img alt="Twitter" title="Twitter" src="${createLinkTo(dir: 'images', file: 'twitter_32.png')}" /></a>
					</li>
					<li><a title="Technorati" href="index.html" rel="nofollow">
					<img alt="Technorati" title="Technorati" src="${createLinkTo(dir: 'images', file: 'technorati_32.png')}" /></a>
					</li>
					<li><a title="NewsVine" href="index.html" rel="nofollow">
					<img alt="NewsVine" title="NewsVine" src="${createLinkTo(dir: 'images', file: 'newsvine_32.png')}" /></a>
					</li>
					<li><a title="LinkedIn" href="index.html" rel="nofollow">
					<img alt="LinkedIn" title="LinkedIn" src="${createLinkTo(dir: 'images', file: 'linkedin_32.png')}" /></a>
					</li>
					<li><a title="E-mail this story to a friend!" href="index.html" rel="nofollow">
					<img alt="E-mail this story to a friend!" title="E-mail this story to a friend!" src="${createLinkTo(dir: 'images', file: 'email_32.png')}" /></a>
					</li>
				</ul>
			</div>

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
			<p class="icon">
				<img src="${createLinkTo(dir: 'images', file: 'book_icon.png')}" class="book-icon" />
			</p>
			<div class="post-meta">
				<!--<h4>Book Info</h4>-->
				<ul>
					<g:if test="${!userBuyBook&&!book?.isPublic}">
						<li><g:link action="addToCart" id="${book.id}">Buy This Book</g:link></li>
					</g:if>
					<li>${book?.name}</li>
					<li>${book?.type}</li>
					<li class="time">${book.dateCreated.format('yyyy-MM-dd')}</li>
					<li class="comment"><a href="#comment">Comments</a></li>
					<li class="permalink"><a href="#permalink">Permalinks</a></li>
					<g:if test="${userBuyBook||book.isPublic}">
						<li class="permalink"><a href="#download">Downloads</a></li>
					</g:if>
				</ul>
			</div>
		</div>
	
		<a name="comment"></a>
		<!-- Comments using Disqus services -->
		<div class="comments">
			<!--<h3>Comments</h3>-->
			<g:socialDisqus shortname="" />
		</div>
	</div>
	
	<p align="right">
		<g:link action="index" class="clickable">Back</g:link>
	</p>

	<content tag="sidebar">
	
		<g:if test="${book?.cover}">
			<a name="cover"></a>
			<p class="cover-image">
				<img src="${book?.cover}" />
			</p>
		</g:if>

	</content>

</body>
</html>
