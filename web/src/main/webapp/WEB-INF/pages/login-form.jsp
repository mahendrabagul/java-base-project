<?xml version="1.0" encoding="ISO-8859-1" ?>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="/images/favicon.ico" />
<title>Login | Neova</title>
<link
	href="${pageContext.request.contextPath}/themes/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/themes/styles/main.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/themes/bootstrap/js/jquery-1.11.0.min.js"></script>
<meta name="menu" content="Login" />
<style>
.error {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #a94442;
	background-color: #f2dede;
	border-color: #ebccd1;
	text-align: center;
}

.msg {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	text-align: center;
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
	color: #31708f;
}

#login-box {
	width: 300px;
	padding: 20px;
	margin: 100px auto;
	background: #fff;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border: 1px solid #000;
}
</style>
</head>
<body id="login">
	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#navbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand"
				href="${pageContext.request.contextPath}/index.html">Neova
				BaseProject</a>
		</div>
		<div class="collapse navbar-collapse" id="navbar">
			<ul class="nav navbar-nav">
				<li class="active"><a
					href="${pageContext.request.contextPath}/user-login.html">Login</a>
				</li>
			</ul>
		</div>
	</div>
	<div class="container" id="content">
		<!-- -Code Added -->

		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="msg">${msg}</div>
		</c:if>

		<!-- -Code Added -->

		<div class="row">
			<form method="post" id="loginForm"
				action="<c:url value='j_spring_security_check'/>"
				onsubmit="saveUsername(this);return validateForm(this)"
				class="form-signin" autocomplete="off">
				<h2 class="form-signin-heading">Sign In</h2>
				<input type="text" name="j_username" id="j_username"
					class="form-control" placeholder="Username" required tabindex="1"><input
					type="password" class="form-control" name="j_password"
					id="j_password" tabindex="2" placeholder="Password" required><label
					for="rememberMe" class="checkbox"> <input type="checkbox"
					name="_spring_security_remember_me" id="rememberMe" tabindex="3"
					value="true" /> Remember Me
				</label>
				<button type="submit" class="btn btn-lg btn-primary btn-block"
					name="login" tabindex="4">Login</button>

				<input type="hidden" name="\${_csrf.parameterName}"
					value="\${_csrf.token}" />

			</form>
			<p>
				Not a member? <a
					href="\${pageContext.request.contextPath}/neova/signup.html">Signup</a>
				for an account.
			</p>

			<p>
				Forgot your password? Have your <a href="?"
					onmouseover="window.status='Have your password hint sent to you.'; return true"
					onmouseout="window.status=''; return true"
					title="Have your password hint sent to you."
					onclick="passwordHint(); return false" id="passwordHint">password
					hint e-mailed to you</a>.
			</p>

			<p>
				Request a <a href="?" onclick="requestRecoveryToken(); return false">password
					reset</a> e-mailed to you.
			</p>
		</div>
	</div>

	<div id="footer" class="container navbar-fixed-bottom">
		<span class="col-sm-6 text-left">Version 1.0 </span> <span
			class="col-sm-6 text-right"> &copy; 2014 <a
			href="http://raibledesigns.com">Neova Solutions Pvt. LTD.</a>
		</span>
	</div>
	<script type="text/javascript">
		if ($.cookie("username") != null && $.cookie("username") != "") {
			$("#j_username").val($.cookie("username"));
			$("#j_password").focus();
		} else {
			$("#j_username").focus();
		}

		function saveUsername(theForm) {
			$.cookie("username", theForm.j_username.value, {
				expires : 30,
				path : "/"
			});
		}

		function validateForm(form) {
			var valid = validateRequired(form);
			if (valid == false) {
				$(".form-group").addClass('error');
			}
			return valid;
		}

		function passwordHint() {
			if ($("#j_username").val().length == 0) {
				alert("Username is a required field.");
				$("#j_username").focus();
			} else {
				location.href = "/passwordHint?username="
						+ $("#j_username").val();
			}
		}

		function requestRecoveryToken() {
			if ($("#j_username").val().length == 0) {
				alert("Username is a required field.");
				$("#j_username").focus();
			} else {
				location.href = "/requestRecoveryToken?username="
						+ $("#j_username").val();
			}
		}

		function required() {
			this.aa = new Array("j_username", "Username is a required field.",
					new Function("varName", " return this[varName];"));
			this.ab = new Array("j_password", "Password is a required field.",
					new Function("varName", " return this[varName];"));
		}
	</script>
</body>
</html>
