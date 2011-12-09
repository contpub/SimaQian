<html>
<head>
	<title>讀者管理</title>
	<style style="text/css">
	form #name {
		width: 200px;
	}
	form #title, form #description, form #homepage, form #icon, form #cover {
		width: 100%;
	}
	form #description {
		height: 150px;
	}
	span.required {
		color: red;
		font-weight: bold;
	}
	div.book-coverImage {
		margin: 10px;
		float: left;
	}
	.clear-both {
		clear:both;
	}
	</style>
	<socialTag:websnaprSDK />
</head>
<body>
	<g:render template="breadcrumbs" model="[title: '讀者管理']" />
	
	<div id="post">
		<div class="right">

			<ul>
				<g:each var="userLink" in="${book?.users}">
					<li>${userLink.user.email}, ${userLink.user.name}, ${userLink.dateCreated.format('yyyy/MM/dd')}, ${userLink.linkType}</li>
				</g:each>
			</ul>

			<g:form action="readerSave" id="${book?.id}">

				<p class="no-border"><strong>新增一位讀者</strong></p>

				<p>
					<label for="title">E-Mail</label><br />
					<g:textField name="email" value="" />
				</p>

				<p class="no-border">
					<g:submitButton name="create" value="Confirm" class="button wide" />
					<bookTag:link book="${book}">Cancel</bookTag:link>
				</p>

			</g:form>
		</div>
		<div class="left">
			<g:render template="leftMenu"></g:render>
		</div>
	</div>
</body>
</html>
