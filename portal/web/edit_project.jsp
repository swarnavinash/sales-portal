<%-- 
    Document   : edit_project
    Created on : 7 Jun, 2016, 11:11:41 AM
    Author     : Swarn Avinash Kumar
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Connection"%>
<jsp:include page="header.jsp" /> 
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="modal-content" style="border-radius: 0px; text-align: center; background: green none repeat scroll 0% 0%; border: medium none;">
                <div class="modal-header" style="border-bottom: 0px none;">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h2 class="modal-title" style="text-transform: uppercase; letter-spacing: 1px; color: rgb(255, 255, 255); font-size: 17px; font-weight: 600;">Project Detail Updated Successfully</h2>
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
    String p_id = (String) request.getAttribute("edit_project_id");
    if (commit == "done") {
%>
<script>
    $(document).ready(function() {
        $("#myModal").modal();

    });
</script>
<% }

    Connection con = mysqlconnection.connectionsql.connect();
    String project_id = (String) request.getParameter("edit_project_id"); 
    if(p_id!=null){ project_id= p_id;}
    if (project_id == null) {
%>
<script>
     window.location = "exist_project.jsp";
</script>
<%
    }

%>
<div class="content-wrapper"> 
    <section class="content-header">
        <h1>
            Edit Project
        </h1>
        <% //out.print("project id is  " +project_id); %>
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
                        <h3 class="box-title"><a href="">Back to List</a> </h3>
                    </div>  
                    <%            
                        String cuser = (String) session.getAttribute("username");
                        String proname="";String prodetail="";String pro_email="";
                        try {
                            String str = "select * from project where sno='" + project_id + "' AND project_status='publish' ";
                            PreparedStatement ps = con.prepareStatement(str);
                            ResultSet st = ps.executeQuery();

                            while (st.next()) {
                               proname= st.getString("project_name");
                               prodetail= st.getString("project_detail");
                                
                                String str_meta = "select * from project_meta where project_id='" + st.getString("sno") + "' ";
                                PreparedStatement ps_meta = con.prepareStatement(str_meta);
                                ResultSet st_meta = ps_meta.executeQuery();
                                int strt = 0;
                                while (st_meta.next()) {  //out.println(st_meta.getString("meta_value"));
                                    if (st_meta.getString("meta_key").equalsIgnoreCase("peoject_emails")) {
                                        if (strt == 0) {
                                            pro_email+=st_meta.getString("meta_value");
                                        } else {
                                            pro_email+=" , " +st_meta.getString("meta_value");
                                             
                                        }
                                        strt++;
                                    }
                                }
                               
                    %>

                    <form role="form" action="edit_project" method="post" enctype="multipart/form-data">
                        <div class="box-body"> 
                            <div class="col-md-3"></div><div class="col-md-6">
                                <div class="col-lg-12">
                                    <div class="form-group"> 
                                        <label ><strong>Project Name</strong></label>
                                        <input type="text" class="form-control" id="project_name" name="project_name" value="<%= proname %>"  placeholder="Project Name">
                                    </div>  
                                    <div class="form-group">  
                                        <label ><strong>Project Detail</strong></label>					  
                                        <textarea class="form-control" name="project_detail" style="resize: none;" rows="3" placeholder="Enter Project Detail Here..."><%=prodetail%></textarea>
                                    </div> 

                                    <div class="form-group"> 
                                        <label ><strong>Email-ID(add email-id separated by ,)</strong></label>

                                        <div class="input-group" >
                                            <div class="input-group-addon">
                                                <i class="fa fa-envelope-o"></i>
                                            </div>
                                            <input type="text" class="form-control" id="email_ids" value="<%=pro_email%>" name="email_ids" placeholder="xzy@gmail.com,abc@gmail.com">

                                        </div>
                                    </div>  
                                    <div class="form-group"> 
                                        <label ><strong>Upload Project Files</strong></label>
                                        <div class="form-group" > 
                                            <input type="file" id="upload_multiple_file" name="upload_multiple_file"   multiple="multiple">
                                            <p class="help-block">Select single and multiple file for project(to check existing file see below..)</p>
                                        </div>

                                    </div> 


                                </div> 
                            </div>
                            <div class="col-md-3"></div>			
                        </div> 
                        <div class="box-footer">
                            <div class="col-md-2"></div>
                            <div class="col-md-7" style="text-align: right;">
                                <input type="hidden" name="project_id" value="<%=project_id%>" />
                                <button class="btn btn-primary" type="submit" style="font-size: 18px;">Update Detail</button>
                                
                            </div>
                            <div class="col-md-2"></div>
                        </div>
                    </form>

                    <%
                                     
                            }
                        } catch (Exception e) {

                        }

                    %>

                     <div class="box-body">
                     <div class="col-md-12">  
                            <div id="table_all_data">
                                <table id="exam_list" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th style="font-size: 13px;" width="15%">S-No</th> 
                                            <th style="font-size: 13px;" width="70%">Document Name</th>
                                            <th style="font-size: 13px;" width="15%">Remove Doc</th> 
                                             
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <%    
                                   String str_meta = "select * from project_meta where project_id='" + project_id + "' ";
                                PreparedStatement ps_meta = con.prepareStatement(str_meta);
                                ResultSet st_meta = ps_meta.executeQuery();
                                int strt = 1;
                                while (st_meta.next()) {  //out.println(st_meta.getString("meta_value"));
                                    if (st_meta.getString("meta_key").equalsIgnoreCase("project_doc")) {
                                        out.println("<tr><td>"+strt+"</td><td>" + st_meta.getString("meta_value") + "</td>");
                                         out.println("<td><form action='remove_doc' method='post'><input type='hidden' name='project_meta_id' value='" + st_meta.getString("meta_id")  + "' />"
                                                +"<input type='hidden' name='project_id' value='"+project_id+"' />"
                                                 + "<input type='submit' class='' value='Remove' /></form> </td> </tr>"); 
                                        strt++;
                                    }
                                }     
                                    %>  
                                    </tbody>
                                </table>
                            </div>
                     </div>
                     </div>
                    
                    
                    
                </div>
            </div>
        </div>
    </section>   
</div> 			

<script>
    var d = document.getElementById("exist_pro");
    d.className += " active";

</script>





<jsp:include page="footer.jsp" />