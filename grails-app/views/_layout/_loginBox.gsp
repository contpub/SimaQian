<div class="loginBox">
	<g:form controller="home" action="login" class="login-form">
		E-mail: <br /><g:textField name="email" value="" /><br />
		Password: <br /><g:passwordField name="password" value="" /><br />
		<g:submitButton name="login" value="Login" class="button" />
		or <g:link controller="home" action="signup">Sign up</g:link>
	</g:form>
</div>