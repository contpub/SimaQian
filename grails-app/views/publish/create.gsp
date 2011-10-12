<html>
<head>
<title>Publish</title>
	<meta name="current.action" content="publish" />
	<style style="text/css">
	form #name {
		width: 200px;
	}
	form #title, form #description {
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

	<h2>Create a book</h2>
	
	<g:renderErrors bean="${book}" />

	<g:form action="save">

		<p class="no-border"><strong>Basic configuration</strong> (<span class="required">*</span> is required)</p>

		<p>
			<label for="name">Name (Ex. MyFirstBook)</label> <span class="required">*</span><br />
			<g:textField name="name" value="${book?.name}" />
		</p>

		<p>
			<label for="title">Book Title</label> <span class="required">*</span><br />
			<g:textField name="title" value="${book?.title}" />
		</p>

		<p>
			<label for="description">Brief Description</label><br />
			<g:textArea name="description" value="${book?.description}" />
		</p>

		<!-- Defaults -->
		<g:hiddenField name="type" value="EMBED" />
		<g:hiddenField name="url" value="" />
		<g:hiddenField name="homepage" value="" />
		<g:hiddenField name="icon" value="" />
		<g:hiddenField name="cover" value="" />
		<g:hiddenField name="contents" value="" />

		<!--
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
				from="${book.typeList}"
				value="${book.type?.toString()}"
				noSelection="['':'']" />
		</p>

		<p>
			<label for="url">Repository URL</label><br />
			<g:textField name="url" value="${book?.url}" />
		</p>
		-->

		<p class="no-border">
			<g:submitButton name="create" value="Create" class="button" />
		</p>

	</g:form>
	
	<content tag="sidebar">
		<div class="sidemenu">
			<h3>Steps</h3>
			<ol class="steps">
				<li><strong>Thinking</strong></li>
				<li>Writing</li>
				<li>Publishing</li>
			</ol>
		</div>
	</content>
</body>
</html>
