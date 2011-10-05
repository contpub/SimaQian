<h2>Create a book</h2>

<g:renderErrors bean="${book}" />

<g:form action="save">

<p class="no-border"><strong>Feel free to fill everything</strong></p>

<p>
	<label for="name">Name</label><br />
	<g:textField name="name" value="${book?.name}" />
</p>

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

<p>
	<label for="type">Repository Type</label><br />
	<g:select name="type"
		from="${RepoType?.values()}"
		value="${book.type?.toString()}"
		noSelection="['':'']" />
</p>

<p>
	<label for="url">Repository URL</label><br />
	<g:textField name="url" value="${book?.url}" />
</p>

<p class="no-border">
	<g:submitButton name="create" value="Create" class="button" />
</p>

</g:form>