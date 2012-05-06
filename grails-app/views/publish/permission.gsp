<html>
<head>
<title>Permissions</title>
</head>
<body>
<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.permission', default: 'Permissions')]" />
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
		<g:form action="permission" id="${book?.id}" class="form-horizontal">
			<fieldset>
				<!--isPublic-->
				<div class="control-group ${hasErrors(bean: book, field: 'isPublic', 'error')}">
					<label class="control-label">Permissions</label>
					<div class="controls">
						<label class="checkbox" for="isPublic"><g:checkBox name="isPublic" value="${book?.isPublic}" /><g:message code="view.publish.form.isPublic" default="Public" /></label>
						<p class="help-block"><g:message code="view.publish.form.isPublic.desc" default="Anyone can access this book." /></p>
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
