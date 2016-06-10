<%-- 
    Document   : view_project
    Created on : 8 Jun, 2016, 1:58:30 PM
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
    String project_id = (String) request.getParameter("view_project_id"); 
    if(p_id!=null){ project_id= p_id;}
    if (project_id == null) {
%>
<script>
     window.location = "buyer.jsp";
</script>
<%
    }

%>
<div class="content-wrapper"> 
    <section class="content-header">
        <h1>
            View Project Details
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
                        String proname="";String prodetail="";String pro_email="";String user_n="";String user_em="";
                        try {
                            String str = "select * from project where sno='" + project_id + "' AND project_status='publish' ";
                            PreparedStatement ps = con.prepareStatement(str);
                            ResultSet st = ps.executeQuery();

                            while (st.next()) {
                               proname= st.getString("project_name");
                               prodetail= st.getString("project_detail"); 
                                user_n= st.getString("created_by");
                               
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
                                
                                
                                String str_uem = "select * from user where user_name='" + user_n + "'  ";
                            PreparedStatement ps_uem = con.prepareStatement(str_uem);
                            ResultSet st_uem = ps_uem.executeQuery();
                            while (st_uem.next()) {
                                user_em=st_uem.getString("email_id");
                            }   
                    %>

                  
                        <div class="box-body"> 
                             <div class="col-md-12">
                                <div class="col-lg-12">
                                     <div class="form-group">  
                                         <p><strong>Project Owner : </strong><% out.println(user_n);  %> <strong> &nbsp;&nbsp; Owner Email-id : &nbsp;&nbsp;&nbsp;</strong><% out.println(user_em);  %></p>
                                        
                                    </div> 
                                    <div class="form-group"> 
                                        <p><strong>Project Name : </strong><% out.println(proname);  %></p>
                                        
                                    </div>  
                                    <div class="form-group">  
                                        <p><strong>Project Details : </strong><% out.println(prodetail);  %></p>
                                        
                                    </div>  
                                </div> 
                            </div>
                            			
                        </div> 
                      

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
                                            <th style="font-size: 13px;" width="15%">View Doc</th> 
                                             
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
                                         out.println("<td><form action='#view_pdf' method='post'><input type='hidden' name='project_meta_id' value='" + st_meta.getString("meta_id")  + "' />"
                                                +"<input type='hidden' name='view_project_id' value='"+project_id+"' />"
                                                 + "<input type='submit' class='' value='view' /></form> </td> </tr>"); 
                                        strt++;
                                    }
                                }     
                                    %>  
                                    </tbody>
                                </table>
                            </div>
                                    <section id="view_pdf">
                                        <%
                                String meta_id=(String) request.getParameter("project_meta_id"); 
                                if(meta_id!=null){
                                 String str_pdf = "select * from project_meta where meta_id='" + meta_id + "' ";
                                PreparedStatement ps_pdf = con.prepareStatement(str_pdf);
                                ResultSet st_pdf = ps_pdf.executeQuery();
                                while (st_pdf.next()) {
                                         out.print("<object Content-Type='application/pdf' Content-Disposition='inline' height='800'"
                                      + " data='file_upload/"+st_pdf.getString("meta_value")+"' type='application/pdf' width='100%'></object>");
                                        
                                }
                                
                                
                                }%>
                                        
                                    </section>           
                                    
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