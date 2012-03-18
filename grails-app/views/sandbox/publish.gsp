<html>
<head>
	<title>Sandbox</title>
	<style type="text/css">
	#title { width: 360px; }
	#authors { width: 200px; }
	.CodeMirror {
		font-family: 'Droid Sans Mono', sans-serif, Consolata, monospace;
		font-size: 12pt;
		line-height: 1.25em;
		width: 95%;
		height: 25em;
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
	td input, td textarea {
		width: 90%;
	}
	#toolbar {
		width: 95%;
		margin-bottom: 5px;
	}
	</style>
	<r:script>
	$(function() {

		var _sandboxId = '${sandbox?.id}';

		var editor = CodeMirror.fromTextArea(document.getElementById('contents'), {
			lineNumbers: true,
			indentUnit: 4,
			indentWithTabs: false,     
			tabMode: 'shift',
			enterMode: 'keep',
			matchBrackets: true,
			theme: 'default'
		});
		$('#dialog-template, #dialog-help, #dialog-setup, #dialog-result').dialog({
			autoOpen: false,
			modal: true,
			width: '640',
			minWidth: '400',
			maxWidth: '800'
		});

		var checker = function() {
			$.post(
				"${createLink(action: 'ajaxCheck')}",
				{
					id: _sandboxId
				},
				function(data) {
					$('#dialog-result').html(data);
				},
				'html'
			);
		};
		
		$( "#publish" ).button({
			icons: {
				primary: "ui-icon-print"
			}
		}).click(function() {
			$.post(
				"${createLink(action: 'ajaxPublish', id: sandbox?.id)}",
				{
					title: $('#title').val(),
					authors: $('#authors').val(),
					password: $('#password').val(),
					pdfPaperSize: $('#pdfPaperSize').val(),
					pdfFontSize: $('#pdfFontSize').val(),
					contents: editor.getValue()
				},
				function(data) {
					$('#dialog-result').html(data.htmlText);
					$('#dialog-result').dialog('open');

					$('span.status').html(data.message);
					_sandboxId = data.sandboxId;					

					//check and wait for 90sec
					checker();
								
				},
				'json'
			);
			
			return false;
		});
		
		$( '#template' ).button({
			icons: {
				primary: "ui-icon-folder-open"
			}
		}).click(function() {
			$('#dialog-template').dialog('open');
		});

		$( '#setup' ).button({
			icons: {
				primary: 'ui-icon-wrench'
			}
		}).click(function() {
			$('#dialog-setup').dialog('open');
		});

		$('#help').button({
			text: false,
			icons: {
				primary: 'ui-icon-help'
			}
		}).click(function(){
			$('#dialog-help').dialog('open');
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

		$('#apply-template').button({
			icons: {
				primary: "ui-icon-circle-check"
			}
		}).click(function() {
			if (confirm('是否套用範本？')) {
				$('#dialog-template').dialog('close');
				$('#title').val($('#previewTitle').val());
				$('#authors').val($('#previewAuthors').val());
				//$('#contents').val($('#previewContents').val());
				editor.setValue($('#previewContents').val());
			}
		});
	});
	</r:script>
</head>
<body>
	<g:link action="list">Sandbox</g:link>
	<g:if test="${sandbox?.id}">
		/
		<g:link action="show" id="${sandbox.id}">${sandbox.title}</g:link>
	</g:if>
	<g:else>
		/ New
	</g:else>

	<a name="editing"></a>

	<div id="toolbar" class="ui-widget-header ui-corner-all">
		<button id="publish"><g:message code="common.publish" default="Publish" /></button>
		<button id="template"><g:message code="common.template" default="Template" /></button>
		<button id="setup"><g:message code="common.setup" default="Setup" /></button>
		<button id="help"><g:message code="common.help" default="Help" /></button>
		<span class="status">
			<span style="color:red">＊</span>請按「發佈」開始製作電子書。
		</span>
	</div>

	<g:textArea name="contents" value="${sandbox?.contents}" />

	<div id="dialog-setup" title="${message(code:'common.setup', default:'Setup')}">
		<table width="90%" cellpadding="0" cellspacing="0" class="form-layout">
			<tr>
				<th width="120">書名</th>
				<td><g:textField name="title" value="${sandbox?.title}" /></td>
			</tr>
			<tr>
				<th>作者</th>
				<td><g:textField name="authors" value="${sandbox?.authors}" /></td>
			</tr>
			<tr>
				<th>紙張大小（PDF）</th>
				<td><g:select name="pdfPaperSize" from="${pdfPaperSizeList}" value="${sandbox?.pdfPaperSize}" /></td>
			</tr>
			<tr>
				<th>字體大小（PDF）</th>
				<td><g:select name="pdfFontSize" from="${pdfFontSizeList}" value="${sandbox?.pdfFontSize}" /></td>
			</tr>
		</table>
	</div>

	<div id="dialog-result" title="發佈"></div>

	<div id="dialog-template" title="範本">
		<table width="90%" cellpadding="0" cellspacing="0" class="form-layout">
			<tr>
				<th width="100">從範本載入</th>
				<td>
					<g:select name="sample" from="${sampleList}" optionKey="id" optionValue="title" noSelection="${['null':'請選擇']}" />
					<button id="apply-template">套用範本</button>
				</td>
			</tr>
			<tr>
				<th>書名</th>
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
		<p><span style="color:red">＊</span>設定完成後，請編輯電子書「原始碼」，並使用「發佈」按鈕產生電子書。</p>
		<p><span style="color:red">＊</span>您在沙盒編輯的原始碼，以及產生的電子書檔案，將會開放任何人存取，請避免填入隱私資料。</p>
		<p>使用<strong>沙盒測試</strong>體驗電子書製作，您可以不必註冊帳號。</p>
		<p>在<strong>原始碼</strong>編輯器，輸入書籍內容，並按下「<strong>發佈</strong>」立即產生一本電子書。</p>
		<p><font color="red">請注意！</font>沙盒測試產生的電子書，系統會定期進行清理，不會永久保存。如果您需要留存檔案資料，請自行下載存放。</p>
	</div>
</body>
</html>
