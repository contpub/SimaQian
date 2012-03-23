<html>
<head>
	<title>切換編輯模式</title>
	<style style="text/css">
	form #name {
		width: 200px;
	}
	form #title, form #description, form #homepage, form #icon, form #cover {
		width: 100%;
	}
	form #description {
		height: 150px;
	}
	span.required {
		color: red;
		font-weight: bold;
	}
	div.book-coverImage {
		margin: 10px;
		float: left;
	}
	.clear-both {
		clear:both;
	}
	</style>
	<socialTag:websnaprSDK />
</head>
<body>
	<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.mode', default: 'Authoring modes')]" />
	
	<div id="post" class="clearlook">
		<div class="right">
			<h2>編輯模式</h2>
			<!--已啟用模式：${book?.type}-->
			<div>
				<h3>線上編輯器</h3>
				<div style="float: left; padding: 0 20px">
				<img src="${createLinkTo(dir: 'images', file: 'mode_embed.png')}" class="icon" />
				</div>
				<p>使用系統內建的網頁版文字編輯器，此為預設模式。如果您是第一次使用，或是只要為電子書建立初稿，請使用此模式。</p>
				<div style="text-align: right">
					<g:if test="${book?.type.toString()=='EMBED'}">
						<strong>已啟用</strong>
					</g:if>
					<g:else>
						<g:link action="modeChange" id="${book?.id}" params="[type: 'EMBED']">啟用</g:link>
					</g:else>
				</div>
			</div>
			<div style="clear:both">
				<h3>Git 版本控制</h3>
				<div style="float: left; padding: 0 20px">
					<img src="${createLinkTo(dir: 'images', file: 'mode_git.png')}" class="icon" /><br/>
					<img src="${createLinkTo(dir: 'images', file: 'mode_github.png')}" class="icon" />
				</div>
				<p>適用開放源碼電子書，可由多位作者協同編輯內容。由於需要額外的 Git 軟體操作，此模式較適合進階使用者。您可以利用免費的 <a href="http://github.com/" target="_blank">GitHub</a> 服務建立 Git 電子書專案，並邀請其他作者一起參與協作。使用 Git 模式的優點包括，可以將各章節拆為不同檔案，並更容易附加圖片、程式碼等。</p>
				<div style="text-align: right">
					<g:if test="${book?.type.toString()=='GIT'}">
						<strong>已啟用</strong>
						|
						<g:link action="setupGit" id="${book?.id}">設定</g:link>
					</g:if>
					<g:else>
						<g:link action="modeChange" id="${book?.id}" params="[type: 'GIT']">啟用</g:link>
					</g:else>
				</div>
			</div>
			<div style="clear:both">
				<h3>SVN 版本控制</h3>
				<div style="float: left; padding: 0 20px">
					<img src="${createLinkTo(dir: 'images', file: 'mode_svn.png')}" class="icon" />
				</div>
				<p>SVN（Subversion）是廣泛使用的版本控制系統，您可以使用 <a href="http://code.google.com/hosting/" target="_blank">Google Project Hosting</a> 或其他 SVN 服務維護電子書原始碼。</p>
				<div style="text-align: right">
					<g:if test="${book?.type.toString()=='SVN'}">
						<strong>已啟用</strong>
						|
						<g:link action="setupSvn" id="${book?.id}">設定</g:link>
					</g:if>
					<g:else>
						<g:link action="modeChange" id="${book?.id}" params="[type: 'SVN']">啟用</g:link>
					</g:else>
				</div>
			</div>
			<div style="clear:both">
				<h3>Dropbox 雲端硬碟</h3>
				<div style="float: left; padding: 0 20px">
					<img src="${createLinkTo(dir: 'images', file: 'mode_dropbox.png')}" class="icon" />
				</div>
				<p>利用 Dropbox 服務儲存電子書原始碼，讓您可以使用喜愛的文字編輯器輕鬆撰寫電子書原始碼，同時也適用於 iPad 平板電腦。此模式可以將章節拆為不同檔案，並附帶圖片、程式碼。本模式變更完成後，必須等待服務人員幫您建立 Dropbox 共享資料夾。</p>
				<p style="color:red">這項功能目前為測試階段，需要聯繫系統管理員協助設定。</p>
				<div style="text-align: right">
					<g:if test="${book?.type.toString()=='DROPBOX'}">
						<strong>已啟用</strong>
					</g:if>
					<g:else>
						<g:link action="modeChange" id="${book?.id}" params="[type: 'DROPBOX']">啟用</g:link>
					</g:else>
				</div>
			</div>
		</div>
		<div class="left">
			<g:render template="leftMenu"></g:render>
		</div>
	</div>
</body>
</html>
