<html>
<head>
<title>Account preferences for ${user?.name}</title>
<script type="text/javascript">
$(function () {
	$('#save').click(function () {
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
</script>
<style type="text/css">
img.avatar {
	float: left;
	margin: 5px;
}
</style>
</head>
<body>

<div class="row">
	<div class="span3">
		<avatar:gravatar email="${user?.email}" size="48" />
		<p>Change your avatar at <a href="http://gravatar.com/" target="_blank" title="gravatar">gravatar.com</a><br/>
			We’re using ${user?.email}</p>
	</div>
	<div class="span9">
		<g:hasErrors bean="${user}">
			<div class="alert alert-error">
				<a class="close" data-dismiss="alert" href="#">×</a>
				<h4>Please correct these errors</h4>
				<g:renderErrors bean="${user}" />
			</div>
		</g:hasErrors>
		<g:form action="account" class="form-horizontal">
			<fieldset>
				<legend>${user?.name}</legend>

				<!--email-->
				<div class="control-group ${hasErrors(bean: user, field: 'email', 'error')}">
					<label class="control-label" for="email">E-mail</label>
					<div class="controls">
						<g:textField name="email" value="${user?.email}" class="input-xlarge disabled" disabled="" autocomplete="off" />
					</div>
				</div>

				<!--account-->
				<div class="control-group ${hasErrors(bean: user, field: 'account', 'error')}">
					<label class="control-label" for="account">Username</label>
					<div class="controls">
						<g:textField name="account" value="${user?.account}" class="input-xlarge disabled" disabled="" autocomplete="off" />
					</div>
				</div>
				
				<!--name-->
				<div class="control-group ${hasErrors(bean: user, field: 'name', 'error')}">
					<label class="control-label" for="name">Display Name</label>
					<div class="controls">
						<g:textField name="name" value="${user?.name}" class="input-xlarge" autocomplete="off" />
						<p class="help-block">Please enter your real name or nickname.</p>
					</div>
				</div>
				
				<!--password-->
				<div class="control-group ${hasErrors(bean: user, field: 'password', 'error')}">
					<label class="control-label" for="password">Password</label>
					<div class="controls">
						<g:passwordField name="password" value="" class="input-medium" autocomplete="off" /><br />
					</div>
				</div>

				<!--confirm-password-->
				<div class="control-group ${hasErrors(bean: user, field: 'password', 'error')}">
					<label class="control-label" for="password2">Confirm Password</label>
					<div class="controls">
						<g:passwordField name="password2" value="" class="input-medium" autocomplete="off" /><br />
						<p class="help-block">If you do not want to change your password, leave it blank.</p>
					</div>
				</div>

				<!--description-->
				<div class="control-group ${hasErrors(bean: user, field: 'description', 'error')}">
					<label class="control-label" for="description">Description</label>
					<div class="controls">
						<g:textArea name="description" value="${user?.profile?.description}" class="input-xlarge" rows="5" />
					</div>
				</div>

				<!--homepage-->
				<div class="control-group ${hasErrors(bean: user?.profile, field: 'homepage', 'error')}">
					<label class="control-label" for="homepage">Homepage</label>
					<div class="controls">
						<g:textField name="homepage" value="${user?.profile?.homepage}" class="input-xlarge" />
						<p class="help-block">e.g. http://about.me/${user?.account}</p>
					</div>
				</div>

				<!--blog-->
				<div class="control-group ${hasErrors(bean: user?.profile, field: 'blog', 'error')}">
					<label class="control-label" for="blog">Blog</label>
					<div class="controls">
						<g:textField name="blog" value="${user?.profile?.blog}" class="input-xlarge" />
						<p class="help-block">e.g. http://${user?.account}.blogspot.com/</p>
					</div>
				</div>

				<!--actions-->
				<div class="form-actions">
					<g:submitButton name="save" value="Save" class="btn btn-primary" />
					<g:link action="index" class="btn">Cancel</g:link>
				</div>
			</fieldset>
		</g:form>
	</div>
</div>

</body>
</html>
