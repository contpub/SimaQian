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
			theme: 'default',
			lineWrapping: true
		});
		
		$('#dialog-template, #dialog-result').dialog({
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
					contents: editor.getValue()
				},
				function(data) {
					$('#dialog-result').html(data.htmlText);
					$('#dialog-result').dialog('open');

					$('span.status').html(data.message);
					_sandboxId = data.sandboxId;
					
					alert('電子書正在製作，等待約一分鐘即可下載！');
					location.href = data.redirectUrl;
					//check and wait for 90sec
					//checker();
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
		<span class="status">
			<span style="color:red">*</span>
			Press "Publish" to making eBook.
		</span>
	</div>
	
	書名 <g:textField name="title" value="${sandbox?.title}" />
	作者 <g:textField name="authors" value="${sandbox?.authors}" />

	<g:textArea name="contents" value="${sandbox?.contents}" />

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
</body>
</html>
