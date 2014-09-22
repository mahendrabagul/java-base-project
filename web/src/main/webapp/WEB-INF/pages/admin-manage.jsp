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
<script
	src="${pageContext.request.contextPath}/themes/bootstrap/js/jquery-1.11.0.min.js"></script>
<script
	src="${pageContext.request.contextPath}/themes/bootstrap/js/jquery.validate.js"></script>
<link
	href="${pageContext.request.contextPath}/themes/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" />
<style type="text/css">
h1 {
	margin: 30px 0;
	padding: 0 200px 15px 0;
	border-bottom: 1px solid #E5E5E5;
}

.bs-example {
	margin: 20px;
}

.my-error-class {
	color: #FF0000; /* red */
}

.default-valid-class {
	color: #000000; /* black */
}

.my-valid-class {
	color: #00CC00; /* green */
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
<script type="text/javascript">
	$(document).ready(function() {
						// Hide updateUserForm when Page loads
						$('#updateUserForm').hide();

						// Reset to clear all fields
						$('#btnReset').click(function() {
							$('.my-error-class ').html("");
 						});

						//Confirm Whether to delete or cancel
						$('#btnConfirmYes').click(function() {
							var url = $('#confirmModal').data('url');
							//Call Controller Method
							$.get(url, function(data, status) {
								$('#confirmModal').data('element').remove();
								$('.modal-body').html(data);
								$('#confirmModal').modal('show');
								$('#confirmModal').modal('hide');
							});
						});
						//Cancel Button on Confirm Modal handler
						$('#btnConfirmCancel').click(function() {
							$('#confirmModal').modal('hide');
						});

						//Yes Button on All Alert Modal
						$('#btnAlertYes').click(function() {
							$('#alertModal').modal('hide');
						});

					
					<!------------------------------------------------>

						// Goto New User Form From Update Existing User Form
						$('#btnUpdateNew').click(function() {
							//Shows newUserForm
							$('#newUserForm').show();
							//Hides updateUserForm 
							$('#updateUserForm').hide();
						});		

						// Update Existing User. Call to Controller Method
						$('#updateUserForm').submit(function(e) {
								var url = $('#updateUserForm').attr('action');
								//Call to Controller Method
								$.post(url,$(this).serialize(),function(response) {
									//Hide Update form After call to Controller Method 
									$('#updateUserForm').hide();
									//Show New User Form
									$('#newUserForm').show();
									//Add Message to Modal Body from Controller Method about operation status
									$('.modal-body').html(response);
									//Add Updated Row in Table
									updateRowInTable();
									//Show Message
									$('#alertModal').modal('show');
								});
								e.preventDefault();
						});
 				
						//Add User to Existing Groups. Call To Controller Method
						$('#addUserToGroupForm').submit(function(e) {
								//Collect URL from Action Attribute of Form
								var url = $('#addUserToGroupForm').attr('action');
								//Call To Controller Method
								$.post(url,$(this).serialize(),function(response) {
									//$('.modal-body').html(response);
 									//$('#alertModal').modal('show');
									if (response.indexOf("Response1") >= 0) {
										$('.modal-body').html(response);
										$('#alertModal').modal('show');
									} else if (response.indexOf("Response2") >= 0) {
										$('.modal-body').html(response);
										$('#alertModal').modal('show');
									} else if (response.indexOf("Response3") >= 0) {
										$('.modal-body').html(response);
										$('#alertModal').modal('show');
									}								
								});
								e.preventDefault();
						});

						//Method to Update Row after updating user successfully.

						function updateRowInTable() {

							//Get Table element
							var scntDiv = $('#tblUsersBody');

							//Create new Row 
							var td1 = "<td>" + $('#updateUserName').val()
									+ "</td>";
							var td2 = "<td>" + $("#updateFirstName").val()
									+ "</td>";
							var td3 = "<td>" + $("#updateLastName").val()
									+ "</td>";
							var td4 = "<td>" + $("#updateEmail").val() + "</td>";

							//Attach links
							var linkVal1 = " ${pageContext.request.contextPath}/user/admin/update/"
									+ $('#updateUserName').val();
							var linkVal2 = " ${pageContext.request.contextPath}/user/admin/delete/"
									+ $('#updateUserName').val();
							var editBtn = "<button class='btnEdit btn btn-primary' href="+linkVal1+" >Edit</button>&nbsp";
							var deleteBtn = "<button class='btnDelete btn btn-danger' href="+linkVal2+" >Delete</button>";

							var td5 = "<td align='center'>" + editBtn
									+ deleteBtn + "</td>";
							var outputString = "<tr>" + td1 + td2 + td3 + td4
									+ td5 + "</tr>";

							//Append Row to Table 
							scntDiv.append(outputString);

							//Enable editBtnFunctionality i.e. When we will click on edit button of newly inserted row,
							//it should set all values of user object to Update Form.
							editBtnFunctionality();
							
							//Enable deleteBtnFunctionality i.e. When we will click on delete button of newly inserted row,
							//it should delete the row.
							deleteBtnFunctionality();
						}

						//Method To get Data from Controller Method and Set it to Update Form  
						function editBtnFunctionality() {
							$('.btnEdit').click(function() {

								//Get URL for user Selected
								var url = $(this).attr('href');

								//Hide newUserForm
								$('#newUserForm').hide();
  								$("#updateUserForm").fadeToggle(200);
								$("#updateUserForm").fadeIn(200);

								//Removes selected row.. Its little bit faulty. Working on it.
								$(this).parent().parent().remove();	

								//Call to Controller Method for accessing data of selected row. and set to elements of UpdateUserForm
								//Populates Updateform form with data from Database
								$.getJSON(url, function(user) {
									$('#updateFirstName').val(user.firstName);
									$('#updateLastName').val(user.lastName);
									$('#updateUserName').val(user.userName);
 									$('#updateEmail').val(user.email);
									$('#updatePassword').val(user.password);
 									$('#updateConfirmPassword').val(user.password);	
									$('#updateEnabled').prop("checked",user.enabled);
 									$('#updateAccountNonExpired').prop("checked",user.accountNonExpired);
									$('#updateAccountNonLocked').prop("checked",user.accountNonLocked);
 									$('#updateCredentialsNonExpired').prop("checked",user.credentialsNonExpired);
								});
							});
						}

						//Enable editBtnFunctionality for buttons which are loaded with page
						editBtnFunctionality();

						//Method To delete data. Call to Controller Method.
						function deleteBtnFunctionality() {
							//Handler for Delete Button in Table	
							$(".btnDelete").click(function() {
								$('.modal-body').html("Are you sure ?");
								
								// Get element (Row)
								var element = $(this).parent().parent();

								// Collect URL of delete Button
								var url = $(this).attr('href');
								
								// Pass URL to MODAL
								$('#confirmModal').data('url',url);

								// Show MODAL
								$('#confirmModal').data('element', element).modal('show');
							});
						}

						//Enable deleteBtnFunctionality for buttons which are loaded with page
						deleteBtnFunctionality();

						// Saves new User. Call to Controller Method
						$('#newUserForm').submit(function(e) {

								//Collect Form's Action Attribute
								var url = $('#newUserForm').attr('action');
							
								//Ajax Call To Controller method
								$.post(url,$(this).serialize(),function(response) {
									//Display MODAL with Resposes 
									if (response.indexOf("Response1") >= 0) {
										$('.modal-body').html(response);
										$('#alertModal').modal('show');
									} else if (response.indexOf("Response2") >= 0) {
										$('.modal-body').html(response);
										$('#alertModal').modal('show');
									} else if (response.indexOf("Response3") >= 0) {
										$('.modal-body').html(response);
										$('#alertModal').modal('show');
										//Inserts row in a Table operation is successful
										insertRowInTable();
									} else if (response.indexOf("Response4") >= 0) {
										$('.modal-body').html(response);
										$('#alertModal').modal('show');
									}
								});
								e.preventDefault();
						});


						//Adds Row in Table	
						function insertRowInTable() {
							
							//Collect Table element
							var scntDiv = $('#tblUsersBody');

							//Creates <TD> for new Row
							var td1 = "<td>" + $('#inputUserName').val()
									+ "</td>";
							var td2 = "<td>" + $("#inputFirstName").val()
									+ "</td>";
							var td3 = "<td>" + $("#inputLastName").val()
									+ "</td>";
							var td4 = "<td>" + $("#inputEmail").val() + "</td>";
							
							//Create Links
							var linkVal1 = " ${pageContext.request.contextPath}/user/admin/update/"
									+ $('#inputUserName').val();
							var linkVal2 = " ${pageContext.request.contextPath}/user/admin/delete/"
									+ $('#inputUserName').val();
							var editBtn = "<button class='btnEdit btn btn-primary' href="+linkVal1+" >Edit</button>&nbsp";
							var deleteBtn = "<button class='btnDelete btn btn-danger' href="+linkVal2+" >Delete</button>";

							var td5 = "<td align='center'>" + editBtn
									+ deleteBtn + "</td>";

							//Create <TR> in a Table.
							var outputString = "<tr>" + td1 + td2 + td3 + td4
									+ td5 + "</tr>";

							//Append New Row in Table
							scntDiv.append(outputString);
							
							//Enable editBtnFunctionality for newly created Buttons.
							editBtnFunctionality();

							//Enable deleteBtnFunctionality for newly created Buttons.
							deleteBtnFunctionality();
						}

					});
</script>

<script type="text/javascript">

		function checkFirstName(param){
			if(param===1){
				//get corresponding form element
				var form = document.getElementById("newUserForm");
				var isCorrect = false;
 				if(form.inputFirstName.value.length<3)	{
 					
 					//Adds Error Class to Wrong FirstName Format   	
			      	form.inputFirstName.className="my-error-class";

			      	alert("Error: FirstName should be more than 3 characters!");
				    form.inputFirstName.focus();
 				}else {
 					re = /^\w+$/;
				    if(!re.test(form.inputFirstName.value)) {
						
						//Adds Error Class to Wrong FirstName Format   	
				      	form.inputFirstName.className="my-error-class";

				    	alert("Error: FirstName must contain only letters, numbers and underscores!");
				      	form.inputFirstName.focus();
				      	//return false;
				    }else{
				    	
						//Adds Valid Class to Correct FirstName Format   	
				      	form.inputFirstName.className="my-valid-class";
					    
					    //return true;
					    isCorrect = true;
				    }
 				}

 				console.log(form.inputFirstName.className);  
			    return isCorrect;
			} 
			else if(param===2){
				//get corresponding form element
				var form = document.getElementById("updateUserForm");
				var isCorrect = false;
 				if(form.updateFirstName.value.length<3)	{
 					
 					//Adds Error Class to Wrong FirstName Format   	
			      	form.updateFirstName.className="my-error-class";

			      	alert("Error: FirstName should be more than 3 characters!");
				    form.updateFirstName.focus();
 				}else {
 					re = /^\w+$/;
				    if(!re.test(form.updateFirstName.value)) {
						
						//Adds Error Class to Wrong FirstName Format   	
				      	form.updateFirstName.className="my-error-class";

				    	alert("Error: FirstName must contain only letters, numbers and underscores!");
				      	form.updateFirstName.focus();
				      	//return false;
				    }else{
				    	
						//Adds Valid Class to Correct FirstName Format   	
				      	form.updateFirstName.className="my-valid-class";
					    
					    //return true;
					    isCorrect = true;
				    }
 				}
 				
 				console.log(form.updateFirstName.className);  
			    return isCorrect;
			}
 		}


		function checkLastName(param){
			if(param===1){
				//get corresponding form element
				var form = document.getElementById("newUserForm");
				var isCorrect = false;
 				if(form.inputLastName.value.length<3)	{
 					
 					//Adds Error Class to Wrong LastName Format   	
			      	form.inputLastName.className="my-error-class";

			      	alert("Error: LastName should be more than 3 characters!");
				    form.inputLastName.focus();
 				}else {
 					re = /^\w+$/;
				    if(!re.test(form.inputLastName.value)) {
						
						//Adds Error Class to Wrong LastName Format   	
				      	form.inputLastName.className="my-error-class";

				    	alert("Error: LastName must contain only letters, numbers and underscores!");
				      	form.inputLastName.focus();
				      	//return false;
				    }else{
				    	
						//Adds Valid Class to Correct LastName Format   	
				      	form.inputLastName.className="my-valid-class";
					    
					    //return true;
					    isCorrect = true;
				    }
 				}

 				console.log(form.inputLastName.className);  
			    return isCorrect;
			} 
			else if(param===2){
				//get corresponding form element
				var form = document.getElementById("updateUserForm");
				var isCorrect = false;
 				if(form.updateLastName.value.length<3)	{
 					
 					//Adds Error Class to Wrong LastName Format   	
			      	form.updateLastName.className="my-error-class";

			      	alert("Error: LastName should be more than 3 characters!");
				    form.updateLastName.focus();
 				}else {
 					re = /^\w+$/;
				    if(!re.test(form.updateLastName.value)) {
						
						//Adds Error Class to Wrong LastName Format   	
				      	form.updateLastName.className="my-error-class";

				    	alert("Error: LastName must contain only letters, numbers and underscores!");
				      	form.updateLastName.focus();
				      	//return false;
				    }else{
				    	
						//Adds Valid Class to Correct LastName Format   	
				      	form.updateLastName.className="my-valid-class";
					    
					    //return true;
					    isCorrect = true;
				    }
 				}
 				
 				console.log(form.updateLastName.className);  
			    return isCorrect;
			}

		}


		//Checks userName Entered is valid or not
 		function checkUserName(param){
 			//if call is from newUserForm
 			if(param===1){
				//get corresponding form element
				var form = document.getElementById("newUserForm");
				var isCorrect = false;
 
 	 		    if(form.inputUserName.value == "") {
		
					//Adds Error Class to Wrong userName Format   	
			      	form.inputUserName.className="my-error-class";

			      	alert("Error: Username cannot be blank!");
				    form.inputUserName.focus();
				    //return false;
			  	}else{
			  		re = /^\w+$/;
				    if(!re.test(form.inputUserName.value)) {
						
						//Adds Error Class to Wrong userName Format   	
				      	form.inputUserName.className="my-error-class";

				    	alert("Error: Username must contain only letters, numbers and underscores!");
				      	form.inputUserName.focus();
				      	//return false;
				    }else{
				    	
						//Adds Valid Class to Correct userName Format   	
				      	form.inputUserName.className="my-valid-class";
					    
					    //return true;
					    isCorrect = true;
				    }
			  	}
			  	console.log(form.inputUserName.className);  
			    return isCorrect;
 			}
 			//if call is from updateUserForm
 			else if(param===2){
 				//get corresponding form element
				var form = document.getElementById("newUserForm");
				var isCorrect = false;
 
 	 		    if(form.updateUserName.value == "") {
		
					//Adds Error Class to Wrong userName Format   	
			      	form.updateUserName.className="my-error-class";

			      	alert("Error: Username cannot be blank!");
				    form.updateUserName.focus();
				    //return false;
			  	}else{
			  		re = /^\w+$/;
				    if(!re.test(form.updateUserName.value)) {
						
						//Adds Error Class to Wrong userName Format   	
				      	form.updateUserName.className="my-error-class";

				    	alert("Error: Username must contain only letters, numbers and underscores!");
				      	form.updateUserName.focus();
				      	//return false;
				    }else{
				    	
						//Adds Valid Class to Correct userName Format   	
				      	form.updateUserName.className="my-valid-class";
					    
					    //return true;
					    isCorrect = true;
				    }
			  	}
			  	console.log(form.updateUserName.className);  
			    return isCorrect;
			}		 	
		}

		//Validates email entered and updated
		function validateEmail(param) { 

 			//if call is from newUserForm
			if(param===1){
				
				//get corresponding form element
				var form = document.getElementById("newUserForm");

 	 		    //Regular Expression for email
	 			var filter=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i

				if (form.inputEmail.value == '' || !filter.test(form.inputEmail.value))
				{

				 	//Adds Error Class to Wrong Email Format   	
		      		form.inputEmail.className="my-error-class";
			    	alert('Please enter a valid email address.');	
			    	return false;
				}
		
			 	 
				//Adds Valid Class to right Email Format 
		 		form.inputEmail.className="my-valid-class";
				return true;
 			}

			//if call is from updateUserForm
 			else if(param===2){
			
				//get corresponding form element
				var form = document.getElementById("updateUserForm");

 	 		    //Regular Expression for email
	 			var filter=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i

				if (form.updateEmail.value == '' || !filter.test(form.updateEmail.value))
				{
 
					//Adds Error Class to Wrong Email Format   	
		      		form.updateEmail.className="my-error-class";
			    	alert('Please enter a valid email address.');	
			    	return false;
				}
		
			 

				//Adds Valid Class to right Email Format   	
		   		form.updateEmail.className="my-valid-class";
				return true;		
			}		
		} 

		//Validates Password
		function checkPassword(param){

			if(param===1){
				//Collect Form Element
				var form = document.getElementById("newUserForm");
			    if(form.inputPassword.value != "" && form.inputPassword.value == form.inputConfirmPassword.value) {
			    	if(form.inputPassword.value.length < 6) {
				        
				        //Adds Error Class to Wrong Password   	
			      		form.inputPassword.className=form.inputPassword.className+"my-error-class";

				        alert("Error: Password must contain at least six characters!");
				        form.inputPassword.focus();
				        
				        return false;
			     	}
				    if(form.inputPassword.value == form.inputUserName.value) {
				       
				        //Adds Error Class to Wrong Password   	
			      		form.inputPassword.className=form.inputPassword.className+"my-error-class";

				        alert("Error: Password must be different from Username!");
				        form.inputPassword.focus();

				        return false;
				    }
			      	re = /[0-9]/;
			      	if(!re.test(form.inputPassword.value)) {

				        //Adds Error Class to Wrong Password   	
			      		form.inputPassword.className=form.inputPassword.className+"my-error-class";
				        alert("Error: password must contain at least one number (0-9)!");
				        form.inputPassword.focus();
				        return false;
			      	}
			      	re = /[a-z]/;
			      	if(!re.test(form.inputPassword.value)) {
			        	
			        	//Adds Error Class to Wrong Password   	
			      		form.inputPassword.className=form.inputPassword.className+"my-error-class";

			        	alert("Error: password must contain at least one lowercase letter (a-z)!");
			        	form.inputPassword.focus();
			        	
			        	
			        	return false;
			      	}
			      	re = /[A-Z]/;
			      	if(!re.test(form.inputPassword.value)) {
						
						//Adds Error Class to Wrong Password   	
			      		form.inputPassword.className=form.inputPassword.className+"my-error-class";
				        alert("Error: password must contain at least one uppercase letter (A-Z)!");
				        form.inputPassword.focus();
				        return false;
			      	}
			    } else {

			    	//Adds Error Class to Wrong Password   	
			      	form.inputPassword.className=form.inputPassword.className+"my-error-class";
			      	alert("Error: Please check that you've entered and confirmed your password!");
			      	form.inputPassword.focus();
			  	   	return false;
			    }	
					//Adds Error Class to Wrong Password   	
			      	form.inputPassword.className=form.inputPassword.className+"my-valid-class";
			      	form.inputConfirmPassword.className=form.inputConfirmPassword.className+"my-valid-class";
			      	return true;
			}
			else if(param===2){
				//Collect Form Element
				var form = document.getElementById("updateUserForm");
			    if(form.updatePassword.value != "" && form.updatePassword.value == form.updateConfirmPassword.value) {
			    	if(form.updatePassword.value.length < 6) {
				        
				        //Adds Error Class to Wrong Password   	
			      		form.updatePassword.className=form.updatePassword.className+"my-error-class";

				        alert("Error: Password must contain at least six characters!");
				        form.updatePassword.focus();
				        
				        return false;
			     	}
				    if(form.updatePassword.value == form.updateUserName.value) {
				       
				        //Adds Error Class to Wrong Password   	
			      		form.updatePassword.className=form.updatePassword.className+"my-error-class";

				        alert("Error: Password must be different from Username!");
				        form.updatePassword.focus();

				        return false;
				    }
			      	re = /[0-9]/;
			      	if(!re.test(form.updatePassword.value)) {

				        //Adds Error Class to Wrong Password   	
			      		form.updatePassword.className=form.updatePassword.className+"my-error-class";
				        alert("Error: password must contain at least one number (0-9)!");
				        form.updatePassword.focus();
				        return false;
			      	}
			      	re = /[a-z]/;
			      	if(!re.test(form.updatePassword.value)) {
			        	
			        	//Adds Error Class to Wrong Password   	
			      		form.updatePassword.className=form.updatePassword.className+"my-error-class";

			        	alert("Error: password must contain at least one lowercase letter (a-z)!");
			        	form.updatePassword.focus();
			        	
			        	
			        	return false;
			      	}
			      	re = /[A-Z]/;
			      	if(!re.test(form.updatePassword.value)) {
						
						//Adds Error Class to Wrong Password   	
			      		form.updatePassword.className=form.updatePassword.className+"my-error-class";
				        alert("Error: password must contain at least one uppercase letter (A-Z)!");
				        form.updatePassword.focus();
				        return false;
			      	}
			    } else {

			    	//Adds Error Class to Wrong Password   	
			      	form.updatePassword.className=form.updatePassword.className+"my-error-class";
			      	alert("Error: Please check that you've entered and confirmed your password!");
			      	form.updatePassword.focus();
			  	   	return false;
			    }	
					//Adds Error Class to Wrong Password   	
			      	form.updatePassword.className=form.updatePassword.className+"my-valid-class";
			      	form.updateConfirmPassword.className=form.updateConfirmPassword.className+"my-valid-class";
			      	return true;
			}

		}
	</script>


</head>
<body>
	<div class="navbar navbar-default navbar-inverse  " role="navigation">
		<div class="container">
			<div class="navbar-header">
				<a href="${pageContext.request.contextPath}/index.html"
					class="navbar-brand">NeoBase Project </a>
				<button class="navbar-toggle" data-toggle="collapse"
					data-target=".navHeaderCollapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
			</div>
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

				<!--New  User Form-->

				<form:form class="form-signin" method="POST"
					action="${pageContext.request.contextPath}/user/admin/insert.html"
					commandName="user" id="newUserForm" autocomplete="off">
					<fieldset>
						<legend>Add New User</legend>
						<form:input path="firstName" placeholder="FirstName"
							value="${user.firstName}" id="inputFirstName"
							onchange="checkFirstName(1)" />
						<form:input path="lastName" placeholder="Last Name"
							value="${user.lastName}" id="inputLastName"
							onchange="checkLastName(1)" />

						<form:input path="userName" placeholder="UserName"
							value="${user.userName}" id="inputUserName"
							onchange="checkUserName(1);" />

						<form:input path="email" placeholder="Email ID"
							value="${user.email}" id="inputEmail"
							onchange="validateEmail(1);" />

						<form:password path="password" placeholder="Password"
							id="inputPassword" value="${user.password}" />
						<form:password path="" placeholder="Confirm Password"
							id="inputConfirmPassword" onchange="checkPassword(1);" />
						<label class="control-label">Account Settings</label> <br /> <label
							class="checkbox-inline"><form:checkbox path="enabled"
								id="inputEnabled" name="enabled" value="true" /> Enabled</label> <br />
						<label class="checkbox-inline"> <form:checkbox
								path="accountNonExpired" id="inputAccountNonExpired"
								name="accountNonExpired" value="true" /> AccountNonExpired
						</label> <br /> <label class="checkbox-inline"> <form:checkbox
								path="accountNonLocked" id="inputAccountNonLocked"
								name="accountNonLocked" value="true" /> AccountNonLocked
						</label> <br /> <label class="checkbox-inline"> <form:checkbox
								path="credentialsNonExpired" id="inputCredentialsNonExpired"
								name="credentialsNonExpired" value="true" />
							CredentialsNonExpired
						</label> <br /> <br /> <br /> <br />
						<button class="btn btn-large btn-primary" value="Save" name="save"
							id="btnSubmit" type="submit">Save</button>
						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

						<button class="btn btn-warning" id="btnReset" type="reset">Clear</button>
					</fieldset>
				</form:form>

				<!-- Update User Form -->

				<form:form class="form-signin" method="POST"
					action="${pageContext.request.contextPath}/user/admin/update.html"
					commandName="user" id="updateUserForm" autocomplete="off">
					<fieldset>
						<legend>Update Existing User</legend>
						<form:input path="firstName" placeholder="FirstName"
							value="${user.firstName}" id="updateFirstName"
							onchange="checkFirstName(2)" />
						<form:input path="lastName" placeholder="Last Name"
							value="${user.lastName}" id="updateLastName"
							onchange="checkLastName(2)" />
						<form:input path="userName" placeholder="UserName"
							value="${user.userName}" id="updateUserName"
							onchange="checkUserName(2);" />
						<form:input path="email" placeholder="Email ID"
							value="${user.email}" id="updateEmail"
							onchange="validateEmail(2);" />

						<form:password path="password" placeholder="Password"
							id="updatePassword" value="${user.password}" />
						<form:password path="" placeholder="Confirm Password"
							id="updateConfirmPassword" onchange="checkPassword(2);" />

						<label class="control-label">Account Settings</label> <br /> <label
							class="checkbox-inline"><form:checkbox path="enabled"
								id="updateEnabled" name="enabled" value="true" /> Enabled</label> <br />
						<label class="checkbox-inline"> <form:checkbox
								path="accountNonExpired" id="updateAccountNonExpired"
								name="accountNonExpired" value="true" /> AccountNonExpired
						</label> <br /> <label class="checkbox-inline"> <form:checkbox
								path="accountNonLocked" id="updateAccountNonLocked"
								name="accountNonLocked" value="true" /> AccountNonLocked
						</label> <br /> <label class="checkbox-inline"> <form:checkbox
								path="credentialsNonExpired" id="updateCredentialsNonExpired"
								name="credentialsNonExpired" value="true" />
							CredentialsNonExpired
						</label> <br /> <br />

						<button class="btn btn-large btn-primary" value="Save" name="save"
							id="btnUpdateSubmit" type="submit">Update</button>
						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<button class="btn btn-warning" id="btnUpdateNew" type="reset">New</button>
					</fieldset>
				</form:form>

				<!---->
			</div>
			<div class="col-md-8">
				<fieldset>
					<legend>Users List</legend>
					<div class="table-responsive">
						<c:if test="${!empty userList}">
							<table class="table table-bordered  table-hover" id="tblUsers">
								<thead>
									<tr>
										<th>UserName</th>
										<th>First Name</th>
										<th>Last Name</th>
										<th>Email Id</th>
										<th>Operations</th>
									</tr>
								</thead>
								<tbody id="tblUsersBody">
									<c:forEach items="${userList}" var="user">
										<tr>
											<td>${user.userName}</td>
											<td>${user.firstName}</td>
											<td>${user.lastName}</td>
											<td>${user.email}</td>
											<td align="center">
												<button class="btnEdit btn btn-primary"
													href="${pageContext.request.contextPath}/user/admin/update/${user.userName}">Edit</button>
												<button class="btnDelete btn btn-danger"
													href="${pageContext.request.contextPath}/user/admin/delete/${user.userName}">Delete</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:if>
					</div>
				</fieldset>


				<fieldset>
					<legend>Add User To Groups</legend>
					<form
						action="${pageContext.request.contextPath}/user/admin/addUserToGroup/"
						method="post" id="addUserToGroupForm">
						<table class="table table-bordered  table-hover">
							<thead>
								<tr>
									<th>Select User</th>
									<th>Select Groups</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><select name="userName" class="form-control">
											<c:forEach items="${userNames}" var="userName">
												<option value="${userName}">${userName}</option>
											</c:forEach>
									</select></td>

									<td><select name="groupNames" multiple
										class="form-control">
											<c:forEach items="${groupNames}" var="groupName">
												<option value="${groupName}">${groupName}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<td colspan="2">
										<center>
											<button class="btnAddUserToGroup btn btn-primary">Update</button>
										</center>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</fieldset>
			</div>



		</div>
	</div>


	<div id="confirmModal" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="confirmModal" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="confirmModalLabel">Delete User</h4>
				</div>

				<div class="modal-body"></div>

				<div class="modal-footer">
					<button type="button" id="btnConfirmCancel" class="btn btn-default">Cancel</button>
					<button type="button" id="btnConfirmYes" class="btn btn-danger">Yes</button>
				</div>
			</div>
		</div>
	</div>


	<div id="alertModal" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="alertModal" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="alertModalLabel">FYI</h4>
				</div>

				<div class="modal-body"></div>

				<div class="modal-footer">
					<button type="button" id="btnAlertYes" class="btn btn-danger">Yes</button>
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
				class="navbar-btn btn-danger btn pull-right"> Visit To Neova
				Solutions</a>
		</div>
	</div>
	<!-- End of Bottom(Footer) Content -->

	<script
		src="${pageContext.request.contextPath}/themes/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>
