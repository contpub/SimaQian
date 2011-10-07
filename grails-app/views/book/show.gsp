<html>
<head>
<title>${book?.title}</title>
<style type="text/css">
table {
	clear:both;
}
img.book-icon {
	border: 0;
	margin: 5px;
	float: left;
	width: 32px;
	height: 32px;
}
table.downloads td {
	text-align: center;
}
</style>
</head>
<body>

<img src="${createLinkTo(dir: 'images', file: 'book_icon.png')}" class="book-icon" />

<h2>${book?.title}</h2>

<table width="600">
	<tr>
		<th width="100">Name</th>
		<td>${book?.name}</td>
	</tr>
	<tr>
		<th>Permalinks</th>
		<td><a href="<g:createBookLink book='${book}' />"><g:createBookLink book="${book}" /></a></td>
	</tr>
	<tr>
		<th>Title</th>
		<td>${book?.title}</td>
	</tr>
	<tr>
		<th>Description</th>
		<td>${book?.description}</td>
	</tr>	
	<tr>
		<th>Homepage</th>
		<td>${book?.homepage}</td>
	</tr>
	<tr>
		<th>Author(s)</th>
		<td></td>
	</tr>
	<tr>
		<td colspan="2">
			<div style="text-align:right">
			<g:link action="update" id="${book?.id}">Modify</g:link>
			|
			Blah
			</div>
		</td>
	</tr>
</table>

<g:if test="${book?.isCooking==false}">
<h3>Downloads</h3>

<table width="600" class="downloads">
	<tr>
		<g:if test="${book?.urlToPdf!=null}">
			<td>
				<a href="<g:createBookDownloadLink book='${book}' ext='pdf' />">
					<img src="${createLinkTo(dir: 'icons', file: 'mime-pdf.png')}" alt="pdf-icon" border="0" /><br/>
					${book?.name}.pdf
				</a>
				<!--
				|
				<a href="http://docs.google.com/viewer?url=${URLEncoder.encode(book.urlToPdf)}&embedded=true" target="_blank">線上檢視</a>
				-->
			</td>
		</g:if>
		<g:if test="${book?.urlToEpub!=null}">
			<td>
				<a href="<g:createBookDownloadLink book='${book}' ext='epub' />">
					<img src="${createLinkTo(dir: 'icons', file: 'mime-epub.png')}" alt="epub-icon" border="0" /><br/>${book?.name}.epub
				</a>
			</td>
		</g:if>
	</tr>
</table>
<p align="right">
<g:link action="cook" id="${book?.id}" class="clickable">Cook It</g:link> (Generate PDF, ePub, ...)
</p>
</g:if>

<g:if test="${book?.isCooking}">
<h3>Unavailable</h3>
<p>This book is printing, wait ...</p>
</g:if>

<h3>Repository</h3>
<table width="600">
	<tr>
		<th width="120">Repository Type</th>
		<td>${book?.type}</td>
	</tr>
	<tr>
		<th>Repository URL</th>
		<td>${book?.url}</td>
	</tr>
</table>

<g:link action="index">Back</g:link>

</body>
</html>
