<div class="userBox">
	<g:isNotUser>
		<g:layoutLoginBox />
	</g:isNotUser>
	<g:isUser>
		<div class="user-info">
			<avatar:gravatar email="${session['user'].email}" size="48" />
			${session['user'].name}<br/>
			${session['user'].email}
		</div>
		<ul>
			<li><g:link controller="home" action="logout" onclick="return confirm('Are you sure???');">Logout</g:link></li>
			<li><g:link controller="home" action="account">My Account</g:link></li>
		</ul>			
	</g:isUser>
</div>