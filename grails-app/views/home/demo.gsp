<html>
<head>
<title>Welcome</title>
<layoutTag:webFonts family="Droid Sans Mono" />
<style tyle="text/css">
#tabs {
	width: 90%;
	margin: 15px auto;
}
.CodeMirror {
	font-family: 'Droid Sans Mono', sans-serif, Consolata, monospace;
	font-size: 12pt;
	line-height: 1.25em;
}
</style>
<r:script>
	$(function() {
		$('#tabs').tabs();
		$('#code').codemirror({
			mode: 'text/x-rst',
			runmode: true
		});
	});
</r:script>
</head>
<body>
	<h2>電子書原始碼</h2>

	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">原始碼</a></li>
			<li><a href="#tabs-2">電子書</a></li>
			<li><a href="#tabs-3">流程說明</a></li>
		</ul>
		<div id="tabs-1">
			<!--<iframe src="${createLink(controller: 'book', action: 'embed', id: book?.id, params: [syntax: true])}" width="100%" height="480" style="border: none"></iframe>-->
			<div style="overflow:auto">
				<textarea id="code" style="display:none">${book?.profile?.contents}</textarea>
			</div>
		</div>
		<div id="tabs-2">
			<!--
			<div style="width:360px;height:480px;float:right">
				<iframe src="https://docs.google.com/viewer?url=http%3A%2F%2Fcontpub.org%2Fdownload%2Fdemo1.pdf&embedded=true#:0.page.5" width="360" height="480" style="border:none;float:right;width:360px;height:480px;"></iframe>
			</div>
			-->
			<p>檔案下載：</p>
			<div style="text-align:center">
				<div style="width:240px;display:inline-block">
					<img src="${createLinkTo(dir: 'images', file: 'pdf-preview-tiny.png')}" style="border:none;padding:0;margin:0" border="0" alt="demo1.pdf" title="download demo1.pdf" />
					<div>
						<bookTag:downloadLink book="${book}" type="pdf">${book?.name}.pdf</bookTag:downloadLink>
						（<a href="http://docs.google.com/viewer?url=${bookTag.createDownloadLink(book: book, type: 'pdf').encodeAsURL()}&embedded=true" target="_blank">線上預覽</a>）
					</div>
				</div>
				<div style="width:240px;display:inline-block">
					<img src="${createLinkTo(dir: 'images', file: 'ibook-preview-tiny.png')}" style="border:none;padding:0;margin:0" border="0" alt="demo1.epub" title="download demo1.epub" />
					<div>
						<bookTag:downloadLink book="${book}" type="epub">${book?.name}.epub</bookTag:downloadLink>
					</div>
				</div>
			</div>			
			<div style="font-size:.8em">
				<p>註1：PDF檔案可以使用 <a href="get.adobe.com/reader/">Adobe Reader</a> 或其他相容閱讀軟體開啟。EPUB檔案可以使用 <a href="http://www.adobe.com/products/digitaleditions/">Adobe Digital Edition</a> 或 iBooks（適用 iPad 平板電腦）等閱讀軟體開啟。</p>
				<p>註2：PDF線上預覽使用 <a href="http://docs.google.com/viewer" target="_blank">Google Doc Viewer</a>（必須驗證您的 Google 帳號），EPUB線上預覽使用 <a href="http://www.magicscroll.net/" target="_blank">Magic Scroll</a>；受限於瀏覽器功能與字型限制，其顯示效果與下載版電子書可能有差異。</p>
			</div>
		</div>
		<div id="tabs-3">
			<p>您只需要學會「電腦打字」，就可以開始出版電子書！</p>

			<p>每個人都能當作家的數位出版時代已經來臨，您不必再忍受傳統出版的一切麻煩。請準備好鍵盤，立即參與我們的電子書寫作行動！</p>

			<p>我們提供免費的電子書製作服務，您只需要線上提交書的「<strong>原始碼</strong>」，不必等待超過三分鐘，就可以輸出成高品質的「<strong>電子書</strong>」，並自動完成上架、開放下載。</p>

			<div style="text-align:center">
				<img src="${createLinkTo(dir: 'images', file: 'source-code-editing.png')}" style="border:none;padding:0;margin:0" />
			</div>

			<p>我們提供的電子書格式包含 PDF（適合列印及大尺寸螢幕）及 EPUB（適合電子書閱讀器及行動裝置）兩種，相容市面上絕大多數電子書閱讀器。</p>

			<div style="text-align:center">
				<img src="${createLinkTo(dir: 'images', file: 'ebook-readers.png')}" style="border:none;padding:0;margin:0" />
			</div>
		</div>
	</div>
	<content tag="sidebar">
		<div class="sidemenu">
			<h3>Social</h3>
			<socialTag:twitterFollow />
			<socialTag:facebookLikeBox width="240" header="false" stream="false" borderColor="#ffffff" />
		</div>
	</content>
</body>
</html>
