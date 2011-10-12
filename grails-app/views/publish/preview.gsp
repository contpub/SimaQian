<html>
<head>
	<title>Publish preview</title>
	<style type="text/css">
	#contents {
		width: 98%;
		height: 360px;
		font-size: 13px;
		resize: none;
	}
	</style>
	<script type="text/javascript">
	</script>
</head>
<body>
	<g:render template="breadcrumbs" model="[title: 'Preview contents']" />
	
	<div id="post">
		<div class="right">
			<label for="contents">Preview contents</label><br />
			<g:textArea name="contents" value="${book?.contents}" disabled="true" />
			<br/>
			<g:link action="cook" id="${book?.id}" class="clickable">Publish</g:link>
			(generates ${book?.name}.pdf, ${book?.name}.epub)
		</div>
		<div class="left">
			<g:render template="leftMenu"></g:render>
		</div>
	</div>
</body>
</html>
