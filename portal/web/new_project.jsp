<%-- 
    Document   : new_project
    Created on : 5 Jun, 2016, 6:21:16 PM
    Author     : Swarn Avinash Kumar
--%>

<jsp:include page="header.jsp" /> 
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-md">
	<div class="col-md-2"></div>
	<div class="col-md-8">
     <div class="modal-content" style="border-radius: 0px; text-align: center; background: green none repeat scroll 0% 0%; border: medium none;">
        <div class="modal-header" style="border-bottom: 0px none;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
         <h2 class="modal-title" style="text-transform: uppercase; letter-spacing: 1px; color: rgb(255, 255, 255); font-size: 17px; font-weight: 600;">Project Added Successfully</h2>
        </div> 
      </div>
      </div>
    </div>
  </div>
  

<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
    } else {

    }
    
     String commit = (String) request.getAttribute("commit");
     if(commit=="done"){
         %>
         <script>
$(document).ready(function(){  
        $("#myModal").modal();
    
});
</script>
     <% }

%>
<div class="content-wrapper"> 
    <section class="content-header">
        <h1>
            Dashboard
        </h1>

        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>New Project</a></li>

        </ol>
    </section> 
    <section class="content">  
        <div class="row">
            <!-- left column -->
            <div class="col-md-12"> 
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">Add New Project</h3>
                    </div>  
                    <form role="form" action="add_project" method="post" enctype="multipart/form-data">
                        <div class="box-body"> 
                            <div class="col-md-3"></div><div class="col-md-6">
                                <div class="col-lg-12">
                                    <div class="form-group"> 
                                        <label ><strong>Project Name</strong></label>
                                        <input type="text" class="form-control" id="project_name" name="project_name" value=""  placeholder="Project Name">
                                    </div>  
                                    <div class="form-group">  
                                        <label ><strong>Project Detail</strong></label>					  
                                        <textarea class="form-control" name="project_detail" style="resize: none;" rows="3" placeholder="Enter Project Detail Here..."></textarea>
                                    </div> 

                                    <div class="form-group"> 
                                        <label ><strong>Email-ID(add email-id separated by ,)</strong></label>

                                        <div class="input-group" >
                                            <div class="input-group-addon">
                                                <i class="fa fa-envelope-o"></i>
                                            </div>
                                            <input type="text" class="form-control" id="email_ids" name="email_ids" placeholder="xzy@gmail.com,abc@gmail.com">

                                        </div>
                                    </div>  
                                    <div class="form-group"> 
                                        <label ><strong>Upload Project Files</strong></label>
                                         <div class="form-group" > 
                      <input type="file" id="upload_multiple_file" name="upload_multiple_file"   multiple="multiple">
                      <p class="help-block">Select single and multiple file for project</p>
                    </div>

                                    </div> 


                                </div> 
                            </div>
                            <div class="col-md-3"></div>			
                        </div> 
                        <div class="box-footer">
                            <div class="col-md-2"></div>
                            <div class="col-md-7" style="text-align: right;">
                                <button class="btn btn-primary" type="submit" style="font-size: 18px;">Save</button>
                            </div>
                            <div class="col-md-2"></div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </section>   
</div> 			

<script>
    var d = document.getElementById("new_pro");
    d.className += " active";

</script>


  
  

<jsp:include page="footer.jsp" />