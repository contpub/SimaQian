<html>
<head>
<title>Permissions</title>
<socialTag:websnaprSDK />
<resource:richTextEditor />
</head>
<body>
	<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.permission', default: 'Permissions')]" />
	
	<div id="post">
		<div class="right">
			<g:renderErrors bean="${book}" />

			<g:form action="permissionSave" id="${book?.id}">

				<layoutTag:flashMessage />

				<!--display errors-->
				<div class="form-errors">
					<g:renderErrors bean="${book}" as="list" />
				</div>

				<p>
					<g:checkBox name="isPublic" value="${book?.isPublic}" />
					<label for="isPublic"><g:message code="view.publish.form.isPublic" default="Public" /></label>
					<div class="desc"><g:message code="view.publish.form.isPublic.desc" default="make this book public" /></div>
				</p>

				<p class="no-border">
					<div id="message"></div>
					<div id="error"></div>

					<g:submitButton name="create" value="${message(code: 'common.update', default: 'Update')}" class="fancy-button-submit" />
				</p>

			</g:form>
		</div>
		<div class="left">
			<g:render template="leftMenu"></g:render>
		</div>
	</div>
</body>
</html>
