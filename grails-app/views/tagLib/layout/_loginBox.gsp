<div class="loginBox">
	<g:form controller="home" action="login" class="login-form">
		E-mail: <br /><input id="email" name="email" type="email" value="" /><br />
		Password: <br /><g:passwordField name="password" value="" autocomplete="off" /><br />
		<g:submitButton name="login" value="Login" class="button" />
		or <g:link controller="home" action="signup">Sign up</g:link>
		<g:hiddenField name="forwardURI" value="${request.forwardURI}" />
	</g:form>
	<g:if test="${flash.loginErrors}">
		<p class="errors">${flash.loginErrors}</p>
	</g:if>
</div>
