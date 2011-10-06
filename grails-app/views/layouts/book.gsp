<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title><g:layoutTitle default="Book" /> - ${grailsApplication.config.appConf.title}</title>
<meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" />
<meta name="author" content="Erwin Aligam - styleshout.com" />
<meta name="description" content="Site Description Here" />
<meta name="keywords" content="keywords, here" />
<meta name="robots" content="index, follow, noarchive" />
<meta name="googlebot" content="noarchive" />
<link rel="stylesheet" type="text/css" media="screen" href="${createLinkTo(dir: 'css', file: 'screen.css')}" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
<g:layoutHead />
</head>
<body>
<!--header -->
<div id="header-wrap"><div id="header">
	<a name="top"></a>
	<h1 id="logo-text"><a href="#" title="">${grailsApplication.config.appConf.title}</a></h1>
	<p id="slogan">${grailsApplication.config.appConf.subTitle}</p>

	<div  id="nav">
		<ul>
			<li><a href="#">Home</a></li>
			<li id="${actionName!='create'?'current':'candidate'}"><a href="${createLink('/')}">Books</a></li>
			<li id="${actionName=='create'?'current':'candidate'}"><a href="${createLink(action: 'create')}">Publish</a></li>
			<li><a href="#">Explorer</a></li>
			<li><a href="#">Support</a></li>
			<li><a href="#">About</a></li>
		</ul>
	</div>
   <p id="rss">
      <a href="#">Grab the RSS feed</a>
   </p>
   <form id="quick-search" method="get" action="#">
      <fieldset class="search">
         <label for="qsearch">Search:</label>
         <input class="tbox" id="qsearch" type="text" name="qsearch" value="Search..." title="Start typing and hit ENTER" />
         <button class="btn" title="Submit Search">Search</button>
      </fieldset>
   </form>
<!--/header-->
</div></div>
	
<!-- content-outer -->
<div id="content-wrap" class="clear" >

	<!-- content -->
   <div id="content">

   <!--main-->
   <div id="main"><g:layoutBody /></div>
   <!--main-->

      <!-- sidebar -->
		<div id="sidebar">

      	<div class="about-me">

         	<h3>我的書櫃</h3>
		      <p>
		      <a href="#"><img src="images/gravatar.jpg" width="40" height="40" alt="firefox" class="float-left" /></a>
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec libero. Suspendisse bibendum.
			   Cras id urna. Morbi tincidunt, orci ac convallis aliquam, lectus turpis varius lorem, eu
			   posuere nunc justo tempus leo <a href="#">Learn more...</a>
				</p>

         </div>

      <!-- /sidebar -->
		</div>

    <!-- content -->
	</div>

<!-- /content-out -->
</div>
		
<!-- footer-outer -->
<div id="footer-outer" class="clear"><div id="footer-wrap">

<div id="gallery" class="clear">
<h3>Flickr Photos </h3>
<p class="thumbs">
	<a href="#"><img src="${createLinkTo(dir: 'images', file: 'thumb.jpg')}" width="40" height="40" alt="thumbnail" /></a>
	<a href="#"><img src="${createLinkTo(dir: 'images', file: 'thumb.jpg')}" width="40" height="40" alt="thumbnail" /></a>
	<a href="#"><img src="${createLinkTo(dir: 'images', file: 'thumb.jpg')}" width="40" height="40" alt="thumbnail" /></a>
	<a href="#"><img src="${createLinkTo(dir: 'images', file: 'thumb.jpg')}" width="40" height="40" alt="thumbnail" /></a>
	<a href="#"><img src="${createLinkTo(dir: 'images', file: 'thumb.jpg')}" width="40" height="40" alt="thumbnail" /></a>
	<a href="#"><img src="${createLinkTo(dir: 'images', file: 'thumb.jpg')}" width="40" height="40" alt="thumbnail" /></a>
	<a href="#"><img src="${createLinkTo(dir: 'images', file: 'thumb.jpg')}" width="40" height="40" alt="thumbnail" /></a>
	<a href="#"><img src="${createLinkTo(dir: 'images', file: 'thumb.jpg')}" width="40" height="40" alt="thumbnail" /></a>
	<a href="#"><img src="${createLinkTo(dir: 'images', file: 'thumb.jpg')}" width="40" height="40" alt="thumbnail" /></a>
	<a href="#"><img src="${createLinkTo(dir: 'images', file: 'thumb.jpg')}" width="40" height="40" alt="thumbnail" /></a>
</p>
</div>
<!-- /footer-outer -->
</div></div>

<!-- footer-bottom -->
<div id="footer-bottom">
<p class="bottom-left">
	&copy; 2010 <strong>Copyright Info</strong>&nbsp; &nbsp; &nbsp;
	Design by <a href="http://www.styleshout.com/">styleshout</a>
</p>
<p class="bottom-right">
	<a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a> |
	<a href="http://validator.w3.org/check/referer">XHTML</a>	|
	<a href="#">Home</a> |
	<a href="#">Sitemap</a> |
	<a href="#">RSS Feed</a> |
	<strong><a href="#top">Back to Top</a></strong>
</p>
<!-- /footer-bottom-->
</div>

</body>
</html>
