<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="/images/favicon.ico" />
<title>Home | Neova</title>
 <link
	href="${pageContext.request.contextPath}/themes/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/themes/main.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/themes/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/themes/bootstrap/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/themes/bootstrap/js/bootstrap.min.js"></script>

<meta name="menu" content="Home" />
</head>
<body class="home">


	<div class="navbar navbar-default navbar-fixed-top" role="navigation">
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
					href="${pageContext.request.contextPath}/moderator/first.html"
					title="Home">Home</a></li>


				<li class=""><a href="/userform" title="Edit Profile">Edit
						Profile</a></li>


				<li class=""><a
					href="<c:url value="/j_spring_security_logout" />" title="Logout">Logout</a>

				</li>

			</ul>
		</div>

	</div>

	<div class="container" id="content">

		<div class="row">
			<h2>Welcome!</h2>
			<p>Congratulations, you have logged in successfully! Now that
				you've logged in, you have the following options:</p>

			<ul class="glassList">
				<li><a href="#">Edit Profile</a></li>
				<li><a href="#">Upload A File</a></li>
			</ul>
		</div>
	</div>
	<div class="container">

		<h1 class="text-center">Users List</h1>
		<c:if test="${!empty userList}">
			<table class="table table-bordered zebra-striped">
				<tr>
					<th>First Name</th>
					<th>Last Name</th>
					<th>UserName</th>
					<th>Email Id</th>
					<th>Country</th>
					<th>Mobile</th>
				</tr>
				<c:forEach items="${userList}" var="user">
					<tr>
						<td>${user.firstName}</td>
						<td>${user.lastName}</td>
						<td>${user.login}</td>
						<td>${user.emailId}</td>
						<td>${user.country}</td>
						<td>${user.mobileNo}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
	</div>

	<div id="footer" class="container navbar-fixed-bottom">
		<span class="col-sm-6 text-left">Version 1.0 Logged in as :
			${username} </span><span class="col-sm-6 text-right"> &copy; 2014 <a
			href="http://www.neovasolutions.com/">Neova Solutions Pvt. LTD.</a>
		</span>
	</div>


</body>
</html>
