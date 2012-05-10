<html>
<head>
<title>Sandbox</title>
<r:require modules="codemirror" />
<layoutTag:webFonts family="Droid+Sans+Mono" />
<style type="text/css">
.CodeMirror {
	font-family: 'Droid Sans Mono', monospace, courier, sans-serif;
	font-size: 11pt;
	height: 30em;
}
.CodeMirror-scroll {
	width: 100%;
	height: 100%;
}
</style>
<r:script>
$(function() {
	$('#contents').codemirror({
		mode: 'rst',
		lineNumbers: true,
		lineWrapping: true
	});
});
</r:script>
</head>
<body>
<ul class="breadcrumb">
	<li>
		<g:link action="list">Sandbox</g:link>
		<span class="divider">/</span>
	</li>
	<g:if test="${sandbox?.id}"><li>
		<g:link action="show" id="${sandbox.id}">${sandbox.title}</g:link>
		<span class="divider">/</span>
	</li></g:if>
	<li class="active">Editing</li>
</ul>
<g:form action="publish" id="${sandbox?.id}" class="form-horizontal">
	<fieldset>
		<!--title-->
		<div class="control-group">
			<label class="control-label" for="title">Title</label>
			<div class="controls">
				<g:textField name="title" value="${sandbox?.title}" class="input-xlarge" />
			</div>
		</div>

		<!--authors-->
		<div class="control-group">
			<label class="control-label" for="authors">Authors</label>
			<div class="controls">
				<g:textField name="authors" value="${sandbox?.authors}" class="input-xlarge" />
			</div>
		</div>

		<!--contents-->
		<div class="control-group">
			<label class="control-label" for="contents">Source Code</label>
			<div class="controls">
				<g:textArea name="contents" value="${sandbox?.contents}" />
			</div>
		</div>

		<!--actions-->
		<div class="form-actions">
			<g:submitButton name="publish" value="Publish" class="btn btn-primary" />
			<g:if test="${sandbox?.id}">
				<g:link action="show" id="${sandbox?.id}" class="btn">Cancel</g:link>
			</g:if>
			<g:else>
				<g:link action="list" class="btn">Cancel</g:link>
			</g:else>
		</div>
	</fieldset>
</g:form>
</body>
</html>
