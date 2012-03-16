<html>
<head>
<title>Welcome</title>
<layoutTag:webFonts family="Droid Sans Mono" />
<style tyle="text/css">
#tabs {
	width: 90%;
	margin: 15px auto;
}
.CodeMirror {
	font-family: 'Droid Sans Mono', sans-serif, Consolata, monospace;
	font-size: 12pt;
	line-height: 1.25em;
}
</style>
<r:script>
	$(function() {
		$('#tabs').tabs();
		$('#code').codemirror({
			mode: 'text/x-rst',
			runmode: true
		});
	});
</r:script>
</head>
<body>
	<center><img src="${createLinkTo(dir: 'images', file: 'concepts.001.png')}" alt="concepts" width="640" height="480" /></center>

	<p style="text-align:right">繼續瞭解<g:link action="demo">電子書原始碼</g:link></p>

	<content tag="sidebar">
		<div class="sidemenu">
			<h3>Social</h3>
			<socialTag:twitterFollow />
			<socialTag:facebookLikeBox width="240" header="false" stream="false" borderColor="#ffffff" />
		</div>
	</content>
</body>
</html>
