<html>
<head>
	<title>Sandbox List</title>
</head>
<body>
	<userTag:isLogin>
		<g:link action="publish" params="[create: true]">Create a new sandbox</g:link>
	</userTag:isLogin>
	<g:if test="${sandboxList?.size()>0}">
	<ul>
		<g:each in="${sandboxList}" var="sandbox">
			<li>
				<g:link action="show" id="${sandbox?.id}">${sandbox?.title}</g:link>
			</li>
		</g:each>
	</ul>
	</g:if>
	<g:else>
		<p>沙盒櫃是空的！</p>
	</g:else>
	<userTag:isNotLogin>
		<p>以您的個人帳號登入，可以擁有自己的沙盒櫃，日後可以繼續編輯、發佈沙盒的電子書。</p>
	</userTag:isNotLogin>
</body>
</html>
