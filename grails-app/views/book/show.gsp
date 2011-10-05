<h2>${book.title}</h2>

<table>
	<tr>
		<th>Repository URL</th>
		<td>${book.url}</td>
	</tr>
	<tr>
		<th>Repository Type</th>
		<td>${book.type}</td>
	</tr>
</table>

<p>
Click me: <g:link action="cook" id="${book.id}">Cook (Generate PDF, ePub, ...)</g:link>
</p>

<g:link action="index">Back</g:link>