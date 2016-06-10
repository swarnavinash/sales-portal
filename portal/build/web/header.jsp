<%-- 
    Document   : header
    Created on : 5 Jun, 2016, 2:16:42 PM
    Author     : Swarn Avinash Kumar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Client Dashboard</title>
            <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"> 
      <link href="cssfile/bootstrap.min.css" rel="stylesheet" > 
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"> 
    <link rel="stylesheet" href="cssfile/datepicker.css"> 
    <link rel="stylesheet" href="cssfile/themecss.min.css"> 
    <link rel="stylesheet" href="cssfile/skins/skin-blue.min.css"> 
	 <link rel="stylesheet" href="appplugins/iCheck/square/blue.css">
           <script src="jsfile/jQuery-2.1.4.min.js"></script> 
    </head>
   <body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper"> 
      <!-- Main Header -->
      <header class="main-header">  
        <a href="#" class="logo">            
          <span class="logo-mini"><b>W</b>eb</span> 
          <span class="logo-lg"><b>Web</b>App</span>
        </a>  
        <nav class="navbar navbar-static-top" role="navigation"> 
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
          </a> 
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
            
              <li class="dropdown user user-menu"> 
                <a href="index.jsp" class="dropdown-toggle"  > 
				<img src="images/avatar5.png" class="user-image" alt="User Image">
				  <span class="hidden-xs">Logout</span>
                </a>
                
              </li> 
              
            </ul>
          </div>
        </nav>
      </header> 
      <%
        //allow access only if session exists
        String user = "fff"; String utype="";
        if (session.getAttribute("username") == null) {  
        } else {
            user = (String) session.getAttribute("username"); 
            String tt = (String) session.getAttribute("user_type");
            if(tt.equalsIgnoreCase("0")){
                utype="Event-Manager";
            }else{
                utype="Buyer";
            }
        }

    %>
      <aside class="main-sidebar"> 
        <section class="sidebar"> 
          <div class="user-panel">
            <div class="pull-left image">
              <img src="images/avatar5.png" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
               <p style="text-transform: capitalize;"><% out.print(user); %></p>
              <!-- Status -->
               <p><% out.print(utype); %></p>
              <!--<a href="#"><i class="fa fa-circle text-success"></i> Online</a> -->
            </div>
          </div>  
          <!-- Sidebar Menu -->
          <ul class="sidebar-menu" style="margin-top:25px;">
            
			 <!--Search Form 
			 <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
              <input type="text" name="q" class="form-control" placeholder="Search...">
              <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i></button>
              </span>
            </div>
          </form>
		   End Search From -->
                         <% if(utype.equalsIgnoreCase("Event-Manager")){ %>
			<li id="dashbord" class=''>
              <a href="event-manager.jsp">
                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
              </a> 
			  </li>
                <li id="new_pro" class=''>
              <a href="new_project.jsp"><i class="fa fa-feed"></i> <span>New Project</span> </a>
               
            </li> 
             <li id="exist_pro" class=''>
              <a href="exist_project.jsp"><i class="fa fa-feed"></i> <span>Exist Project</span> </a>
               
            </li> 
           <li class=''>
              <a href="index.jsp">
                <i class="fa fa-toggle-off "></i> <span>Logout</span>
              </a> 
			  </li>
                <%  }else{
                         %>
			<li id="dashbord" class=''>
              <a href="buyer.jsp">
                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
              </a> 
			  </li>
               
             
           <li class=''>
              <a href="index.jsp">
                <i class="fa fa-toggle-off "></i> <span>Logout</span>
              </a> 
			  </li> 
                <% 
         }  %>        
          </ul> 
        </section> 
      </aside> 