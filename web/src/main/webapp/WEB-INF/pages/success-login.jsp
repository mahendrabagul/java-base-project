<?xml version="1.0" encoding="ISO-8859-1" ?>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Log-In Page</title>

<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<link
	href="${pageContext.request.contextPath}/themes/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
	<script
		src="${pageContext.request.contextPath}/themes/bootstrap/js/jquery-1.11.0.min.js"></script></head>
<body>
	<div class="navbar navbar-inverse navbar-static-top">
		<div class="container">
			<a href="${pageContext.request.contextPath}/index.html"
				class="navbar-brand">Neova Solution's Base Project</a>
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
						data-toggle="dropdown">Social Media <b class="caret	"></b></a>
						<ul class="dropdown-menu">
							<li><a href="#">Twitter</a> <a href="#">Facebook</a> <a
								href="#">Google+</a> <a href="#">Instagram</a></li>
						</ul></li>
					<li><a href="#">About</a></li>
					<li><a href="#">Contact</a></li>
				</ul>
			</div>
		</div>
	</div>

	<!--Contains of Home Page-->
	<div class="container">
		<div class="jumbotron">
			<h1 class="text-center">Welcome page</h1>
			<p class="text-center">
				You have successfully logged in.<br />
			</p>
		</div>
	</div>

	<!--End of Contains of Home Page-->

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

	<script
		src="${pageContext.request.contextPath}/themes/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
