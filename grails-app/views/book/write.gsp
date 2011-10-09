<html>
<head>
<title>Writing</title>
<link rel="stylesheet" type="text/css" media="screen" href="${createLinkTo(dir: 'css', file: 'colorbox.css')}" />
<script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'jquery.colorbox-min.js')}"></script>
<script src="${createLinkTo(dir: 'codemirror', file: 'codemirror.js')}"></script>
<script src="${createLinkTo(dir: 'codemirror/mode/rst', file: 'rst.js')}"></script>
<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror/mode/rst', file: 'rst.css')}">
<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror', file: 'codemirror.css')}">
<!--<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror/theme', file: 'default.css')}">-->
<style type="text/css">
form {
	width:auto;
}
form .form-controls {
	margin: 0;
	padding: 0;
}
form .form-controls li {
	margin: 0;
	padding: 0;
	margin-right: 15px;
	list-style: none;
	display: inline;
}
form .form-controls li .button {
	padding: 0 20px;
}
#fullscreen-area {
	background-color: #fff;
}
#fullscreen-area .CodeMirror {
	font-size: 15px;
}
#fullscreen-area .CodeMirror, #fullscreen-area .CodeMirror-scroll {
	width: 100%;
	height: 100%;
}
.steps {
	font-size: 1.25em;
}
.steps strong {
	color: blue;
}
</style>
<script type="text/javascript">
$(function() {
	var __html_css_overflow = '';
		
	$('#fullscreen').colorbox({
		inline: true,
		href: '#fullscreen-area',
		width: '95%',
		height: '95%',                                           
		onComplete: function () {
			__html_css_overflow = $('html').css('overflow');
			$('html').css({overflow: 'hidden'});
		},
		onClosed: function() {
			$('html').css({overflow: __html_css_overflow});
		}
	});
	
	var editor = CodeMirror.fromTextArea(document.getElementById('contents'), {
		lineNumbers: true,
		indentUnit: 4,
		indentWithTabs: false,     
		tabMode: 'shift', //indent
		enterMode: 'keep', //indent
		matchBrackets: true
	});
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

	<h2>Write a book</h2>
	
	<g:renderErrors bean="${book}" />
		
	<g:form action="saveWrite" id="${book.id}">
		<h3>${book.title}</h3>
		<p align="right">
			<a id="fullscreen" href="#" class="clickable">full screen</a>
		</p>
		<p>
			<label for="contents">Book contents</label><br />
			<div id="fullscreen-area">
				<g:textArea name="contents" value="${book?.contents}" />
			</div>
		</p>

		<!-- Defaults -->

		<p class="no-border">
			<ul class="form-controls">	
				<li><g:submitButton name="save" value="Save" class="button" /></li>
				<li><g:submitButton name="save" value="Done" class="button" /></li>
				<li><g:submitButton name="save" value="Publish" class="button" /></li>
				<li><g:link action="show" id="${book.id}">Back</g:link></li>
				<li>${flash.message}</li>
			</ul>
		</p>

	</g:form>
	
	<content tag="sidebar">
		<div class="sidemenu">
			<h3>Steps</h3>
			<ol class="steps">
				<li><strong>Thinking</strong></li>
				<li>Writing</li>
				<li>Publishing</li>
			</ol>
		</div>
	</content>
</body>
</html>
