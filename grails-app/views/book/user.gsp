<html>
<head>
<title>Publications of ${user?.name}</title>
</head>
<body>
<table class="table table-striped">
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
					<div class="btn-group">
						<g:link controller="publish" action="update" id="${book?.id}" class="btn btn-small"><g:message code="button.publish.update" default="Settings" /></g:link>
	<g:link controller="publish" action="editor" id="${book?.id}" class="btn btn-small"><g:message code="button.publish.editor" default="Editor" /></g:link>
					</div>
				</td>
			</tr>
		</g:each>
	</tbody>
</table>
</body>
</html>
