<html>
<head>
	<title>Processing</title>
	<meta HTTP-EQUIV="REFRESH" content="10; url=${createLink(action: 'checkCook', id: book.id)}">
	<script type="text/javascript">
	$(function() {
			var sec = 10
		
			var timer = function () {
				window.setTimeout(function () {		
						if (--sec > 0) {
							timer();
						}
						$('#countdown').text(sec);
				}, 1000);
			};
			
			timer();
	});
	</script>
	<style type="text/css">
	#countdown {
		font-family: Gerogia;
		font-size: 1.8em;
		font-weight: bold;
		color: #0000ff;
	}
	</style>
</head>
<body>
	<g:render template="breadcrumbs" model="[title: 'Publishing']" />
	
	<div id="post">
		<div class="right">
			<layoutTag:ajaxLoaderImage type="bar" />
	
			<p>Following files are publishing ...</p>
			<ul>
				<li>${book?.name}.pdf</li>
				<li>${book?.name}.epub</li>
			</ul>
	
			<p>
				Estimated time remaining ... 
				<span id="countdown">10</span>
			</p>
	
			<p align="right">
				<g:link action="show" id="${book.id}" class="clickable">Back</g:link>
			</p>
		</div>
		<div class="left">
			<g:render template="leftMenu"></g:render>
		</div>
	</div>
</body>
</html>
