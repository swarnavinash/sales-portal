<%-- 
    Document   : index
    Created on : 5 Jun, 2016, 11:02:14 AM
    Author     : Swarn Avinash Kumar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
            <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"> 
      <link href="cssfile/bootstrap.min.css" rel="stylesheet" > 
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"> 
    <link rel="stylesheet" href="cssfile/datepicker.css"> 
    <link rel="stylesheet" href="cssfile/themecss.min.css"> 
    <link rel="stylesheet" href="cssfile/skins/skin-blue.min.css"> 
	 <link rel="stylesheet" href="appplugins/iCheck/square/blue.css">
    </head>
   <body class="hold-transition login-page">
        <% session.invalidate(); %>
        <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-md">
	<div class="col-md-2"></div>
	<div class="col-md-8">
      <div class="modal-content"   >
        <div class="modal-header"  >
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title" style="color:#365774; text-transform:uppercase; letter-spacing:1px; font-size:14px;">Forgot Password ?</h4>
        </div>
        <div class="modal-body">
          <div class="login-box-body">
          <form action="" method="post">
            <span ><strong>Email-ID</strong></span>
          <div class="form-group has-feedback">
            <input type="email" class="form-control" placeholder="Email">
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
          </div>
<div class="form-group" style="text-align: right; margin: 0px;">
  <button type="submit" class="btn btn-primary" >Submit</button>
  </div>
</form>  
        </div>
        </div>
        <div class="modal-footer"> 
        </div>
      </div>
      </div>
    </div>
  </div>
 
 
 
    <div class="login-box">
      <div class="login-logo">
        <a href="index.html"><b>WEB</b>APP</a>
      </div> 
      <div class="login-box-body">
        <p class="login-box-msg" style="font-size: 17px;">Sign in to start your session</p>
        <form action="login_request" method="post">
		<label ><strong>Username</strong></label>
          <div class="form-group has-feedback">
              <input type="text" class="form-control" name="user_name" placeholder="Username" required="true">
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
          </div>
		  <label ><strong>Password</strong></label>
          <div class="form-group has-feedback">
            <input type="password" class="form-control" name="password" placeholder="Password" required="true">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          </div>
          <div class="row">
           <div class="col-xs-8">
             <!--  <div class="checkbox icheck">
                <label>
                  <input type="checkbox"> Remember Me
                </label>
              </div>  -->
            </div>
            <div class="col-xs-4">
              <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
            </div>
          </div>
        </form>
 <hr>

     <!-- <button type="submit" class="btn btn-default btn-block btn-flat login" data-toggle="modal" data-target="#myModal">I forgot my password</button>  
          <a href="register.html" class="text-center"><button type="submit" class="btn btn-default btn-block btn-flat login">Register a new membership</button></a>
       -->
      </div> 
    </div> 
 <script src="jsfile/jQuery-2.1.4.min.js"></script> 
    <script src="cssfile/js/bootstrap.min.js"></script> 
    <script src="cssfile/js/bootstrap-datepicker.js"></script> 
    <script src="jsfile/app.min.js"></script> 
	 <script src="appplugins/input-mask/jquery.inputmask.js"></script> 
    <script src="appplugins/iCheck/icheck.min.js"></script>
	  
    <script>
      $(function () { 
        $('input').iCheck({
          checkboxClass: 'icheckbox_square-blue',
          radioClass: 'iradio_square-blue',
          increaseArea: '20%'  
        });
      });
    </script>
        
    
    </body>
</html>
