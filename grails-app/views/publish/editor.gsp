<html>
<head>
	<title>Writing</title>
	<layoutTag:webFonts family="Droid Sans Mono" />
	<style type="text/css">
	#save.button {
		padding: 0 20px;
	}
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
		$('#tabs').tabs();

		var editor = CodeMirror.fromTextArea(
			document.getElementById('contents'), {
			lineNumbers: true,
			indentUnit: 4,
			indentWithTabs: false,     
			tabMode: 'shift', //indent
			enterMode: 'keep', //indent
			matchBrackets: true,
			theme: 'default',	//[default, night]
			lineWrapping: true
		});

		$('a.save-button').click(function() {
			$.post(
				"${createLink(action: 'ajaxSaveContents', id: book?.id)}",
				{
					contents: editor.getValue()
				},
				function(data) {
					$('span.status').html(data.result.message);
				},
				'json'
			);
			return false;
		});

		$('a.publish-button').click(function() {
			$.post(
				"${createLink(action: 'ajaxPublish', id: book?.id)}",
				'',
				function(data) {
					$('span.status').html(data.result.message);
				},
				'json'
			);
		});

		$('a.refresh-button').click(function() {
			$.post(
				"${createLink(action: 'ajaxStatus', id: book?.id)}",
				'',
				function(data) {
					$('span.isCooking').html(data.result.isCooking);
					$('span.lastUpdated').html(data.result.lastUpdated);
					$('span.cookUpdated').html(data.result.cookUpdated);
					$('span.refresh-status').html(data.result.message)
				},
				'json'
			);
		});

		// Auto-Save
		var autoSave = function() {
			window.setTimeout(function() {
				$('a.save-button').click();
				autoSave();
			}, 30000);
		};
		autoSave();
	});
	</script>
</head>
<body>
	<a name="editing"></a>
	
	<g:render template="breadcrumbs" model="[title: '編輯室']" />
	
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">原始碼</a></li>
			<li><a href="#tabs-2">電子書</a></li>
		</ul>
		<div id="tabs-1">
			<div class="toolbar">
				<a href="#" class="save-button"><img src="${createLinkTo(dir: 'icons/silk', file: 'page_save.png')}" border="0" /><span>儲存</span></a>
				<a href="#" class="publish-button"><img src="${createLinkTo(dir: 'icons/silk', file: 'printer.png')}" border="0" /><span>發佈</span></a>
				<a href="${bookTag.createDownloadLink(book: book, type: 'log')}" target="_blank" title="檢視記錄檔"><img src="${createLinkTo(dir: 'icons/silk', file: 'page_white_text.png')}" border="0" /><span>記錄檔</span></a>
				<span class="status"></span>
			</div>
			<g:if test="${book?.type==org.contpub.simaqian.RepoType.GIT}">
				<p>
					本書已設定為 Git 編輯模式，系統將由 
					${book?.url} 位址下載書籍原始碼，請使用 Git 工具來撰寫內容。您在下方編輯器輸入的內容，仍會上傳儲存在網站，但是不會用來產生電子書。
				</p>
			</g:if>

			<g:textArea name="contents" value="${book?.profile?.contents}" />
		</div>
		<div id="tabs-2">
			<div class="toolbar">
				<a href="#" class="refresh-button"><img src="${createLinkTo(dir: 'icons/silk', file: 'page_refresh.png')}" border="0" /><span>重新整理</span></a>
				<span class="refresh-status"></span>
			</div>
			<ul>
				<li>上一次儲存時間：<span class="lastUpdated"></span></li>
				<li>發佈時間：<span class="cookUpdated"></span></li>
				<li>是否已製作完成：<span class="isCooking"></span></li>
			</ul>
		</div>
	</div>
</body>
</html>
