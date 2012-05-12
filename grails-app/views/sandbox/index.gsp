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
		<g:link action="index" class="btn">
			<i class="icon-list"></i> List only my items
		</g:link>
		<g:link action="index" params="[all: true]" class="btn">
			<i class="icon-list"></i> List all items
		</g:link>
		<g:link action="publish" params="[create: true]" class="btn btn-primary">
			<i class="icon-edit icon-white"></i> Create a new sandbox
		</g:link>
	</div>
</userTag:isLogin>
<h2>Sandbox items</h2>
<table class="table table-striped table-bordered">
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
							<g:link action="publish" id="${sandbox?.id}">Edit</g:link>
							|
							<g:link action="delete" id="${sandbox?.id}" onclick="return confirm('Are you sure?')">Delete</g:link>
						</g:if>
					</div>
				</td>
			</tr>
		</g:each>
	</tbody>
</table>
</body>
</html>
