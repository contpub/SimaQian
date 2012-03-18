<html>
<head>
	<socialTag:openGraph title="${sandbox?.title}" type="book" url="${createLink(action: 'show', id: sandbox?.id, absolute: true)}" image="${createLinkTo(dir: 'icons', file: 'book.png', absolute: true)}" description="您也可以使用「沙盒」輕鬆製作一本電子書，趕快來體驗開放源碼電子書。" />
	<title>${sandbox?.title}</title>
	<style tyle="text/css">
	.CodeMirror {
		background: #ffffee;
		padding: 1em;
		font-family: 'Droid Sans Mono', sans-serif, Consolata, monospace;
		font-size: 12pt;
		line-height: 1.25em;
	}
	</style>
	<r:script>
	$(function() {
		$('#code').codemirror({
			mode: 'text/x-rst',
			runmode: true
		});
	});
	</r:script>
</head>
<body>
	<g:link action="list">Sandbox</g:link>
	<g:if test="${sandbox?.id}">
		/
		${sandbox.title}
	</g:if>
	<g:if test="${sandbox.owner==user}">
		<g:link action="update" id="${sandbox.id}">Edit</g:link>
	</g:if>

    <h2>${sandbox?.title}</h2>

	<div style="margin: 1em 2em">
		<socialTag:facebookLikeButton />
	</div>


    <h3>E-book source code</h3>
    <div style="overflow:auto;width:95%;height:240px;margin:auto">
		<textarea id="code" style="display:none">${sandbox?.contents}</textarea>
	</div>

	<h3>Download</h3>
	<div style="text-align:center">
		<div style="width:180px;display:inline-block">
			<g:link action="download" id="sandbox${sandbox?.id}.pdf">
				<img src="${createLinkTo(dir: 'icons', file: 'mime-pdf-64.png')}" style="border:none;padding:0;margin:0" border="0" alt="pdf" title="download ${sandbox?.id}.pdf" />
				<br/>
				sandbox${sandbox?.id}.pdf
			</g:link>
			<br/>
			（<a href="http://docs.google.com/viewer?url=${createLink(action: 'download', id: 'sandbox'+sandbox?.id+'.pdf', absolute: true).encodeAsURL()}&embedded=true" target="_blank">線上預覽</a>）
		</div>
		<div style="width:180px;display:inline-block">
			<g:link action="download" id="sandbox${sandbox?.id}.epub">
				<img src="${createLinkTo(dir: 'icons', file: 'mime-epub-64.png')}" style="border:none;padding:0;margin:0" border="0" alt="epub" title="download sandbox${sandbox?.id}.epub" />
				<br/>
				sandbox${sandbox?.id}.epub
			</g:link>
			<br/>
			&nbsp;
		</div>
		<div style="width:180px;display:inline-block">
			<g:link action="download" id="sandbox${sandbox?.id}.mobi">
				<img src="${createLinkTo(dir: 'icons', file: 'mime-mobi-64.png')}" style="border:none;padding:0;margin:0" border="0" alt="mobi" title="download sandbox${sandbox?.id}.mobi" />
				<br/>
				sandbox${sandbox?.id}.mobi
			</g:link>
			<br/>
			&nbsp;
		</div>
	</div>

	<div style="width:90%;margin:auto">
		<p>檔案下載：</p>			
		<div style="font-size:.8em;margin-top:2em;">
			<p>註1：PDF檔案可以使用 <a href="get.adobe.com/reader/">Adobe Reader</a> 或其他相容閱讀軟體開啟。EPUB檔案可以使用 <a href="http://www.adobe.com/products/digitaleditions/">Adobe Digital Edition</a> 或 iBooks（適用 iPad 平板電腦）等閱讀軟體開啟。</p>
			<p>註2：PDF線上預覽使用 <a href="http://docs.google.com/viewer" target="_blank">Google Doc Viewer</a>（必須驗證您的 Google 帳號），EPUB線上預覽使用 <a href="http://www.magicscroll.net/" target="_blank">Magic Scroll</a>；受限於瀏覽器功能與字型限制，其顯示效果與下載版電子書可能有差異。</p>
		</div>
	</div>

	<div id="tabs-3" style="display:none">
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

	<div class="comments">
		<socialTag:disqus identifier="sandbox-${sandbox?.id}" url="${createLink(action: 'show', id: sandbox?.id, absolute: true)}" />
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
