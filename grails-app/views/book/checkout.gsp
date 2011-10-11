<html>
<head>
	<title>Checkout ${book?.title}</title>
	<style type="text/css">
	.checkout-confirm {
		font-size: 1.25em;
	}
	.checkout-confirm a {
		font-size: 1.5em;
	}
	</style>
</head>
<body>

	<div class="breadcrumbs">
		<g:link action="index">Books</g:link>
		&gt;
		<g:link action="show" id="${book.id}">${book.title}</g:link>
		&gt;
		checkout
	</div>

	<h2>${book?.title}</h2>
	<p class="checkout-confirm">
		Are you sure to buy this book?
		<g:link action="checkoutSave" id="${book.id}">Yes</g:link>
		or
		<g:link action="show" id="${book.id}">No</g:link>
	</p>
</body>
</html>
