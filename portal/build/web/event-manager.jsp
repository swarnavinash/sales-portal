<%-- 
    Document   : client
    Created on : 5 Jun, 2016, 1:03:41 PM
    Author     : Swarn Avinash Kumar
--%>


<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<jsp:include page="header.jsp" /> 
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
    } else {

    }
String login = (String) request.getAttribute("login");
String tt = (String) session.getAttribute("user_type");
if(tt.equalsIgnoreCase("0")){ }else{ 
%>
         <script>
  window.location = "buyer.jsp";  
</script>
 <% }
     if(login=="done"){
         %>
         <script>
  window.location = "event-manager.jsp";  
</script>
 <% }
%>
<div class="content-wrapper"> 
    <section class="content-header">
        <h1>
            Dashboard
        </h1>

        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>

        </ol>
    </section> 
    <section class="content">  
        <div class="row">
            <!-- left column -->
            <% 
     Connection con = mysqlconnection.connectionsql.connect();
     String project_id=   (String) request.getParameter("project_id");
 if(project_id==null){
%>
            
            <div class="col-md-12"> 
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">Project List</h3>
                    </div>  


                    <div class="box-body">
                        <div class="col-md-12"> 

                            <div id="table_all_data">
                                <table id="exam_list" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th style="font-size: 13px;" width="20%">Name Of Project</th> 
                                            <th style="font-size: 13px;" width="40%">Details of project</th>
                                            <th style="font-size: 13px;" width="30%">Offer To</th> 
                                            <th style="font-size: 13px;" width="10%">View Docs</th> 
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%            
                                            String cuser = (String) session.getAttribute("username");
                                            try {
                                                String str = "select * from project where created_by='" + cuser + "' AND project_status='publish' ";
                                                PreparedStatement ps = con.prepareStatement(str);
                                                ResultSet st = ps.executeQuery();

                                                while (st.next()) {
                                                    out.println("<tr><td>" + st.getString("project_name") + "</td>");
                                                    out.println("<td>" + st.getString("project_detail") + "</td> ");
                                                    out.println("<td>");
                                                    String str_meta = "select * from project_meta where project_id='" + st.getString("sno") + "' ";
                                                    PreparedStatement ps_meta = con.prepareStatement(str_meta);
                                                    ResultSet st_meta = ps_meta.executeQuery();
                                                    int strt = 0;
                                                    while (st_meta.next()) {  //out.println(st_meta.getString("meta_value"));
                                                        if (st_meta.getString("meta_key").equalsIgnoreCase("peoject_emails")) {
                                                            if (strt == 0) {
                                                                out.println(st_meta.getString("meta_value"));
                                                            } else {
                                                                out.println(" , " + st_meta.getString("meta_value"));
                                                            }
                                                            strt++;
                                                        }

                                                    }

                                                    out.println("</td>");
                                                    out.println("<td><form action='' method='post'><input type='hidden' name='project_id' value='" + st.getString("sno") + "' />"
                                                            + "<input type='submit' class='' value='View Docs' /></form> </td> </tr>");

                                                }
                                            } catch (Exception e) {

                                            }
                                             String uploadPath = getServletContext().getRealPath("")+ File.separator  +"file_upload"+File.separator;
                                             // out.println(uploadPath);
                                        %>
                                    </tbody>

                                </table>
                            </div> 
                        </div>


                        <!-- End Row -->
                    </div>
                </div>
            </div>


<%  } else{ 
%>

            <div class="col-md-12"> 
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">Document List</h3>
                    </div>  


                    <div class="box-body">
                        <div class="col-md-12"> 
                            <%
                            String str = "select * from project_meta where project_id='" + project_id + "' ";
                                                PreparedStatement ps = con.prepareStatement(str);
                                                ResultSet st = ps.executeQuery();
                       int doc_no=1;
                                                while (st.next()) {
                                                  if (st.getString("meta_key").equalsIgnoreCase("project_doc")) {
                             out.print("<div id='pdf_show' style='border: 1px solid rgb(238, 238, 238); margin: 30px 15px ! important; padding: 0px 15px;'> "
                                     + "<h3 style='margin: 15px 0px;'>Project Document Number "+doc_no+"</h3>");                         
                              out.print("<object Content-Type='application/pdf' Content-Disposition='inline' height='800'"
                                      + " data='file_upload/"+st.getString("meta_value")+"' type='application/pdf' width='100%'></object>");
                              out.print("</div> ");
                              doc_no++;
                                                  }
                                                }
                            %>
                            
                            
                      <!-- <iframe src="http://docs.google.com/gview?url=http://example.com/mypdf.pdf&embedded=true" style="width:718px; height:700px;" frameborder="0"></iframe>-->

                        </div>
                    </div>
                </div>
            </div>


<%
 }
%>








        </div>
    </section>   
</div> 			

<script>
    var d = document.getElementById("dashbord");
    d.className += " active";

</script>




<jsp:include page="footer.jsp" />