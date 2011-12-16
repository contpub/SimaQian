<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>Source Code</title>
<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/reset/reset-min.css">
<link href="http://fonts.googleapis.com/css?family=Droid+Sans+Mono" rel="stylesheet" type="text/css">
<script src="${createLinkTo(dir: 'codemirror', file: 'codemirror.js')}"></script>
<script src="${createLinkTo(dir: 'codemirror', file: 'runmode.js')}"></script>
<script src="${createLinkTo(dir: 'codemirror/mode/rst', file: 'rst.js')}"></script>
<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror/mode/rst', file: 'rst.css')}">
<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror', file: 'codemirror.css')}">
<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror/theme', file: 'default.css')}">
<style type="text/css">
.CodeMirror {
	font-family: 'Droid Sans Mono', sans-serif, Consolata, monospace;
	font-size: 12pt;
	line-height: 1.25em;
}
</style>
</head>
<body>
<textarea id="code" style="display:none">${contents}</textarea>
<div class="CodeMirror">
	<div class="CodeMirror-gutter">
		<div class="CodeMirror-gutter-text">
			<div id="numbers"></div>
		</div>
	</div>
	<div class="CodeMirror-lines">
		<div style="position: relative; margin-left: 33px;">
			<pre id="output" class="cm-s-default"></pre>
		</div>
	</div>
</div>
<script type="text/javascript">
var numbers = document.getElementById("numbers");
var output = document.getElementById("output");
var accum = [], gutter = [], size = 0;
var callback = function(string, style) {
	if (string == "\n") {
		accum.push("<br>");
		gutter.push('<pre>'+(++size)+'</pre>');
	}
	else if (style)
		accum.push("<span class=\"cm-" + CodeMirror.htmlEscape(style) + "\">" + CodeMirror.htmlEscape(string) + "</span>");
	else
		accum.push(CodeMirror.htmlEscape(string));
}
CodeMirror.runMode(document.getElementById("code").value, "text/x-rst", callback);
output.innerHTML = accum.join('');
numbers.innerHTML = gutter.join('');
</script>
</body>
</html>
