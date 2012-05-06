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
			
		</ul>			
	</userTag:isLogin>
</div>
