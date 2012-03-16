<html>
<head>
<title>Delete a book</title>
<socialTag:websnaprSDK />
<resource:richTextEditor />
</head>
<body>
	<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.update', default: 'Basic settings')]" />
	<div id="post">
		<div class="right">
			<h2>刪除確認</h2>
			<p>
				請確認是否真的要要刪除這本書？<br/>
				${book?.title} (${book?.name})<br/>
				<g:link action="delete" id="${book?.id}" params="[confirm:'yes']">Yes</g:link>
				or
				<g:link action="update" id="${book?.id}">Cancel</g:link>
			</p>
		</div>
		<div class="left">
			<g:render template="leftMenu"></g:render>
		</div>
	</div>
</body>
</html>
