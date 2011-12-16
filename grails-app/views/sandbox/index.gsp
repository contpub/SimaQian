<html>
<head>
	<title>Sandbox</title>
	<link href="http://fonts.googleapis.com/css?family=Droid+Sans+Mono" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" media="screen" href="${createLinkTo(dir: 'css', file: 'colorbox.css')}" />
	<script type="text/javascript" src="${createLinkTo(dir: 'js', file: 'jquery.colorbox-min.js')}"></script>
	<script src="${createLinkTo(dir: 'codemirror', file: 'codemirror.js')}"></script>
	<script src="${createLinkTo(dir: 'codemirror/mode/rst', file: 'rst.js')}"></script>
	<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror/mode/rst', file: 'rst.css')}">
	<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror', file: 'codemirror.css')}">
	<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror/theme', file: 'default.css')}">
	<link rel="stylesheet" href="${createLinkTo(dir: 'codemirror/theme', file: 'night.css')}">
	<style type="text/css">
	#title { width: 360px; }
	#authors { width: 200px; }
	.CodeMirror {
		font-family: 'Droid Sans Mono', sans-serif, Consolata, monospace;
		font-size: 12pt;
		line-height: 1.25em;
		width: 100%;
		height: 480px;
	}
	.CodeMirror-scroll {
		width: 100%;
		height: 100%;
	}
	.toolbar {
		padding: 2px 0;
	}
	.toolbar img {
		background: none;
		border: 0;
		padding: 1px 1px;
	}
	.toolbar a {
		padding: 2px;
		display: inline-block;
		border: 1px solid #cccccc;
	}
	.toolbar a:hover {
		background: #cccccc;
	}
	#tabs {
		width: 95%;
	}
	</style>
	<script type="text/javascript">
	$(function() {
		var editor = CodeMirror.fromTextArea(document.getElementById('contents'), {
			lineNumbers: true,
			indentUnit: 4,
			indentWithTabs: false,     
			tabMode: 'shift',
			enterMode: 'keep',
			matchBrackets: true,
			theme: 'default'
		});
		
		var tabs = $('#tabs').tabs();

		$('a.publish-button').click(function() {
			$.post(
				"${createLink(action: 'ajaxPublish')}",
				{
					title: $('#title').val(),
					authors: $('#authors').val(),
					pdfPaperSize: $('#pdfPaperSize').val(),
					pdfFontSize: $('#pdfFontSize').val(),
					contents: editor.getValue()
				},
				function(data) {
					$('span.status').html(data.message);
					$('#result-iframe').attr('src', data.resultUrl);
					tabs.tabs('select', 2);
					
					//$('span.status').html('抱歉！伺服器發生錯誤。');
				},
				'json'
			);
		});
	});
	</script>
</head>
<body>
	<a name="editing"></a>
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">設定</a></li>
			<li><a href="#tabs-2">原始碼</a></li>
			<li><a href="#tabs-3">電子書</a></li>
			<li><a href="#tabs-4">說明</a></li>
		</ul>
		<div id="tabs-1">
			<div>
				書名：<g:textField name="title" value="${sandbox?.title}" /><br/>
				作者：<g:textField name="authors" value="${sandbox?.authors}" /><br/>
				紙張大小（PDF）：<g:select name="pdfPaperSize" from="${pdfPaperSizeList}" value="${sandbox?.pdfPaperSize}" /><br/>
				字體大小（PDF）：<g:select name="pdfFontSize" from="${pdfFontSizeList}" value="${sandbox?.pdfFontSize}" /><br/>
				驗證碼：<br/>
				<recaptcha:ifEnabled>
					<recaptcha:recaptcha theme="clean"/>
					<recaptcha:ifFailed>CAPTCHA Failed</recaptcha:ifFailed>
				</recaptcha:ifEnabled>
			</div>
		</div>
		<div id="tabs-2">
			<div class="toolbar">
				<a href="#" class="publish-button"><img src="${createLinkTo(dir: 'icons/silk', file: 'printer.png')}" border="0" /><span>發佈</span></a>
				<span class="status"></span>
				<g:textArea name="contents" value="${sandbox?.contents}" />
			</div>
		</div>
		<div id="tabs-3">
			<iframe id="result-iframe" src="${createLink(action: 'empty', params: ['_t':new Date().time])}" border="0" width="100%" height="250" style="width:100%;height:250px"></iframe>
		</div>
		<div id="tabs-4">
			<p>使用<strong>沙盒測試</strong>體驗電子書製作，您可以不必註冊帳號。</p>
			<p>在<strong>原始碼</strong>編輯器，輸入書籍內容，並按下「<strong>發佈</strong>」立即產生一本電子書。</p>
			<p><font color="red">請注意！</font>沙盒測試產生的電子書，系統會定期進行清理，不會永久保存。如果您需要留存檔案資料，請自行下載存放。</p>
		</div>
	</div>
</body>
</html>
