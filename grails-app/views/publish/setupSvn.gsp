<html>
<head>
<title>Setup SVN Repository</title>
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
	
	<div id="post">
		<div class="right">
			<g:renderErrors bean="${book}" />

			<g:form action="setupSvnSave" id="${book?.id}">

				<layoutTag:flashMessage />

				<!--display errors-->
				<div class="form-errors">
					<g:renderErrors bean="${book}" as="list" />
				</div>

				<p>
					<label for="url">SVN Repository Url</label><br/>
					<g:textField name="url" value="${book?.url}" class="w90p" /><br/>
					e.g. svn://server/book1
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
