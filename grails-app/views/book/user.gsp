<html>
<head>
<title>Creations of ${user?.name}</title>
</head>
<body>
<g:if test="${books?.size()>1}">
	Wow! You have ${books.size()} books.
</g:if>
<g:elseif test="${books?.size()>0}">
	You have 1 book.
</g:elseif>
<g:else>
	Just press <g:link controller="publish" action="index">publish</g:link> to write your new book.
</g:else>
	<table width="90%" cellpadding="0" cellspacing="0" border="0">
		<thead>
			<tr>
				<th>Title</th>
				<th>Last Modified</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
		<g:each status="i" in="${books}" var="book">
			<tr>
				<td><bookTag:link book="${book}">${book?.title}</bookTag:link></td>
				<td>${book?.lastUpdated}</td>
				<td>
					<g:link controller="publish" action="update" id="${book?.id}">
						<g:message code="button.publish.update" default="Settings" />
					</g:link>
					|
					<g:link controller="publish" action="editor" id="${book?.id}">
						<g:message code="button.publish.editor" default="Editor" />
					</g:link>
				</td>
			</tr>
		</g:each>
		</tbody>
	</table>
</body>
</html>
