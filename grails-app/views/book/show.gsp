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
	<g:if test="${book.urlToPdf}">
	<tr>
		<th>PDF</th>
		<td>
			<a href="${book.urlToPdf}">${book.name}.pdf</a>
			<a href="http://docs.google.com/viewer?url=${URLEncoder.encode(book.urlToPdf)}&embedded=true" target="_blank">線上檢視</a>
		</td>
	</tr>
	</g:if>
	<g:if test="${book.urlToEpub}">
	<tr>
		<th>ePub</th>
		<td><a href="${book.urlToEpub}">${book.name}.epub</a></td>
	</tr>
	</g:if>
</table>

<p>
Click me: <g:link action="cook" id="${book.id}">Cook (Generate PDF, ePub, ...)</g:link>
</p>

<g:link action="index">Back</g:link>