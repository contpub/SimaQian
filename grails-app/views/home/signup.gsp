<html>
<head>
<title>Sign up</title>
<r:script>
$(function() {
	$('#signup').click(function () {
		var result = true;
		var password_val = $('#password').val();
		var password2_val = $('#password2').val();
		
		if (password_val != '' && password_val != password2_val) {
			result = false;
			alert('Password not match!');
			$('#password2').focus();
		}
		
		return result;
	});
	
	$('.control-group.error input').focus();
});
</r:script>
</head>
<body>
<div class="row">
	<div class="span4">
		<p></p>
		<p>Our site has ${usernums} members.Welcome to join us to enjoy the fun of reading and writing. The following are the rights of membership:</p>
		<ul>
			<li>Buy a book from ${booknums} publications</li>
			<li>Write a book and self-publish</li>
			<li>Receive special offers</li>
		</ul>
	</div>
	<div class="span8">
		<g:hasErrors bean="${user}">
			<div class="alert alert-error">
				<a class="close" data-dismiss="alert" href="#">×</a>
				<h4>Please correct these errors</h4>
				<g:renderErrors bean="${user}" />
			</div>
		</g:hasErrors>
		<g:form action="signup" class="form-horizontal">
			<fieldset>
				<legend>Free Sign up</legend>

				<!--email-->
				<div class="control-group ${hasErrors(bean: user, field: 'email', 'error')}">
					<label class="control-label" for="email">E-mail</label>
					<div class="controls">
						<g:textField name="email" value="${user?.email}" class="input-xlarge" autocomplete="off" />
						<p class="help-block">Your e-mail address.</p>
					</div>
				</div>

				<!--account-->
				<div class="control-group ${hasErrors(bean: user, field: 'account', 'error')}">
					<label class="control-label" for="account">Username</label>
					<div class="controls">
					<g:textField name="account" value="${user?.account}" class="input-xlarge" autocomplete="off" />
					<p class="help-block">e.g. john2011</p>
					</div>
				</div>
				
				<!--name-->
				<div class="control-group ${hasErrors(bean: user, field: 'name', 'error')}">
					<label class="control-label" for="name">Display Name</label>
					<div class="controls">
					<g:textField name="name" value="${user?.name}" class="input-xlarge" autocomplete="off" />
					<p class="help-block">e.g. Peter Druker</p>
					</div>
				</div>
				
				<!--password-->
				<div class="control-group ${hasErrors(bean: user, field: 'password', 'error')}">
					<label class="control-label" for="password">Password</label>
					<div class="controls">
					<g:passwordField name="password" value="${user?.password}" class="input-xlarge" autocomplete="off" /><br />
					</div>
				</div>

				<!--confirm-password-->
				<div class="control-group ${hasErrors(bean: user, field: 'password', 'error')}">
					<label class="control-label" for="password2">Confirm Password</label>
					<div class="controls">
					<g:passwordField name="password2" value="" class="input-xlarge" autocomplete="off" /><br />
					<p class="help-block">Please enter the password twice.</p>
					</div>
				</div>

				<!--actions-->
				<div class="form-actions">
					<g:submitButton name="signup" value="Sign up" class="btn btn-primary" />
					<g:link action="index" class="btn">Cancel</g:link>
				</div>
			</fieldset>
		</g:form>
	</div>
</div>
</body>
</html>
