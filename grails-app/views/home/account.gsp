<html>
<head>
	<title>Account</title>
</head>
<body>
	<h2>Account</h2>

	<g:renderErrors bean="${user}" />

	<g:form action="accountSave" id="${user.id}">
		<p class="no-border"><strong>Change your account setting</strong></p>
		<p>
			<label for="email">Email</label><br />
			<g:textField name="email" value="${user?.email}" />
		</p>
		<p>
			<label for="name">Name</label> (ex. Peter Druker)<br />
			<g:textField name="name" value="${user?.name}" />
		</p>
		<p>
			<label for="password">Password</label><br />
			<g:passwordField name="password" value="${user?.password}" />
		</p>
		<p class="no-border">
			<g:submitButton name="save" value="Save" class="button" />
		</p>
	</g:form>
</body>
</html>
