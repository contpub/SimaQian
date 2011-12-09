<p class="icon">
	<img src="${createLinkTo(dir: 'images', file: 'book_icon.png')}" class="book-icon" />
</p>
<div class="post-meta">
	<ul>
		<li>${book.title}</li>
		<li><g:link action="update" id="${book?.id}">基本設定</g:link></li>
		<li><g:link action="mode" id="${book?.id}">切換編輯模式</g:link></li>
		<!--<li><g:link action="write" id="${book?.id}" fragment="editing">Write contents</g:link></li>
		<li><g:link action="preview" id="${book?.id}">Publish</g:link></li>-->
	</ul>
</div>
