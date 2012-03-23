<html>
<head>
<title>Publish</title>
	<meta name="current.action" content="publish" />
	<style style="text/css">
	form #name {
		width: 50%;
		color: #000055;
		font-weight: bold;
		font-size: 1.25em;
	}
	form #title, form #description {
		width: 90%;
	}
	form #description {
		height: 150px;
	}
	span.required {
		color: red;
		font-weight: bold;
	}
	.preview-list {
		font-size: .875em;
	}
	</style>
	<script type="text/javascript">
	$(function () {
		$('form #create').click(function () {
			var result = true;
			
			return result;
		});

		$('#agreement').toggle(function() {
			$('#agreement-frame').show();
		}, function() {
			$('#agreement-frame').hide();
		});

		$('#name').keyup(function() {
			$('.preview-name').text($(this).val());
		}).focus(function() {
			$('#preview-box').fadeIn();
		}).blur(function() {
			$('#preview-box').fadeOut();
		});
		
		$('#agree').click(function () {
			if ($('form #agree').is(':checked')) {
				$('form #create').show();
			}
			else {
				$('form #create').hide();
			}
		});
		
		$('form input.errors').focus();
	});
	</script>
</head>
<body>

	<g:renderErrors bean="${book}" />

	<g:form action="save">

		<p class="no-border"><strong>Basic configuration</strong> (<span class="required">*</span> is required)</p>

		<p>
			<label for="name">Name</label>
			(e.g. my-first-book)
			<span class="required">*</span><br/>
			<g:textField name="name" value="${book?.name}" />
		</p>

		<div id="preview-box" style="display:none">
			Book URLs preview:
			<ul class="preview-list">
				<li>${grailsApplication.config.appConf.baseUrl}read/<span class="preview-name">${book?.name}</span></li>
				<li>${grailsApplication.config.appConf.baseUrl}download/<span class="preview-name">${book?.name}</span>.pdf</li>
				<li>${grailsApplication.config.appConf.cdn.href}pubic/<span class="preview-name">${book?.name}</span>/index.html</li>
			</ul>
		</div>


		<p>
			<label for="title">Book Title</label>
			(e.g. My First Book)
			<span class="required">*</span><br />
			<g:textField name="title" value="${book?.title}" />
		</p>

		<!-- Defaults -->
		<g:hiddenField name="type" value="EMBED" />
		<g:hiddenField name="url" value="" />
		
		<p>
			<strong>Permissions</strong><br/>
			<g:checkBox name="isPublic" value="${book?.isPublic}" />
			<label for="isPublic"><g:message code="view.publish.form.isPublic" default="Public" /></label><br/>
			<g:message code="view.publish.form.isPublic.desc" default="Everyone can download this book, including an unpaid user." />
		</p>

		<p>
			<strong>Agreement</strong><br/>
			<g:checkBox name="agree" value="${true}" />
			<label for="agree">I have read, understood, and agree to <a href="#" id="agreement">Publishing Agreement</a></label><br/>
			<iframe id="agreement-frame" src="${createLinkTo(file: 'publishing-agreement.html')}" style="width:90%;display:none"></iframe>
		</p>

		<p class="no-border">
			<g:submitButton name="create" value="Create" class="button" />
		</p>

	</g:form>
	
	<content tag="sidebar">
	</content>
</body>
</html>
