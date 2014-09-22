<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Cache-Control" content="no-store"/>
        <meta http-equiv="Pragma" content="no-cache"/>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" href="/images/favicon.ico"/>
        <title>Sign Up | Neova</title>
         <link
	href="${pageContext.request.contextPath}/themes/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/themes/main.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/themes/bootstrap/js/jquery-1.11.0.min.js"></script>
    </head>
    <body class="signup">
        <div class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="${pageContext.request.contextPath}/index.html">Neova BaseProject</a>
            </div>         
            <div class="collapse navbar-collapse" id="navbar">
                <ul class="nav navbar-nav">
                    <li class="active">
                        <a href="${pageContext.request.contextPath}/user-login.html">Login</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="container" id="content">
            <div class="row">
                <div class="col-sm-2">
                    <h2>New User Registration</h2>
                    <p>Please enter your personal information.</p>
                </div>
                <div class="col-sm-7">
                    <form id="signupForm" class="well" action="${pageContext.request.contextPath}/signup" method="post" onsubmit="return validateSignup(this)" autocomplete="off">
                        <div class="form-group">
                            <label for="username" class="control-label">Username <span class="required">*</span></label><input id="username" name="username" class="form-control" autofocus="true" type="text" value=""/>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label for="password" class="control-label">Password</label><input id="password" name="password" class="form-control" type="password" value=""/>
                            </div>
                            <div class="col-sm-6 form-group">
                                <label for="passwordHint" class="control-label">Password Hint <span class="required">*</span></label><input id="passwordHint" name="passwordHint" class="form-control" type="text" value=""/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label for="firstName" class="control-label">First Name <span class="required">*</span></label><input id="firstName" name="firstName" class="form-control" type="text" value="" maxlength="50"/>
                            </div>
                            <div class="col-sm-6 form-group">
                                <label for="lastName" class="control-label">Last Name <span class="required">*</span></label><input id="lastName" name="lastName" class="form-control" type="text" value="" maxlength="50"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label for="email" class="control-label">E-Mail <span class="required">*</span></label><input id="email" name="email" class="form-control" type="text" value=""/>
                            </div>
                            <div class="col-sm-6 form-group">
                                <label for="phoneNumber" class="control-label">Phone Number</label><input id="phoneNumber" name="phoneNumber" class="form-control" type="text" value=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="website" class="control-label">Website</label><input id="website" name="website" class="form-control" type="text" value=""/>
                        </div>
                        <div>
                            <legend class="accordion-heading">
                                <a data-toggle="collapse" href="#collapse-address">Address</a>
                            </legend>
                            <div id="collapse-address" class="accordion-body collapse">
                                <div class="form-group">
                                    <label for="address.address" class="control-label">Address</label><input id="address.address" name="address.address" class="form-control" type="text" value=""/>
                                </div>
                                <div class="row">
                                    <div class="col-sm-7 form-group">
                                        <label for="address.city" class="control-label">City</label><input id="address.city" name="address.city" class="form-control" type="text" value=""/>
                                    </div>
                                    <div class="col-sm-2 form-group">
                                        <label for="address.province" class="control-label">State</label><input id="address.province" name="address.province" class="form-control" type="text" value=""/>
                                    </div>
                                    <div class="col-sm-3 form-group">
                                        <label for="address.postalCode" class="control-label">Zip</label><input id="address.postalCode" name="address.postalCode" class="form-control" type="text" value=""/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address.country" class="control-label">Country</label>
                                        <select name="address.country" id="address.country" class="form-control">
                                            <option value="" selected="selected"></option>
                                            <option value="AL">Albania</option>
                                            <option value="DZ">Algeria</option>
                                            <option value="AR">Argentina</option>
                                            <option value="AU">Australia</option>
                                            <option value="AT">Austria</option>
                                            <option value="BH">Bahrain</option>
                                            <option value="BY">Belarus</option>
                                            <option value="BE">Belgium</option>
                                            <option value="BO">Bolivia</option>
                                            <option value="BA">Bosnia and Herzegovina</option>
                                            <option value="BR">Brazil</option>
                                            <option value="BG">Bulgaria</option>
                                            <option value="CA">Canada</option>
                                            <option value="CL">Chile</option>
                                            <option value="CN">China</option>
                                            <option value="CO">Colombia</option>
                                            <option value="CR">Costa Rica</option>
                                            <option value="HR">Croatia</option>
                                            <option value="CY">Cyprus</option>
                                            <option value="CZ">Czech Republic</option>
                                            <option value="DK">Denmark</option>
                                            <option value="DO">Dominican Republic</option>
                                            <option value="EC">Ecuador</option>
                                            <option value="EG">Egypt</option>
                                            <option value="SV">El Salvador</option>
                                            <option value="EE">Estonia</option>
                                            <option value="FI">Finland</option>
                                            <option value="FR">France</option>
                                            <option value="DE">Germany</option>
                                            <option value="GR">Greece</option>
                                            <option value="GT">Guatemala</option>
                                            <option value="HN">Honduras</option>
                                            <option value="HK">Hong Kong</option>
                                            <option value="HU">Hungary</option>
                                            <option value="IS">Iceland</option>
                                            <option value="IN">India</option>
                                            <option value="ID">Indonesia</option>
                                            <option value="IQ">Iraq</option>
                                            <option value="IE">Ireland</option>
                                            <option value="IL">Israel</option>
                                            <option value="IT">Italy</option>
                                            <option value="JP">Japan</option>
                                            <option value="JO">Jordan</option>
                                            <option value="KW">Kuwait</option>
                                            <option value="LV">Latvia</option>
                                            <option value="LB">Lebanon</option>
                                            <option value="LY">Libya</option>
                                            <option value="LT">Lithuania</option>
                                            <option value="LU">Luxembourg</option>
                                            <option value="MK">Macedonia</option>
                                            <option value="MY">Malaysia</option>
                                            <option value="MT">Malta</option>
                                            <option value="MX">Mexico</option>
                                            <option value="ME">Montenegro</option>
                                            <option value="MA">Morocco</option>
                                            <option value="NL">Netherlands</option>
                                            <option value="NZ">New Zealand</option>
                                            <option value="NI">Nicaragua</option>
                                            <option value="NO">Norway</option>
                                            <option value="OM">Oman</option>
                                            <option value="PA">Panama</option>
                                            <option value="PY">Paraguay</option>
                                            <option value="PE">Peru</option>
                                            <option value="PH">Philippines</option>
                                            <option value="PL">Poland</option>
                                            <option value="PT">Portugal</option>
                                            <option value="PR">Puerto Rico</option>
                                            <option value="QA">Qatar</option>
                                            <option value="RO">Romania</option>
                                            <option value="RU">Russia</option>
                                            <option value="SA">Saudi Arabia</option>
                                            <option value="RS">Serbia</option>
                                            <option value="CS">Serbia and Montenegro</option>
                                            <option value="SG">Singapore</option>
                                            <option value="SK">Slovakia</option>
                                            <option value="SI">Slovenia</option>
                                            <option value="ZA">South Africa</option>
                                            <option value="KR">South Korea</option>
                                            <option value="ES">Spain</option>
                                            <option value="SD">Sudan</option>
                                            <option value="SE">Sweden</option>
                                            <option value="CH">Switzerland</option>
                                            <option value="SY">Syria</option>
                                            <option value="TW">Taiwan</option>
                                            <option value="TH">Thailand</option>
                                            <option value="TN">Tunisia</option>
                                            <option value="TR">Turkey</option>
                                            <option value="UA">Ukraine</option>
                                            <option value="AE">United Arab Emirates</option>
                                            <option value="GB">United Kingdom</option>
                                            <option value="US">United States</option>
                                            <option value="UY">Uruguay</option>
                                            <option value="VE">Venezuela</option>
                                            <option value="VN">Vietnam</option>
                                            <option value="YE">Yemen</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-primary" name="save" onclick="bCancel=false">
                                    <i class="icon-ok icon-white"></i> Signup
                                </button>
                                <button type="submit" class="btn btn-default" name="cancel" onclick="bCancel=true">
                                    <i class="icon-remove"></i> Cancel
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div id="footer" class="container navbar-fixed-bottom">
                <span class="col-sm-6 text-left">Version 1.0
                </span>
                <span class="col-sm-6 text-right">
                     &copy; 2014 <a href="http://raibledesigns.com">Neova Solutions Pvt. LTD.</a>
                </span>
            </div>
            <script type="text/javascript" language="Javascript1.1"> 
            /*Begin 
                var bCancel = false; 
                function validateSignup(form) {                                                                   
                    if (bCancel) 
                        return true; 
                    else    
                        return validateRequired(form) && validateEmail(form); 
                } 
                function required () { 
                    this.aa = new Array("username", "Username is a required field.", new Function ("varName", " return this[varName];"));
                    this.ab = new Array("firstName", "First Name is a required field.", new Function ("varName", " return this[varName];"));
                    this.ac = new Array("lastName", "Last Name is a required field.", new Function ("varName", " return this[varName];"));
                    this.ad = new Array("email", "E-Mail is a required field.", new Function ("varName", " return this[varName];"));
                    this.ae = new Array("passwordHint", "Password Hint is a required field.", new Function ("varName", " return this[varName];"));
                    this.af = new Array("password", "Password is a required field.", new Function ("varName", " return this[varName];"));
                } 
                function email () { 
                    this.aa = new Array("email", "E-Mail is an invalid e-mail address.", new Function ("varName", " return this[varName];"));
                }    
            End*/
            </script>
            <script type="text/javascript" src="${pageContext.request.contextPath}/themes/validator.jsp"></script>
    </body>
</html>

