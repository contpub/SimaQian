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

<g:link action="show" id="${book.id}">Back</g:link>
</body>
</html>