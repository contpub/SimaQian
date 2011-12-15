<div class="breadcrumbs">
	<userTag:isLogin>
		<g:link controller="book" action="index">Books</g:link>
	</userTag:isLogin>
	<userTag:isNotLogin>
		Books
	</userTag:isNotLogin>
	&gt;
	<bookTag:link book="${book}" />
	&gt;
	${title}
</div>
