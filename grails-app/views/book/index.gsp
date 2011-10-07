<html>
<head>
<style type="text/css">
#bookshelf {
	margin: 0 auto;
	width: 600px;
	height: 616px;
	padding: 0;
	border: 1px solid black;
	background: url(${createLinkTo(dir: 'images', file: 'bookshelf_600px.png')})
}
#bookshelf .inner {
	border: 0;
	margin: 55px 0 0 27px;
	padding: 0 auto;
}
#bookshelf a {
	border: 0;
	padding: 0;
	margin: 0;
}
#bookshelf a .box {
	background: transparent;
	border: 0;
	float: left;
	margin-bottom: 28px;
	margin-right: 12px;
	width: 100px;
	height: 115px;
	text-align: center;
}
#bookshelf a:hover .box {
}
#bookshelf a .empty {
	display: block;
	border: 0;
	background: #ffffff;
	text-align: center;
	font-size: 11px;
	color: black;
	width: 95px;
	height: 115px;
}
#bookshelf a img {
	border: 0;
	padding: 0;
	margin: 0;
	height: 115px;
	border-radius: 0;
}
</style>
</head>
<body>
<!--
<ul>
<g:each in="${books}" var="book">
	<li><g:link action="show" id="${book.id}">${book.title}</g:link></li>
</g:each>
</ul>
-->

<div id="bookshelf"><div class="inner">
<g:each in="${books}" var="book">
<a href="${createLink(url:book.link)}" title="${book.title}">
<div class="box">
<g:if test="${book.cover==null||book.cover.equals('')}">
<span class="empty">${book.title}</span>
</g:if>
<g:else>
<img src="${book.cover}" alt="${book.title}" />
</g:else>
</div>
</a>
</g:each>
<!--
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
<a href="#"><div class="box"><img src="http://freeebooksearch.net/pics/ce839_java_51IJ8LZqxmL.jpg" /></div></a>
-->
<div style="clear:both"></div>
</div></div>


</body>
</html>
