<div id="header-wrap"><div id="header">
	<a name="top"></a>
	<span class="beta">beta</span>
	<h1 id="logo-text"><a href="${createLink(controller: 'home')}" title="Index">${grailsApplication.config.appConf.title}</a></h1>
	<p id="slogan">${grailsApplication.config.appConf.subTitle}</p>
	<div id="nav">
		<ul>
			<li id="${pageProperty(name: 'currentAction')=='home'?'current':'candidate'}">
				<g:link controller="home">
					<g:message code="layout.header.home.label" default="Home"/>
				</g:link>
			</li>
			<li id="${pageProperty(name: 'currentAction')=='explore'?'current':'candidate'}">
				<g:link controller="explore">
					<g:message code="layout.header.explore.label" default="Explore"/>
				</g:link>
			</li>
			<userTag:isLogin>
				<li id="${pageProperty(name: 'currentAction')=='book'?'current':'candidate'}">
					<g:link controller="book">
						<g:message code="layout.header.book.label" default="Books"/>
					</g:link>
				</li>
				<li id="${pageProperty(name: 'currentAction')=='publish'?'current':'candidate'}">
					<g:link controller="publish">
						<g:message code="layout.header.publish.label" default="Publish"/>
					</g:link>
				</li>
			</userTag:isLogin>
			<li id="${pageProperty(name: 'currentAction')=='sandbox'?'current':'candidate'}">
				<g:link controller="sandbox" class="highlight">
					<g:message code="layout.header.sandbox.label" default="Sandbox"/>
					<span class="new">New</span>
				</g:link>
			</li>
		</ul>
	</div>
	<p id="rss">
		<a href="#">Grab the RSS feed</a>
	</p>
	<form id="quick-search" method="get" action="#" style="display:none">
		<fieldset class="search">
		<label for="qsearch">Search:</label>
		<input class="tbox" id="qsearch" type="text" name="qsearch" value="Search..." title="Start typing and hit ENTER" />
		<button class="btn" title="Submit Search" disabled>Search</button>
		</fieldset>
	</form>
</div></div>
