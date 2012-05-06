<html>
<head>
<title>Update ${book?.title}</title>
<socialTag:websnaprSDK />
<r:require modules="tinymce" />
<r:script>
$(function() {
    $('textarea.tinymce').tinymce({
        script_url : '/tiny_mce/tiny_mce.js',
        theme : "simple"
    });
});
</r:script>
</head>
<body>
<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.update', default: 'Basic settings')]" />
<div class="row">
	<div class="span3">
		<g:render template="leftMenu" />
	</div>
	<div class="span9">
		<g:hasErrors bean="${book}">
			<div class="alert alert-error">
				<a class="close" data-dismiss="alert" href="#">×</a>
				<h4>Please correct these errors</h4>
				<g:renderErrors bean="${book}" as="list" />
			</div>
		</g:hasErrors>
		<g:form action="update" id="${book?.id}" class="form-horizontal">
			<fieldset>
				<!--title-->
				<div class="control-group ${hasErrors(bean: book, field: 'title', 'error')}">
					<label class="control-label" for="title">Book Title</label>
					<div class="controls">
						<g:textField name="title" value="${book?.title}" class="input-xlarge" />
						<!--<p class="help-block"></p>-->
					</div>
				</div>

				<!--subtitle-->
				<div class="control-group ${hasErrors(bean: book, field: 'subtitle', 'error')}">
					<label class="control-label" for="subtitle">Subtitle</label>
					<div class="controls">
						<g:textField name="subtitle" value="${book?.subtitle}" class="input-xlarge" />
					</div>
				</div>

				<!--authors-->
				<div class="control-group ${hasErrors(bean: book, field: 'authors', 'error')}">
					<label class="control-label" for="authors">Authors</label>
					<div class="controls">
						<g:textField name="authors" value="${book?.authors}" class="input-medium" />
					</div>
				</div>

				<!--description-->
				<div class="control-group ${hasErrors(bean: book?.profile, field: 'description', 'error')}">
					<label class="control-label" for="description">Brief Description</label>
					<div class="controls">
						<g:textArea name="description" value="${book?.profile?.description}" class="tinymce input-xlarge" rows="10" />
					</div>
				</div>

				<!--actions-->
				<div class="form-actions">
					<g:submitButton name="update" value="Update" class="btn btn-primary" />
					<bookTag:link book="${book}" class="btn">Cancel</bookTag:link>
				</div>
			</fieldset>
		</g:form>
	</div>
</div>
</body>
</html>
