<!--header -->
<div id="header-wrap"><div id="header">
	<a name="top"></a>
	<h1 id="logo-text"><a href="${createLink(controller: 'home')}" title="Index">${grailsApplication.config.appConf.title}</a></h1>
	<p id="slogan">${grailsApplication.config.appConf.subTitle}</p>
	<div  id="nav">
		<ul>
			<li id="${controllerName.equals('home')?'current':'candidate'}">
				<g:link controller="home">
					<g:message code="layout.header.home.label" default="Home"/>
				</g:link>
			</li>
			<li id="${controllerName.equals('explore')?'current':'candidate'}">
				<g:link controller="explore">
					<g:message code="layout.header.explore.label" default="Explore"/>
				</g:link>
			</li>
			<li id="${controllerName.equals('book')&&!actionName.equals('create')?'current':'candidate'}">
				<g:link controller="book">
					<g:message code="layout.header.book.label" default="Books"/>
				</g:link>
			</li>
			<g:isUser>
				<li id="${controllerName.equals('book')&&actionName.equals('create')?'current':'candidate'}">
					<g:link controller="book" action="create">
						<g:message code="layout.header.publish.label" default="Publish"/>
					</g:link>
				</li>
			</g:isUser>
			
			<!--<li id="${controllerName.equals('explorer')?'current':'candidate'}"><g:link controller="explorer">Explorer</g:link></li>
			<li id="${controllerName.equals('support')?'current':'candidate'}"><g:link controller="support">Support</g:link></li>
			<li id="${controllerName.equals('about')?'current':'candidate'}"><g:link controller="about">About</g:link></li>-->
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
<!--/header-->
</div></div>
