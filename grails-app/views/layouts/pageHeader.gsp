<div id="header-wrap"><div id="header">
	<a name="top"></a>
	<h1 id="logo-text"><a href="${createLink(controller: 'home')}" title="Index">${grailsApplication.config.appConf.title}</a></h1>
	<p id="slogan">${grailsApplication.config.appConf.subTitle}</p>
	<div  id="nav">
		<ul>
			<li id="${pageProperty(name: 'meta.current.action')=='home'?'current':'candidate'}">
				<g:link controller="home">
					<g:message code="layout.header.home.label" default="Home"/>
				</g:link>
			</li>
			<li id="${pageProperty(name: 'meta.current.action')=='explore'?'current':'candidate'}">
				<g:link controller="explore">
					<g:message code="layout.header.explore.label" default="Explore"/>
				</g:link>
			</li>
			<li id="${pageProperty(name: 'meta.current.action')=='book'?'current':'candidate'}">
				<g:link controller="book">
					<g:message code="layout.header.book.label" default="Books"/>
				</g:link>
			</li>
			<userTag:isLogin>
				<li id="${pageProperty(name: 'meta.current.action')=='publish'?'current':'candidate'}">
					<g:link controller="publish">
						<g:message code="layout.header.publish.label" default="Publish"/>
					</g:link>
				</li>
			</userTag:isLogin>
		</ul>
	</div>
	<p id="rss">
		<a href="#">Grab the RSS feed</a>
	</p>
	<form id="quick-search" method="get" action="#">
		<fieldset class="search">
		<label for="qsearch">Search:</label>
		<input class="tbox" id="qsearch" type="text" name="qsearch" value="Search..." title="Start typing and hit ENTER" />
		<button class="btn" title="Submit Search" disabled>Search</button>
		</fieldset>
	</form>
</div></div>
