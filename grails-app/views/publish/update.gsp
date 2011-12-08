<html>
<head>
	<title>Update book info</title>
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
	<g:render template="breadcrumbs" model="[title: '基本設定']" />
	
	<div id="post">
		<div class="right">
			<g:renderErrors bean="${book}" />

			<g:form action="saveUpdate" id="${book.id}">

			<p class="no-border"><strong>Feel free to fill everything</strong></p>

			<p>
				<label for="title">Book Title</label><br />
				<g:textField name="title" value="${book?.title}" />
			</p>

			<p>
				<label for="description">Brief Description</label> (reStructuredText)<br />
				<g:textArea name="description" value="${book?.profile?.description}" />
			</p>	

			<p>
				<label for="homepage">Homepage</label><br />
				<g:textField name="homepage" value="${book?.profile?.homepage}" />
				<socialTag:websnapr href="${book?.profile?.homepage}" size="s" />
			</p>

			<p>
				<label for="icon">Icon</label><br />
				<g:textField name="icon" value="${book?.profile?.icon}" />
			</p>

			<p>
				<label for="cover">Cover Image</label><br />
				<bookTag:coverImage book="${book}" />
				<g:link action="cover" id="${book?.id}">Upload</g:link> a new cover image
				<div class="clear-both"></div>
			</p>
	
			<p>
				<label>Options</label><br/>
				<g:checkBox name="isPublic" value="${book?.isPublic}" />
				<label for="isPublic">Public? (開放式電子書)</label>
			</p>

			<p class="no-border">
				<g:submitButton name="create" value="Update" class="button wide" />
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
