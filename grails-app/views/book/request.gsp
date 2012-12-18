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
		</div>
	</div>
	<div class="span9">
		<!--book-->
		<div class="page-header">
			<h1 class="title">${book?.title}</h1>
		</div>
		<g:if test="${book?.subtitle}"><p class="subtitle">${book?.subtitle}</p></g:if>
		<g:if test="${book?.authors}"><p>By ${book?.authors}</p></g:if>
		<g:if test="${book?.cookUpdated}"><p>Released: ${book?.cookUpdated?.format('MMM yyyy')}</p></g:if>

		<div class="well">
			<g:form controller="book" action="requestSend" id="${book?.id}" method="post">
				<legend>取得電子書下載連結</legend>

				<g:if test="${result=='SENDMAILOK'}">
					<div class="alert alert-success">電子郵件已經寄出</div>
				</g:if>
				<g:if test="${result=='SENDMAILERROR'}">
					<div class="alert alert-success">電子郵件寄送失敗</div>
				</g:if>

				<p>驗證通過後，您會在 24 小時內會收到一封電子郵件，提供《${book?.title}》電子書下載連結。</p>
				<label>電子郵件信箱</label>
				<g:textField name="email" value="${user?.email}" class="input-xlarge" />
				<span class="help-block">請輸入您購買時使用的電子郵件信箱。</span>
				<g:submitButton name="update" value="確認" class="btn btn-primary" />
			</g:form>
		</div>
	</div>
</div>

</body>
</html>
