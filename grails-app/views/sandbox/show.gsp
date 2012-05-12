<html>
<head>
<socialTag:openGraph title="${sandbox?.title}" type="book" url="${createLink(action: 'show', id: sandbox?.id, absolute: true)}" description="您也可以使用「沙盒」輕鬆製作一本電子書，趕快來體驗開放源碼電子書。" />
<title>${sandbox?.title}</title>
<layoutTag:webFonts family="Droid+Sans+Mono" />
<style tyle="text/css">
.CodeMirror {
	font-family: 'Droid Sans Mono', Consolata, monospace, sans-serif;
}
</style>
<r:require modules="codemirror" />
<r:script>
$(function() {
	$('.sourcecode').codemirror({runmode: true, mode: 'rst'});
});
</r:script>
</head>
<body>
	<ul class="breadcrumb">
		<li>
			<g:link action="index">Sandbox</g:link>
			<span class="divider">/</span>
		</li>
		<li class="active">${sandbox.title}</li>
	</ul>

	<div class="row">

		<div class="span3">
			<ul class="well nav nav-list">
				<li class="nav-header">Download</li>
				<li><g:link action="download" id="sandbox${sandbox?.id}.pdf">
					<i class="icon-download"></i>
					sandbox${sandbox?.id}.pdf
				</g:link></li>
				<li><g:link action="download" id="sandbox${sandbox?.id}.epub">
					<i class="icon-download"></i>
					sandbox${sandbox?.id}.epub
				</g:link></li>
				<li><g:link action="download" id="sandbox${sandbox?.id}.mobi">
					<i class="icon-download"></i>
					sandbox${sandbox?.id}.mobi
				</g:link></li>
				<userTag:isLogin>
					<li class="nav-header">Actions</li>
					<li>
						<g:link action="publish" params="[create: true, template: sandbox?.id]">
							<i class="icon-file"></i> Use as template
						</g:link>
					</li>
					<g:if test="${sandbox.owner==user}">
						<li>
							<g:link action="publish" id="${sandbox.id}">
								<i class="icon-edit"></i>
								<g:message code="button.edit" default="Edit" />
							</g:link>
						</li>
						<li>
							<g:link action="delete" id="${sandbox.id}" onclick="return confirm('Are you sure?')">
								<i class="icon-remove"></i>
								<g:message code="button.delete" default="Delete" />
							</g:link>
						</li>
					</g:if>
				</userTag:isLogin>
			</ul>
		</div>

		<div class="span9">
			<h1>${sandbox?.title}</h1>
			<p>Authors: ${sandbox?.authors} (${sandbox?.owner?.name})</p>

			<div style="height:50px;overflow:hidden">
				<socialTag:facebookLikeButton />
			</div>

			<h3>Source Code</h3>
			<pre class="sourcecode">${sandbox?.contents?.encodeAsHTML()}</pre>
		</div>

	</div>

	<hr class="soften" />

	<div class="comments" style="min-height:250px">
		<socialTag:disqus identifier="sandbox-${sandbox?.id}" url="${createLink(action: 'show', id: sandbox?.id, absolute: true)}" />
	</div>

</body>
</html>
