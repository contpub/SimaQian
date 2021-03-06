<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>Source Code</title>
<layoutTag:webFonts family="Droid Sans Mono" />
<r:require modules="reset, jquery, jquery-ui, codemirror" />
<r:layoutResources />
<link rel="stylesheet" type="text/css" href="${createLinkTo(dir: 'css', file: 'pygments.css')}">
<style type="text/css">
body {
	font-size: 12pt;
}
.linenodiv {
	color: #888888;
	padding: 0 .25em;
}
.highlight {
	padding: 0 .5em;
}
pre {
	font-family: 'Droid Sans Mono', sans-serif, Consolata, monospace;
}
</style>
</head>
<body>
	${contents}
	<r:layoutResources />
</body>
</html>
