<html>
<head>
<title>Processing</title>
<meta HTTP-EQUIV="REFRESH" content="30; url=${createLink(action: 'show', id: book.id)}">
<script type="text/javascript">
$(function() {
		var sec = 30;
		
		var timer = function () {
			window.setTimeout(function () {
					if (sec-- > 0) {
						timer();
					}
					$('#countdown').text(sec);
			}, 1000);
		};
		
		timer();
		
});
</script>
</head>
<body>
	<div class="breadcrumbs">
		<g:link action="index">Books</g:link>
		&gt;
		<g:link action="show" id="${book.id}">${book.title}</g:link>		
		&gt;
		Writing
	</div>
	
	<h2>Wait a moment ...</h2>
	
	<p>
		<pre>
		正在製作 PDF, ePub 檔案，
		過程大概需要三分鐘左右，
		如果您覺得這實在太慢，
		請多多贊助頻寬、主機費用，謝謝...
		</pre>
	</p>
	
	<p>
	剩餘 <span id="countdown">30</span> 秒 ...
	</p>
	
	<p align="right">
		<g:link action="show" id="${book.id}" class="clickable">Back</g:link>
	</p>
	
	<content tag="sidebar">
		<div class="sidemenu">
			<h3>Steps</h3>
			<ol class="steps">
				<li>Thinking</li>
				<li>Writing</li>
				<li><strong>Publishing</strong></li>
			</ol>
		</div>
	</content>

</body>
</html>