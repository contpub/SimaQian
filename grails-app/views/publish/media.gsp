<html>
<head>
<title><g:message code="view.publish.menu.media" default="Media types" /></title>
</head>
<body>
	<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.media', default: 'Media types')]" />
	
	<div id="post">
		<div class="right">
			<g:renderErrors bean="${book}" />

			<g:form action="mediaSave" id="${book?.id}">

				<layoutTag:flashMessage />

				<!--display errors-->
				<div class="form-errors">
					<g:renderErrors bean="${book}" as="list" />
				</div>

				<!--<p>
					<g:checkBox name="isPublic" value="${book?.isPublic}" />
					<label for="isPublic"><g:message code="view.publish.form.isPublic" default="Public" /></label>
					<div class="desc"><g:message code="view.publish.form.isPublic.desc" default="make this book public" /></div>
				</p>-->

				<p>
					<label for="vhost">Virtual Host</label><br />
					<g:textField name="vhost" value="${book?.vhost}" class="w90p" /><br/>
					Using your DNS manager, create a CNAME alias record to <strong>vhost.contpub.org</strong> for your sub domain (e.g. book.your-domain-name.com).<br/>
					<g:checkBox name="generate" />
					<label for="generate">generate contents</label>
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
