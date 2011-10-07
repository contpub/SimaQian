<html>
<head>
	<title>Sign up</title>
</head>
<body>

	<h2>Register</h2>

	<g:renderErrors bean="${user}" />

	<g:form action="signupSave">
		<p class="no-border"><strong>Feel free to fill everything</strong></p>

		<p>
			<label for="email">Email</label><br />
			<g:textField name="email" value="${user?.email}" />
		</p>

		<p>
			<label for="account">Account</label> (ex. john2011)<br />
			<g:textField name="account" value="${user?.account}" />
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
			<g:submitButton name="signup" value="Sign up" class="button" />
		</p>

	</g:form>

</body>
</html>
