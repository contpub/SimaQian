<html>
<head>
	<title>Account</title>
	<style type="text/css">
	form img.avatar {
		float: left;
		margin: 5px;
		background-color: white;
	}
	form #description {
		width: 95%;
		height: 250px;
	}
	form #account, form #password, form #password2 {
		width: 180px;
	}
	form #email, form #name, form #homepage, form #blog {
		width: 95%;
	}
	form input.errors {
		border: 1px solid red;
	}
	</style>
	<script type="text/javascript">
	$(function () {
		$('form #save.button').click(function () {
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
	<g:renderErrors bean="${user}" />

	<g:form action="accountSave" id="${user.id}">
		<p class="no-border"><strong>Change your account setting</strong></p>
		<avatar:gravatar email="${session['user'].email}" size="48" />
		<p class="avatar-info">
			Change your avatar at <a href="gravatar.com" title="gravatar">gravatar.com</a><br/>
			We’re using lyhcode@gmail.com
			<div style="clear:both"></div>
		</p>
		<p>
			<label for="account">Login account</label><br />
			<g:textField name="account" value="${user?.account}" disabled="" />
		</p>	
		<p>
			<label for="email">Email</label><br />
			<g:textField name="email" value="${user?.email}" disabled="" />
		</p>	
		<p>
			<label for="name">Name</label> (Full name or nick name)<br />
			<g:textField name="name" value="${user?.name}" />
		</p>
		<p>
			<label for="password">Password</label> (If you don't want to change, just leave blank.)<br />
			<g:passwordField name="password" value="" /><br/>
			<g:passwordField name="password2" value="" /> Type again.
		</p>
		<p>
			<label for="description">Description</label><br />
			<g:textArea name="description" value="${user?.profile?.description}" />		
		</p>	
		<p>
			<label for="homepage">Homepage</label> (ex. http://about.me/${user?.account})<br />
			<g:textField name="homepage" value="${user?.profile?.homepage}" class="${hasErrors(bean: user, field: 'homepage', 'errors')}" />
		</p>
		<p>
			<label for="blog">Blog</label><br />
			<g:textField name="blog" value="${user?.profile?.blog}" class="${hasErrors(bean: user, field: 'blog', 'errors')}" />
		</p>	
		<p class="no-border">
			<g:submitButton name="save" value="Save" class="button wide" />
			<g:link action="index">Cancel</g:link>
		</p>
	</g:form>
</body>
</html>
