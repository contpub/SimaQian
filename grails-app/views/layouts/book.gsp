<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>${grailsApplication.config.appConf.title}</title>
<meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" />
<meta name="author" content="Erwin Aligam - styleshout.com" />
<meta name="description" content="Site Description Here" />
<meta name="keywords" content="keywords, here" />
<meta name="robots" content="index, follow, noarchive" />
<meta name="googlebot" content="noarchive" />
<link rel="stylesheet" type="text/css" media="screen" href="${createLinkTo(dir: 'css', file: 'screen.css')}" />
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
			<li id="current"><a href="${createLink('/')}">Books</a></li>
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

         	<h3>About Me</h3>
		      <p>
		      <a href="#"><img src="images/gravatar.jpg" width="40" height="40" alt="firefox" class="float-left" /></a>
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec libero. Suspendisse bibendum.
			   Cras id urna. Morbi tincidunt, orci ac convallis aliquam, lectus turpis varius lorem, eu
			   posuere nunc justo tempus leo <a href="#">Learn more...</a>
				</p>

         </div>

			<div class="sidemenu">

				<h3>Sidebar Menu</h3>
                <ul>
					<li><a href="#">Home</a></li>
					<li><a href="##TemplateInfo">TemplateInfo</a></li>
					<li><a href="style.html">Style Demo</a></li>
					<li><a href="blog.html">Blog</a></li>
					<li><a href="archives.html">Archives</a></li>
				</ul>

			</div>

			<div class="sidemenu">

				<h3>Sponsors</h3>

                <ul>
					<li><a href="http://themeforest.net?ref=ealigam" title="Site Templates">Themeforest <br />
	            	<span>Site Templates, Web &amp; CMS Themes.</span></a>
	            </li>
					<li><a href="http://www.4templates.com/?go=228858961" title="Website Templates">4Templates <br />
	            	<span>Low Cost High-Quality Templates.</span></a>
	            </li>
					<li><a href="http://store.templatemonster.com?aff=ealigam" title="Web Templates">Templatemonster <br />
	            	<span>Delivering the Best Templates on the Net!</span></a>
	            </li>
					<li><a href="http://graphicriver.net?ref=ealigam" title="Stock Graphics">Graphic River <br />
	            	<span>Awesome Stock Graphics.</span></a>
	            </li>
                    <li><a href="http://www.dreamhost.com/r.cgi?287326|sshout" title="Webhosting">Dreamhost <br />
	            	<span>Premium Webhosting. Use the promocode <strong>sshout</strong> and save <strong>50 USD</strong>.</span></a>
	            </li>


				</ul>

			</div>

         <div class="popular">

				<h3>Most Popular</h3>
				<ul>
			   	<li><a href="#">Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</a>
						<br /><span>Posted on December 22, 2010</span>
					</li>
               <li><a href="#">Cras fringilla magna. Phasellus suscipit.</a>
						<br /><span>Posted on December 20, 2010</span>
					</li>
               <li><a href="#">Morbi tincidunt, orci ac convallis aliquam.</a>
						<br /><span>Posted on December 15, 2010</span>
					</li>
               <li><a href="#">Ipsum dolor sit amet, consectetuer adipiscing elit.</a>
						<br /><span>Posted on December 14, 2010</span>
					</li>
               <li><a href="#">Morbi tincidunt, orci ac convallis aliquam, lectus turpis varius lorem</a>
						<br /><span>Posted on December 12, 2010</span>
					</li>
				</ul>

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
			<a href="#"><img src="images/thumb.jpg" width="40" height="40" alt="thumbnail" /></a>
			<a href="#"><img src="images/thumb.jpg" width="40" height="40" alt="thumbnail" /></a>
			<a href="#"><img src="images/thumb.jpg" width="40" height="40" alt="thumbnail" /></a>
			<a href="#"><img src="images/thumb.jpg" width="40" height="40" alt="thumbnail" /></a>
			<a href="#"><img src="images/thumb.jpg" width="40" height="40" alt="thumbnail" /></a>
			<a href="#"><img src="images/thumb.jpg" width="40" height="40" alt="thumbnail" /></a>
			<a href="#"><img src="images/thumb.jpg" width="40" height="40" alt="thumbnail" /></a>
			<a href="#"><img src="images/thumb.jpg" width="40" height="40" alt="thumbnail" /></a>
         <a href="#"><img src="images/thumb.jpg" width="40" height="40" alt="thumbnail" /></a>
			<a href="#"><img src="images/thumb.jpg" width="40" height="40" alt="thumbnail" /></a>
      </p>

    </div>

	<div class="col-a">
		<h3>Contact Info</h3>	
		<p>
			<strong>Phone: </strong>+1234567<br/>
			<strong>Fax: </strong>+123456789
		</p>
		<p><strong>Address: </strong>123 Put Your Address Here</p>
		<p><strong>E-mail: </strong>lyhcode@gmail.com</p>
		<p>Want more info - go to our <a href="#">contact page</a></p>
	
		<h3>Updates</h3>
		<ul class="subscribe-stuff">
		<li><a title="RSS" href="#" rel="nofollow">
		<img alt="RSS" title="RSS" src="images/social_rss.png" /></a>
		</li>
		<li><a title="Facebook" href="#" rel="nofollow">
		<img alt="Facebook" title="Facebook" src="images/social_facebook.png" /></a>
		</li>
		<li><a title="Twitter" href="#" rel="nofollow">
		<img alt="Twitter" title="Twitter" src="images/social_twitter.png" /></a>
		</li>
		<li><a title="E-mail this story to a friend!" href="#" rel="nofollow">
		<img alt="E-mail this story to a friend!" title="E-mail this story to a friend!" src="images/social_email.png" /></a>
		</li>
		</ul>
		
		<p>Stay up to date. Subscribe via
			<a href="index">RSS</a>, <a href="index">Facebook</a>,
			<a href="index">Twitter</a> or <a href="index">Email</a>
		</p>	
	</div>

	<div class="col-a">

   	<h3>Site Links</h3>

		<div class="footer-list">
			<ul>
				<li><a href="#">Home</a></li>
				<li><a href="#">Style Demo</a></li>
				<li><a href="#">Blog</a></li>
				<li><a href="#">Archive</a></li>
				<li><a href="#">About</a></li>
				<li><a href="#">Template Info</a></li>
				<li><a href="#">Site Map</a></li>
			</ul>
		</div>

      <h3>Friends</h3>

		<div class="footer-list">
			<ul>
				<li><a href="#">consequat molestie</a></li>
				<li><a href="#">sem justo</a></li>
				<li><a href="#">semper</a></li>
				<li><a href="#">magna sed purus</a></li>
				<li><a href="#">tincidunt</a></li>
				<li><a href="#">consequat molestie</a></li>
				<li><a href="#">magna sed purus</a></li>
			</ul>
		</div>

	</div>

   <div class="col-a">

      <h3>Credits</h3>

      <div class="footer-list">
			<ul>
				<li><a href="http://jasonlarose.com/blog/110-free-classy-social-media-icons">
						110 Free Classy Social Media Icons by Jason LaRose
				    </a>
				</li>
            <li><a href="http://wefunction.com/2009/05/free-social-icons-app-icons/">
						Free Social Media Icons by WeFunction
				    </a>
				</li>
            <li><a href="http://www.famfamfam.com/lab/icons/">
						Free Icons by FAMFAMFAM
				    </a>
				</li>
			</ul>
		</div>

      <h3>Recent Comments</h3>

	   <div class="recent-comments">
         <ul>
			<li><a href="#" title="Comment on title">Whoa! This one is really cool...</a><br /> &#45; <cite>Erwin</cite></li>
			<li><a href="#" title="Comment on title">Wow. This theme is really awesome...</a><br /> &#45; <cite>John Doe</cite></li>
			<li><a href="#" title="Comment on title">Type your comment here...</a><br />&#45; <cite>Naruto</cite></li>
			<li><a href="#" title="Comment on title">And don't forget this theme is free...</a><br /> &#45; <cite>Shikamaru</cite></li>
         <li><a href="#" title="Comment on title">Just a simple reply test. Thanks...</a><br /> &#45; <cite>ABCD</cite></li>
			</ul>
		</div>

   </div>

   <div class="col-b">

      <h3>Archives</h3>

	   <div class="footer-list">
			<ul>
				<li><a href="#">January 2010</a></li>
				<li><a href="#">December 2009</a></li>
				<li><a href="#">November 2009</a></li>
				<li><a href="#">October 2009</a></li>
				<li><a href="#">September 2009</a></li>
			</ul>
		</div>

      <h3>Recent Bookmarks</h3>

	   <div class="footer-list">
			<ul>
				<li><a href="#">5 Must Have Sans Serif Fonts for Web Designers</a></li>
				<li><a href="#">The Basics of CSS3</a></li>
				<li><a href="#">10 Simple Tips for Launching a Website</a></li>
				<li><a href="#">24 ways: Working With RGBA Colour</a></li>
				<li><a href="#">30 Blog Designs with Killer Typography</a></li>
				<li><a href="#">The Principles of Great Design</a></li>
			</ul>
		</div>

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
