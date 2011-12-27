<div class="userBox">
	<userTag:isNotLogin>
		<layoutTag:loginBox />
	</userTag:isNotLogin>
	<userTag:isLogin>
		<div class="user-info">
			<avatar:gravatar email="${user?.email}" size="48" />
			${user?.name}<br/>
			${user?.email}
		</div>
		<ul>
			<li>
				<g:link controller="home" action="logout" onclick="return confirm('Are you sure???');">
					<g:message code="common.logout" default="Logout" />
				</g:link>
			</li>
			<li>
				<g:link controller="home" action="account">
					<g:message code="common.myAccount" default="My Account" />
				</g:link>
			</li>
			<li>
				<g:link controller="sandbox" action="user">
					<g:message code="common.mySandbox" default="My Sandbox" />
				</g:link>
			</li>
		</ul>			
	</userTag:isLogin>
</div>
