<html>
<head>
<title>Explore Awesome eBooks</title>
</head>
<body>
<table class="table">
	<thead>
		<tr>
			<th>#</th>
			<th>Book Title</th>
			<th>Descriptions</th>
			<th>Authors</th>
			<th>Available Formats</th>
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
			</tr>
		</g:each>
	</tbody>
</table>
</body>
</html>
