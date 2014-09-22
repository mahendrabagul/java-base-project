<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>User Management</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<link
	href="${pageContext.request.contextPath}/themes/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/themes/bootstrap/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/themes/bootstrap/js/bootstrap.min.js"></script>
	<style type="text/css">
h1 {
	margin: 30px 0;
	padding: 0 200px 15px 0;
	border-bottom: 1px solid #E5E5E5;
}

.bs-example {
	margin: 20px;
}

.form-signin {
	max-width: 300px;
	padding: 19px 29px 29px;
	margin: 0 auto 20px;
	background-color: #fff;
	border: 1px solid #e5e5e5;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
	-moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
	box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
}

.form-signin .form-signin-heading,.form-signin .checkbox {
	margin-bottom: 10px;
}

.form-signin input[type="text"],.form-signin input[type="password"] {
	font-size: 16px;
	height: auto;
	margin-bottom: 15px;
	padding: 7px 9px;
}
</style>
</head>
<body>
	<div class="navbar navbar-inverse navbar-static-top">
		<div class="container">
			<a href="${pageContext.request.contextPath}/index.html"
				class="navbar-brand">Neova Solution's Base Project </a>
			<button class="navbar-toggle" data-toggle="collapse"
				data-target=".navHeaderCollapse">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<div class="collapse navbar-collapse navHeaderCollapse">
				<ul class="nav navbar-nav navbar-right">
					<li class="active"><a id="a-home"
						href="${pageContext.request.contextPath}/index.html">Home</a></li>
					<li><a href="#">Blog</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> Social Media <b class="caret "></b>
					</a>
						<ul class="dropdown-menu">
							<li><a href="#">Twitter</a> <a href="#">Facebook</a> <a
								href="#">Google+</a> <a href="#">Instagram</a></li>
						</ul></li>
					<li><a href="#">About</a></li>
					<li><a href="#">Contact</a></li>
					<li><a id="a-logout-button"
						href="<c:url value="/j_spring_security_logout" />">Logout</a> <br /></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-4">
				<form:form class="form-signin" method="POST"
					action="/web/admin/save.html" commandName="command">
					<fieldset>
						<legend> Update Existing User</legend>
						<form:input path="id" placeholder="User ID" value="${user.id}"
							readonly="true" />
						<form:input path="firstName" placeholder="FirstName"
							value="${user.firstName}" />
						<form:input path="lastName" placeholder="Last Name"
							value="${user.lastName}" />
						<form:input path="username" placeholder="UserName"
							value="${user.username}" />
						<form:input path="emailId" placeholder="Email ID"
							value="${user.emailId}" />
						<form:password path="password" placeholder="Password" id="pwd"
							value="${user.password}" />
						<form:password path="" placeholder="Confirm Password" id="cnfmpwd" />
						<form:input path="country" placeholder="Country"
							value="${user.country}" />
						<form:input path="mobileNo" placeholder="Mobile No"
							value="${user.mobileNo}" />
						<br />
						<button class="btn btn-large btn-primary" value="Update"
							name="update" id="update" type="submit">Update</button>
						<button class="btn btn-warning" id="reset" type="reset">Clear</button>

					</fieldset>
				</form:form>
			</div>
			<div class="col-md-8">
				<div class="table-responsive">
					<c:if test="${!empty userList}">
						<table class="table table-bordered  table-hover">
							<tr>
								<th>User ID</th>
								<th>First Name</th>
								<th>Last Name</th>
								<th>UserName</th>
								<th>Email Id</th>
								<th>Country</th>
								<th>Mobile</th>
								<th>Operations</th>
							</tr>
							<c:forEach items="${userList}" var="user">
								<tr>
									<td>${user.id}</td>
									<td>${user.firstName}</td>
									<td>${user.lastName}</td>
									<td>${user.username}</td>
									<td>${user.emailId}</td>
									<td>${user.country}</td>
									<td>${user.mobileNo}</td>
									<td align="center"><a
										href="/web/admin/update.html?id=${user.id}">Edit</a> | <a
										href="/web/admin/delete.html?id=${user.id}">Delete</a></td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
				</div>
			</div>
		</div>
	</div>

	<!--End of Contains of First Admin Page-->

	<!--Bottom(Footer) Content -->

	<div class="navbar navbar-default navbar-fixed-bottom">
		<div class="container">
			<p class="navbar-text pull-left">Designed by Neova Solution's
				JAVA Team</p>
			<a href="http://www.neovasolutions.com/"
				class="navbar-btn btn-danger btn pull-right">Visit To Neova
				Solutions</a>
		</div>
	</div>
	<!-- End of Bottom(Footer) Content -->



</body>
</html>