<html>
<head>
	<title>Sandbox List</title>
</head>
<body>
<ul class="breadcrumb">
	<li class="active">Sandbox</li>
</ul>
<userTag:isLogin>
	<div class="btn-group pull-right">
		<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
			Action
			<span class="caret"></span>
		</a>
		<ul class="dropdown-menu">
			<li><g:link action="publish">Editing my sandbox</g:link></li>
			<li><g:link action="publish" params="[create: true]">Create a new sandbox</g:link></li>
			<li><g:link action="list">Displays a list of all users</g:link></li>
			<li><g:link action="list" params="[user: user?.id]">Display only the list of individuals</g:link></li>
		</ul>
	</div>
</userTag:isLogin>

<table class="table table-striped">
	<thead>
		<tr>
			<th width="50">#</th>
			<th>Sandbox Title</th>
			<th width="200">Authors</th>
			<!--<th width="150">Last Updated</th>-->
			<th width="120">Action</th>
		</tr>
	</thead>
	<tbody>
		<g:each status="i" in="${sandboxList}" var="sandbox">
			<tr>
				<td>${i+1}</td>
				<td><g:link action="show" id="${sandbox?.id}">${sandbox?.title}</g:link></td>
				<td>${sandbox?.authors} <small>(${sandbox?.owner?.name})</small></td>
				<!--<td>${sandbox?.lastUpdated.format('yyyy-MM-dd HH:mm:ss')}</td>-->
				<td>
					<div class="btn-group">
						<!--<g:link action="publish" params="[create: true, template: sandbox?.id]" class="btn btn-small">Template</g:link>-->
						<g:if test="${sandbox?.owner==user}">
							<g:link action="publish" id="${sandbox?.id}" class="btn btn-small">Edit</g:link>
							<g:link action="delete" id="${sandbox?.id}" class="btn btn-small" onclick="return confirm('Are you sure?')">Delete</g:link>
						</g:if>
					</div>
				</td>
			</tr>
		</g:each>
	</tbody>
</table>
</body>
</html>
