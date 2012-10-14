<html>
<head>
<title>Setup Git Repository</title>
<socialTag:websnaprSDK />
<resource:richTextEditor />
<r:script>
$(function() {
	var callback = function() {
		$('#url').val('git://github.com/'+$('#ghuser').val()+'/'+$('#ghname').val()+'.git');
	};

	$('#ghuser,#ghname').keyup(function() {
		callback();
	});
});
</r:script>
</head>
<body>
<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.permission', default: 'Permissions')]" />
<div class="row">
	<div class="span3">
		<g:render template="leftMenu" />
	</div>
	<div class="span9">
		<g:renderErrors bean="${book}" />

		<g:form action="setupGitSave" id="${book?.id}" class="form-horizontal">
			<fieldset>
				<layoutTag:flashMessage />

				<!--display errors-->
				<div class="form-errors">
					<g:renderErrors bean="${book}" as="list" />
				</div>

				<div class="control-group">
					<label class="control-label">GitHub Repository</label>
					<div class="controls">
						<label for="url">User or Organization</label>
						<g:textField name="ghuser" value="" class="input-medium" />
						<label for="url">Repository</label>
						<g:textField name="ghname" value="" class="input-medium" />
					</div>
				</div>

				<div class="control-group">
					<label class="control-label" for="url">Git Repository Url</label>
					<div class="controls">
						<g:textField name="url" value="${book?.url}" class="input-xlarge" />
					</div>
				</div>

				<!--actions-->
				<div class="form-actions">
					<div id="message"></div>
					<div id="error"></div>

					<g:submitButton name="create" value="${message(code: 'common.update', default: 'Update')}" class="btn btn-primary" />
					<g:link controller="publish" action="mode" id="${book?.id}">Cancel</g:link>
				</div>

					
			</fieldset>
		</g:form>
	</div>
</div>
</body>
</html>
