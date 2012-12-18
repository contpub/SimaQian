<html>
<head>
<title>Welcome</title>
</head>
<body>
<header class="jumbotron masthead">
	<div class="inner">
		<h1 class="text-shadow">Continuous Publishing</h1>
		<p>Typing and self-publish anytime, anywhere... Get awesome eBooks with your favorite devices in minutes.</p>
		<p class="text-shadow"><g:img uri="/images/leaf-64.png" /> PDF, EPUB, MOBI and HTML</p>
		<p class="download-info">
			<userTag:isLogin>
				<g:link controller="publish" action="create" class="btn btn-primary btn-large">Publish now »</g:link>
			</userTag:isLogin>
			<userTag:isNotLogin>
				<g:link action="signup" class="btn btn-success btn-large">Sign up now »</g:link>
			</userTag:isNotLogin>
			<g:link controller="page" action="show" params="[category: 'help', name: 'learning']" class="btn btn-large">Learning <small>step by step</small></g:link>
		</p>
	</div>
	<div class="bs-links">
		<ul class="quick-links">
			<li class="follow-btn"><socialTag:twitterFollow /></li>
			<li class="follow-btn"><socialTag:facebookFollow /></li>
			<li class="follow-btn"><socialTag:googleFollow /></li>
		</ul>
	</div>
</header>

<hr class="soften" />

<div class="marketing">
	<ul class="thumbnails example-sites">
		<li class="span3">
			<h1 class="text-shadow">Featured Books</h1>
			<p class="marketing-byline">Would you like to read more book? Please try to <g:link controller="explore">explore</g:link>.</p>
		</li>
		<li class="span3">
			<div class="thumbnail">
				<g:img uri="/images/cover-nodejs.png" />
				<h5>Node.js Taiwan 中文電子書</h5>
				<p>由台灣社群作者協作，從初學到進階都適用的開發指南。</p>
				<g:link controller="book" action="read" id="nodejs-wiki-book" class="btn btn-primary"><g:message code="common.readMore" default="Read more" /></g:link>
			</div>
		</li>
		<li class="span3">
			<div class="thumbnail">
				<g:img uri="/images/cover-mongodb.png" />
				<h5>The Little MongoDB Book 中文版</h5>
				<p>MongoDB 是效能極高的 NoSQL 資料庫軟體，這本書適合剛開始接觸的初學者。</p>
				<g:link controller="book" action="read" id="the-little-mongodb-book-zh-tw" class="btn btn-primary"><g:message code="common.readMore" default="Read more" /></g:link>
			</div>
		</li>
	</ul>
</div>

</body>
</html>
