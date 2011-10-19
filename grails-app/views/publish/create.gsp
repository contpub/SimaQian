<html>
<head>
<title>Publish</title>
	<meta name="current.action" content="publish" />
	<style style="text/css">
	form #name {
		width: 250px;
		color: #000055;
		font-weight: bold;
		font-size: 1.25em;
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

		<!-- Defaults -->
		<g:hiddenField name="type" value="EMBED" />
		<g:hiddenField name="url" value="" />


		<p>
		條款
		</p>
		<g:checkBox />
		
		<p class="no-border">
			<g:submitButton name="create" value="Create" class="button" />
		</p>

	</g:form>
	
	<content tag="sidebar">
	</content>
</body>
</html>
