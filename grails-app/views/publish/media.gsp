<html>
<head>
<title><g:message code="view.publish.menu.media" default="Media types" /></title>
</head>
<body>
<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.media', default: 'Media types')]" />
<div class="row">
	<div class="span3">
		<g:render template="leftMenu" />
	</div>
	<div class="span9">
		<g:hasErrors bean="${book}">
			<div class="alert alert-error">
				<a class="close" data-dismiss="alert" href="#">×</a>
				<h4>Please correct these errors</h4>
				<g:renderErrors bean="${book}" as="list" />
			</div>
		</g:hasErrors>
		<g:form action="media" id="${book?.id}" class="form-horizontal">
			<fieldset>
				<!--formats-->
				<div class="control-group ${hasErrors(bean: book, field: 'formats', 'error')}">
					<label class="control-label">Avaliable Formats</label>
					<div class="controls">
						<label class="checkbox" for="pdf"><g:checkBox name="pdf" value="${book.formats?.contains('pdf')}" />PDF</label>
						<p class="help-block">PC/iPad/Android/Printable</p>
					</div>
					<div class="controls">
						<label class="checkbox" for="epub"><g:checkBox name="epub" value="${book.formats?.contains('epub')}" />EPUB</label>
						<p class="help-block">iPad/iPhone/Android</p>
					</div>
					<div class="controls">
						<label class="checkbox" for="mobi"><g:checkBox name="mobi" value="${book.formats?.contains('mobi')}" />MOBI</label>
						<p class="help-block">Kindle</p>
					</div>
					<div class="controls">
						<label class="checkbox" for="html"><g:checkBox name="html" value="${book.formats?.contains('html')}" />HTML</label>
						<p class="help-block">Browsers (.zip)</p>
					</div>
				</div>

				<!--vhost-->
				<div class="control-group ${hasErrors(bean: book, field: 'vhost', 'error')}">
					<label class="control-label" for="vhost">Virtual Host</label>
					<div class="controls">
						<g:textField name="vhost" value="${book?.vhost}" class="input-xlarge" />
						<p class="help-block">Using your DNS manager, create a CNAME alias record to <strong>vhost.contpub.org</strong> for your sub domain (e.g. book.your-domain-name.com).</p>
					</div>
				</div>

				<!--actions-->
				<div class="form-actions">
					<g:submitButton name="update" value="Update" class="btn btn-primary" />
					<bookTag:link book="${book}" class="btn">Cancel</bookTag:link>
				</div>
			</fieldset>
		</g:form>
	</div>
</div>
</body>
</html>
