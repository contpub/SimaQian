<div class="book-coverImage">
	<g:if test="${book?.profile?.cover}">
		<img class="cover-image" src="${book?.profile?.cover}" alt="${book?.title}" />
	</g:if>
	<g:else>
		<span class="embedded-title">${book?.title}</span>
		<img class="cover-image empty" src="${createLinkTo(dir: 'images', file: 'book_cover.png')}" />
	</g:else>
</div>
