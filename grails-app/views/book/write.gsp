<html>
<head>
<title>Writing</title>
<style>
form { width:auto; }
form #contents {
	width: 100%;
	height: 480px;
}
</style>
</head>
<body>

	<h2>Write a book</h2>
	
	<g:renderErrors bean="${book}" />

	<g:form action="saveWrite" id="${book.id}">
	
		<h3>${book.title}</h3>

		<p>
			<label for="contents">Book contents</label><br />
			<g:textArea name="contents" value="${book?.contents}" />
		</p>

		<!-- Defaults -->

		<p class="no-border">
			<g:submitButton name="save" value="Save" class="button" />
			<g:link action="show" id="${book.id}">Back</g:link>
		</p>

	</g:form>
	
	<content tag="sidebar">
		<div class="sidemenu">
			<h3>Steps</h3>
			<ol>
				<li><strong>Thinking</strong></li>
				<li>Writing</li>
				<li>Publishing</li>
			</ol>
		</div>
	</content>
</body>
</html>
