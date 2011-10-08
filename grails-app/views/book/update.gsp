<html>
<head>
<title>Publish</title>
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
</style>
</head>
<body>
	<h2>Update a book</h2>

	<g:renderErrors bean="${book}" />

	<g:form action="saveUpdate" id="${book.id}">

	<p class="no-border"><strong>Feel free to fill everything</strong></p>

	<p>
		<label for="title">Book Title</label><br />
		<g:textField name="title" value="${book?.title}" />
	</p>

	<p>
		<label for="description">Brief Description</label><br />
		<g:textArea name="description" value="${book?.description}" />
	</p>


	<p>
		<label for="homepage">Homepage</label><br />
		<g:textField name="homepage" value="${book?.homepage}" />
	</p>

	<p>
		<label for="icon">Icon</label><br />
		<g:textField name="icon" value="${book?.icon}" />
	</p>

	<p>
		<label for="cover">Cover Image</label><br />
		<g:textField name="cover" value="${book?.cover}" />
	</p>

	<p class="no-border">
		<g:submitButton name="create" value="Update" class="button" />

		<g:link action="show" id="${book.id}">Cancel</g:link>
	</p>

	</g:form>
</body>
</html>
