<html>
<head>
	<title>Sandbox</title>
	<layoutTag:webFonts family="Droid Sans Mono" />
	<layoutTag:jqueryColorbox />
	<layoutTag:codemirror />
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
		padding: 5px 0;
	}
	.toolbar ul.items, .toolbar li.item {
		margin: 0;
		padding: 0;
		list-style: none;
	}
	.toolbar ul.items {
		display: inline-block;
	}
	.toolbar li.item {
	}
	.toolbar .item a img {
		background: none;
		border: 0;
		padding: 1px;
	}
	.toolbar .item a span {
		display: block;
	}
	.toolbar .item a {
		width: 48px;
		padding: 2px;
		display: inline-block;
		border: 1px solid #cccccc;
		text-align: center;
		color: #555555;
		font-size: 13px;
	}
	.toolbar .item a:hover {
		background: #cccccc;
		color: #333333;
	}
	.preview-table th {
		background: none;
		border: none;
		color: #333333;
		text-align: right;
		font-weight: normal;
		margin: 0;
		padding: 0;
		vertical-align: middle;
	}
	.preview-table td {
		border: none;
	}
	.preview-table td input, .preview-table td textarea {
		width: 90%;
	}
	#tabs {
		width: 95%;
	}
	#toolbar {
		width: 95%;
		margin-bottom: 5px;
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

		$('#dialog-template').dialog({
			autoOpen: false,
			modal: true,
			width: '640',
			minWidth: '400',
			maxWidth: '800'
		});

		$('#dialog-help').dialog({
			autoOpen: false
		});

		$('#button-template').button({
			icons: {
				primary: 'ui-icon-folder-open'
			}
		}).click(function() {
			$('#dialog-template').dialog('open');
		});

		$( "#save" ).button({
			icons: {
				primary: "ui-icon-disk"
			}
		});
		$( "#publish" ).button({
			icons: {
				primary: "ui-icon-print"
			}
		});

		$('#help').button({
			text: false,
			icons: {
				primary: 'ui-icon-help'
			}
		}).click(function(){
			$('#dialog-help').dialog('open');
		});

		$('.goto-editor').click(function() {
			tabs.tabs('select', 1);
			return false;
		});

		$('#sample').change(function() {
			var sampleId = $('option:selected', this).val();

			$.post(
				"${createLink(action: 'ajaxSample')}",
				{
					id: sampleId
				},
				function(data) {
					$('#previewTitle').val(data.title);
					$('#previewAuthors').val(data.authors);
					$('#previewContents').val(data.contents);
				},
				'json'
			);
		});

		$('#button-apply-template').button({
			icons: {
				primary: "ui-icon-circle-check"
			}
		}).click(function() {
			if (confirm('是否套用範本？')) {
				$('#title').val($('#previewTitle').val());
				$('#authors').val($('#previewAuthors').val());
				//$('#contents').val($('#previewContents').val());
				tabs.tabs('select', 0);
				editor.setValue($('#previewContents').val());
			}
		});

		$('a.publish-button').click(function() {
			$.post(
				"${createLink(action: 'ajaxPublish')}",
				{
					title: $('#title').val(),
					authors: $('#authors').val(),
					password: $('#password').val(),
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
			return false;
		});
	});
	</script>
</head>
<body>
	<a name="editing"></a>

	<div id="toolbar" class="ui-widget-header ui-corner-all">
		<button id="save"><g:message code="common.save" default="Save" /></button>
		<button id="publish"><g:message code="common.publish" default="Publish" /></button>
		<button id="help"><g:message code="common.help" default="Help" /></button>
		<span class="status">
			<span style="color:red">＊</span>請按「發佈」開始製作電子書。
		</span>
	</div>

	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">原始碼</a></li>
			<li><a href="#tabs-2">設定</a></li>
			<li><a href="#tabs-3">電子書</a></li>
		</ul>
		<div id="tabs-1">
			<g:textArea name="contents" value="${sandbox?.contents}" />
		</div>
		<div id="tabs-2">
			<div>
				<button id="button-template">載入範本</button><br/>

				書名：<g:textField name="title" value="${sandbox?.title}" /><br/>
				作者：<g:textField name="authors" value="${sandbox?.authors}" /><br/>
				紙張大小（PDF）：<g:select name="pdfPaperSize" from="${pdfPaperSizeList}" value="${sandbox?.pdfPaperSize}" /><br/>
				字體大小（PDF）：<g:select name="pdfFontSize" from="${pdfFontSizeList}" value="${sandbox?.pdfFontSize}" /><br/>

				<userTag:isNotLogin>
					密碼保護：<g:passwordField name="password" value="${sandbox?.password}" /><br/>
				
					<p><span style="color:red">＊</span>輸入密碼，讓您日後可以重新編輯（匿名使用者）。</p>
				</userTag:isNotLogin>

				<!--驗證碼：<br/>
				<recaptcha:ifEnabled>
					<recaptcha:recaptcha theme="clean"/>
					<recaptcha:ifFailed>CAPTCHA Failed</recaptcha:ifFailed>
				</recaptcha:ifEnabled>-->
				<p><span style="color:red">＊</span>設定完成後，請編輯電子書「<a class="goto-editor" href="#tabs-2">原始碼</a>」，並使用「發佈」按鈕產生電子書。</p>
				<p><span style="color:red">＊</span>您在沙盒編輯的原始碼，以及產生的電子書檔案，將會開放任何人存取，請避免填入隱私資料。</p>
			</div>
		</div>
		<div id="tabs-3">
			<!--<iframe id="result-iframe" src="${createLink(action: 'empty', params: ['_t':new Date().time])}" border="0" width="100%" height="320" style="width:100%;height:320px"></iframe>-->
			<div id="publish-status-container">
				<img src="${createLinkTo(dir: 'images', file: 'ajax-loader-big.gif')}" border="0" class="pure-image" />
			</div>
		</div>
	</div>

	<div id="dialog-template" title="範本">
		從範本載入：<g:select name="sample" from="${sampleList}" optionKey="id" optionValue="title" noSelection="${['null':'請選擇']}" />
		<button id="button-apply-template">套用範本</button>
		<br/>
		<table width="90%" cellpadding="0" cellspacing="0" class="preview-table">
			<tr>
				<th width="90">書名</th>
				<td>
					<g:textField name="previewTitle" value="" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<th>作者</th>
				<td>
					<g:textField name="previewAuthors" value="" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<th>原始碼</th>
				<td>
					<g:textArea name="previewContents" value="" rows="8" readonly="readonly" />
				</td>
			</tr>
		</table>
	</div>

	<div id="dialog-help" title="${message(code: 'common.help', default: 'Help')}">
		<p>使用<strong>沙盒測試</strong>體驗電子書製作，您可以不必註冊帳號。</p>
		<p>在<strong>原始碼</strong>編輯器，輸入書籍內容，並按下「<strong>發佈</strong>」立即產生一本電子書。</p>
		<p><font color="red">請注意！</font>沙盒測試產生的電子書，系統會定期進行清理，不會永久保存。如果您需要留存檔案資料，請自行下載存放。</p>
	</div>
</body>
</html>
