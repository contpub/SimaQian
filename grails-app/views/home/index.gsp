<html>
<head>
	<title>Welcome</title>
	<style tyle="text/css">
		.login-form {
			margin: 0;
			padding: 10px;
			width: 200px;
			border: none;
			background: none;
		}
		.login-form #email, .login-form #password {
			font-size: 1.125em;
			padding: .25em;
			width: 200px;
		}
	</style>
</head>
<body>
	<h2>Welcome</h2>
	<p>ContPub (continuous publishing) is the easiest way to publish your own books!</p>
	<p>ContPub （持續出版系統）是您自行出版專屬書籍的最簡易方式！</p>
	<ol>
		<li>Thinking</li>
		<li>Writing</li>
		<li>Publishing</li>
	</ol>
	<p>
		持續出版的宗旨，是讓書籍的出版速度能趕上您思考、撰寫的速度。
		在資訊爆炸的時代，許多新知、技術都是有時效性，
		讀者等不及想看到作者最新的著作；
		但傳統的出版流程又慢又貴，
		從作者構思、寫完整本書，
		到讀者的手上恐怕已超過半年之久，
		既耗時又花費相當多額外的成本（編輯、印刷、物流等）。
	</p>
	<h3>BaaS (Book as a Service)</h3>
	<p>
		持續出版的理念，是讓書籍變成作者提供給讀者的服務，
		讀者願意付費給作者，以取得內容持續更新的服務，
		而不需要經過漫長的等待。
		作者可以在最短的時間內，用最低廉的成本將書籍內容傳遞給讀者，
		並得到市場的意見回饋、持續更新更能滿足讀者需求的內容。
	</p>
	
	<content tag="sidebar">
		<div class="sidemenu">
			<g:if test="${!session['user']}">
				<h3>Login</h3>
				<g:form action="login" class="login-form">
					E-mail: <br /><g:textField name="email" value="" /><br />
					Password: <br /><g:passwordField name="password" value="" /><br />
					<g:submitButton name="login" value="Login" class="button" />
				</g:form>
			</g:if>
		</div>
		<div class="sidemenu">
			<h3>Sidebar Menu</h3>
			<ul>
				<g:isUser><li><g:link action="logout" onclick="return confirm('Are you sure???');">Logout</g:link></li></g:isUser>
				<g:isUser><li><g:link action="account">Account</g:link></li></g:isUser>
				<li><g:link action="signup">Sign up</g:link></li>
				<li><a href="#">Archives</a></li>
			</ul>
		</div>
	</content>
</body>
</html>
