<!--<iframe src="//www.facebook.com/plugins/likebox.php?href=${href.encodeAsURL()}&amp;width=${width}&amp;colorscheme=${colorscheme}&amp;show_faces=${show_faces}&amp;border_color=${border_color.encodeAsURL()}&amp;stream=${stream}&amp;header=${header}&amp;height=${height}" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:${width}px; height:${height}px;" allowTransparency="true"></iframe>-->
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) {return;}
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<div class="fb-like-box" data-href="${href}" data-width="${width}" data-show-faces="${show_faces}" data-border-color="${border_color}" data-stream="${stream}" data-header="${header}"></div>
