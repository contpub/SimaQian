<html>
<head>
<title>Update book info</title>
<socialTag:websnaprSDK />
<resource:richTextEditor />
</head>
<body>
	<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.update', default: 'Basic settings')]" />
	<div id="post">
		<div class="right">
			<g:form action="updateSave" id="${book?.id}">
				
				<layoutTag:flashMessage />
				
				<!--display errors-->
				<div class="form-errors">
					<g:renderErrors bean="${book}" as="list" />
				</div>

				<!--form emelments-->
				<p class="no-border"><span class="required">*</span> = required</p>
				<p>
					<label for="title">Book Title</label><span class="required">*</span><br />
					<g:textField name="title" value="${book?.title}" class="w90p" />
				</p>
				<p>
					<label for="title">Subtitle</label><br />
					<g:textField name="subtitle" value="${book?.subtitle}" class="w90p" />
				</p>
				<p>
					<label for="authors">Authors</label><br />
					<g:textField name="authors" value="${book?.authors}" class="w90p" />
				</p>
				<p>
					<label for="description">Brief Description</label><br />
					<richui:richTextEditor name="description" value="${book?.profile?.description}" width="450" />
				</p>
				<g:if test="${book?.type==org.contpub.simaqian.RepoType.GIT}">
					<p>
						<label for="url">Url</label><br/>
						<g:textField name="url" value="${book?.url}" class="w90p" />
					</p>
				</g:if>
				<p class="no-border">
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
