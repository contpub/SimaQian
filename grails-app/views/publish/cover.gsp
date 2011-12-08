<html>
<head>
</head>
<body>
	<g:render template="breadcrumbs" model="[title: 'Upload a cover image']" />
	
	<div id="post">
		<div class="right">
			<g:uploadForm action="saveCover" id="${book?.id}">
				<p class="no-border"><strong>Image file</strong> (*.jpg, *.jpeg, *.png)</p>

				<p>
					Local file:
					<input type="file" name="coverFile" />
				</p>
				
				<p class="no-border">
					<g:submitButton name="upload" value="Upload" class="button" />
					<g:link action="update" id="${book?.id}">Cancel</g:link>
				</p>
			</g:uploadForm>
		</div>
		<div class="left">
			<g:render template="leftMenu"></g:render>
		</div>
	</div>

</body>
</html>
