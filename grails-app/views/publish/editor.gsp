<html>
<head>
<title>Writing</title>
<layoutTag:webFonts family="Droid Sans Mono" />
<r:script>
$(function() {
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
	var save = function(params) {
		if (!params) params = {};

		$.post(
			"${createLink(action: 'ajaxSaveContents', id: book?.id)}",
			{
				contents: editor.getValue(),
				offset: "${offset}",
				publish: params.publish?'true':'false'
			},
			function(data) {
				$('span.status').html(data.result.message);
				if (params.callback) {
					params.callback();
				}
			},
			'json'
		);
	};
	$('#save-button').click(function() {
		if (editor.getValue()) {
			save();
		}
		else {
			if ("${total}"=="1") {
				alert("Unable to save the blank content, please write at least one line sentence.");
			}
			else {
				if (confirm('If you choose to continue, it will clear the current text file.')) {
					save({
						callback: function() {
							location.href='${createLink(action: 'cleanupContents', id: book?.id)}';
						}
					});
				}
			}
		}
		return false;
	});
	$('#publish-button').click(function() {
		if ("${total}"=="1" && !editor.getValue()) {
			alert("Unable to publish the blank content, please write at least one line sentence.");
		}
		else {
			save({
				publish: true
			});
		}
		return false;
	});
	// Auto-Save
	var autoSave = function() {
		window.setTimeout(function() {
			if (editor.getValue()) {
				save();
			}
			autoSave();
		}, 30000);
	};
	autoSave();
});
</r:script>
</head>
<body>
	<a name="editing"></a>
	<g:render template="breadcrumbs" model="[title: '編輯室']" />
	<div class="toolbar">
		<a href="#" id="save-button" class="fancy-button">
			<span class="icons ss_page_save">&nbsp;</span>Save
		</a>
		<a href="#" id="publish-button" class="fancy-button">
			<span class="icons ss_printer">&nbsp;</span>Publish
		</a>
		<span class="status"></span>
	</div>
	<g:if test="${book?.type==simaqian.RepoType.GIT}">
		<p>
			本書已設定為 Git 編輯模式，系統將由 
			${book?.url} 位址下載書籍原始碼，請使用 Git 工具來撰寫內容。您在下方編輯器輸入的內容，仍會上傳儲存在網站，但是不會用來產生電子書。
		</p>
	</g:if>
	<div style="height:480px">
		<g:textArea name="contents" value="${contents}" style="display:none" />
	</div>
	<div class="paginate">
		<g:paginate next="Forward" prev="Back" action="editor" id="${book?.id}" max="1" maxsteps="10" offset="0" total="${total}" />
	</div>
	<div class="editor-links">
		Insert new text
		<g:link action="insertContent" id="${book?.id}" params="[offset: offset]">after current text</g:link>
		or
		<g:link action="insertContent" id="${book?.id}">as last text</g:link>.
		See
		<a href="${bookTag.createDownloadLink(book: book, type: 'log')}" target="_blank" title="檢視記錄檔">
			<span class="icons ss_page_white_text">&nbsp;</span>logs
		</a>
		if something wrong.
	</div>
</body>
</html>
