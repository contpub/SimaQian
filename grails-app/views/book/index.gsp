<h2>Welcome</h2>

<h3>施工中</h3>

<p>開發團隊正在持續爆肝，如果您有任何問題，請過三個月後再說...</p>

<p>右邊、下面，只是假資料</p>

<h3>Books</h3>

<p>
<g:link action="create">Create</g:link>
</p>

<ul>
<g:each in="${books}" var="book">
	<li><g:link action="show" id="${book.id}">${book.title}</g:link></li>
</g:each>
</ul>