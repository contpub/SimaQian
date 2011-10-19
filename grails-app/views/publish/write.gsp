<html>
<head>
	<title>Writing</title>
	<link rel="stylesheet" type="text/css" media="screen" href="${createLinkTo(dir: 'css', file: 'colorbox.css')}" />
	<script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'jquery.colorbox-min.js')}"></script>
	<script src="${createLinkTo(dir: 'codemirror', file: 'codemirror.js')}"></script>
	<script src="${createLinkTo(dir: 'codemirror/mode/rst', file: 'rst.js')}"></script>
	<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror/mode/rst', file: 'rst.css')}">
	<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror', file: 'codemirror.css')}">
	<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror/theme', file: 'default.css')}">
	<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror/theme', file: 'night.css')}">
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
	#fullscreen {
		float: right;
	}
	#fullscreen-area {
		background-color: #fff;
	}
	#fullscreen-area .CodeMirror {
		font-size: 1.125em;
		line-height: 1.1em;
	}
	#fullscreen-area .CodeMirror {
		width: 100%;
		height: 480px;
	}
	#fullscreen-area .CodeMirror-scroll {
		width: 100%;
		height: 100%;
	}
	#fullscreen-area.enable .CodeMirror {
		width: 100%;
		height: 100%;
		font-size: 1.25em;
		line-height: 1.25em;
	}
	</style>
	<script type="text/javascript">
	$(function() {
		var __html_css_overflow = '';
		
		var editor = CodeMirror.fromTextArea(document.getElementById('contents'), {
			lineNumbers: true,
			indentUnit: 4,
			indentWithTabs: false,     
			tabMode: 'shift', //indent
			enterMode: 'keep', //indent
			matchBrackets: true,
			theme: 'default'	//=> default, night
		});
		
		$('#fullscreen').colorbox({
			inline: true,
			href: '#fullscreen-area',
			width: '95%',
			height: '95%',
			onComplete: function () {
				__html_css_overflow = $('html').css('overflow');
				$('html').css({overflow: 'hidden'});
				$('#fullscreen-area').addClass('enable');
				editor.refresh();
			},
			onClosed: function() {
				$('html').css({overflow: __html_css_overflow});
				$('#fullscreen-area').removeClass('enable');
				editor.refresh();
			}
		});
	});
	</script>
</head>
<body>
	<a name="editing"></a>
	
	<g:render template="breadcrumbs" model="[title: 'Write contents']" />
	
	<div id="post">
		<div class="right">
			<g:renderErrors bean="${book}" />
			
			<g:form action="saveWrite" id="${book.id}">
				<a id="fullscreen" href="#">fullscreen</a>
				<p>
					<label for="contents">Book contents</label><br />
					<div id="fullscreen-area">
						<g:textArea name="contents" value="${book?.profile?.contents}" />
					</div>
				</p>

				<!-- Defaults -->

				<p class="no-border">
					<ul class="form-controls">	
						<li><g:submitButton name="save" value="Save" class="button" /></li>
					</ul>
					${flash.message}
				</p>
			</g:form>
		</div>
		<div class="left">
			<g:render template="leftMenu"></g:render>
		</div>
	</div>
</body>
</html>
