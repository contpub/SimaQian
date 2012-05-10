<html>
<head>
<title>Publications of ${user?.name}</title>
</head>
<body>
<p><g:link controller="publish" action="create" class="btn btn-primary">Create a new book now</g:link></p>
<table class="table table-striped table-bordered">
	<thead>
		<tr>
			<th>#</th>
			<th>Book Title</th>
			<th>Descriptions</th>
			<th>Authors</th>
			<th>Available Formats</th>
			<th>Actions</th>
		</tr>
	</thead>
	<tbody>
		<g:each status="i" in="${books}" var="book">
			<tr>
				<td>${i+1}</td>
				<td><bookTag:link book="${book}">${book?.title}</bookTag:link></td>
				<td>${book?.subtitle}</td>
				<td>${book?.authors}</td>
				<td>${book?.formats}</td>
				<td>
					<g:link controller="publish" action="update" id="${book?.id}"><g:message code="button.publish.update" default="Settings" /></g:link>
					|
					<g:link controller="publish" action="editor" id="${book?.id}"><g:message code="button.publish.editor" default="Editor" /></g:link>
				</td>
			</tr>
		</g:each>
	</tbody>
</table>
</body>
</html>
