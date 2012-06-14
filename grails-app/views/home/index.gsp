<html>
<head>
<title>Welcome</title>
</head>
<body>
<header class="jumbotron masthead">
	<div class="inner">
		<h1 class="text-shadow">Continuous Publishing</h1>
		<p>Typing and self-publish anytime, anywhere... Get awesome eBooks with your favorite devices in minutes.</p>
		<p class="text-shadow"><g:img uri="/images/leaf-64.png" /> PDF, EPUB, MOBI and HTML <small>is ready.</small></p>
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
		<!--<ul class="quick-links">
			<li><a href="./upgrading.html">Upgrading from 1.4</a></li>
			<li><a href="https://github.com/twitter/bootstrap/zipball/master">Download with docs</a></li>
			<li><a href="http://blog.getbootstrap.com">Read the blog</a></li>
			<li><a href="https://github.com/twitter/bootstrap/issues?state=open">Submit issues</a></li>
			<li><a href="https://github.com/twitter/bootstrap/wiki">Roadmap and changelog</a></li>
		</ul>-->
		<ul class="quick-links">
			<li class="follow-btn"><socialTag:twitterFollow /></li>
			<li class="follow-btn"><socialTag:facebookFollow /></li>
			<li class="follow-btn"><socialTag:googleFollow /></li>
		</ul>
	</div>
</header>

<div class="hero-unit">
  <g:img uri="/images/champion.png" align="left" />
  <h1>Award-Winning Innovation</h1>
  <p>Cloud Application <strong>Champion</strong> in 2012 Open Software Competition</p>
  <p>「ContPub 雲端電子書自助出版平台」<br/>榮獲 2012 年開放軟體創作競賽，產學合作組<strong>金牌</strong>。</p>
  <p>
	<a class="btn btn-primary btn-large" href="http://osc2012.csie.ncku.edu.tw/news.php">
	  Read more
	</a>
  </p>
</div>

<hr class="soften" />

<div class="marketing">
	<h1 class="text-shadow">Featured Books</h1>
	<p class="marketing-byline">Would you like to read more book? Please try to <g:link controller="explore">explore</g:link>.</p>
	<ul class="thumbnails example-sites">
		<li class="span3">
			<div class="thumbnail">
				<g:img uri="/images/cover-nodejs.png" />
				<h5>Node.js Taiwan 中文電子書</h5>
				<p>由台灣社群作者協作，從初學到進階都適用的開發指南。</p>
				<g:link controller="book" action="read" id="nodejs-wiki-book" class="btn btn-primary">Read more</g:link>
			</div>
		</li>
		<li class="span3">
			<div class="thumbnail">
				<g:img uri="/images/cover-javasteps.png" />
				<h5>Java Steps：手腦並用學 Java</h5>
				<p>適合大學課程的 Java 程式設計教科書，搭配豐富詳盡的 TQC+ Java 認證題庫與補充練習。</p>
				<g:link controller="book" action="read" id="JavaSteps" class="btn btn-primary">Read more</g:link>
			</div>
		</li>
		<li class="span3">
			<div class="thumbnail">
				<g:img uri="/images/cover-mongodb.png" />
				<h5>The Little MongoDB Book 中文版</h5>
				<p>MongoDB 是效能極高的 NoSQL 資料庫軟體，這本書適合剛開始接觸的初學者。</p>
				<g:link controller="book" action="read" id="the-little-mongodb-book-zh-tw" class="btn btn-primary">Read more</g:link>
			</div>
		</li>
		<li class="span3">
			<div class="thumbnail">
				<h5>正常的基督徒生活</h5>
				<p>《正常的基督徒生活》（英語：The Normal Christian Life）是倪柝聲於1938年至1939年旅行歐洲時完成的著名作品，首先用英語在英國（開西大會）、丹麥講道時發表，回中國後由上海福音書房出版了中文文本。該書被許多基督徒視為經典著作，這也是西方基督教界最熟悉的一本倪柝聲著作。該書已經用多種語言出版，至今至少出版了25萬冊。</p>
				<g:link controller="book" action="read" id="normal-christan-life" class="btn btn-primary">Read more</g:link>
			</div>
		</li>
	</ul>
</div>

</body>
</html>
