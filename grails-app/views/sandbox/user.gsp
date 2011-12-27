<html>
<head>
	<title>Sandbox</title>
	<style type="text/css">
	</style>
	<script type="text/javascript">
	$(function() {

		$('#button-create').button({
			icons: {
				primary: 'ui-icon-folder-open'
			}
		}).click(function() {
			location.href="${createLink(action: 'renew')}";
		});
	});
	</script>
</head>
<body>

	<userTag:isLogin>
		<button id="button-create"><g:message code="common.create" default="Create" /></button>
	</userTag:isLogin>
	<g:if test="${sandboxList?.size()>0}">
	<ul>
		<g:each in="${sandboxList}" var="mySandbox">
			<li>
				<g:link action="show" id="${mySandbox?.id}">${mySandbox?.title}</g:link>
				<g:link action="update" id="${mySandbox?.id}">[編輯]</g:link>
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
