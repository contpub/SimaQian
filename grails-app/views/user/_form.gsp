<%@ page import="org.contpub.simaqian.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="user.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" required="" value="${userInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'account', 'error')} required">
	<label for="account">
		<g:message code="user.account.label" default="Account" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="account" maxlength="20" pattern="${userInstance.constraints.account.matches}" required="" value="${userInstance?.account}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" maxlength="15" required="" value="${userInstance?.password}"/>
</div>

