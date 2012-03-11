<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>Source Code</title>
<layoutTag:webFonts family="Droid Sans Mono" />
<r:require modules="reset, jquery, jquery-ui, codemirror" />
<r:layoutResources />
<style type="text/css">
.CodeMirror {
	font-family: 'Droid Sans Mono', sans-serif, Consolata, monospace;
	font-size: 11pt;
	line-height: 1.25em;
}
</style>
<r:script>
$(function() {
	$('#code').codemirror({
		mode: 'text/x-rst',
		runmode: true
	});
});
</r:script>
</head>
<body>
	<textarea id="code" style="display:none">${contents}</textarea>
	<r:layoutResources />
</body>
</html>