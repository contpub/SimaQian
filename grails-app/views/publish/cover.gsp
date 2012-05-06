<html>
<head>
</head>
<body>
<g:render template="breadcrumbs" model="[title: message(code: 'view.publish.menu.cover', default: 'Change cover image')]" />
<div class="row">
	<div class="span3">
		<g:render template="leftMenu" />
	</div>
	<div class="span9">
		<g:uploadForm action="cover" id="${book?.id}" class="form-horizontal">
			<fieldset>

				<!--cover-->
				<div class="control-group ${hasErrors(bean: book?.profile, field: 'description', 'error')}">
					<label class="control-label">Current cover</label>
					<div class="controls" style="height:120px">
						<bookTag:coverImage book="${book}" />
					</div>
				</div>

				<!--coverFile-->
				<div class="control-group ${hasErrors(bean: book?.profile, field: 'description', 'error')}">
					<label class="control-label" for="coverFile">Choose an image file</label>
					<div class="controls">
						<input type="file" name="coverFile" />
						<p class="help-block">Supported image file formats (*.jpg, *.jpeg, *.png)</p>
					</div>
				</div>

				<!--actions-->
				<div class="form-actions">
					<g:submitButton name="upload" value="Upload" class="btn btn-primary" />
					<bookTag:link book="${book}" class="btn">Cancel</bookTag:link>
				</div>
			</fieldset>
		</g:uploadForm>
	</div>
</div>
</body>
</html>
