<nav class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container">
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</a>
			<a class="brand" href="/">ContPub</a>
			<userTag:isNotLogin><div class="pull-right">
				<g:form controller="home" action="login" class="form-inline" style="margin:0;padding:0">
					<g:textField name="loginEmail" value="${flash.loginEmail}" class="input-medium" placeholder="Username or e-mail" />
					<g:passwordField name="loginPassword" value="" autocomplete="off" class="input-small" placeholder="Password" />
					<g:submitButton name="login" value="Sign in" class="btn btn-primary" />
					<g:link controller="home" action="signup" class="btn btn btn-success">Sign up</g:link>
				</g:form>
				<r:script>$('#loginEmail').focus();</r:script>
			</div></userTag:isNotLogin>
			<userTag:isLogin>
				<div class="btn-group pull-right">
					<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
						<i class="icon-user"></i> ${session.userName}
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li>
							<g:link controller="publish" action="index">
								<i class="icon-book"></i>
								<g:message code="common.myCreations" default="Publications" />
							</g:link>
						</li>
						<li>
							<g:link controller="sandbox" action="user">
								<i class="icon-pencil"></i>
								<g:message code="common.mySandbox" default="Sandbox" />
							</g:link>
						</li>
						<li>
							<g:link controller="home" action="account">
								<i class="icon-wrench"></i>
								<g:message code="common.myAccount" default="Account preferences" />
							</g:link>
						</li>
						<li class="divider"></li>
						<li>
							<g:link controller="home" action="logout" onclick="return confirm('${message(code: 'home.logout.confirm', default: 'Are you sure???')}');">
								<i class="icon-minus-sign"></i>
								<g:message code="layout.header.logout.label" default="Sign out" />
							</g:link>
						</li>
					</ul>
				</div>
			</userTag:isLogin>
			<div class="nav-collapse">
				<ul class="nav">
					<li class="${controllerName=='home'?'active':''}">
						<g:link controller="home" action="index">
							<g:message code="layout.header.home.label" default="Home"/>
						</g:link>
					</li>
					<li class="${controllerName=='explore'?'active':''}">
						<g:link controller="explore" action="index">
							<g:message code="layout.header.explore.label" default="Explore"/>
						</g:link>
					</li>
					<userTag:isLogin>
						<li class="${controllerName=='book'?'active':''}">
							<g:link controller="book" action="index">
								<g:message code="layout.header.book.label" default="Books"/>
							</g:link>
						</li>
						<li class="${controllerName=='publish'?'active':''}">
							<g:link controller="publish" action="index">
								<g:message code="layout.header.publish.label" default="Publish"/>
							</g:link>
						</li>
						<li class="${controllerName=='sandbox'?'active':''}">
							<g:link controller="sandbox" action="publish">
								<g:message code="layout.header.sandbox.label" default="Sandbox"/>
							</g:link>
						</li>
					</userTag:isLogin>
				</ul>
			</div>
		</div>
	</div>
</nav>
<div class="container">
<g:if test="${flash.alertType}"><div class="alert alert-${flash.alertType}"><a class="close" data-dismiss="alert" href="#">×</a>${flash.alertMessage}</div></g:if>
<g:if test="${flash.type}"><div class="alert alert-${flash.type}"><a class="close" data-dismiss="alert" href="#">×</a><g:message code="${flash.message}" args="${flash.args}" default="${flash.default}"/></div></g:if>
</div>