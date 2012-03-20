<div class="loginBox">
	<g:form controller="home" action="login" class="login-form">
		E-mail: <br /><g:textField name="loginEmail" value="${flash.loginEmail}" /><br />
		Password: <br /><g:passwordField name="loginPassword" value="" autocomplete="off" /><br />
		<g:submitButton name="login" value="Login" class="button" />
		or <g:link controller="home" action="signup">Sign up</g:link>
		<g:hiddenField name="forwardURI" value="${request.forwardURI}" />
	</g:form>
	<g:if test="${flash.loginErrors}">
		<p class="errors">${flash.loginErrors}</p>
	</g:if>
</div>
<r:script>
$(function() {
	$('#loginEmail').focus();
});
</r:script>