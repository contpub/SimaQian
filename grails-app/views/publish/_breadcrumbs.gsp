<ul class="breadcrumb">
	<li>
		<g:link controller="book" action="index">Books</g:link>
		<span class="divider">/</span>
	</li>
	<userTag:isLogin>
		<li>
			<bookTag:link book="${book}" />
			<span class="divider">/</span>
		</li>
	</userTag:isLogin>
	<userTag:isNotLogin>
		<li>
			${book?.title}
			<span class="divider">/</span>
		</li>
	</userTag:isNotLogin>
	<li class="active">${title}</li>
</ul>
