<%@ page import="simaqian.User" %>
<html>
<head>
	<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<div class="nav" role="navigation">
		<ul>
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
		</ul>
	</div>
	<div id="list-user" class="content scaffold-list" role="main">
		<h1><g:message code="default.list.label" args="[entityName]" /></h1>
		<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
		</g:if>
		<table>
			<thead>
				<tr>				
					<g:sortableColumn property="email" title="${message(code: 'user.email.label', default: 'Email')}" />
					<g:sortableColumn property="account" title="${message(code: 'user.account.label', default: 'Account')}" />
				</tr>
			</thead>
			<tbody>
			<g:each in="${userInstanceList}" status="i" var="userInstance">
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<td>${fieldValue(bean: userInstance, field: "email")}</td>
					<td>${fieldValue(bean: userInstance, field: "account")}</td>
				</tr>
			</g:each>
			</tbody>
		</table>
		<div class="pagination">
			<g:paginate total="${userInstanceTotal}" />
		</div>
	</div>
</body>
</html>
