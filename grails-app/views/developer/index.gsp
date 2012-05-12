<html>
<head>
<title>Developer</title>
</head>
<body>
<div class="row">
	<div class="span3">
		<ul class="nav nav-tabs nav-stacked">
			<li><a href="#doc-login">Login</a></li>
			<li><a href="#doc-category">Category</a></li>
			<li><a href="#doc-catalog">Catalog</a></li>
			<li><a href="#doc-favorite">Favorite</a></li>
		</ul>
	</div>
	<div class="span9">
		<div class="page-header">
			<h1>Developer Home</h1>
		</div>

		<p>Use ContPub as publishing engine of your own Internet Bookstore.</p>
		<p style="text-align:center"><img src="${createLinkTo(dir:'images', file:'developer-page.png')}" alt="developer page" /></p>

		<section id="doc-login">
			<div class="page-header">
				<h2>Login <small>user authentication</small></h2>
			</div>
			<p>URL Format</p>
			<pre>${g.basehref()}/api/<strong>login</strong>?user=<span class="label">guest</span>&amp;pwd=<span class="label">guest</span>&amp;store=<span class="label label-info">CafeBook</span>&amp;s=<span class="label label-important">SECURITY_CODE</span></pre>
			<p>Response Sample (JSON)</p>
			<pre>{"success":true,"session":"<span class="label label-warning">SESSION</span>"}</pre>
			<pre>{"success":false}</pre>
		</section>

		<section id="doc-category">
			<div class="page-header">
				<h2>Category</h2>
			</div>
			<p>URL Format</p>
			<pre>${g.basehref()}/api/<strong>category</strong>/<span class="label label-warning">SESSION</span></pre>
			<p>Response Sample (JSON)</p>
			<pre>[{"id":<span class="badge badge-success">1</span>,"label":"公版書"},{"id":2,"label":"軟體開發"},{"id":3,"label":"Upper Category","child":[{"id":4,"label":"Child Category"},{"id":5,"label":"Child Category Two"}]}]</pre>
		</section>
		
		<section id="doc-catalog">
			<div class="page-header">
				<h2>Catalog</h2>
			</div>
			<p>URL Format</p>
			<pre>${g.basehref()}/api/<strong>catalog</strong>/<span class="label label-warning">SESSION</span>/<span class="badge badge-success">1</span></pre>
			<p>Response Sample (JSON)</p>
			<pre>[{"name":"PUB000003","title":"孫子兵法","subtitle":"SunZi [ SunTzu ] - Art of War","authors":"孫武","favorite":true,"cover":"${g.basehref()}/cover/PUB000003.png","pdf":"${g.basehref()}/download/PUB000003.pdf","epub":"${g.basehref()}/download/PUB000003.epub"}]</pre>
		</section>

		<section id="doc-favorite">
			<div class="page-header">
				<h2>Favorite</h2>
			</div>
			<p>URL Format</p>
			<pre>${g.basehref()}/api/<strong>favorite</strong>/<span class="label label-warning">SESSION</span>/<span class="badge badge-success">1</span></pre>
			<pre>${g.basehref()}/api/<strong>favorite</strong>/<span class="label label-warning">SESSION</span>/<span class="badge badge-success">1</span>?<strong>cancel</strong>=true</pre>
			<p>Response Sample (JSON)</p>
			<pre>{"success":true}</pre>
			<pre>{"success":false}</pre>
		</section>
	</div>
</div>
</body>
</html>