<html>
<head>
<title>eBook Editor</title>
<layoutTag:webFonts family="Droid+Sans+Mono" />
<r:require modules="codemirror" />
<style type="text/css">
.CodeMirror {
	font-family: 'Droid Sans Mono', sans-serif, Consolata, monospace;
	font-size: 12pt;
	height: 30em;
}
.CodeMirror-scroll {
	width: 100%;
	height: 100%;
}
</style>
<r:script>
$(function() {
	$('#contents').codemirror({
		mode: 'rst',
		lineNumbers: true,
		lineWrapping: true
	});

	var save = function(params) {
		if (!params) params = {};

		$.post(
			"${createLink(action: 'ajaxSaveContents', id: book?.id)}",
			{
				contents: editor.getValue(),
				offset: "${offset}",
				publish: params.publish?'true':'false'
			},
			function(data) {
				$('span.status').html(data.result.message);
				if (params.callback) {
					params.callback();
				}
			},
			'json'
		);
	};
	$('#save-button').click(function() {
		if (editor.getValue()) {
			save();
		}
		else {
			if ("${total}"=="1") {
				alert("Unable to save the blank content, please write at least one line sentence.");
			}
			else {
				if (confirm('If you choose to continue, it will clear the current text file.')) {
					save({
						callback: function() {
							location.href='${createLink(action: 'cleanupContents', id: book?.id)}';
						}
					});
				}
			}
		}
		return false;
	});
	$('#publish-button').click(function() {
		if ("${total}"=="1" && !editor.getValue()) {
			alert("Unable to publish the blank content, please write at least one line sentence.");
		}
		else {
			save({
				publish: true
			});
		}
		return false;
	});
	// Auto-Save
	var autoSave = function() {
		window.setTimeout(function() {
			if (editor.getValue()) {
				save();
			}
			autoSave();
		}, 30000);
	};
	autoSave();
});
</r:script>
</head>
<body>
<g:render template="breadcrumbs" model="[title: 'Editor']" />
<g:form action="editor" id="${book?.id}" params="[offset: offset]" class="form-horizontal">
	<div class="row">
		<div class="span3">
			<ul class="nav nav-tabs nav-stacked">
				<g:each var="item" in="${catalog}" status="i">
					<li class="${offset==i?'active':''}" style="overflow:hidden;white-space:nowrap;">
						<g:link action="editor" id="${book?.id}" params="[offset: i]">
							<i class="icon-file"></i> ${item}
						</g:link>
					</li>
				</g:each>
			</ul>
			<div class="btn-group pull-right">
				<g:link action="editor" id="${book?.id}" params="[insert: true, offset: offset]" class="btn">
					<i class="icon-plus"></i> Create New File
				</g:link>
				<a class="btn dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li>
						<g:link action="editor" id="${book?.id}" params="[insert: true, offset: offset]">
							<i class="icon-file"></i> After Current File
						</g:link>
					</li>
					<li>
						<g:link action="editor" id="${book?.id}" params="[insert: true, offset: total-1]">
							<i class="icon-file"></i> As Last File
						</g:link>
					</li>
					<li class="divider"></li>
					<li>
						<g:link action="editor" id="${book?.id}" params="[remove: true, offset: offset]" onclick="return confirm('Are you sure???');">
							<i class="icon-remove"></i> Remove Current File
						</g:link>
					</li>
				</ul>
			</div>
		</div>
		<div class="span9">
			<!--contents-->
			<g:textArea name="contents" value="${contents}" style="height:30em;display:none" />

			<!--actions-->
			<div class="form-actions">
				<button type="submit" name="update" value="publish" class="btn btn-primary">
					<i class="icon-print icon-white"></i> Publish
				</button>
				<button type="submit" name="update" value="save" class="btn">Save</button>
				<bookTag:link book="${book}" class="btn">Cancel</bookTag:link>
			</div>
		</div>
	</div>
</g:form>
</body>
</html>
