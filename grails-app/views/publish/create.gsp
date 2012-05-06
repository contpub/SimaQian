<html>
<head>
<title>Publish</title>
<script type="text/javascript">
$(function () {
	$('#agreement').toggle(function() {
		$('#agreement-frame').show();
	}, function() {
		$('#agreement-frame').hide();
	});

	$('#name').keyup(function() {
		$('.preview-name').text($(this).val());
	});
	
	$('#agree').click(function () {
		if ($('form #agree').is(':checked')) {
			$('form #create').show();
		}
		else {
			$('form #create').hide();
		}
	});
	
	$('.controls.error input').focus();
});
</script>
</head>
<body>
<g:renderErrors bean="${book}" />
<div class="row">
	<div class="span3">
		<p>Typing and self-publish anytime, anywhere... Get awesome eBooks with your favorite devices in minutes.</p>
		<p>${booknums} books have been established in the past.</p>
	</div>
	<div class="span9">
		<g:hasErrors bean="${book}">
			<div class="alert alert-error">
				<a class="close" data-dismiss="alert" href="#">×</a>
				<h4>Please correct these errors</h4>
				<g:renderErrors bean="${book}" as="list" />
			</div>
		</g:hasErrors>
		<g:form action="create" class="form-horizontal">
			<fieldset>
				<!--name-->
				<div class="control-group ${hasErrors(bean: book, field: 'name', 'error')}">
					<label class="control-label" for="name">File Name</label>
					<div class="controls">
						<g:textField name="name" value="${book?.name}" class="input-medium" />
						<p class="help-block">
							Book URLs preview:<br/>
							<i class="icon-book"></i> ${grailsApplication.config.appConf.baseUrl}read/<span class="preview-name">${book?.name}</span><br/>
							<i class="icon-file"></i> ${grailsApplication.config.appConf.baseUrl}download/<span class="preview-name">${book?.name}</span>.pdf<br/>
						</p>
					</div>
				</div>

				<!--title-->
				<div class="control-group ${hasErrors(bean: book, field: 'title', 'error')}">
					<label class="control-label" for="title">Book Title</label>
					<div class="controls">
						<g:textField name="title" value="${book?.title}" class="input-xlarge" />
						<p class="help-block">e.g. My First Book</p>
					</div>
				</div>

				<!--permissions-->
				<div class="control-group ${hasErrors(bean: book, field: 'isPublic', 'error')}">
					<label class="control-label">Permissions</label>
					<div class="controls">
						<label class="checkbox" for="isPublic"><g:checkBox name="isPublic" value="${book?.isPublic}" /> <g:message code="view.publish.form.isPublic" default="Public" /></label>
						<p class="help-block"><g:message code="view.publish.form.isPublic.desc" default="Everyone can download this book, including an unpaid user." /></p>
					</div>
				</div>

				<!--agreement-->
				<div class="control-group">
					<label class="control-label">Agreement</label>
					<div class="controls">
						<label class="checkbox" for="agree"><g:checkBox name="agree" value="${true}" /> I have read, understood, and agree to <a href="#" id="agreement">Publishing Agreement</a>.</label>
						<div id="agreement-frame" class="well" style="display:none"><iframe src="${createLinkTo(file: 'agreement-zh_TW.html')}" style="width:100%;border:none"></iframe></div>
					</div>
				</div>

				<!--actions-->
				<div class="form-actions">
					<g:submitButton name="create" value="Create" class="btn btn-primary" />
					<g:link controller="home" action="index" class="btn">Cancel</g:link>
				</div>
			</fieldset>
		</g:form>
	</div>
</div>
</body>
</html>
