<html>
<head>
<title><g:message code="view.publish.menu.media" default="Media types" /></title>
</head>
<body>
	<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.media', default: 'Media types')]" />
	
	<div id="post">
		<div class="right">
			<g:renderErrors bean="${book}" />

			<g:form action="mediaSave" id="${book?.id}">

				<layoutTag:flashMessage />

				<!--display errors-->
				<div class="form-errors">
					<g:renderErrors bean="${book}" as="list" />
				</div>

				<p>
					<label>Available Formats</label><br/>
					
					<g:checkBox name="pdf" value="${book.formats?.contains('pdf')}" />
					<label for="pdf">PDF</label> PC/iPad/Android/Printable<br/>
					
					<g:checkBox name="epub" value="${book.formats?.contains('epub')}" />
					<label for="epub">EPUB</label> iPad/iPhone/Android<br/>
					
					<g:checkBox name="mobi" value="${book.formats?.contains('mobi')}" />
					<label for="mobi">MOBI</label> Kindle<br/>
					
					<g:checkBox name="html" value="${book.formats?.contains('html')}" />
					<label for="html">HTML</label> Browsers(ZIP archive file)<br/>
				</p>
				
				<p>
					<label for="vhost">Virtual Host</label><br />
					<g:textField name="vhost" value="${book?.vhost}" class="w90p" /><br/>
					Using your DNS manager, create a CNAME alias record to <strong>vhost.contpub.org</strong> for your sub domain (e.g. book.your-domain-name.com).<br/>
					<g:checkBox name="generate" />
					<label for="generate">generate contents</label>
				</p>
				
				<p class="no-border">
					<div id="message"></div>
					<div id="error"></div>

					<g:submitButton name="create" value="${message(code: 'common.update', default: 'Update')}" class="fancy-button-submit" />
				</p>

			</g:form>
		</div>
		<div class="left">
			<g:render template="leftMenu"></g:render>
		</div>
	</div>
</body>
</html>
