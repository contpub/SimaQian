<html>
<head>
<title><g:message code="title.publish.sale" default="Sales Management" /></title>
</head>
<body>
<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.reader', default: 'Readers')]" />
<div class="row">
	<div class="span3">
		<g:render template="leftMenu" />
	</div>
	<div class="span9">
		<g:form controller="publish" action="sale" id="${book?.id}" method="post">
			<table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>選取</th>
						<th>#</th>
						<th>E-Mail</th>
						<th>購買者</th>
						<th>購買方式</th>
						<th>單號</th>
						<th>備註</th>
						<th>建立日期</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<g:each status="i" var="row" in="${buyers}">
						<tr>
							<td><g:checkBox name="selBuyerId" value="${row?.id}" checked="false" /></td>
							<td>${i+1}</td>
							<td>${row?.email}</td>
							<td>${row?.name}</td>
							<td>${row?.method}</td>
							<td>${row?.serial}</td>
							<td>${row?.memo}</td>
							<td>${row?.dateCreated?.format('yyyy/MM/dd')}</td>
							<td>
								<g:link action="sale" id="${book?.id}" params="[unlink: row?.id]" onclick="return confirm('請再次確認???')">刪除</g:link>
							</td>
					</g:each>				
				</tbody>
			</table>
			選取的購買者：
			<g:submitButton name="sendmail" value="寄發下載通知" class="btn" />
			<g:submitButton name="batchunlink" value="批次刪除" class="btn" />
		</g:form>

		<hr class="soften" />

		<g:form controller="publish" action="sale" id="${book?.id}" class="well">
			<legend>新增一位購買者</legend>
			<g:hasErrors bean="${buyer}">
				<div class="alert alert-error">
					<a class="close" data-dismiss="alert" href="#">×</a>
					<h4>Please correct these errors</h4>
					<g:renderErrors bean="${buyer}" />
				</div>
			</g:hasErrors>
			<label for="email">請輸入購買者的 E-Mail</label>
			<div class="controls">
				<g:textField name="email" value="${buyer.email}" class="input-xlarge" />
			</div>
			<label for="name">購買者（姓名）</label>
			<div class="controls">
				<g:textField name="name" value="${buyer.name}" class="input-large" />
			</div>
			<label for="method">購買方式</label>
			<div class="controls">
				<g:select name="method" value="${buyer.method}" from="${['paypal']}" />
			</div>
			<label for="serial">單號</label>
			<div class="controls">
				<g:textField name="serial" value="${buyer.serial}" class="input-large" />
			</div>
			<label for="memo">備註</label>
			<div class="controls">
				<g:textArea name="memo" value="${buyer.memo}" class="input-xlarge" />
			</div>
			
			<g:submitButton name="add" value="新增購買者" class="btn btn-primary" />
			<bookTag:link book="${book}" class="btn"><g:message code="common.cancel" default="Cancel"/></bookTag:link>
		</g:form>
	</div>
</div>
</body>
</html>
