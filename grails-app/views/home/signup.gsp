<html>
<head>
	<title>Sign up</title>
	<style type="text/css">
	form #account, form #password, form #password2 {
		width: 180px;
	}
	form #email, form #name {
		width: 95%;
	}
	</style>
	<script type="text/javascript">
	$(function () {
		$('form #signup.button').click(function () {
			var result = true;
			var password_val = $('form #password').val();
			var password2_val = $('form #password2').val();
			
			if (password_val != '' && password_val != password2_val) {
				result = false;
				alert('Password not match!');
				$('form #password2').focus();
			}
			
			return result;
		});
		
		$('form input.errors').focus();
	});
	</script>
</head>
<body>

	<h2>Register</h2>

	<g:renderErrors bean="${user}" />

	<g:form action="signupSave">
		<p class="no-border"><strong>Feel free to fill everything</strong></p>

		<p>
			<label for="email">Email</label><br />
			<g:textField name="email" value="${user?.email}" autocomplete="off" />
		</p>

		<p>
			<label for="account">Account</label> (ex. john2011)<br />
			<g:textField name="account" value="${user?.account}" autocomplete="off" />
		</p>
		
		<p>
			<label for="name">Display Name</label> (ex. Peter Druker)<br />
			<g:textField name="name" value="${user?.name}" autocomplete="off" />
		</p>
		
		<p>
			<label for="password">Password</label><br />
			<g:passwordField name="password" value="${user?.password}" autocomplete="off" /><br />
			<g:passwordField name="password2" value="" autocomplete="off" /> (confirm your new password)
		</p>

		<p class="no-border">
			<g:submitButton name="signup" value="Sign up" class="button" />
		</p>

	</g:form>

</body>
</html>
