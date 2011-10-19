<div class="book-coverImage">
	<g:if test="${book?.hasCover}">
		<img class="cover-image" src="${bookTag.createCoverLink(book: book)}" alt="${book?.title}" />
	</g:if>
	<g:else>
		<img class="cover-image empty" src="${createLinkTo(dir: 'images', file: 'book_cover.png')}" />
		<span class="embedded-title">${book?.title}</span>
	</g:else>
</div>
