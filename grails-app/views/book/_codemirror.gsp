<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<title>Source Code</title>
	<layoutTag:webFonts family="Droid Sans Mono" />
	<layoutTag:reset />
	<layoutTag:jquery />
	<layoutTag:codemirror />
	<style type="text/css">
	.CodeMirror {
		font-family: 'Droid Sans Mono', sans-serif, Consolata, monospace;
		font-size: 12pt;
		line-height: 1.25em;
	}
	</style>
	<script type="text/javascript">
	$(function() {
		$('#code').codemirrorHighlight({mode:'text/x-rst', gutter:true});
	});
	</script>
</head>
<body>
<textarea id="code" style="display:none">${contents}</textarea>
</body>
</html>
