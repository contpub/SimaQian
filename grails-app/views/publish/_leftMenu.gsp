<ul class="nav nav-pills nav-stacked">
	<li class="${actionName=='update'?'active':''}">
		<g:link action="update" id="${book?.id}">
			<i class="icon-cog"></i>
			<g:message code="view.publish.menu.update" default="Basic settings" /></g:link>
	</li>
	<li class="${actionName=='cover'?'active':''}">
		<g:link action="cover" id="${book?.id}">
			<i class="icon-cog"></i>
			<g:message code="view.publish.menu.cover" default="Change cover image" />
		</g:link>
	</li>
	<li class="${actionName=='mode'?'active':''}">
		<g:link action="mode" id="${book?.id}">
			<i class="icon-cog"></i>
			<g:message code="view.publish.menu.mode" default="Authoring modes" />
		</g:link>
	</li>
	<li class="${actionName=='media'?'active':''}">
		<g:link action="media" id="${book?.id}">
			<i class="icon-cog"></i>
			<g:message code="view.publish.menu.media" default="Media types" />
		</g:link>
	</li>
	<li class="${actionName=='reader'?'active':''}">
		<g:link action="reader" id="${book?.id}">
			<i class="icon-cog"></i>
			<g:message code="view.publish.menu.reader" default="Readers" />
		</g:link>
	</li>
	<li class="${actionName=='permission'?'active':''}">
		<g:link action="permission" id="${book?.id}">
			<i class="icon-cog"></i>
			<g:message code="view.publish.menu.permission" default="Permissions" />
		</g:link>
	</li>
</ul>