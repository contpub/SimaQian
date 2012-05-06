<html>
<head>
<title>Manage Readers</title>
</head>
<body>
<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.reader', default: 'Readers')]" />
<div class="row">
	<div class="span3">
		<g:render template="leftMenu" />
	</div>
	<div class="span9">
		<table class="table">
			<thead>
				<tr>
					<th>#</th>
					<th>E-Mail</th>
					<th>Name</th>
					<th>User Name</th>
					<th>Type</th>
					<th>Date</th>
				</tr>
			</thead>
			<tbody>
				<g:each status="i" var="userLink" in="${book?.users}">
					<tr>
						<td>${i+1}</td>
						<td>${userLink.user.email}</td>
						<td>${userLink.user.account}</td>
						<td>${userLink.user.name}</td>
						<td>${userLink.linkType}</td>
						<td>${userLink.dateCreated.format('yyyy/MM/dd')}</td>
				</g:each>				
			</tbody>
		</table>

		<g:form action="reader" id="${book?.id}" class="well">
			<label for="email">E-Mail</label>
			<div class="controls">
				<g:textField name="email" value="" class="input-xlarge" />
			</div>
			<g:submitButton name="add" value="Add Reader" class="btn btn-primary" />
			<bookTag:link book="${book}" class="btn">Cancel</bookTag:link>
		</g:form>
	</div>
</div>
</body>
</html>
